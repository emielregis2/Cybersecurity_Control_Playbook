# Moduł 13: Bezpieczeństwo chmury

**Rozdział 13 · Jason Edwards, *The Cybersecurity Control Playbook* (Wiley, 2025)**

> W chmurze możesz stracić wszystko przez jedno złe ustawienie w konsoli. Nie przez hakerów z Rosji — przez checkbox który ktoś kliknął nie rozumiejąc konsekwencji.

---

## Rewolucja chmury i nowe zagrożenia

Chmura zmieniła fundamentalnie sposób budowania i utrzymywania systemów. Zamiast miesięcy konfiguracji sprzętu — minuty do uruchomienia serwera. Zamiast kupowania pojemności z wyprzedzeniem — skalowanie na żądanie. Zamiast lokalnego data center — globalna infrastruktura.

Ale chmura stworzyła też nowe kategorie ryzyk:

**Misconfiguration jako główny wektor ataków**
Gartner szacuje że do 2025 roku 99% incydentów chmurowych będzie wynikiem błędów konfiguracyjnych po stronie klienta, nie dostawcy. Otwarte S3 buckety, nadmierne uprawnienia IAM, brakujące szyfrowanie — to najczęstsze przyczyny naruszeń chmurowych.

**Rozszerzenie powierzchni ataku**
API-first architektura chmury oznacza że każda usługa ma API dostępne z internetu. Błąd w konfiguracji = publiczny dostęp do zasobów.

**Złożoność multi-cloud**
Organizacje używają przeciętnie 3–4 dostawców chmury. Różne modele bezpieczeństwa, różne narzędzia, trudność w centralnym zarządzaniu.

---

## Shared Responsibility Model

Fundamentalna zasada bezpieczeństwa w chmurze: odpowiedzialność jest podzielona między dostawcę chmury a klienta. Granica podziału zależy od modelu usługi.

### IaaS (Infrastructure as a Service) — np. AWS EC2, Azure VM

**Dostawca odpowiada za:**
- Fizyczne bezpieczeństwo data center
- Bezpieczeństwo hiperwizora i sprzętu
- Bezpieczeństwo sieci fizycznej
- Dostępność infrastruktury

**Klient odpowiada za:**
- System operacyjny (patching, hardening)
- Middleware i runtime
- Aplikacje
- Dane
- Konfigurację sieci wirtualnej (Security Groups, VPC)
- Zarządzanie tożsamością i dostępem (IAM)
- Szyfrowanie danych

### PaaS (Platform as a Service) — np. AWS RDS, Azure App Service

**Dostawca** dodatkowo zarządza: OS, middleware, runtime.
**Klient** odpowiada za: aplikację, dane, konfigurację, IAM.

### SaaS (Software as a Service) — np. Microsoft 365, Salesforce

**Dostawca** zarządza: wszystkim poza danymi i dostępem użytkowników.
**Klient** odpowiada za: dane, zarządzanie kontami użytkowników, konfigurację dostępu.

**Najczęstszy błąd:** klient myśli że dostawca chmury odpowiada za więcej niż faktycznie. AWS nie chroni przed otwartym S3 bucketem — klient go otworzył.

---

## AWS Security — kluczowe usługi

### IAM (Identity and Access Management)

Zarządzanie tożsamościami i dostępem w AWS. Najważniejsza usługa bezpieczeństwa AWS — błędy IAM są przyczyną większości incydentów chmurowych.

**Kluczowe zasady IAM:**
- **Least Privilege:** polityki IAM z minimalnymi uprawnieniami. Unikaj `"Action": "*"` i `"Resource": "*"`.
- **Brak kluczy Root:** konto root AWS nie powinno być używane do codziennej pracy. Wyłącz MFA root account nigdy nie wyłączaj.
- **IAM Roles zamiast Users dla aplikacji:** aplikacje powinny używać IAM Roles (tymczasowe, rotowane automatycznie) nie IAM Users z kluczami dostępu.
- **Access Analyzer:** narzędzie AWS które wykrywa zbyt szerokie polityki IAM.

**Przykład podatnej polityki IAM:**
```json
{
  "Effect": "Allow",
  "Action": "*",
  "Resource": "*"
}
```
Daje pełny dostęp do wszystkiego — Admin bez granic.

**Przykład bezpiecznej polityki IAM (least privilege):**
```json
{
  "Effect": "Allow",
  "Action": ["s3:GetObject", "s3:PutObject"],
  "Resource": "arn:aws:s3:::my-specific-bucket/*"
}
```

### Security Groups i VPC

**VPC (Virtual Private Cloud):** izolowana sieć wirtualna w AWS. Odpowiednik sieci firmowej w chmurze — z możliwością segmentacji przez subnets, route tables, gateways.

**Security Groups:** statefull firewall na poziomie instancji. Zasada: "deny by default" — zezwalasz tylko na potrzebny ruch.

**Błąd numer 1:** `0.0.0.0/0` na port 22 (SSH) lub 3389 (RDP) w Security Group. Otwiera dostęp z całego internetu. Prawidłowo: dostęp SSH/RDP tylko z konkretnych IP (bastion host lub VPN).

**NACLs (Network Access Control Lists):** stateless firewall na poziomie subnetu. Uzupełnia Security Groups.

### CloudTrail — audyt API

AWS CloudTrail loguje każde wywołanie API w koncie AWS — kto co zrobił, kiedy, z jakiego IP. Niezbędne dla audytu i forensics.

**Podstawowe zasady CloudTrail:**
- Włącz CloudTrail w każdym regionie
- Przechowuj logi w oddzielnym, chronionym S3 bucket (z MFA Delete)
- Monitoruj CloudTrail przez AWS Security Hub lub zewnętrzny SIEM

### AWS Security Hub

Centralne miejsce zarządzania bezpieczeństwem w AWS — agreguje wyniki z: GuardDuty, Inspector, Config, Macie, IAM Access Analyzer. Dashboard pokazujący "security score" konta AWS.

### GuardDuty — detekcja zagrożeń

Managed threat detection — AWS analizuje CloudTrail, VPC Flow Logs, DNS logs i wykrywa anomalie:
- Nieoczekiwane wywołania API z podejrzanych IP
- Komunikacja z known malicious IP/domain
- Nieautoryzowany dostęp do EC2 z Tor
- Crypto mining aktywność

### Amazon Macie

Odkrywanie i ochrona wrażliwych danych w S3. Używa ML do wykrywania PII (PESEL, numery kart, hasła) w plikach S3 — alert gdy znajdzie wrażliwe dane w niezabezpieczonym buckecie.

---

## Azure Security — kluczowe usługi

### Microsoft Entra ID (Azure AD)

Zarządzanie tożsamościami dla Microsoft 365 i Azure. Kluczowe funkcje bezpieczeństwa:
- **Conditional Access:** dostęp zależny od warunków (lokalizacja, urządzenie, ryzyko)
- **Identity Protection:** wykrywanie ryzykownych logowań (anomalie, leaked credentials)
- **Privileged Identity Management (PIM):** JIT dostęp do ról uprzywilejowanych
- **MFA:** wymaganie dodatkowego czynnika

### Microsoft Defender for Cloud

CSPM (Cloud Security Posture Management) + CWPP (Cloud Workload Protection Platform) dla Azure, AWS i GCP. Dashboard bezpieczeństwa z:
- Secure Score (0–100) — ocena konfiguracji bezpieczeństwa
- Recommendations — konkretne sugestie poprawy
- Threat protection dla VM, kontenery, bazy danych

### Azure Policy

Zarządzanie governance — wymuszanie standardów konfiguracji przez organizację:
```json
{
  "if": {
    "field": "Microsoft.Storage/storageAccounts/supportsHttpsTrafficOnly",
    "equals": "false"
  },
  "then": {
    "effect": "deny"
  }
}
```
Ta polityka blokuje tworzenie Storage Accounts bez wymuszenia HTTPS.

---

## GCP Security — kluczowe usługi

### Cloud IAM

Podobnie jak AWS IAM — zarządzanie dostępem do zasobów GCP. Specyfika GCP: **podmiot (Principal)** może być: user, service account, grup, lub domain.

**Service Accounts:** konta dla aplikacji i VM. Zasada: każda aplikacja ma osobne service account z minimalnymi uprawnieniami.

### VPC Service Controls

Tworzenie security perimetrów wokół usług GCP — usługi wewnątrz perimetru mogą się komunikować, ruch wychodzący jest ograniczony. Zapobiega eksfiltracji danych przez misconfigured API.

### Security Command Center

Centralne miejsce zarządzania bezpieczeństwem GCP — wykrywa misconfiguracje, zagrożenia, podatności w projektach GCP.

---

## CSPM — Cloud Security Posture Management

**CSPM** to kategoria narzędzi automatycznie skanujących konfiguracje zasobów chmurowych pod kątem odchyleń od best practices bezpieczeństwa.

**Co wykrywa CSPM:**
- Publiczne S3 buckety / Storage Blobs / GCS buckets
- Security Groups z regułami 0.0.0.0/0
- Brak szyfrowania dla baz danych RDS
- Brak włączonego CloudTrail / Audit Logs
- Nadmiernie szerokie polityki IAM
- Brak MFA dla użytkowników root/admin
- Publiczne snapshoty dysków
- Niezaszyfrowane EBS volumes

**Narzędzia CSPM:**
- **Wbudowane:** AWS Security Hub, Microsoft Defender for Cloud, GCP Security Command Center
- **Multi-cloud:** Wiz, Prisma Cloud (Palo Alto), Orca Security, Lacework
- **Open-source:** Prowler (AWS), ScoutSuite, CloudSploit

**Prowler** (open-source) to szczególnie użyteczne narzędzie — skanuje konto AWS pod kątem CIS AWS Benchmark i własnych sprawdzeń:
```bash
prowler aws --region eu-central-1 --checks check11 check12 check14
```

---

## Zero Trust w chmurze

Tradycyjny model perimetru (VPN do data center) nie działa gdy aplikacje i dane są w chmurze. ZTNA (Zero Trust Network Access) zastępuje VPN:

**Zasady Zero Trust w chmurze:**
- **Identity-first:** każde żądanie autoryzowane przez tożsamość, nie lokalizację sieciową
- **Least Privilege:** dostęp tylko do konkretnych aplikacji/zasobów, nie do całej sieci
- **Device compliance:** urządzenie musi spełniać wymagania przed uzyskaniem dostępu
- **Continuous verification:** weryfikacja przy każdym żądaniu, nie tylko przy logowaniu

**Implementacje ZTNA:** Zscaler Private Access, Cloudflare Access, Microsoft Entra Private Access, Google BeyondCorp.

---

## Multi-cloud Security

**Wyzwania multi-cloud:**
- Różne modele IAM, różne polityki szyfrowania, różne logi
- Brak centralnej widoczności
- Trudność w egzekwowaniu spójnych polityk
- Skomplikowane sieci (VPC peering, Transit Gateway, ExpressRoute)

**Podejście:**
- **CNAPP (Cloud-Native Application Protection Platform):** narzędzia unifikujące CSPM, CWPP, CIEM (Cloud Infrastructure Entitlement Management) dla wszystkich chmur
- **Spójne polityki:** definiowane centralnie, egzekwowane wszędzie (Terraform + Policy as Code)
- **Centralne logowanie:** wszystkie logi do jednego SIEM niezależnie od dostawcy

---

## Kluczowe wnioski z modułu 13

**1. Misconfiguration to #1 zagrożenie w chmurze**
Nie zaawansowani hakerzy — błędy konfiguracyjne. CSPM jako ciągły monitoring jest niezbędny.

**2. Shared Responsibility musi być rozumiany przez wszystkich**
Developerzy którzy deployują do chmury muszą rozumieć za co odpowiadają — nie można założyć że "AWS to ogarnie".

**3. IAM to fundament bezpieczeństwa chmury**
Błędy IAM (zbyt szerokie uprawnienia, brak MFA, używanie root) są przyczyną większości poważnych incydentów.

**4. Infrastructure as Code + Policy as Code = skalowalne bezpieczeństwo**
Ręczne konfigurowanie konsol nie skaluje. IaC (Terraform) + CSPM + Policy as Code (OPA, Sentinel) pozwala na egzekwowanie polityk bezpieczeństwa przy każdym deploymencie.

**5. Zero Trust zastępuje VPN w chmurze**
Perimeter VPN nie chroni zasobów chmurowych. ZTNA daje granularny dostęp do konkretnych aplikacji z weryfikacją tożsamości i urządzenia.

---

## Terminologia — słownik modułu 13

| Termin | Definicja |
|--------|-----------|
| IaaS/PaaS/SaaS | Modele usług chmurowych (Infrastructure/Platform/Software as a Service) |
| Shared Responsibility | Podział odpowiedzialności bezpieczeństwa między dostawcę a klienta |
| IAM | Identity and Access Management — zarządzanie tożsamością w chmurze |
| Least Privilege | Minimalne uprawnienia potrzebne do wykonania zadania |
| Security Group | Statefull firewall na poziomie instancji w AWS/Azure |
| VPC | Virtual Private Cloud — izolowana sieć wirtualna |
| CSPM | Cloud Security Posture Management — skanowanie misconfiguracji |
| CWPP | Cloud Workload Protection Platform — ochrona workloadów |
| CNAPP | Cloud-Native Application Protection Platform |
| GuardDuty | AWS managed threat detection — wykrywanie zagrożeń przez ML |
| Macie | AWS — wykrywanie wrażliwych danych w S3 |
| CloudTrail | AWS — audit log każdego wywołania API |
| Conditional Access | Azure — dostęp warunkowy zależny od tożsamości/urządzenia/lokalizacji |
| Zero Trust | Model bezpieczeństwa: weryfikuj każdego, niezależnie od lokalizacji |
| ZTNA | Zero Trust Network Access — dostęp do aplikacji bez VPN |
| Policy as Code | Polityki bezpieczeństwa zakodowane w kodzie, automatycznie egzekwowane |
| Prowler | Open-source narzędzie do audytu bezpieczeństwa AWS |

---

*Źródła: Jason Edwards, The Cybersecurity Control Playbook (Wiley, 2025), rozdział 13; AWS Security Best Practices; Microsoft Azure Security Benchmark; Google Cloud Security Best Practices; CIS AWS Foundations Benchmark; Gartner Cloud Security Reports 2024.*
