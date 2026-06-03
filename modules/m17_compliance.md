# Moduł 17: Zgodność i audyt

**Rozdział 17 · Jason Edwards, *The Cybersecurity Control Playbook* (Wiley, 2025)**

> Compliance bez bezpieczeństwa to teatr. Bezpieczeństwo bez compliance to chaos. Najlepsze organizacje osiągają oba jednocześnie — i rozumieją że to nie jest sprzeczność.

---

## RODO (GDPR) — regulacja prywatności w UE

### Podstawy RODO dla IT i bezpieczeństwa

RODO (Rozporządzenie o Ochronie Danych Osobowych, GDPR) obowiązuje od 2018 roku i dotyczy każdej organizacji przetwarzającej dane osobowe osób w UE. Dla cyberbezpieczeństwa najważniejsze artykuły:

**Art. 5 — Zasady przetwarzania danych:**
- Minimalizacja danych: zbieraj tylko to co niezbędne
- Ograniczenie przechowywania: nie trzymaj dłużej niż potrzeba
- Integralność i poufność: **odpowiednie środki techniczne i organizacyjne** — to jest nasza działka

**Art. 25 — Privacy by Design and by Default:**
Bezpieczeństwo musi być wbudowane w systemy od początku, nie dodane na końcu. Domyślne ustawienia = najbardziej prywatne.

**Art. 32 — Bezpieczeństwo przetwarzania:**
Organizacja musi wdrożyć "odpowiednie środki techniczne i organizacyjne" uwzględniające: pseudonimizację i szyfrowanie, ciągłość, odporność, backup i odtwarzanie, regularne testowanie.

**Art. 33/34 — Zgłaszanie naruszeń:**
Naruszenie danych osobowych → UODO w 72h. Wysokie ryzyko dla osób → notyfikacja indywidualna.

**Art. 37-39 — Inspektor Ochrony Danych (IOD/DPO):**
Dla podmiotów publicznych i firm przetwarzających dane na dużą skalę — obowiązek wyznaczenia IOD.

**Kary:** do 4% rocznego obrotu lub 20 mln EUR (wyższa z kwot) za poważne naruszenia.

### RODO a cyberbezpieczeństwo — praktyczne implikacje

1. **Data mapping:** wiesz gdzie są dane osobowe? (wymagane przez art. 30 — rejestr czynności)
2. **Szyfrowanie:** art. 32 wprost wymienia szyfrowanie jako środek bezpieczeństwa
3. **Backup:** odtwarzanie jako wymaganie art. 32
4. **Access control:** minimalizacja dostępu do danych osobowych
5. **Incydent response:** 72h notification clock wymaga gotowego IRP

---

## PCI DSS — bezpieczeństwo kart płatniczych

### Co to jest PCI DSS

PCI DSS (Payment Card Industry Data Security Standard) to standard bezpieczeństwa dla organizacji przetwarzających, przechowujących lub przesyłających dane kart płatniczych (Visa, Mastercard, AMEX, Discover).

Nie jest regulacją prawną (jak RODO) — jest wymaganiem umownym nałożonym przez sieci kartowe. Naruszenie = kary kontraktowe + możliwa utrata możliwości przetwarzania kart.

### 12 wymagań PCI DSS v4.0

PCI DSS v4.0 (2022) organizuje wymagania w 6 celów i 12 wymogów:

**Budowanie i utrzymanie bezpiecznej sieci:**
1. Zainstaluj i utrzymuj kontrole bezpieczeństwa sieci (firewalle, routery)
2. Zastosuj bezpieczne konfiguracje dla wszystkich komponentów systemu

**Ochrona danych kart:**
3. Chroń przechowywane dane posiadaczy kart (szyfrowanie, tokenizacja)
4. Chroń dane kart podczas transmisji w otwartych sieciach (TLS)

**Zarządzanie podatnościami:**
5. Chroń wszystkie systemy i sieci przed złośliwym oprogramowaniem
6. Rozwijaj i utrzymuj bezpieczne systemy i oprogramowanie

**Silna kontrola dostępu:**
7. Ogranicz dostęp do komponentów systemu i danych kart przez need-to-know
8. Identyfikuj użytkowników i uwierzytelniaj dostęp do komponentów systemu
9. Ogranicz fizyczny dostęp do danych kart

**Regularne monitorowanie i testowanie:**
10. Loguj i monitoruj cały dostęp do komponentów systemu i danych kart
11. Testuj bezpieczeństwo systemów i sieci regularnie

**Polityka bezpieczeństwa informacji:**
12. Wspieraj bezpieczeństwo informacji przez polityki i programy organizacyjne

### Poziomy zgodności PCI DSS

Organizacje dzielone na poziomy (Levels) według liczby transakcji rocznie:
- **Level 1:** >6 mln transakcji/rok → roczny audyt przez QSA (Qualified Security Assessor)
- **Level 2:** 1–6 mln → roczny Self-Assessment Questionnaire (SAQ) + kwartalny skan sieci
- **Level 3:** 20k–1 mln transakcji e-commerce → SAQ + kwartalny skan
- **Level 4:** <20k e-commerce lub do 1 mln innych → SAQ

### CDE — Cardholder Data Environment

**CDE (Cardholder Data Environment)** to systemy które przetwarzają, przechowują lub transmitują dane kart. Kluczowa zasada PCI DSS: minimalizuj zakres CDE przez segmentację — im mniej systemów w zakresie, tym mniejszy koszt compliance.

**Tokenizacja:** zamiast przechowywać numer karty, przechowujesz token (np. `tok_visa_4242_...`) — token jest bezużyteczny dla atakującego, prawdziwy numer tylko u procesora płatności (np. Stripe, PayU). Radykalnie redukuje zakres PCI DSS.

---

## HIPAA — ochrona danych zdrowotnych (USA)

HIPAA (Health Insurance Portability and Accountability Act) to amerykańska regulacja ochrony danych zdrowotnych (PHI — Protected Health Information).

**Security Rule:** wymaga ochrony elektronicznych PHI przez:
- Administrative safeguards: polityki, szkolenia, zarządzanie dostępem
- Physical safeguards: ochrona fizyczna urządzeń z PHI
- Technical safeguards: kontrola dostępu, audyt, integralność, szyfrowanie transmisji

**Breach Notification Rule:** naruszenie PHI → powiadomienie dotkniętych osób + Department of Health and Human Services. Breaches affecting >500 persons → publiczne zgłoszenie.

**Dla polskich firm:** HIPAA obowiązuje jeśli obsługujesz pacjentów lub podmioty medyczne w USA. Coraz ważniejsze dla polskich firm SaaS sprzedających do USA.

---

## Audyt bezpieczeństwa — typy i metodologie

### Typy audytów

**Audyt wewnętrzny:** przeprowadzany przez własny zespół (internal audit). Regularny, mniej formalny, identyfikuje problemy zanim znajdzie je audytor zewnętrzny.

**Audyt zewnętrzny:** przez niezależną firmę audytorską. Bardziej formalny, obiektywny. Wymagany przez certyfikacje (ISO 27001, SOC 2, PCI DSS Level 1).

**Penetration testing:** symulacja ataku żeby ocenić skuteczność kontroli. Nie to samo co audyt zgodności — test penetracyjny pokazuje czy coś można zhakować, audyt sprawdza czy procesy i kontrole są wdrożone.

**Vulnerability Assessment:** skanowanie systemów pod kątem znanych podatności. Szerszy zasięg, mniejsza głębokość niż pentest.

### Metodologie audytu

**Audyt compliance:** sprawdza czy organizacja spełnia konkretne wymagania regulacyjne lub standardu. Wynik: comply/non-comply dla każdego wymagania + plan remediacji.

**Risk-based audit:** skupia się na obszarach najwyższego ryzyka (zamiast przeglądu wszystkiego). Efektywniejszy użytek czasu audytora.

**Controls testing:** testowanie czy kontrole są zaprojektowane odpowiednio (design effectiveness) i czy działają w praktyce (operating effectiveness). SOC 2 Type II testuje operating effectiveness przez okres obserwacji.

### Cykl audytu

```
Planowanie (scope, objectives, methodology)
    ↓
Zbieranie dowodów (dokumenty, wywiady, testy)
    ↓
Analiza i ocena
    ↓
Raportowanie (findings, recommendations)
    ↓
Remediacja (organization fixes issues)
    ↓
Follow-up (verify remediation)
```

### Najczęstsze findings audytowe

Z doświadczenia audytorów — najczęstsze braki:
1. Brak lub przestarzałe polityki bezpieczeństwa
2. Niewykonane przeglądy dostępu (access reviews)
3. Aktywne konta byłych pracowników
4. Brak lub niesprawdzone backupy
5. Brakujące patche bezpieczeństwa
6. Brak logowania/monitorowania kluczowych systemów
7. Nadmierne uprawnienia administratorów
8. Brak szkolenia użytkowników (dokumentacji)
9. Niespójność między polityką a praktyką (SSP vs rzeczywistość)
10. Brak planu IR lub nieaktualizowany

---

## Zarządzanie dowodem zgodności — Evidence Management

### Co to jest evidence

Dowód (evidence) w kontekście audytu to artefakt potwierdzający że kontrola jest wdrożona i działa. Przykłady:

| Kontrola | Przykładowy dowód |
|---------|-----------------|
| MFA włączone dla wszystkich | Screenshot polityki MFA + raport Entra ID: 100% users MFA |
| Quarterly access review | Podpisany formularz z listą kont certyfikowanych przez managerów |
| Backup testowany | Raport testu odtwarzania z datą i wynikiem |
| Szkolenie security awareness | Lista obecności + certyfikaty ukończenia |
| Patch management | Raport Nessus/Qualys z datami naprawy |

### Automatyzacja zbierania dowodów

Narzędzia compliance automation (Vanta, Drata, Secureframe, Tugboat Logic) automatycznie zbierają dowody przez integracje z systemami:
- AWS/Azure: sprawdza MFA, encryption, logging
- GitHub: sprawdza code reviews, branch protection
- Okta: sprawdza MFA policies, active users
- Google Workspace: sprawdza 2FA enrollment

Zamiast ręcznego screenshota co kwartał — ciągłe, automatyczne zbieranie dowodów.

---

## Wewnętrzny program audytu — budowanie dojrzałości

### Maturity Model dla compliance

**Level 1 (Ad Hoc):** brak formalnych procesów compliance. Reagowanie na audytorów zewnętrznych doraźnie.

**Level 2 (Defined):** podstawowe polityki i procedury. Compliance jako projekt jednorazowy.

**Level 3 (Managed):** regularne wewnętrzne audyty. Tracking remediation. Metryki.

**Level 4 (Optimized):** ciągły monitoring zgodności. Automatyczne alertowanie przy odchyleniach. Compliance zintegrowany z procesami IT.

**Edwards rekomenduje:** organizacje powinny dążyć do Level 3 minimum. Level 4 jest możliwy z narzędziami automation.

---

## Kluczowe wnioski z modułu 17

**1. Compliance i bezpieczeństwo to nie to samo, ale powinny być zsynchronizowane**
Certyfikat ISO 27001 nie gwarantuje że nie zostaniesz zhakowany. Ale dobry program bezpieczeństwa sprawia że compliance jest łatwiejszy.

**2. RODO to nie tylko formularz cookies — to architektura bezpieczeństwa**
Art. 32 wymaga konkretnych środków technicznych. RODO powinien napędzać wdrożenie szyfrowania, backupu, access control — nie tylko polityki prywatności na stronie.

**3. Minimalizuj zakres PCI DSS przez tokenizację i segmentację**
Im mniejszy CDE, tym tańszy i prostszy compliance. Tokenizacja kart radykalnie redukuje zakres.

**4. Dokumentacja to połowa audytu**
Kontrola bez dokumentacji = brak dowodów = finding. Automatyzuj zbieranie dowodów.

**5. Wewnętrzny audyt to "próba generalna" przed zewnętrznym**
Regularne audyty wewnętrzne eliminują niespodzianki podczas certyfikacji.

---

## Terminologia — słownik modułu 17

| Termin | Definicja |
|--------|-----------|
| RODO/GDPR | Rozporządzenie o ochronie danych osobowych (UE 2018) |
| UODO | Urząd Ochrony Danych Osobowych — polski organ nadzorczy |
| IOD/DPO | Inspektor Ochrony Danych / Data Protection Officer |
| PCI DSS | Payment Card Industry Data Security Standard |
| CDE | Cardholder Data Environment — środowisko danych kart |
| QSA | Qualified Security Assessor — certyfikowany audytor PCI DSS |
| SAQ | Self-Assessment Questionnaire — PCI DSS samoocena |
| HIPAA | Health Insurance Portability and Accountability Act (USA) |
| PHI | Protected Health Information — chronione dane zdrowotne |
| Evidence | Dowód audytowy potwierdzający działanie kontroli |
| Finding | Odkryta niezgodność lub słabość w audycie |
| Remediation | Działania naprawcze po znalezieniu niezgodności |
| Tokenizacja | Zastąpienie wrażliwych danych (np. nr karty) tokenem |
| Privacy by Design | Wbudowanie prywatności w systemy od projektu |
| Controls Testing | Testowanie czy kontrole działają w praktyce |
| Operating Effectiveness | Czy kontrola faktycznie działa (testowane przez SOC 2 Type II) |

---

*Źródła: Jason Edwards, The Cybersecurity Control Playbook (Wiley, 2025), rozdział 17; RODO/GDPR (EUR-Lex); PCI DSS v4.0 (pcisecuritystandards.org); HIPAA Security Rule (HHS.gov); ISO 19011 (Guidelines for auditing management systems).*
