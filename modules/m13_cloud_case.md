# Case Study: CloudStartup Sp. z o.o. — Wyciek danych przez misconfigurację AWS S3

**Moduł 13 · Bezpieczeństwo chmury**

CloudStartup to 3-letnia firma SaaS (narzędzie do analizy HR, 45 pracowników, dane 180 firm klientów na AWS). Developerzy zarządzają infrastrukturą sami (brak DevOps), używają AWS Console ręcznie.

**Incydent:** Security researcher przez Shodan/GrayhatWarfare znalazł publicznie dostępny bucket S3 `cloudstartup-hr-reports-prod` zawierający raporty HR 43 klientów (dane pracowników, wynagrodzenia, oceny). Powiadomił firmę przez email. Bucket był publiczny przez **47 dni**.

**Przyczyna:** Developer tworzył nowy bucket do raportów, zaznaczył "Block Public Access = Off" myśląc że to dotyczy tylko dostępu przez konsolę, nie przez URL. Błąd konfiguracyjny przez niezrozumienie modelu AWS.

---

## Analiza — co zawiodło

**Brak CSPM:** żaden system nie skanował konfiguracji AWS. AWS Config nie był włączony. Bucket był publiczny 47 dni bez żadnego alertu.

**Nadmierne uprawnienia IAM:** developer który stworzył bucket miał politykę `s3:*` na `*` — mógł zrobić wszystko ze wszystkimi bucketami.

**Brak Security Hub:** AWS Security Hub nie był włączony — automatycznie wykrywa publiczne S3 buckety (CIS AWS Benchmark check 2.1.5).

**Brak CloudTrail:** wyłączony w regionie eu-west-1 gdzie były dane. Niemożliwe ustalenie czy dane zostały pobrane przed odkryciem.

---

## Plan naprawczy

**Tydzień 1 — natychmiastowe:**
1. Wyłączyć Public Access na wszystkich bucketach S3 (AWS Organization-level S3 Block Public Access)
2. Włączyć CloudTrail we wszystkich regionach
3. Włączyć AWS Security Hub (CIS Benchmark + AWS Foundational Security Standard)
4. Resetowanie kluczy dostępu i przegląd IAM

**Miesiąc 1 — strukturalne:**
```bash
# Prowler audit — znalazło 47 issues
prowler aws -g cislevel2 --region eu-west-1 eu-central-1

# AWS Config Rule — blokada publicznych S3
aws configservice put-config-rule \
  --config-rule file://s3-bucket-public-read-prohibited.json
```

**Automatyczne remediowanie przez Lambda:**
```python
# Lambda wyzwalana przez CloudWatch Event gdy S3 staje się publiczne
def lambda_handler(event, context):
    bucket_name = event['detail']['requestParameters']['bucketName']
    s3_client.put_public_access_block(
        Bucket=bucket_name,
        PublicAccessBlockConfiguration={
            'BlockPublicAcls': True,
            'IgnorePublicAcls': True,
            'BlockPublicPolicy': True,
            'RestrictPublicBuckets': True
        }
    )
    # Alert do Slack
    notify_security_team(bucket_name)
```

**IAM refactor — least privilege:**
Każdy developer dostał minimalny zakres IAM per projekt zamiast `s3:*` na `*`.

---

## Koszty incydentu

| Pozycja | Kwota |
|---------|-------|
| Prawnik (RODO — 43 klientów = 43 zawiadomienia) | 28 000 PLN |
| UODO zgłoszenie i doradztwo | 15 000 PLN |
| Utracone kontrakty (5 klientów wypowiedziało umowy) | 420 000 PLN ARR |
| Wdrożenie bezpieczeństwa (AWS Security Hub, Prowler, IaC) | 25 000 PLN |
| **Łącznie** | **~488 000 PLN** |

Koszt prewencji (AWS Security Hub + podstawowe CSPM): **~3 000 PLN/rok**.

---

## Wnioski

1. **Shared Responsibility musi być szkolone** — developer nie rozumiał że "Block Public Access" w AWS jest krytyczną konfiguracją bezpieczeństwa
2. **CSPM to minimum** — AWS Security Hub wykrywa publiczne S3 od razu, koszt niski
3. **Automatyczne remediowanie** — zamiast alertu który czeka na człowieka, Lambda automatycznie przywraca bezpieczną konfigurację
4. **CloudTrail zawsze włączony** — bez logów API nie możesz wiedzieć czy doszło do eksfiltracji

---

## Pytania do dyskusji

1. Developer nie rozumiał implikacji ustawień S3. Jak szkolić developerów z bezpieczeństwa chmury?
2. Jak zaprojektować IAM żeby developer mógł tworzyć buckety S3 ale nigdy nie mógł ich upublicznić?
3. CloudTrail był wyłączony — co to oznacza dla możliwości ustalenia zasięgu naruszenia?

---

*Przypadek syntetyczny, typowy wzorzec misconfiguracji S3 według raportów Verizon DBIR i AWS Security bulletins.*
