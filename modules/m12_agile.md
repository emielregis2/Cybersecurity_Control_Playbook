# Moduł 12: Zwinne bezpieczeństwo — Agile Security i DevSecOps

**Rozdział 12 · Jason Edwards, *The Cybersecurity Control Playbook* (Wiley, 2025)**

> Bezpieczeństwo dodane na końcu jest jak pas bezpieczeństwa przyklejony do samochodu taśmą. Wygląda jak rozwiązanie, ale nie działa kiedy naprawdę potrzeba.

---

## Problem: bezpieczeństwo vs szybkość

Tradycyjny model wytwarzania oprogramowania (Waterfall) miał wyraźną fazę "security review" przed wdrożeniem. W erze Agile i Continuous Delivery ta faza zniknęła — lub stała się wąskim gardłem blokującym szybkość.

Typowy konflikt:
- **Developer:** "Wdrażamy nową funkcję jutro"
- **Security:** "Potrzebujemy tygodniowego code review"
- **Biznes:** "Klient czeka, deployment idzie jutro"
- **Wynik:** security review pominięty albo przeprowadzony symbolicznie

**DevSecOps** rozwiązuje ten problem przez wbudowanie bezpieczeństwa bezpośrednio w proces wytwarzania — nie jako bramkę na końcu, ale jako ciągłą aktywność zintegrowaną z każdym etapem.

Edwards podkreśla: **"Shift Left"** — przesuń bezpieczeństwo jak najwcześniej w cykl wytwarzania. Błąd znaleziony w fazie projektowania kosztuje 10x mniej niż znaleziony w code review, 100x mniej niż znaleziony w produkcji.

---

## Czym jest DevSecOps

**DevSecOps** = Development + Security + Operations — kultura i praktyka gdzie bezpieczeństwo jest wspólną odpowiedzialnością całego zespołu, wbudowaną w każdy etap cyklu życia oprogramowania.

Kluczowe zmiany vs tradycyjne podejście:

| Tradycyjne | DevSecOps |
|-----------|----------|
| Security na końcu | Security od początku (Shift Left) |
| Security jako bramka | Security jako enabler |
| Oddzielny zespół security | Security champions w każdym zespole |
| Roczny pentest | Ciągłe skanowanie w pipeline |
| Ręczne code review | Automatyczne SAST/DAST/SCA |
| "Security vs Speed" | "Security umożliwia speed" |

---

## CI/CD Pipeline — bezpieczeństwo w każdej fazie

Nowoczesny pipeline CI/CD (Continuous Integration / Continuous Delivery) składa się z wielu etapów. DevSecOps integruje kontrole bezpieczeństwa w każdym:

### Faza 1: Plan (Sprint Planning, Design)

**Threat Modeling:**
Przed napisaniem kodu — zespół przeprowadza threat modeling dla nowej funkcji. 30-minutowa sesja: jakie dane przetwarza nowa funkcja? Jakie są możliwe wektory ataku? Jakie kontrole są potrzebne?

Narzędzia: OWASP Threat Dragon (open-source), Microsoft Threat Modeling Tool (bezpłatny).

**Security Requirements:**
User Stories powinny zawierać wymagania bezpieczeństwa. Nie tylko "jako użytkownik chcę się zalogować" ale "jako użytkownik chcę się zalogować przez MFA, a po 5 nieudanych próbach konto zostaje tymczasowo zablokowane".

### Faza 2: Code (Development)

**Pre-commit hooks:**
Git hooks uruchamiane przed każdym commitem — sprawdzają czy developer nie commituje sekretów (kluczy API, haseł, certyfikatów).

```bash
# .git/hooks/pre-commit
# Przykład: sprawdzanie hardcoded secrets przez detect-secrets
detect-secrets scan --all-files
if [ $? -ne 0 ]; then
  echo "BŁĄD: Znaleziono potencjalne sekrety w kodzie!"
  exit 1
fi
```

Narzędzia: `detect-secrets` (Yelp), `git-secrets` (AWS), `truffleHog`.

**IDE Security Plugins:**
Wtyczki do IDE (VS Code, IntelliJ) które podświetlają podatności podczas pisania kodu:
- Snyk (SAST + SCA w IDE)
- SonarLint (real-time SAST)
- DeepSource

### Faza 3: Build (CI — Continuous Integration)

**SAST (Static Application Security Testing):**
Automatyczna analiza kodu źródłowego przy każdym pull request. Pipeline nie przejdzie jeśli SAST wykryje podatności powyżej zdefiniowanego progu (np. blokuj przy CRITICAL i HIGH).

Narzędzia: SonarQube (multi-language), Semgrep (open-source, bardzo szybki), Checkmarx, Veracode.

```yaml
# Przykład GitHub Actions — SAST z Semgrep
- name: Run Semgrep SAST
  uses: returntocorp/semgrep-action@v1
  with:
    config: p/owasp-top-ten
  env:
    SEMGREP_APP_TOKEN: ${{ secrets.SEMGREP_TOKEN }}
```

**SCA (Software Composition Analysis):**
Skanowanie zależności open-source pod kątem znanych podatności CVE. Każda biblioteka ma swój "koszt bezpieczeństwa".

Narzędzia: Dependabot (GitHub, bezpłatny), Snyk Open Source, OWASP Dependency-Check (bezpłatny), Mend (dawniej WhiteSource).

**Secrets Scanning:**
Skanowanie repozytorium git pod kątem przypadkowo zakodowanych sekretów. GitHub Advanced Security, GitGuardian, truffleHog.

**Container Image Scanning:**
Jeśli deployujesz Dockerem — skanowanie obrazu przed pushowaniem do registry.

```yaml
- name: Scan Docker image with Trivy
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: 'myapp:${{ github.sha }}'
    exit-code: '1'
    severity: 'CRITICAL,HIGH'
```

### Faza 4: Test (Staging/QA)

**DAST (Dynamic Application Security Testing):**
Testowanie działającej aplikacji w środowisku staging. Symuluje atakującego z zewnątrz — testuje XSS, SQL injection, authentication bypass, insecure direct object reference.

Narzędzia: OWASP ZAP (open-source, bezpłatny), Burp Suite Professional, Nikto.

**Infrastructure as Code Security:**
Skanowanie konfiguracji IaC (Terraform, CloudFormation, Helm) pod kątem misconfiguracji bezpieczeństwa przed deploymentem.

Narzędzia: Checkov (Bridgecrew, open-source), tfsec, Terrascan.

```bash
# Checkov — skanowanie Terraform
checkov -d ./terraform --framework terraform --check CKV_AWS_*
```

**Penetration Testing (DAST + manual):**
Regularne testy penetracyjne dla aplikacji produkcyjnych — minimum raz w roku lub po znaczących zmianach.

### Faza 5: Deploy (CD — Continuous Delivery)

**Image Signing:**
Obrazy Docker podpisywane kryptograficznie — cluster Kubernetes akceptuje tylko podpisane obrazy z zaufanego rejestru.

Narzędzia: Cosign (Sigstore), Notary (Docker Content Trust).

**Runtime Security:**
Monitoring bezpieczeństwa aplikacji w czasie rzeczywistym — wykrywanie anomalii, prób eskalacji uprawnień, nieoczekiwanych wywołań systemowych.

Narzędzia: Falco (open-source, CNCF), Aqua Security, Sysdig Secure.

**Secret Management:**
Aplikacja pobiera sekrety ze Secrets Manager w czasie runtime — nie z zmiennych środowiskowych zakodowanych w deploymencie.

Narzędzia: HashiCorp Vault, AWS Secrets Manager, Azure Key Vault, Kubernetes Secrets (z encryption at rest).

### Faza 6: Monitor (Production)

**Application Security Monitoring:**
- RASP (Runtime Application Self-Protection) — agent w aplikacji wykrywający ataki w czasie rzeczywistym
- WAF (Web Application Firewall) — CloudFlare, AWS WAF, Azure Front Door
- Alerty na anomalie: nieoczekiwane błędy 500, spike żądań, podejrzane user agents

**Vulnerability Disclosure:**
Program odpowiedzialnego ujawniania podatności — `security.txt` na stronie, polityka bug bounty (HackerOne, Bugcrowd dla większych firm).

---

## Security Champions

Kluczowy element kulturowy DevSecOps: **Security Champions** — developerzy/inżynierowie z każdego zespołu którzy przeszli dodatkowe szkolenie z bezpieczeństwa i są łącznikiem między zespołem developerskim a security.

Rola Security Champion:
- Uczestniczy w threat modelingach nowych funkcji
- Recenzuje code changes pod kątem bezpieczeństwa
- Propaguje security best practices w zespole
- Eskaluje do zespołu security gdy potrzeba
- Uczestniczy w regularnych spotkaniach Security Champions Network

Edwards podkreśla: Security Champions skalują bezpieczeństwo. Jeden centralny security engineer nie może być "security" dla 20 zespołów deweloperskich. Security Champion w każdym zespole = rozproszone bezpieczeństwo.

---

## OWASP Top 10 — fundamenty bezpieczeństwa aplikacji

OWASP (Open Web Application Security Project) Top 10 to lista najczęstszych kategorii podatności w aplikacjach webowych. Aktualizowana co kilka lat, powszechnie używana jako minimum wymagań bezpieczeństwa.

**OWASP Top 10 (2021):**

**A01 — Broken Access Control:** niepoprawna implementacja kontroli dostępu. Użytkownik może zobaczyć dane innego użytkownika, zmienić URL i uzyskać dostęp do zabronionych zasobów. Najczęstsza kategoria.

**A02 — Cryptographic Failures:** słabe lub brakujące szyfrowanie. Dane wrażliwe w plaintext, słabe algorytmy (MD5, SHA1 do hashowania haseł), brakujące TLS.

**A03 — Injection:** SQL injection, LDAP injection, OS command injection. Niezaufane dane interpretowane jako polecenia. OWASP Top 3 przez dekadę.

**A04 — Insecure Design:** brak threat modelingu, brak security requirements w fazie projektowania. "Security by design" jako odpowiedź.

**A05 — Security Misconfiguration:** domyślne hasła, nieaktualne oprogramowanie, otwarte S3 buckety, verbose error messages z stack trace.

**A06 — Vulnerable and Outdated Components:** używanie bibliotek z known CVE, brak SCA, ignorowanie Dependabot alerts.

**A07 — Identification and Authentication Failures:** słabe uwierzytelnianie, brak MFA, słabe hashowanie haseł, insecure session management.

**A08 — Software and Data Integrity Failures:** brak weryfikacji integralności kodu i danych, insecure deserialization, CI/CD pipeline bez zabezpieczeń.

**A09 — Security Logging and Monitoring Failures:** brak logowania, brak alertów na ataki, zbyt krótka retencja logów.

**A10 — Server-Side Request Forgery (SSRF):** aplikacja wykonuje żądania HTTP na podstawie wejścia użytkownika — atakujący może skierować żądanie do wewnętrznych usług (np. AWS metadata endpoint).

---

## Secure SDLC — modele dojrzałości

**BSIMM (Building Security In Maturity Model):** benchmark bezpieczeństwa aplikacji oparty na danych z dziesiątek firm. Mierzy dojrzałość programu AppSec w 4 domenach i 16 praktykach.

**OWASP SAMM (Software Assurance Maturity Model):** open-source framework oceny i poprawy AppSec — 5 funkcji biznesowych, 15 praktyk bezpieczeństwa, 3 poziomy dojrzałości.

**Microsoft SDL (Security Development Lifecycle):** metodologia Microsoft łącząca threat modeling, code review, fuzz testing, incident response plan dla każdego produktu.

---

## Metryki DevSecOps

**Vulnerability Lead Time:** czas od wykrycia podatności do naprawy (MTTM — Mean Time to Mitigate).

**Pipeline Security Coverage:** % pipeline'ów z SAST, SCA, Container Scanning.

**Security Debt:** liczba open security findings (CRITICAL/HIGH) × czas otwarcia.

**False Positive Rate:** % alertów SAST które są false positive — wysokie FP = narzędzie ignorowane przez developerów.

**Secrets Detected:** liczba sekretów wykrytych i zapobieżonych przed commitem.

---

## Kluczowe wnioski z modułu 12

**1. Shift Left radykalnie obniża koszt naprawy**
Błąd w design: 1x koszt. Błąd w produkcji: 100x koszt. Automaty SAST/SCA w pipeline kosztują grosze per scan i zwracają się przy pierwszej znalezionej podatności.

**2. Automatyzacja jest kluczem — nie można skalować manualnie**
Jeden security engineer + 20 zespołów developerskich = niemożliwe do ręcznego skanowania. Automatyzacja w pipeline + Security Champions = skalowalne bezpieczeństwo.

**3. Security musi być enablerem, nie blokadą**
Security które spowalnia delivery jest omijane. Security wbudowane w pipeline — przyspiesza delivery przez wczesne wykrywanie i eliminację bug bounty/incydentów produkcyjnych.

**4. Culture > Tools**
Najlepsze narzędzia SAST nie pomogą jeśli developerzy ignorują alerty. Kultura "security is everyone's responsibility", Security Champions, szkolenia — ważniejsze niż wybór konkretnego narzędzia.

---

## Terminologia — słownik modułu 12

| Termin | Definicja |
|--------|-----------|
| DevSecOps | Development + Security + Operations — bezpieczeństwo wbudowane w SDLC |
| Shift Left | Przeniesienie bezpieczeństwa jak najwcześniej w cykl wytwarzania |
| CI/CD | Continuous Integration / Continuous Delivery — automatyczny pipeline |
| SAST | Static Application Security Testing — analiza kodu bez uruchamiania |
| DAST | Dynamic Application Security Testing — testowanie działającej aplikacji |
| SCA | Software Composition Analysis — skanowanie zależności open-source |
| IaC | Infrastructure as Code — konfiguracja infrastruktury jako kod |
| Security Champion | Developer z dodatkowym szkoleniem security, łącznik z zespołem security |
| OWASP Top 10 | Lista 10 najczęstszych kategorii podatności w aplikacjach webowych |
| Threat Modeling | Systematyczna identyfikacja zagrożeń dla systemu/funkcji |
| RASP | Runtime Application Self-Protection — agent bezpieczeństwa w aplikacji |
| Pre-commit hook | Skrypt uruchamiany przed commitem — np. skanowanie sekretów |
| SBOM | Software Bill of Materials — lista komponentów oprogramowania |
| BSIMM | Building Security In Maturity Model — benchmark AppSec |
| SAMM | Software Assurance Maturity Model (OWASP) |
| False Positive | Alert bezpieczeństwa który jest fałszywym alarmem |

---

*Źródła: Jason Edwards, The Cybersecurity Control Playbook (Wiley, 2025), rozdział 12; OWASP DevSecOps Guideline; OWASP Top 10 (2021); Microsoft Security Development Lifecycle; NIST SP 800-218 (Secure Software Development Framework); CISA Shifting the Balance of Cybersecurity Risk (2023).*
