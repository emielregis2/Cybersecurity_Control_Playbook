# Moduł 14: Bezpieczeństwo łańcucha dostaw

**Rozdział 14 · Jason Edwards, *The Cybersecurity Control Playbook* (Wiley, 2025)**

> SolarWinds pokazał że możesz zrobić wszystko dobrze i nadal zostać zaatakowanym przez oprogramowanie które kupiłeś od zaufanego dostawcy. Łańcuch dostaw to rozszerzenie Twojej powierzchni ataku poza Twoje mury.

---

## Czym jest zagrożenie łańcucha dostaw

**Supply Chain Attack** — atakujący kompromituje system ofiary nie przez bezpośredni atak, ale przez przejęcie zaufanego dostawcy, oprogramowania, komponentu lub partnera.

Logika jest prosta i przerażająca: jeśli firma A jest trudna do zaatakowania bezpośrednio, a firma A ufa dostawcy B — atak na B daje dostęp do A.

**Skala problemu:** CISA raportuje że supply chain ataki wzrosły o 742% w latach 2019–2022. SolarWinds (2020), Log4Shell (2021), 3CX (2023), XZ Utils (2024) — każdy z tych incydentów dotknął tysiące organizacji przez kompromitację jednego oprogramowania lub komponentu.

---

## Kategorie zagrożeń łańcucha dostaw

### 1. Software Supply Chain — kompromitacja kodu

**Typosquatting:** złośliwy pakiet o nazwie podobnej do popularnego (`requesst` zamiast `requests`, `colourama` zamiast `colorama`). Programiści przypadkowo instalują złośliwy pakiet.

**Dependency Confusion:** atakujący publikuje złośliwy pakiet w publicznym registry (PyPI, npm) o tej samej nazwie co wewnętrzny pakiet firmy — menedżer pakietów pobiera publiczny zamiast wewnętrznego.

**Compromised Maintainer:** przejęcie konta opiekuna popularnej biblioteki open-source i dodanie złośliwego kodu do nowej wersji. XZ Utils (2024) — backdoor wstrzyknięty przez projekt społeczny trwający ponad 2 lata.

**Build System Compromise:** kompromitacja systemu CI/CD lub procesu budowania — złośliwy kod wstrzykiwany podczas budowania oprogramowania. SolarWinds SUNBURST (2020) — złośliwy kod w procesie budowania oprogramowania SolarWinds Orion.

**Malicious Update:** dostawca oprogramowania kompromitowany i złośliwa aktualizacja dystrybuowana do klientów. 3CX Desktop App (2023) — aktualizator 3CX zawierał malware.

### 2. Third-Party Software Risk

Każda aplikacja SaaS, biblioteka, SDK czy API którą używasz to potencjalny wektor. Typowa aplikacja enterprise używa:
- 500–1000 bibliotek open-source (bezpośrednich i tranzytywnych zależności)
- 30–50 integracji SaaS
- Dziesiątek partnerów z dostępem API

Każda z tych zależności ma własny profil ryzyka bezpieczeństwa.

### 3. Hardware Supply Chain

Kompromitacja sprzętu przed dostarczeniem do klienta — chipy, routery, serwery. Mniej powszechna, ale bardzo groźna gdy wystąpi. Przykład: Bloomberg raportował (kontrowersyjnie) o mikrochipach dodanych przez chińskich producentów do serwerów Supermicro.

### 4. Service Provider (MSSP, IT outsourcing)

Firmy obsługujące IT wielu klientów jednocześnie (MSSP, MSP) są atrakcyjnym celem — kompromitacja jednego dostawcy daje dostęp do setek klientów. Kaseya VSA (2021): REvil zaatakował Kaseya → oprogramowanie do zarządzania IT w 1500 firmach zostało zaszyfrowane ransomware.

---

## SBOM — Software Bill of Materials

**SBOM (Software Bill of Materials)** to formalny, maszynowo-czytelny spis wszystkich komponentów oprogramowania: biblioteki, zależności, wersje, licencje.

Analogia: lista składników na opakowaniu jedzenia. Gdy odkryto że dany konserwant jest szkodliwy — możesz szybko sprawdzić które produkty go zawierają. SBOM daje to samo dla oprogramowania: gdy wychodzi krytyczny CVE dla log4j — możesz w minuty sprawdzić które Twoje aplikacje go zawierają.

### Formaty SBOM

**SPDX (Software Package Data Exchange):** standard Linux Foundation, ISO/IEC 5962:2021.

**CycloneDX:** standard OWASP, zaprojektowany pod security use cases — zawiera informacje o podatnościach, licencjach, integralności.

**SWID (Software Identification Tags):** ISO/IEC 19770-2, stosowany głównie przez firmy enterprise.

### Generowanie SBOM

```bash
# CycloneDX dla Python
pip install cyclonedx-bom
cyclonedx-py -o sbom.json

# Syft — multi-ecosystem SBOM generator
syft myapp:latest -o cyclonedx-json > sbom.json

# GitHub — automatyczne SBOM dla repozytoriów
# Settings → Security → Export SBOM
```

### SBOM w CI/CD pipeline

```yaml
# GitHub Actions — generowanie SBOM przy każdym release
- name: Generate SBOM
  uses: anchore/sbom-action@v0
  with:
    image: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}
    format: cyclonedx-json
    output-file: sbom.cyclonedx.json

- name: Upload SBOM
  uses: actions/upload-artifact@v3
  with:
    name: sbom
    path: sbom.cyclonedx.json
```

### SBOM w regulacjach

**US Executive Order 14028 (2021):** wymaga SBOM dla oprogramowania sprzedawanego rządowi USA. Praktycznie wszyscy dostawcy rządowi muszą dostarczać SBOM.

**EU Cyber Resilience Act (CRA):** planowane wymagania SBOM dla produktów cyfrowych na rynek UE.

---

## Zarządzanie ryzykiem dostawców (Third-Party Risk Management)

### Inwentaryzacja dostawców

Pierwszy krok: wiedzieć kto ma dostęp do czego. Typowa organizacja ma setki dostawców — część z dostępem do danych, część z dostępem do systemów, część z dostępem do kodu.

Kategorie dostawców według ryzyka:
- **Critical:** dostęp do danych produkcyjnych lub systemów krytycznych
- **High:** dostęp do środowisk nieprodukcyjnych lub danych niekrytycznych
- **Medium:** integracje API bez dostępu do wrażliwych danych
- **Low:** narzędzia bez dostępu do danych klientów

### Due Diligence przed wyborem dostawcy

Dla dostawców Critical/High:
- Certyfikaty bezpieczeństwa: SOC 2 Type II lub ISO 27001 (nie starsze niż 1 rok)
- Security questionnaire (SIG — Standardized Information Gathering, CAIQ — Consensus Assessment Initiative Questionnaire)
- Penetration testing report summary
- Incident response capability assessment
- Financial stability (upadłość dostawcy = utrata dostępu do kluczowego systemu)
- Subprocesor/subcontractors (czy dostawca sam korzysta z dostawców z dostępem do Twoich danych?)

### Kontraktowe wymagania bezpieczeństwa

Każda umowa z dostawcą mającym dostęp do danych powinna zawierać:
- **DPA (Data Processing Agreement)** — wymagany przez RODO
- **SLA bezpieczeństwa:** czas notyfikacji o incydencie (max 24–48h), czas remediation
- **Prawo do audytu** (lub akceptacja certyfikatu jako ekwiwalentu)
- **Minimalne standardy bezpieczeństwa** (MFA, szyfrowanie, patch management)
- **Procedura offboardingu:** jak dane są usuwane po zakończeniu umowy

### Ciągłe monitorowanie dostawców

Jednorazowy due diligence przy podpisaniu umowy to za mało. Monitorowanie ciągłe:
- Automatyczne alerty gdy dostawca ma nowy incydent bezpieczeństwa (np. przez SecurityScorecard, BitSight)
- Roczny przegląd certyfikatów (SOC 2 Type II — aktualna data?)
- Monitorowanie CVE w produktach dostawców (CISA KEV — Known Exploited Vulnerabilities)

**SecurityScorecard i BitSight** — platformy które automatycznie oceniają zewnętrzne bezpieczeństwo dostawców na podstawie publicznie dostępnych danych (otwarte porty, wycieki haseł, DNS anomalie, certyfikaty SSL). Ocena A–F.

---

## Secure Software Development w kontekście łańcucha dostaw

### NIST SSDF (Secure Software Development Framework)

NIST SP 800-218 definiuje praktyki bezpiecznego wytwarzania oprogramowania:
- **PO (Prepare Organization):** kultura bezpieczeństwa, role, narzędzia
- **PS (Protect Software):** ochrona kodu i procesu buildowania
- **PW (Produce Well-Secured Software):** SAST, SCA, threat modeling
- **RV (Respond to Vulnerabilities):** vulnerability disclosure, patch management

### Zabezpieczenie pipeline CI/CD

CI/CD pipeline to krytyczna infrastruktura — kompromitacja pipeline daje dostęp do całego oprogramowania firmy.

**Kluczowe zabezpieczenia pipeline:**
- **Separacja uprawnień:** pipeline nie powinien mieć praw do modyfikacji własnej konfiguracji
- **Secrets management:** klucze i tokeny w Vault/Secrets Manager, nie w zmiennych środowiskowych CI
- **Pinning zależności:** zamiast `requests>=2.0` używaj `requests==2.28.1` — zapobiega niespodziewanemu pobraniu nowej, złośliwej wersji
- **Weryfikacja integralności:** sprawdzanie hash/podpisu pobieranych pakietów
- **Least privilege dla service accounts:** konto pipeline ma dostęp tylko do potrzebnych zasobów

```yaml
# Pinning GitHub Actions na konkretny hash (nie tag)
# Zły (podatny na tag override):
uses: actions/checkout@v3

# Dobry (pinning na konkretny commit SHA):
uses: actions/checkout@b4ffde65f46336ab88eb53be808477a3936bae11
```

### SLSA (Supply-chain Levels for Software Artifacts)

Framework Google/CISA definiujący cztery poziomy dojrzałości bezpieczeństwa procesu buildowania:

- **SLSA Level 1:** build jest automatyczny i skryptowany
- **SLSA Level 2:** build używa kontrolowanego systemu CI z auditem
- **SLSA Level 3:** build jest hermetyczny (hermetic build) — wyizolowany, powtarzalny
- **SLSA Level 4:** build jest dwuosobowo zatwierdzony, w pełni audytowalny

---

## Odpowiedź na incydent supply chain

Gdy wychodzi informacja o kompromitacji biblioteki/oprogramowania (np. nowy CVE dla Log4j):

**Godzina 0–4: Identyfikacja wpływu**
1. Sprawdź SBOM wszystkich aplikacji — które zawierają podatną wersję?
2. Jeśli brak SBOM — przeszukaj kod źródłowy i package.json/requirements.txt/pom.xml
3. Oceń exploitowalność: czy podatność jest osiągalna w Twojej konfiguracji?

**Godzina 4–24: Priorytetyzacja i plany**
1. Dla każdej podatnej aplikacji: czy jest dostępna łatka?
2. Czy istnieje workaround (mitigacja bez aktualizacji)?
3. Priorytet: aplikacje produkcyjne z dostępem z internetu najpierw

**Dzień 1–7: Remediation**
1. Deploy łatek z normalnym procesem change management (przyspieszone dla CRITICAL)
2. Aktywuj WAF reguły blokujące znane exploitation patterns
3. Monitoruj logi pod kątem prób exploitacji

**Lekcja z Log4Shell:** organizacje z aktualnym SBOM poradziły sobie w godziny. Organizacje bez SBOM — tygodnie szukania "czy używamy Log4j?"

---

## Kluczowe wnioski z modułu 14

**1. Łańcuch dostaw jest rozszerzeniem Twojej powierzchni ataku**
Twoje bezpieczeństwo jest tak silne jak bezpieczeństwo Twoich najsłabszych dostawców. Nie możesz ignorować tego ryzyka.

**2. SBOM to must-have w erze open-source**
Bez SBOM nie wiesz co jest w Twoim oprogramowaniu. Z SBOM — reagujesz w godziny na nowe CVE zamiast tygodniami szukać ekspozycji.

**3. Nie tylko duże firmy są celem**
Kaseya VSA dotknął małe firmy IT (MSP) — bo były łatwymi celami z dostępem do wielu klientów. Małe firmy mogą być "stepping stone" do większych celów.

**4. Due diligence dostawców to ciągły proces**
Jednorazowy przegląd przy podpisaniu umowy jest niewystarczający. Dostawcy się zmieniają, certyfikaty wygasają, incydenty się zdarzają.

**5. Pinning zależności i weryfikacja integralności**
Proste działania techniczne (pinowanie wersji, sprawdzanie hash, podpisywanie pakietów) znacząco redukują ryzyko typosquatting i dependency confusion.

---

## Terminologia — słownik modułu 14

| Termin | Definicja |
|--------|-----------|
| Supply Chain Attack | Atak przez kompromitację zaufanego dostawcy lub komponentu |
| SBOM | Software Bill of Materials — spis komponentów oprogramowania |
| SCA | Software Composition Analysis — skanowanie podatności w zależnościach |
| Typosquatting | Złośliwy pakiet o nazwie podobnej do popularnego |
| Dependency Confusion | Atak przez publikację pakietu w public registry o nazwie jak wewnętrzny |
| SLSA | Supply-chain Levels for Software Artifacts — poziomy bezpieczeństwa buildu |
| SSDF | NIST Secure Software Development Framework |
| DPA | Data Processing Agreement — umowa przetwarzania danych (RODO) |
| SecurityScorecard | Platforma automatycznej oceny zewnętrznego bezpieczeństwa dostawców |
| TPRM | Third-Party Risk Management — zarządzanie ryzykiem dostawców |
| SIG | Standardized Information Gathering — kwestionariusz bezpieczeństwa dostawców |
| CAIQ | Consensus Assessment Initiative Questionnaire (CSA) |
| CycloneDX | Format SBOM (OWASP) |
| SPDX | Software Package Data Exchange — format SBOM (Linux Foundation) |
| Pinning | Zablokowanie zależności na konkretną wersję/hash |
| Hermetic Build | Build izolowany od zewnętrznych wpływów, w pełni powtarzalny |

---

*Źródła: Jason Edwards, The Cybersecurity Control Playbook (Wiley, 2025), rozdział 14; CISA Software Supply Chain Security Guidance; NIST SP 800-218 (SSDF); SLSA Framework (slsa.dev); OWASP CycloneDX; NSA/CISA Enduring Security Framework Supply Chain Risk Management.*
