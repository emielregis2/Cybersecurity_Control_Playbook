# Moduł 7: Mapowanie zagrożeń do kontroli

**Rozdział 7 · Jason Edwards, *The Cybersecurity Control Playbook* (Wiley, 2025)**

> Kontrola bez zagrożenia to biurokracja. Zagrożenie bez kontroli to katastrofa. Mapowanie to most między nimi — przekształca listę technik ATT&CK w konkretne decyzje: co wdrożyć, w jakiej kolejności, za ile.

---

## Dlaczego mapowanie jest kluczowe

Poprzedni moduł wprowadził ATT&CK jako katalog technik atakujących. Ale katalog to nie strategia. Organizacja stojąca przed macierzą 700+ technik ATT&CK może poczuć się przytłoczona — od czego zacząć? Co jest ważne?

Edwards w rozdziale 7 odpowiada na to pytanie: **mapowanie zagrożeń do kontroli** to proces który przekształca wiedzę o zagrożeniach w działania obronne. To most między threat intelligence (co robią atakujący) a programem bezpieczeństwa (co robimy my).

Mapowanie działa w obie strony:
- **Zagrożenie → Kontrola:** dla danej techniki ATT&CK — jakie kontrole ją mitygują?
- **Kontrola → Zagrożenie:** jakie techniki ATT&CK pokrywa dana kontrola (np. EDR, MFA, firewall)?

Obie perspektywy są użyteczne, ale dla organizacji budującej lub doskonalący program bezpieczeństwa kluczowe jest drugie podejście: zacznij od inwentaryzacji kontroli, zmapuj je na ATT&CK, zobaczgdzie są luki.

---

## Threat Modeling — modelowanie zagrożeń

Zanim zmapujesz zagrożenia do kontroli, musisz wiedzieć jakie zagrożenia są dla Ciebie relewantne. To jest **threat modeling** — systematyczny proces identyfikacji zagrożeń dla konkretnej organizacji, systemu lub aplikacji.

### Cztery pytania threat modelingu (metodologia PASTA/STRIDE/DREAD)

Edwards rekomenduje proste cztery pytania jako punkt startowy:

**1. Co chronimy? (Assets)**
Lista zasobów wymagających ochrony: dane klientów, własność intelektualna, systemy produkcyjne, konta uprzywilejowane, reputacja. Każdy zasób ma wartość — data breach klientów ma inną wartość biznesową niż utrata dokumentacji technicznej.

**2. Przed czym chronimy? (Threats)**
Kto może chcieć zaatakować? Jakie ma motywacje? Jakie możliwości?
- Cyberprzestępcy (motywacja finansowa): ransomware, kradzież danych do sprzedaży
- Haktywizm: zakłócenie działania, wyciek danych dla efektu propagandowego
- Konkurencja (szpiegostwo przemysłowe): kradzież własności intelektualnej, planów
- Insiderzy (celowi lub przypadkowi): kradzież danych przy odejściu, błędy
- Państwa-hakerzy (APT): szpiegostwo, sabotaż infrastruktury krytycznej

**3. Jak mogą zaatakować? (Attack Vectors)**
Jakie techniki ATT&CK są realistyczne dla tych aktorów atakujących tę organizację? Tu wchodzi ATT&CK — każda zidentyfikowana grupa lub typ aktora ma profil technik w bazie.

**4. Co się stanie gdy się uda? (Impact)**
Skutki udanego ataku: finansowe (kara UODO, okup, koszty IR), operacyjne (przestój, utrata danych), reputacyjne (utrata klientów, medialne), prawne (odpowiedzialność, postępowania).

### STRIDE — model zagrożeń dla aplikacji

Microsoft STRIDE to framework do threat modelingu aplikacji:
- **S**poofing — podszywanie (np. fałszywa tożsamość, ARP spoofing)
- **T**ampering — manipulacja danymi (np. zmiana transakcji w bazie)
- **R**epudiation — zaprzeczenie (brak dowodów kto co zrobił — logi)
- **I**nformation Disclosure — ujawnienie informacji (wyciek danych)
- **D**enial of Service — odmowa usługi (DDoS, przeciążenie)
- **E**levation of Privilege — podniesienie uprawnień (privilege escalation)

STRIDE jest używany przez developerów podczas projektowania systemów. Dla każdego elementu diagramu przepływu danych (DFD) pytamy: jak może być zaatakowany w każdej kategorii STRIDE?

### DREAD — ocena ryzyka zagrożeń

DREAD to scoring model do priorytetyzacji zagrożeń:
- **D**amage — jaka szkoda jeśli atak się powiedzie? (1-10)
- **R**eproducibility — jak łatwo odtworzyć atak? (1-10)
- **E**xploitability — jak trudne jest przeprowadzenie? (1-10)
- **A**ffected Users — ilu użytkowników dotknie? (1-10)
- **D**iscoverability — jak łatwo znaleźć tę podatność? (1-10)

Suma / 5 = DREAD score (1-10). Wyższy = wyższy priorytet.

---

## Mapowanie ATT&CK → Kontrole: oficjalne zasoby

MITRE dostarcza wbudowane mapowania w bazie ATT&CK — dla każdej techniki sekcja **Mitigations** zawiera listę oficjalnych mitygacji (M + numer):

Przykłady mitygacji ATT&CK:
- **M1032 — Multi-factor Authentication** — mityguje T1078, T1110, T1556
- **M1049 — Antivirus/Antimalware** — mityguje wiele technik Execution
- **M1026 — Privileged Account Management** — mityguje T1078, T1003, T1021
- **M1042 — Disable or Remove Feature or Program** — mityguje T1059 (wyłącz makra Office)
- **M1031 — Network Intrusion Prevention** — mityguje techniki Command and Control
- **M1027 — Password Policies** — mityguje T1110 (Brute Force)

### Mapowanie CIS Controls → ATT&CK

Center for Internet Security opublikował oficjalne mapowanie CIS Controls v8 na ATT&CK Enterprise. To niezwykle użyteczny zasób — każda z 18 grup kontroli CIS jest powiązana z technikami ATT&CK które mityguje.

Przykłady:
- **CIS Control 1 (Inventory of Enterprise Assets)** → mityguje T1200, T1195, T1190 — ataki na nieznane zasoby
- **CIS Control 5 (Account Management)** → mityguje T1078, T1136, T1087 — nieautoryzowane konta
- **CIS Control 6 (Access Control Management)** → mityguje T1078, T1098, T1548 — nadużycia uprawnień
- **CIS Control 10 (Malware Defenses)** → mityguje T1566, T1204, T1059 — malware
- **CIS Control 13 (Network Monitoring and Defense)** → mityguje T1071, T1048, T1041 — C2 i eksfiltracja

Edwards rekomenduje: jeśli organizacja wdraża CIS Controls (dobra praktyka), używaj oficjalnego mapowania CIS→ATT&CK do oceny co zostało pokryte, a co wymaga dodatkowych kontroli.

### Mapowanie NIST CSF → ATT&CK

CISA (Cybersecurity and Infrastructure Security Agency) i NIST opublikowały mapowania między funkcjami CSF a technikami ATT&CK. Funkcja **Detect** w CSF bezpośrednio odpowiada wykrywalności technik ATT&CK — każda kategoria CSF DE (Detection) mapuje się na konkretne techniki które powinna wykrywać.

---

## Praktyczny proces mapowania — krok po kroku

Edwards proponuje sześciostopniowy proces dla organizacji wdrażającej threat-informed defense:

### Krok 1: Inwentaryzacja aktywów i danych

Zanim zmapujesz zagrożenia, wiedz co chronisz:
- Jakie dane przechowujesz i gdzie? (klasyfikacja danych)
- Jakie systemy są krytyczne dla działania?
- Jakie są zewnętrzne punkty dostępu?
- Jakie zewnętrzne zależności (SaaS, dostawcy, API)?

Wynik: mapa aktywów z klasyfikacją ważności (Critical / High / Medium / Low).

### Krok 2: Profil przeciwnika

Na podstawie branży, geografii i profilu organizacji — zidentyfikuj realistycznych aktorów zagrożeń:
- Sprawdź ATT&CK Groups dla branży
- Przejrzyj raporty threat intelligence (CERT Polska, Mandiant, CrowdStrike)
- Uwzględnij zagrożenia wewnętrzne (insiderzy, błędy ludzkie)

Wynik: lista 3–5 najbardziej prawdopodobnych typów aktorów z ich TTP.

### Krok 3: Lista priorytetowych technik ATT&CK

Na podstawie profilu przeciwników — wypisz techniki ATT&CK które są dla nich charakterystyczne. Filtruj przez lens swojej organizacji:
- Czy ta technika jest możliwa w naszym środowisku? (np. techniki iOS nie są relewantne jeśli nie używasz iOS)
- Czy nasze aktywa są wartościowym celem dla tej techniki?

Wynik: lista 30–60 priorytetowych technik (zamiast 700+).

### Krok 4: Inwentaryzacja obecnych kontroli

Lista wszystkich kontroli bezpieczeństwa które posiadasz:
- Techniczne: EDR, SIEM, firewall, WAF, MFA, PAM, email gateway, DLP
- Procesowe: access review, patch management, incident response, backup testing
- Ludzkie: szkolenia security awareness, SOC procedures

Dla każdej kontroli: co ona robi? Jakie zachowania/techniki wykrywa lub blokuje?

### Krok 5: Gap Analysis — mapowanie kontroli na techniki

Dla każdej priorytetowej techniki ATT&CK sprawdź:
- **Detect:** czy mamy regułę która wykryje użycie tej techniki?
- **Block:** czy mamy kontrolę która zablokuje tę technikę?
- **Respond:** czy mamy procedurę reagowania na alert o tej technice?

Wynik: macierz z kolorowaniem:
- 🟢 Zielony: pełne pokrycie (detect + block + respond)
- 🟡 Żółty: częściowe pokrycie (np. detect bez block)
- 🔴 Czerwony: brak pokrycia

### Krok 6: Priorytetyzacja i roadmapa

Nie możesz naprawić wszystkiego naraz — musisz priorytetyzować. Edwards rekomenduje scoring każdej luki (czerwonej komórki):

**Priorytet = Prawdopodobieństwo użycia × Wpływ na organizację × (1 / Koszt kontroli)**

Wysoki priorytet = technika często używana przez Twoich przeciwników, duży wpływ jeśli się powiedzie, relatywnie tania do adresowania.

Wynik: roadmapa zabezpieczeń z priorytetami Q1/Q2/Q3/Q4.

---

## Narzędzia do mapowania

### ATT&CK Navigator (MITRE)

Darmowe, webowe narzędzie. Pozwala na:
- Importowanie profili grup APT jako warstwy
- Kolorowanie macierzy według pokrycia
- Eksport do JSON (możliwość automatyzacji)
- Porównywanie warstw (np. "pokrycie EDR" vs "profil atakującego")

**Workflow z Navigatorem:**
1. Pobierz profil grupy APT atakującej branżę (np. FIN7) jako warstwę
2. Stwórz własną warstwę "nasze kontrole" — zaznacz techniki które EDR/SIEM pokrywa
3. Porównaj obie warstwy — red cells w warstwie atakującego bez odpowiednika w warstwie kontroli = luka

### Vectr (Security Risk Advisors)

Open-source platforma do zarządzania i śledzenia ćwiczeń red team/purple team z mapowaniem na ATT&CK. Umożliwia dokumentowanie wyników testów (które techniki zostały skutecznie użyte, które zablokowane) i śledzenie postępu w czasie.

### OpenCTI / MISP

Platformy Threat Intelligence (TIP) z wbudowaną integracją ATT&CK. Automatyczne tagowanie IOC i kampanii technikami ATT&CK. Przydatne gdy organizacja przetwarza duże ilości threat intelligence.

### Tidal Cyber

Komercyjne narzędzie do threat-informed defense — profiler przeciwników, mapowanie na kontrole, tracking postępu Gap Analysis w czasie.

---

## Purple Team — pomost między Red i Blue

Tradycyjny model: Red Team atakuje, Blue Team broni, po ćwiczeniu jest "debrief". Problem: obie strony rzadko się uczą od siebie w czasie rzeczywistym.

**Purple Team** to model współpracy gdzie Red i Blue pracują razem:
1. Red Team ogłasza jaką technikę ATT&CK zamierza emulować
2. Blue Team obserwuje w czasie rzeczywistym czy widzi tę aktywność w swoich narzędziach
3. Jeśli nie widzi — Red Team pomaga zrozumieć co było widoczne i jak to zdetektować
4. Blue Team tworzy nową regułę detekcji
5. Red Team powtarza technikę — Blue sprawdza czy reguła działa

Wynik: bezpośrednia poprawa możliwości detekcji SOC, a nie raport po fakcie.

ATT&CK jest wspólnym językiem Purple Team: Red mówi "wykonuję T1055.012 Process Hollowing" — Blue dokładnie wie czego szukać.

### Atomic Red Team (Red Canary)

Open-source biblioteka małych, atomowych testów dla każdej techniki ATT&CK. Zamiast pełnego ćwiczenia Red Team (kosztowne, rzadkie) — możesz codziennie uruchomić konkretny atomowy test i sprawdzić czy SIEM/EDR go wykrył.

Przykład testu dla T1003.001 (LSASS Dump):
```powershell
# Atomic Test T1003.001-1
# Test: Dump LSASS memory using procdump
procdump.exe -accepteula -ma lsass.exe lsass_dump
```

Uruchamiasz test → sprawdzasz czy alert w EDR/SIEM → jeśli tak: kontrola działa; jeśli nie: tworzysz regułę.

---

## Mapowanie w kontekście regulacji i compliance

Jedną z ważnych aplikacji mapowania ATT&CK→kontrole jest **compliance mapping** — wykazanie regulatorom lub audytorom że kontrole bezpieczeństwa są adekwatne do realnych zagrożeń.

### ATT&CK → NIS2

Dyrektywa NIS2 (Network and Information Security) obowiązuje w Polsce od 2024 roku dla podmiotów kluczowych i ważnych. Wymaga "odpowiednich i proporcjonalnych środków technicznych i organizacyjnych". ATT&CK gap analysis jest doskonałym dowodem że organizacja rozumie zagrożenia i wdraża proporcjonalne kontrole.

### ATT&CK → ISO 27001

ISO 27001 Annex A zawiera 93 kontrole bezpieczeństwa. Mapowanie ISO 27001 kontroli na ATT&CK techniki (istnieje kilka publicznych mapowań) pozwala na threat-informed prioritization kontroli ISO — zamiast wdrażać wszystkie 93 z równą starannością, skupiasz się na tych które pokrywają realne techniki Twoich przeciwników.

### ATT&CK → DORA (Digital Operational Resilience Act)

DORA obowiązuje instytucje finansowe w UE od 2025 roku. Wymaga threat-led penetration testing (TLPT) opartego na ATT&CK dla największych instytucji. Mniejsze firmy mogą używać ATT&CK gap analysis jako alternatywę.

---

## Przykład praktyczny: mapowanie dla firmy e-commerce

Firma e-commerce (150 pracowników, Magento, AWS) przechodzi przez proces mapowania:

**Profil przeciwnika:** cyberprzestępcy finansowi (kradzież kart) + ransomware grupy

**Priorytetowe techniki ATT&CK (top 15):**
T1566.001, T1078, T1190, T1059.001, T1055, T1003.001, T1021.001, T1021.002, T1486, T1041, T1505.003, T1190, T1071.001, T1110.003, T1136

**Inwentaryzacja kontroli:**
- EDR: CrowdStrike Falcon (wszystkie stacje Windows)
- Email gateway: Microsoft Defender for Office 365
- MFA: tylko dla VPN, nie dla M365 ani Magento admin
- SIEM: brak (tylko logi w CloudWatch)
- WAF: AWS WAF przed Magento
- Backup: codzienne snapshots RDS, retencja 7 dni

**Gap Analysis wynik (fragment):**

| Technika | Kontrola | Status |
|---------|---------|--------|
| T1566.001 Phishing | M365 Defender email filter | 🟡 Częściowe |
| T1078 Valid Accounts | MFA tylko VPN | 🔴 Luka |
| T1190 Exploit Public App | AWS WAF | 🟡 Częściowe |
| T1059.001 PowerShell | CrowdStrike (script control) | 🟢 Pokryte |
| T1486 Ransomware | Backup + CrowdStrike | 🟡 Częściowe |
| T1041 Exfiltration | Brak DLP | 🔴 Luka |
| T1505.003 Web Shell | AWS WAF + CrowdStrike | 🟡 Częściowe |

**Priorytetowe działania:**
1. 🔴 MFA dla M365 i Magento admin → T1078 → koszt: 0 PLN (wbudowane w M365)
2. 🔴 SIEM (Wazuh lub Elastic) → widoczność → koszt: ~15 000 PLN
3. 🟡 DLP dla AWS S3 → T1041 → koszt: ~8 000 PLN/rok
4. 🟡 Rozszerzenie retencji backup → ransomware recovery → koszt: ~6 000 PLN/rok

---

## Kluczowe wnioski z modułu 7

**1. Mapowanie to ciągły proces, nie projekt**
Landscape zagrożeń ewoluuje, ATT&CK jest aktualizowany, kontrole się zmieniają. Gap analysis powinien być powtarzany co kwartał lub przy każdej znaczącej zmianie infrastruktury.

**2. Zacznij od profilu przeciwnika, nie od pełnej macierzy**
700+ technik ATT&CK to za dużo. Zawęź do 30–60 technik relewantnych dla Twoich rzeczywistych przeciwników.

**3. Purple Team to najszybsza ścieżka poprawy detekcji**
Regularne, małe ćwiczenia (Atomic Red Team) dają szybką pętlę informacji zwrotnej: uruchamiasz test → sprawdzasz detekcję → naprawiasz → powtarzasz.

**4. Mapowanie daje język do rozmowy z biznesem**
"Mamy 18 technik bez żadnej detekcji, 12 z częściowym pokryciem" to zrozumiały argument dla zarządu. Lepszy niż "potrzebujemy więcej bezpieczeństwa".

**5. Compliance ≠ Bezpieczeństwo, ale ATT&CK pomaga połączyć oba**
Organizacje które rozumieją mapowanie ATT&CK→kontrole mogą wykazać regulatorom że ich compliance ma realne umocowanie w zagrożeniach.

---

## Terminologia — słownik modułu 7

| Termin | Definicja |
|--------|-----------|
| Threat Modeling | Systematyczny proces identyfikacji zagrożeń dla systemu/organizacji |
| STRIDE | Microsoft framework do threat modelingu aplikacji (6 kategorii zagrożeń) |
| DREAD | Scoring model do priorytetyzacji zagrożeń (5 wymiarów) |
| Gap Analysis | Analiza luk między obecnymi kontrolami a wymaganym pokryciem |
| Purple Team | Współpraca Red i Blue Team w czasie rzeczywistym dla poprawy detekcji |
| Atomic Red Team | Biblioteka małych testów dla każdej techniki ATT&CK (Red Canary) |
| TTP | Tactics, Techniques, Procedures — profil zachowań aktora zagrożeń |
| Mitigation | Kontrola w ATT&CK która ogranicza lub eliminuje technikę (M + numer) |
| Threat-informed defense | Model obrony oparty na wiedzy o rzeczywistych zagrożeniach |
| TLPT | Threat-Led Penetration Testing — wymagane przez DORA dla instytucji finansowych |
| DFD | Data Flow Diagram — diagram przepływu danych używany w threat modelingu |
| PASTA | Process for Attack Simulation and Threat Analysis — metodologia threat modelingu |
| NIS2 | Dyrektywa o bezpieczeństwie sieci i systemów informacyjnych (UE, 2024) |
| DORA | Digital Operational Resilience Act — regulacja dla instytucji finansowych UE (2025) |

---

*Źródła: Jason Edwards, The Cybersecurity Control Playbook (Wiley, 2025), rozdział 7; MITRE ATT&CK Mitigations (attack.mitre.org/mitigations); CIS Controls v8 ATT&CK Mapping (cisecurity.org); CISA ATT&CK Mapping Guide; Red Canary Atomic Red Team (github.com/redcanaryco/atomic-red-team).*
