# Case Study: GovTechPL Sp. z o.o. — Wdrożenie NIST 800-53 dla systemu rządowego

**Moduł 10 · NIST SP 800-53 w praktyce**

---

## Kontekst organizacji

**GovTechPL Sp. z o.o.** to polska firma IT świadcząca usługi dla sektora publicznego. Wygrała przetarg na budowę i utrzymanie systemu obsługującego wnioski o świadczenia społeczne dla jednej z ministerstw. System przetwarza dane wrażliwe: PESEL, dane dochodowe, informacje o niepełnosprawności, dane dzieci.

**Wymagania kontraktu:**
- System musi spełniać wymagania NIST SP 800-53 Rev. 5 (wymóg ministerstwa wzorującego się na standardach NATO i USA)
- Audyt bezpieczeństwa co roku przez akredytowanego audytora
- Dokumentacja SSP (System Security Plan) jako warunek odbioru
- Poziom systemu: MODERATE (dane osobowe wrażliwe, ale nie tajne)

**Infrastruktura:**
- AWS GovCloud (eu-west-1) — izolowana infrastruktura AWS dla sektora publicznego
- Aplikacja webowa (React + Node.js API + PostgreSQL)
- Integracje: ZUS API, PESEL API, e-Urząd
- Użytkownicy: 1 200 urzędników z dostępem, 180 000 obywateli z dostępem do własnych danych

**Zespół GovTechPL:** 45 pracowników, w tym 8 dedykowanych do projektu ministerialnego. Nowy CISO: Piotr Nowak (certyfikaty: CISSP, CISM).

---

## Krok 1: Kategoryzacja systemu (NIST SP 800-60)

Piotr Nowak przeprowadza formalną kategoryzację używając NIST SP 800-60:

| Wymiar bezpieczeństwa | Uzasadnienie | Poziom |
|----------------------|-------------|--------|
| Confidentiality | Dane osobowe + dane dochodowe + dane o niepełnosprawności — naruszenie = poważna szkoda dla osób | HIGH |
| Integrity | Manipulacja danymi może spowodować błędne przyznanie/odmowę świadczeń — poważny wpływ | MODERATE |
| Availability | Niedostępność przez kilka dni = problemy operacyjne urzędów — poważny wpływ | MODERATE |

**Wynik kategoryzacji:** `{HIGH, MODERATE, MODERATE}` → System kategorii **HIGH** (najwyższy z wymiarów).

Decyzja: ministerstwo zgadza się na "tailoring down" do MODERATE baseline z dodatkowymi kontrolami dla poufności HIGH. Kompromis między kosztem a ryzykiem.

---

## Krok 2: Wybór i tailoring kontroli

Na podstawie NIST SP 800-53B (MODERATE baseline) — lista 323 wymaganych kontroli. Piotr przeprowadza tailoring:

**Scoping — kontrole wyłączone:**
- **PE (Physical and Environmental Protection):** system w AWS GovCloud — fizyczna ochrona po stronie AWS (shared responsibility). Wyłączono PE-1 przez PE-20. Udokumentowano uzasadnienie + odpowiednie sekcje AWS Shared Responsibility Model.
- **MA-3, MA-4 (Maintenance Tools, Nonlocal Maintenance):** nie dotyczy systemu SaaS bez fizycznego sprzętu na miejscu.

**Wzmocnienia (upgrades) dla HIGH confidentiality:**
- **AC-2(12):** dodatkowy monitoring kont uprzywilejowanych (upgrade z MODERATE)
- **AU-9(3):** kryptograficzna ochrona logów (upgrade — podpis cyfrowy każdego rekordu logu)
- **SC-28(1):** kryptograficzne mechanizmy ochrony danych w spoczynku (AES-256 wymagane explicitnie)
- **IA-2(6):** MFA dla dostępu przez sieć zewnętrzną — TOTP lub hardware token (upgrade)

**Compensating controls:**
- **SA-9 External System Services:** GovTechPL korzysta z API ZUS i PESEL — zewnętrzne systemy rządowe. Nie można wymagać od ZUS implementacji kontroli 800-53. Compensating control: kryptograficzna weryfikacja odpowiedzi API (podpis kwalifikowany), monitoring anomalii w odpowiedziach, SLA w kontrakcie.

**Wynik tailoring:** 287 aktywnych kontroli (spośród 323 MODERATE baseline), 36 wyłączonych z uzasadnieniem, 6 ulepszeń dla HIGH confidentiality.

---

## Krok 3: System Security Plan (SSP)

GovTechPL tworzy SSP w formacie OSCAL (JSON) — umożliwia automatyczną weryfikację i integrację z narzędziami audytowymi.

**Struktura SSP (wybrane sekcje):**

```json
{
  "system-security-plan": {
    "metadata": {
      "title": "SSP: System Obsługi Świadczeń Społecznych v1.2",
      "last-modified": "2026-03-15",
      "version": "1.2"
    },
    "system-characteristics": {
      "system-name": "SOSS (System Obsługi Świadczeń Społecznych)",
      "security-impact-level": {
        "security-objective-confidentiality": "high",
        "security-objective-integrity": "moderate",
        "security-objective-availability": "moderate"
      }
    },
    "control-implementation": {
      "implemented-requirements": [
        {
          "control-id": "ac-2",
          "description": "System implementuje AC-2 przez: (a) zdefiniowane typy kont: indywidualne (urzędnicy), serwisowe (integracje API), obywatele (read-only własne dane); (b) account managers: administratorzy systemu z każdego urzędu; (c) warunki: weryfikacja tożsamości przez ePUAP przed aktywacją konta...",
          "by-components": [
            {
              "component-uuid": "aws-iam-component",
              "description": "AWS IAM zarządza uprawnieniami API i serwisów"
            }
          ]
        }
      ]
    }
  }
}
```

SSP zawiera 287 sekcji (jedna na kontrolę) — łącznie 340 stron dokumentacji.

---

## Krok 4: Implementacja kluczowych kontroli

### AC-2 Account Management — implementacja

**Typy kont:**
- Urzędnik (standardowy): dostęp do wniosków swojego urzędu, brak exportu
- Urzędnik (senior): dostęp do raportów, możliwość podglądu historii
- Administrator urzędu: zarządzanie kontami w obrębie urzędu
- GovTechPL admin: pełny dostęp tylko przez JIT (15 minut, z zatwierdzeniem)
- Konto serwisowe: bez logowania interaktywnego, ograniczone do konkretnych API endpoints
- Obywatel: tylko własne wnioski (read-only)

**Automatyzacja:**
- Provisioning kont urzędników: integracja z LDAP ministerstwa — konto tworzone automatycznie gdy urzędnik pojawia się w LDAP
- Dezaktywacja: gdy pracownik znika z LDAP → konto dezaktywowane następnego dnia (nie natychmiastowo — czas na synchronizację)
- Przegląd kont: kwartalny — każdy administrator urzędu certyfikuje listę aktywnych kont przez panel administracyjny

### AU-9(3) — Kryptograficzna ochrona logów

Każdy rekord logu jest podpisywany cyfrowo kluczem asymetrycznym:
```python
import hashlib, hmac, json
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import padding

def sign_log_entry(entry: dict, private_key) -> dict:
    entry_json = json.dumps(entry, sort_keys=True).encode()
    signature = private_key.sign(entry_json, padding.PKCS1v15(), hashes.SHA256())
    entry['signature'] = signature.hex()
    entry['signed_at'] = datetime.utcnow().isoformat()
    return entry
```

Klucz prywatny przechowywany w AWS KMS (Key Management Service) — niedostępny bezpośrednio dla żadnego pracownika. Weryfikacja podpisu przez audytora potwierdza że logi nie były modyfikowane.

### RA-5 Vulnerability Management — implementacja

**Pipeline skanowania:**
1. Budowanie obrazu Docker → Trivy scan (CRITICAL/HIGH blokują deployment)
2. Co tydzień: AWS Inspector skanuje wszystkie działające kontenery
3. Co miesiąc: Burp Suite scan aplikacji webowej (OWASP Top 10)
4. SLA naprawy: CRITICAL ≤24h, HIGH ≤7 dni, MEDIUM ≤30 dni, LOW best effort

**Tracking:**
- Każda podatność = ticket w Jira z SLA datą i właścicielem
- Eskalacja do CISO gdy SLA przekroczony
- Miesięczny raport dla ministerstwa: liczba wykrytych, naprawionych, otwartych według severity

---

## Krok 5: Audyt i wyniki

Po 8 miesiącach wdrożenia, zewnętrzny audytor (akredytowany przez NIST/FedRAMP) przeprowadza assessment:

**Zakres audytu:** 287 aktywnych kontroli

**Wyniki:**

| Rodzina | Kontrole | Wdrożone | Częściowe | Niezgodne |
|---------|---------|---------|---------|---------|
| AC | 22 | 20 | 2 | 0 |
| AU | 14 | 12 | 1 | 1 |
| CM | 11 | 10 | 1 | 0 |
| IA | 11 | 11 | 0 | 0 |
| IR | 9 | 8 | 1 | 0 |
| SC | 38 | 35 | 3 | 0 |
| SI | 19 | 17 | 2 | 0 |
| Pozostałe | 163 | 158 | 4 | 1 |
| **RAZEM** | **287** | **271 (94%)** | **14 (5%)** | **2 (1%)** |

**2 niezgodności (Findings):**
1. **AU-11:** Logi w hot storage przechowywane 60 dni zamiast wymaganych 90 dni w SSP (parametr zdefiniowany w SSP jako 90 dni, implementacja — 60 dni). Znalezisko HIGH.
2. **SI-3(7):** Automatyczne aktualizacje definicji malware dla serwera plików — przerwa 36 godzin przy jednej aktualizacji udokumentowana w logach. Znalezisko MEDIUM.

**Plan naprawczy:**
- AU-11: poprawka konfiguracji S3 lifecycle policy → 90 dni. Termin: 5 dni roboczych.
- SI-3(7): dodanie monitoringu aktualności definicji z alertem po 4 godzinach braku aktualizacji. Termin: 2 tygodnie.

**Wynik audytu:** warunkowa akceptacja (conditional ATO equivalent) — wdrożenie planu naprawczego w ciągu 30 dni.

---

## Wnioski dla dyrektora IT

**1. 800-53 jest przytłaczający — tailoring to nie opcja, to konieczność**
323 kontroli MODERATE baseline. Bez tailoring (scoping, parametryzacja) to niemożliwe do wdrożenia. GovTechPL zredukowało do 287 aktywnych — nadal dużo, ale możliwe do zarządzania.

**2. SSP to żywy dokument, nie jednorazowy artefakt**
SSP musi być aktualizowany przy każdej znaczącej zmianie systemu. GovTechPL wdrożył obowiązkowy "security impact analysis" przed każdą zmianą architektury — ocena czy zmiana wymaga aktualizacji SSP.

**3. OSCAL ułatwia audyt i automatyzację**
Format OSCAL pozwolił audytorowi zautomatyzować część weryfikacji. Ręczny przegląd 287 kontroli zajmuje tygodnie — z OSCAL i narzędziami: dni.

**4. Małe szczegóły kończą audyt**
2 niezgodności z 287 kontroli — 99% zgodność. Ale obie niezgodności to błędy implementacyjne vs SSP (zadeklarowano 90 dni, wdrożono 60 dni). Lekcja: SSP i implementacja muszą być zsynchronizowane. Regularne wewnętrzne audyty "SSP vs rzeczywistość" są kluczowe.

**5. 800-53 otwiera kontrakt rządowy i sektor publiczny**
GovTechPL wygrał kontrakt częściowo dzięki deklarowanej znajomości 800-53. To przewaga konkurencyjna na rynku public sector.

---

## Pytania do dyskusji

1. System przetwarza dane PESEL i dane o niepełnosprawności. Dlaczego Confidentiality zostało ocenione jako HIGH, a nie MODERATE? Jakie konkretne konsekwencje naruszenia poufności uzasadniają to?

2. GovTechPL wyłączył rodzinę PE (Physical and Environmental Protection) ze względu na shared responsibility z AWS. Jakie kontrole/dowody powinny być zachowane żeby uzasadnić to wykluczenie audytorowi?

3. Audyt znalazł niezgodność: SSP mówi 90 dni retencji logów, implementacja — 60 dni. Jak zapobiegać takim rozbieżnościom między dokumentacją a rzeczywistością?

4. System integruje się z ZUS API i PESEL API. Kontrola SA-9 wymaga zarządzania ryzykiem zewnętrznych systemów. Jak praktycznie zarządzać ryzykiem gdy nie masz wpływu na bezpieczeństwo ZUS lub PESEL API?

---

*Przypadek opisany na podstawie syntetycznych danych. Scenariusz odzwierciedla typowe wyzwania wdrożenia NIST 800-53 w polskim kontekście public sector z odniesieniem do praktyk FedRAMP i FISMA.*
