# Moduł 9: Przegląd frameworków cyberbezpieczeństwa

**Rozdział 9 · Jason Edwards, *The Cybersecurity Control Playbook* (Wiley, 2025)**

> Framework to nie cel — to mapa. Dobra mapa nie zastąpi znajomości terenu, ale bez niej łatwo się zgubić. Wybór właściwej mapy zależy od tego, dokąd chcesz dotrzeć.

---

## Dlaczego frameworki są potrzebne

Cyberbezpieczeństwo bez struktury to chaos: każdy robi co uważa, brak wspólnego języka, niemożność porównania poziomu dojrzałości, trudność w komunikacji z zarządem i regulatorami.

Frameworki cyberbezpieczeństwa rozwiązują ten problem — dostarczają ustrukturyzowany, powtarzalny sposób oceny, budowania i komunikowania programu bezpieczeństwa. Są wynikiem wieloletnich doświadczeń tysięcy organizacji i ekspertów.

Edwards w rozdziale 9 podkreśla kluczową prawdę: **nie istnieje jeden "najlepszy" framework**. Każdy ma swój kontekst, cel i branżę dla której jest optymalny. Zadanie CISO to wybrać właściwy framework (lub kombinację) dla swojej organizacji — i używać go konsekwentnie.

W tym module omówimy cztery główne frameworki:
- **NIST CSF** — elastyczny, szeroko stosowany, język dla zarządu
- **ISO 27001** — standard certyfikowalny, rozpoznawany globalnie
- **CIS Controls** — praktyczna lista priorytetowych kontroli
- **SOC 2** — standard dla firm SaaS i usług chmurowych

---

## NIST Cybersecurity Framework (CSF)

### Geneza i cel

NIST CSF powstał w 2014 roku na zlecenie rządu USA jako odpowiedź na rosnące zagrożenia dla infrastruktury krytycznej. Od wersji 1.0 ewoluował do **wersji 2.0 (2024)** — najważniejsza aktualizacja od dekady.

Założenie: framework musi być użyteczny dla każdej organizacji — niezależnie od wielkości, branży i poziomu dojrzałości. Dlatego jest **dobrowolny, technologicznie neutralny i oparty na wynikach** (outcome-based), nie na konkretnych technologiach.

### Sześć funkcji CSF 2.0

NIST CSF 2.0 organizuje działania bezpieczeństwa w sześć funkcji (w wersji 1.1 było pięć — dodano **Govern**):

**GOVERN (GV) — Zarządzanie** *(nowe w v2.0)*
Kontekst organizacyjny, strategia zarządzania ryzykiem, role i odpowiedzialności, polityki. To "dlaczego" i "kto" bezpieczeństwa.
Przykładowe kategorie: Organizational Context, Risk Management Strategy, Cybersecurity Supply Chain Risk Management.

**IDENTIFY (ID) — Identyfikacja**
Zrozumienie środowiska organizacji: aktywa, dane, systemy, ryzyka. Nie możesz chronić tego, czego nie znasz.
Przykładowe kategorie: Asset Management, Risk Assessment, Improvement.

**PROTECT (PR) — Ochrona**
Kontrole ograniczające wpływ potencjalnego incydentu: zarządzanie tożsamością, szkolenia, bezpieczeństwo danych, hardening.
Przykładowe kategorie: Identity Management, Awareness and Training, Data Security, Platform Security.

**DETECT (DE) — Wykrywanie**
Identyfikowanie incydentów bezpieczeństwa w odpowiednim czasie.
Przykładowe kategorie: Continuous Monitoring, Adverse Event Analysis.

**RESPOND (RS) — Reagowanie**
Działania po wykryciu incydentu: zarządzanie incydentem, komunikacja, analiza, łagodzenie.
Przykładowe kategorie: Incident Management, Incident Analysis, Incident Response Reporting.

**RECOVER (RC) — Odtwarzanie**
Przywrócenie normalnego działania po incydencie, komunikacja, wyciąganie wniosków.
Przykładowe kategorie: Incident Recovery Plan Execution, Incident Recovery Communication.

### Profile i poziomy dojrzałości

**Profile CSF:** organizacja tworzy dwa profile — "Current Profile" (jak jest teraz) i "Target Profile" (jak chce być). Gap między nimi to roadmapa działań.

**Implementation Tiers:** cztery poziomy dojrzałości:
- **Tier 1 Partial:** ad hoc, reaktywne, brak formalnych procesów
- **Tier 2 Risk Informed:** świadomość ryzyka ale brak formalnych procesów organizacyjnych
- **Tier 3 Repeatable:** formalne procesy, regularne aktualizacje
- **Tier 4 Adaptive:** proaktywne, ciągłe doskonalenie, threat-informed

### Kiedy stosować NIST CSF

NIST CSF jest idealny gdy:
- Chcesz zbudować lub ocenić program bezpieczeństwa od podstaw
- Potrzebujesz wspólnego języka dla zarządu i IT
- Organizacja działa w USA lub chce współpracować z partnerami amerykańskimi
- Szukasz elastycznego frameworku bez certyfikacji
- Chcesz połączyć z innymi frameworkami (CSF dobrze się integruje z ISO, CIS, NIST 800-53)

---

## ISO/IEC 27001

### Co to jest i co obejmuje

**ISO 27001** to międzynarodowy standard zarządzania bezpieczeństwem informacji. Definiuje wymagania dla **ISMS (Information Security Management System)** — systemu zarządzania bezpieczeństwem informacji.

Kluczowa różnica od NIST CSF: ISO 27001 jest **certyfikowalny**. Organizacja może przejść audyt przez akredytowaną jednostkę certyfikującą i otrzymać certyfikat ISO 27001, ważny 3 lata (z rocznymi audytami nadzoru).

Standard składa się z dwóch części:
- **Clauses 4-10:** wymagania dla systemu zarządzania (obowiązkowe)
- **Annex A:** katalog 93 kontroli bezpieczeństwa (referencyjne, nie wszystkie muszą być wdrożone)

### Annex A — 93 kontrole w 4 domenach (ISO 27001:2022)

**Organizational Controls (37 kontroli):** polityki, role, zarządzanie ryzykiem, relacje z dostawcami, ciągłość działania, zgodność z prawem.

**People Controls (8 kontroli):** weryfikacja pracowników, warunki zatrudnienia, świadomość bezpieczeństwa, szkolenia, dyscyplina, offboarding.

**Physical Controls (14 kontroli):** bezpieczeństwo fizyczne, ochrona sprzętu, polityka czystego biurka.

**Technological Controls (34 kontrole):** uwierzytelnianie, dostęp do sieci, szyfrowanie, logi, monitoring, zarządzanie podatnościami, backup.

### Proces wdrożenia ISO 27001

1. **Gap Analysis:** gdzie jesteśmy vs wymagania ISO 27001?
2. **Scope Definition:** co obejmuje ISMS? (cała organizacja? jeden dział? jeden produkt?)
3. **Risk Assessment:** identyfikacja i ocena ryzyk
4. **Statement of Applicability (SoA):** które z 93 kontroli Annex A stosujemy (i dlaczego nie stosujemy pozostałych)?
5. **Risk Treatment Plan:** jak adresujemy każde ryzyko?
6. **Wdrożenie kontroli:** implementacja techniczna i procesowa
7. **Internal Audit:** wewnętrzny audyt zgodności
8. **Management Review:** przegląd zarządczy
9. **Certification Audit:** audyt przez zewnętrzną jednostkę (Stage 1 + Stage 2)

### Kiedy stosować ISO 27001

ISO 27001 jest idealny gdy:
- Klienci lub partnerzy wymagają certyfikatu bezpieczeństwa
- Działasz na rynkach europejskich gdzie ISO 27001 jest powszechnie rozpoznawany
- Chcesz formalnie udokumentować i certyfikować program bezpieczeństwa
- Organizacja działa w sektorze finansowym, medycznym lub rządowym
- Chcesz ułatwić compliance z RODO (ISO 27001 nie zastępuje RODO, ale znacznie ułatwia)

**Koszt wdrożenia ISO 27001** (szacunki dla firmy 100–500 pracowników):
- Konsultant external: 80 000–150 000 PLN
- Certyfikacja: 20 000–50 000 PLN
- Czas wewnętrzny: 6–18 miesięcy
- Recertyfikacja co 3 lata + audyty roczne

---

## CIS Controls

### Co to jest

**CIS Controls** (Center for Internet Security Controls) to lista priorytetowych działań bezpieczeństwa opracowana przez społeczność praktyków cyberbezpieczeństwa. Aktualna wersja: **CIS Controls v8 (2021)**.

Filozofia CIS Controls jest radykalnie praktyczna: **zamiast kompleksowego frameworku — daj organizacji konkretną, priorytetyzowaną listę co wdrożyć najpierw.** Wynik dekady analizy najczęstszych wektorów ataków i najbardziej skutecznych kontroli.

### 18 grup kontroli

CIS Controls v8 organizuje działania w 18 grup:

| Nr | Kontrola | Priorytet |
|----|---------|-----------|
| 1 | Inventory and Control of Enterprise Assets | IG1 |
| 2 | Inventory and Control of Software Assets | IG1 |
| 3 | Data Protection | IG1 |
| 4 | Secure Configuration of Enterprise Assets | IG1 |
| 5 | Account Management | IG1 |
| 6 | Access Control Management | IG1 |
| 7 | Continuous Vulnerability Management | IG1 |
| 8 | Audit Log Management | IG1 |
| 9 | Email and Web Browser Protections | IG1 |
| 10 | Malware Defenses | IG1 |
| 11 | Data Recovery | IG1 |
| 12 | Network Infrastructure Management | IG2 |
| 13 | Network Monitoring and Defense | IG2 |
| 14 | Security Awareness and Skills Training | IG2 |
| 15 | Service Provider Management | IG2 |
| 16 | Application Software Security | IG2 |
| 17 | Incident Response Management | IG2 |
| 18 | Penetration Testing | IG3 |

### Implementation Groups — priorytetyzacja dla różnych organizacji

Kluczowa innowacja CIS Controls v8: **Implementation Groups (IG)** — trzy grupy określające które kontrole są obowiązkowe dla organizacji danej wielkości i dojrzałości.

**IG1 — "Basic Cyber Hygiene"** (małe firmy, ograniczone zasoby):
56 safeguards z kontroli 1–11. To minimum które każda organizacja powinna wdrożyć. Adresuje 85%+ typowych ataków. Koszt: niski do umiarkowanego.

**IG2 — IG1 + dodatkowe** (średnie organizacje, pewna wrażliwość danych):
74 dodatkowe safeguards (kontrole 12–17). Dla organizacji które mają wrażliwe dane lub złożone środowisko.

**IG3 — IG1+IG2 + zaawansowane** (duże organizacje, wysokie ryzyko):
23 dodatkowe safeguards (kontrola 18 — penetration testing). Dla organizacji targetowanych przez zaawansowanych aktorów.

Edwards rekomenduje: **małe firmy zacznij od IG1 — 56 safeguards zamiast 700 technik ATT&CK.** To realistyczny, osiągalny cel który eliminuje zdecydowaną większość ryzyk.

### Kiedy stosować CIS Controls

CIS Controls jest idealny gdy:
- Jesteś małą lub średnią firmą bez dedykowanego CISO
- Potrzebujesz konkretnej, priorytetyzowanej listy działań (nie teorii)
- Masz ograniczone zasoby i musisz wybrać co zrobić najpierw
- Chcesz zmierzyć postęp bezpieczeństwa w czasie
- Szukasz bezpłatnego, publicznie dostępnego frameworku

---

## SOC 2

### Co to jest

**SOC 2** (System and Organization Controls 2) to standard audytowy opracowany przez AICPA (American Institute of Certified Public Accountants). Jest dedykowany dla **firm świadczących usługi dla innych organizacji** — szczególnie SaaS, usługi chmurowe, outsourcing IT.

SOC 2 odpowiada na pytanie klientów: *"Czy dostawca któremu powierzamy nasze dane jest bezpieczny?"*

### Trust Service Criteria (TSC)

SOC 2 ocenia organizację według pięciu kryteriów:

**Security (CC):** podstawowe wymagane kryterium. Kontrole chroniące przed nieautoryzowanym dostępem. Obejmuje: logiczne kontrole dostępu, szyfrowanie, monitoring, zarządzanie zmianami, zarządzanie ryzykiem.

**Availability (A):** dostępność systemu zgodna z umową SLA. Monitoring dostępności, disaster recovery, redundancja.

**Processing Integrity (PI):** kompletność i dokładność przetwarzania danych. Używane głównie przez firmy finansowe i przetwarzające transakcje.

**Confidentiality (C):** ochrona poufnych informacji. Stosowane gdy system przetwarza informacje oznaczone jako poufne.

**Privacy (P):** zbieranie, używanie i ujawnianie danych osobowych. Powiązanie z RODO i innymi regulacjami prywatności.

Każda organizacja wybiera które kryteria są relewantne — Security jest obowiązkowe, pozostałe opcjonalne.

### SOC 2 Type I vs Type II

**SOC 2 Type I:** ocena projektu kontroli na dany moment ("czy kontrole są odpowiednio zaprojektowane?"). Szybszy do uzyskania (3–6 miesięcy), mniej wartościowy dla klientów.

**SOC 2 Type II:** ocena skuteczności kontroli przez okres obserwacji (zazwyczaj 6–12 miesięcy) — "czy kontrole faktycznie działały?". Znacznie bardziej wartościowy — wymaga udowodnienia że kontrole działały konsekwentnie.

Klienci enterprise niemal zawsze wymagają SOC 2 Type II.

### Kiedy stosować SOC 2

SOC 2 jest niezbędny gdy:
- Jesteś firmą SaaS sprzedającą do klientów enterprise w USA
- Klienci pytają o twój "security posture" i wymagają dowodu
- Przetwarzasz dane klientów w chmurze
- Chcesz przyspieszyć sprzedaż enterprise (SOC 2 eliminuje długie security questionnaires)
- Jesteś podwykonawcą dla firm które mają SOC 2 lub ISO 27001

**Koszt SOC 2:**
- Przygotowanie (6–12 miesięcy): wewnętrzny czas + ewentualnie konsultant
- Audyt Type II przez CPA firm: 15 000–50 000 USD
- Narzędzia do automatyzacji compliance (Vanta, Drata, Secureframe): 10 000–30 000 USD/rok

---

## Porównanie frameworków

| Kryterium | NIST CSF | ISO 27001 | CIS Controls | SOC 2 |
|-----------|---------|-----------|-------------|-------|
| Certyfikowalny | Nie | Tak | Nie | Tak (raport audytora) |
| Dla kogo | Wszystkich | Średnich i dużych | Małych i średnich | Dostawców usług |
| Szczegółowość | Wysoka (kategorie i podkategorie) | Wysoka (93 kontrole) | Bardzo praktyczna (153 safeguards) | Średnia (criteria) |
| Koszt wdrożenia | Niski–średni | Wysoki | Niski | Średni–wysoki |
| Rozpoznawalność | USA i globalnie | Globalnie | USA i globalnie | USA (rynek SaaS) |
| Regulacje | Dobrowolny | Dobrowolny | Dobrowolny | Dobrowolny (wymagany przez klientów) |
| Aktualizacje | CSF 2.0 (2024) | ISO 27001:2022 | CIS v8 (2021) | Stały |
| Integracja z ATT&CK | Dobra (CISA mapping) | Częściowa | Oficjalne mapowanie | Słaba |

---

## Jak wybrać właściwy framework

Edwards proponuje drzewo decyzyjne:

**Pytanie 1: Czy klienci lub regulatorzy wymagają certyfikatu?**
- Tak, certyfikat ISO 27001 → ISO 27001
- Tak, raport SOC 2 (klienci SaaS/USA) → SOC 2
- Nie → przejdź do pytania 2

**Pytanie 2: Jaka jest wielkość i dojrzałość organizacji?**
- Mała firma, ograniczone zasoby, brak CISO → CIS Controls IG1
- Średnia firma, wrażliwe dane, budujemy program → NIST CSF + CIS Controls
- Duża firma, regulowany sektor → NIST CSF + ISO 27001

**Pytanie 3: Jaki jest główny cel?**
- Komunikacja z zarządem i budowanie programu → NIST CSF
- Certyfikacja dla partnerów i klientów → ISO 27001
- Konkretna lista co wdrożyć → CIS Controls
- Wymagania klientów SaaS → SOC 2

### Frameworki można łączyć

Wiele organizacji używa kombinacji:
- **NIST CSF** jako nadrzędny framework strategiczny
- **CIS Controls** jako taktyczna lista implementacji
- **ISO 27001** dla certyfikacji
- **ATT&CK** dla threat-informed defense (moduły 6–8)

Mapowania między frameworkami są publiczne — CIS opublikował mapowania CIS→NIST CSF→ISO 27001→ATT&CK.

---

## Frameworki w Polsce — regulacje

### RODO (GDPR)

RODO nie jest frameworkiem bezpieczeństwa — jest regulacją prawną. Ale wymaga "odpowiednich środków technicznych i organizacyjnych". ISO 27001 i NIST CSF są powszechnie akceptowane jako dowód adekwatnych środków.

### NIS2

Dyrektywa NIS2 wdrożona w Polsce (ustawa o KSC — Krajowy System Cyberbezpieczeństwa) wymaga od podmiotów kluczowych i ważnych wdrożenia środków zarządzania ryzykiem. NIST CSF i ISO 27001 są akceptowanymi frameworkami do spełnienia tych wymagań.

### KNF (Komisja Nadzoru Finansowego)

Rekomendacje KNF dla sektora finansowego (Rekomendacja D) są silnie powiązane z ISO 27001 i NIST CSF. Banki i instytucje finansowe w Polsce praktycznie obowiązkowo używają tych frameworków.

---

## Kluczowe wnioski z modułu 9

**1. Framework to narzędzie, nie cel sam w sobie**
Certyfikat ISO 27001 bez realnego bezpieczeństwa to papier. Program bezpieczeństwa oparty na CIS Controls bez certyfikatu może być silniejszy. Cel to realne bezpieczeństwo — framework to mapa do celu.

**2. Zacznij od pytania "po co" — dobór frameworku zależy od kontekstu**
Klienci enterprise wymagają SOC 2? → SOC 2. Regulatorzy wymagają certyfikatu? → ISO 27001. Budujesz program od zera? → NIST CSF + CIS Controls.

**3. CIS Controls IG1 to minimum dla każdej firmy**
56 safeguards, publicznie dostępne, bezpłatne, praktyczne. Każda organizacja — niezależnie od budżetu — powinna wdrożyć IG1.

**4. Frameworki są komplementarne — mapowania istnieją**
Nie musisz wybierać jednego na zawsze. Kombinacja NIST CSF (strategia) + CIS Controls (taktyka) + ISO 27001 (certyfikacja) jest powszechna i skuteczna.

**5. ATT&CK uzupełnia każdy framework**
Żaden z czterech omawianych frameworków nie zastępuje threat-informed defense z ATT&CK. Są komplementarne — frameworki dają strukturę programu, ATT&CK daje operacyjną szczegółowość detekcji.

---

## Terminologia — słownik modułu 9

| Termin | Definicja |
|--------|-----------|
| Framework | Ustrukturyzowany zestaw wytycznych do budowania programu bezpieczeństwa |
| NIST CSF | NIST Cybersecurity Framework — elastyczny framework oparty na wynikach |
| ISO 27001 | Certyfikowalny standard zarządzania bezpieczeństwem informacji |
| ISMS | Information Security Management System — system zarządzania bezpieczeństwem |
| Annex A | Katalog 93 kontroli bezpieczeństwa w ISO 27001:2022 |
| SoA | Statement of Applicability — dokument określający które kontrole ISO stosujemy |
| CIS Controls | Priorytetyzowana lista 18 grup kontroli bezpieczeństwa |
| Implementation Groups | Trzy poziomy CIS Controls (IG1/IG2/IG3) dla różnych organizacji |
| SOC 2 | Standard audytowy dla dostawców usług — Trust Service Criteria |
| TSC | Trust Service Criteria — pięć kryteriów SOC 2 |
| SOC 2 Type I | Ocena projektu kontroli na dany moment |
| SOC 2 Type II | Ocena skuteczności kontroli przez okres obserwacji (6–12 miesięcy) |
| Gap Analysis | Porównanie obecnego stanu z wymaganiami frameworku |
| NIS2 | Dyrektywa UE o bezpieczeństwie sieci i systemów informacyjnych |
| KSC | Krajowy System Cyberbezpieczeństwa — polska implementacja NIS2 |

---

*Źródła: Jason Edwards, The Cybersecurity Control Playbook (Wiley, 2025), rozdział 9; NIST CSF 2.0 (nist.gov/cyberframework); ISO/IEC 27001:2022; CIS Controls v8 (cisecurity.org); AICPA SOC 2 criteria; CISA Cross-Sector Cybersecurity Performance Goals.*
