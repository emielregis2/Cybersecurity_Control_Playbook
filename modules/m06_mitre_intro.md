# Moduł 6: MITRE ATT&CK — wprowadzenie

**Rozdział 6 · Jason Edwards, *The Cybersecurity Control Playbook* (Wiley, 2025)**

> Większość organizacji wie że jest atakowana. Nieliczne wiedzą jak. MITRE ATT&CK daje wspólny język do opisania tego "jak" — i to zmienia wszystko.

---

## Czym jest MITRE ATT&CK i dlaczego powstał

Przez dekady cyberbezpieczeństwo opisywało zagrożenia w kategoriach narzędzi i sygnatur: „wirus X", „exploit CVE-Y", „hash złośliwego pliku Z". To podejście ma fundamentalną wadę: atakujący mogą zmieniać narzędzia, sygnatury i hashe w ciągu minut — ale ich **metody działania** pozostają znacznie bardziej stabilne.

MITRE Corporation — amerykańska organizacja non-profit prowadząca federalne centra badawcze — w 2013 roku rozpoczęła projekt dokumentowania zachowań przeciwników na podstawie obserwacji rzeczywistych ataków. Wynik: **MITRE ATT&CK** (Adversarial Tactics, Techniques and Common Knowledge) — baza wiedzy o tym jak atakujący naprawdę działają, opisana w ustrukturyzowany, systematyczny sposób.

ATT&CK nie opisuje exploitów ani złośliwego oprogramowania jako takich. Opisuje **zachowania**: co atakujący robi krok po kroku — od pierwszego dostępu do realizacji swojego celu. To zmiana perspektywy z „co" na „jak".

Edwards w rozdziale 6 podkreśla kluczową właściwość ATT&CK: **wspólny język**. Gdy analityk SOC, inżynier bezpieczeństwa, CISO i zewnętrzny pentester mówią o tym samym ataku, mogą używać tych samych oznaczeń (T1566.001 — Spearphishing Attachment) zamiast opisywać go różnymi słowami. To pozwala na precyzyjną komunikację i porównywalność.

### Skala i zasięg ATT&CK

ATT&CK obejmuje trzy główne macierze:

**Enterprise ATT&CK** — ataki na systemy korporacyjne: Windows, macOS, Linux, Cloud (AWS, Azure, GCP), SaaS, Network, Containers. To najszerzej używana macierz — ponad 700 technik i podtechnik.

**Mobile ATT&CK** — ataki na urządzenia mobilne iOS i Android.

**ICS ATT&CK** — ataki na systemy przemysłowe i infrastrukturę krytyczną (SCADA, PLC, DCS).

Baza jest publicznie dostępna pod adresem attack.mitre.org i aktualizowana kilka razy w roku na podstawie nowych obserwacji z rzeczywistych incydentów.

---

## Struktura ATT&CK: Taktyki, Techniki, Podtechniki

Zrozumienie hierarchii ATT&CK jest kluczowe. Trzy poziomy abstrakcji:

### Taktyki — DLACZEGO (cel atakującego)

Taktyki to najwyższy poziom abstrakcji — opisują **cel** który atakujący chce osiągnąć na danym etapie ataku. ATT&CK Enterprise definiuje 14 taktyk:

| ID | Taktyka | Opis |
|----|---------|------|
| TA0001 | **Initial Access** | Pierwsze wejście do środowiska ofiary |
| TA0002 | **Execution** | Uruchomienie złośliwego kodu |
| TA0003 | **Persistence** | Utrzymanie dostępu po restarcie |
| TA0004 | **Privilege Escalation** | Uzyskanie wyższych uprawnień |
| TA0005 | **Defense Evasion** | Unikanie wykrycia |
| TA0006 | **Credential Access** | Kradzież poświadczeń |
| TA0007 | **Discovery** | Rekonesans wewnątrz sieci |
| TA0008 | **Lateral Movement** | Przemieszczanie się między systemami |
| TA0009 | **Collection** | Zbieranie danych do eksfiltracji |
| TA0010 | **Exfiltration** | Wyprowadzenie danych na zewnątrz |
| TA0011 | **Command and Control** | Komunikacja z zainfekowanymi systemami |
| TA0040 | **Impact** | Zakłócenie, zniszczenie, zaszyfrowanie danych |
| TA0042 | **Resource Development** | Budowanie infrastruktury do ataku |
| TA0043 | **Reconnaissance** | Rekonesans zewnętrzny przed atakiem |

**Ważne:** taktyki nie są krokami sekwencyjnymi — atakujący może wykonywać wiele taktyk jednocześnie, pomijać niektóre lub wracać do wcześniejszych.

### Techniki — JAK (metoda realizacji celu)

Techniki opisują **w jaki sposób** atakujący realizuje cel taktyczny. Każda taktyka ma wiele możliwych technik.

Przykład dla taktyki **Initial Access (TA0001)**:
- **T1566 — Phishing** — wyłudzanie przez e-mail
- **T1190 — Exploit Public-Facing Application** — exploit publicznej aplikacji
- **T1133 — External Remote Services** — wykorzystanie zewnętrznych usług zdalnych (VPN, RDP)
- **T1078 — Valid Accounts** — użycie prawidłowych skradzionych kont
- **T1195 — Supply Chain Compromise** — kompromitacja łańcucha dostaw

Każda technika ma unikalny identyfikator (T + numer).

### Podtechniki — DOKŁADNIE JAK (szczegółowa implementacja)

Podtechniki uszczegóławiają techniki — opisują konkretną implementację. Format: T[numer].[numer podtechniki].

Przykład dla **T1566 — Phishing**:
- **T1566.001 — Spearphishing Attachment** — złośliwy załącznik w e-mailu
- **T1566.002 — Spearphishing Link** — link do złośliwej strony
- **T1566.003 — Spearphishing via Service** — phishing przez media społecznościowe, Teams, Slack
- **T1566.004 — Spearphishing Voice** — vishing (phishing głosowy)

Ta granularność pozwala na bardzo precyzyjne mapowanie: konkretna kampania atakująca przez złośliwy plik Word w załączniku e-mail to T1566.001, nie ogólnie „phishing".

---

## Grupy i oprogramowanie w ATT&CK

ATT&CK nie tylko dokumentuje techniki — dokumentuje też **kto** ich używa i **czym**.

### Grupy (Groups)

ATT&CK kataloguje znane grupy atakujące (Advanced Persistent Threats — APT) z ich profilem technik. Przykłady:

**APT29 (Cozy Bear)** — rosyjski wywiad (SVR). Używa T1566.001 (spearphishing), T1059.001 (PowerShell), T1078 (valid accounts). Znany z ataku SolarWinds.

**APT41** — chińska grupa łącząca szpiegostwo z cyberprzestępczością. Szeroki arsenał technik od initial access przez persistence po exfiltration.

**Lazarus Group** — północnokoreańska grupa powiązana z atakami na banki i giełdy kryptowalut (WannaCry, Sony Pictures hack).

**FIN7** — cyberprzestępcza grupa targetująca branżę restauracyjną i retail. Specjalizacja: kradzież kart płatniczych.

Znajomość profilu technik konkretnej grupy pozwala organizacjom targetowanym przez danego aktora skupić ochronę tam gdzie jest najbardziej potrzebna.

### Oprogramowanie (Software)

ATT&CK kataloguje też narzędzia i malware z mapowaniem na techniki które implementują:

**Mimikatz** — T1003 (OS Credential Dumping), T1550.002 (Pass the Hash). Narzędzie do wyciągania haseł z pamięci Windows.

**Cobalt Strike** — framework do symulacji ataków (i niestety używany przez atakujących). Implementuje dziesiątki technik ATT&CK.

**Empire** — PowerShell post-exploitation framework. Używany przez wiele grup APT.

**Emotet** — banking trojan/botnet. Initial Access przez phishing, następnie loader dla innych malware.

---

## Macierz ATT&CK — Navigator

MITRE udostępnia narzędzie **ATT&CK Navigator** (attack.mitre.org/navigator) — interaktywna wizualizacja macierzy. Pozwala na:

- Kolorowanie technik według poziomu pokrycia przez kontrole
- Nakładanie profili grup APT na macierz
- Porównywanie pokrycia przez różne narzędzia bezpieczeństwa
- Tworzenie własnych warstw (layers) — np. "techniki zakryte przez nasz EDR"

Navigator jest kluczowym narzędziem do pracy z ATT&CK w praktyce. Edwards rekomenduje tworzenie własnych warstw dla organizacji — co wykrywamy, co blokujemy, gdzie mamy luki.

---

## Kill Chain vs ATT&CK — różnice i komplementarność

Często pojawia się pytanie: czym ATT&CK różni się od Cyber Kill Chain (Lockheed Martin)?

**Cyber Kill Chain** (2011) definiuje 7 faz ataku:
Reconnaissance → Weaponization → Delivery → Exploitation → Installation → Command & Control → Actions on Objectives

**Różnice:**

| | Kill Chain | ATT&CK |
|--|-----------|--------|
| Liczba faz/taktyk | 7 | 14 |
| Granularność | Wysoka (fazy) | Bardzo wysoka (700+ technik) |
| Skupienie | Fazy ataku | Konkretne zachowania |
| Aktualizacje | Rzadko | Kilka razy w roku |
| Mapping do narzędzi | Nie | Tak (grupy, software) |
| Zastosowanie | Rozumienie faz | Detekcja, hunting, gap analysis |

Kill Chain daje dobry model mentalny dla zarządu i komunikacji. ATT&CK daje operacyjną szczegółowość dla SOC, inżynierów i pentesterów. Obie mają swoje miejsce.

Edwards rekomenduje: Kill Chain do komunikacji z biznesem, ATT&CK do pracy operacyjnej.

---

## Praktyczne zastosowania ATT&CK

### 1. Threat Intelligence — profilowanie przeciwników

Gdy firma otrzymuje raport o kampanii atakującej jej branżę, raport najczęściej zawiera listę technik ATT&CK. Analityk może natychmiast sprawdzić:
- Które z tych technik są już pokryte przez nasze kontrole?
- Które wymagają dodatkowej detekcji lub blokowania?
- Jakie dane (artifacts) szukać w logach?

### 2. SOC — tworzenie reguł detekcji

ATT&CK dla każdej techniki dostarcza:
- Opis techniki i jej wariantów
- Przykłady użycia przez grupy APT
- **Data Sources** — jakie źródła danych pozwalają wykryć tę technikę
- **Detections** — konkretne wskazówki jak wykryć
- **Mitigations** — kontrole które ograniczają lub eliminują technikę

Przykład: T1059.001 (PowerShell) → Data Sources: Command execution logs, Script logs → Detection: Monitoruj wykonywanie PowerShell z encodowanymi komendami (`-EncodedCommand`), nieinteraktywne uruchomienia (`-NonInteractive -WindowStyle Hidden`), połączenia wychodzące z procesu powershell.exe.

### 3. Red Team / Penetration Testing

Pentesterzy używają ATT&CK jako scenariuszy testowych. Zamiast losowych ataków — symulacja konkretnego aktora (np. "emulacja APT29") z użyciem technik które ta grupa stosuje. To daje bardziej realistyczny obraz odporności organizacji.

**MITRE Engenuity ATT&CK Evaluations** — niezależne ewaluacje produktów bezpieczeństwa (EDR, SIEM) pod kątem pokrycia technik ATT&CK. Dobre źródło do porównania rozwiązań.

### 4. Threat Hunting

Proaktywne poszukiwanie śladów ataku w sieci przed wygenerowaniem alertu. Hipoteza: "zakładamy że atakujący mógł użyć T1055 (Process Injection) — szukamy w logach artefaktów które na to wskazują".

ATT&CK dostarcza listę artefaktów do szukania dla każdej techniki. Threat hunter tworzy hipotezę opartą na ATT&CK, przeszukuje dane, weryfikuje lub odrzuca.

### 5. Gap Analysis — gdzie mamy dziury?

Organizacja może zmapować swoje kontrole bezpieczeństwa na macierz ATT&CK i zobaczyć:
- Które techniki są wykrywane przez SIEM?
- Które są blokowane przez EDR?
- Które są całkowicie "niewidoczne" — brak detekcji, brak blokowania?

Wynik: mapa pokrycia z wyraźnie widocznymi lukami. To pozwala priorytezować inwestycje w bezpieczeństwo.

---

## Najważniejsze techniki ATT&CK — przegląd

Poniżej wybór technik o najwyższej częstości użycia w rzeczywistych atakach (dane ATT&CK i raporty Mandiant, CrowdStrike):

### T1566 — Phishing (Initial Access)
Najczęstszy wektor Initial Access. Złośliwy załącznik (T1566.001), link (T1566.002) lub phishing przez platformy komunikacji (T1566.003). Przeciwdziałanie: filtrowanie e-mail, szkolenia, sandbox dla załączników, DMARC/DKIM/SPF.

### T1059 — Command and Scripting Interpreter (Execution)
Wykonywanie poleceń przez interpretery: PowerShell (T1059.001), cmd (T1059.003), Bash (T1059.004), Python (T1059.006), JavaScript (T1059.007). Szeroko używane bo "living off the land" — atakujący używa wbudowanych narzędzi systemu. Detekcja: logowanie poleceń, monitorowanie argumentów procesów.

### T1078 — Valid Accounts (Multiple tactics)
Użycie skradzionych lub domyślnych kont. Pojawia się w Initial Access, Persistence, Privilege Escalation, Defense Evasion. Dlatego jest jedną z najniebezpieczniejszych technik — legalny użytkownik jest trudny do odróżnienia od atakującego. Przeciwdziałanie: MFA, monitoring anomalii logowania.

### T1055 — Process Injection (Defense Evasion, Privilege Escalation)
Wstrzykiwanie kodu do innego procesu — złośliwy kod działa w kontekście legalnego procesu (np. explorer.exe). Utrudnia wykrycie przez AV/EDR. Wiele wariantów: DLL injection (T1055.001), Process Hollowing (T1055.012), Thread Execution Hijacking (T1055.003).

### T1003 — OS Credential Dumping (Credential Access)
Wyciąganie hashy haseł z systemu. Mimikatz jest archetypem tej techniki. Warianty: LSASS Memory (T1003.001), SAM (T1003.002), DCSync (T1003.006). Przeciwdziałanie: Credential Guard, Protected Users group.

### T1021 — Remote Services (Lateral Movement)
Przemieszczanie się między systemami przez usługi zdalne: RDP (T1021.001), SMB (T1021.002), SSH (T1021.004), WinRM (T1021.006). Detekcja: monitoring lateralnych połączeń, anomalie w logowaniach na inne stacje.

### T1486 — Data Encrypted for Impact (Impact)
Szyfrowanie danych — ransomware. Jeden z najbardziej niszczycielskich wyników ataku. Przeciwdziałanie: backupy offline, EDR z ochroną przed szyfrowaniem, segmentacja sieci ograniczająca zasięg.

### T1041 — Exfiltration Over C2 Channel (Exfiltration)
Eksfiltracja danych przez ten sam kanał co Command & Control. Trudna do wykrycia bo ruch wygląda jak normalna komunikacja C2. Przeciwdziałanie: DLP, anomalie w ruchu wychodzącym.

---

## ATT&CK w praktyce — przykład analizy incydentu

Firma zostaje zaatakowana ransomware. Po incydencie forensics rekonstruuje przebieg ataku i mapuje go na ATT&CK:

```
1. TA0001 Initial Access
   └─ T1566.001 Spearphishing Attachment
      Pracownik otworzył złośliwy plik Word z makrem

2. TA0002 Execution  
   └─ T1059.001 PowerShell
      Makro uruchomiło ukryty skrypt PowerShell

3. TA0003 Persistence
   └─ T1547.001 Registry Run Keys
      Wpis w rejestrze zapewniający przetrwanie po restarcie

4. TA0005 Defense Evasion
   └─ T1055.012 Process Hollowing
      Złośliwy kod uruchomiony w kontekście explorer.exe

5. TA0006 Credential Access
   └─ T1003.001 LSASS Memory (Mimikatz)
      Wyciągnięcie haseł z pamięci

6. TA0008 Lateral Movement
   └─ T1021.001 Remote Desktop Protocol
      Dostęp do 12 serwerów przez RDP z wykradzionymi hasłami

7. TA0009 Collection
   └─ T1005 Data from Local System
      Zbieranie plików przed szyfrowaniem

8. TA0040 Impact
   └─ T1486 Data Encrypted for Impact
      Szyfrowanie plików (ransomware)
```

Ta mapa pozwala na precyzyjną odpowiedź: które kontrole zawiodły na którym etapie, co należy wzmocnić żeby zapobiec podobnemu atakowi w przyszłości.

---

## MITRE ATT&CK a inne frameworki

ATT&CK nie istnieje w próżni — jest komplementarny z innymi frameworkami:

**NIST CSF** → ATT&CK: NIST mówi "Detect" — ATT&CK precyzuje co i jak wykrywać.

**CIS Controls** → ATT&CK: każda kontrola CIS mapuje się na techniki ATT&CK które mityguje. CIS opublikował oficjalne mapowania.

**D3FEND** (MITRE): komplementarny framework opisujący techniki defensywne — co dokładnie blokuje konkretne techniki ATT&CK. Omówimy w module 8.

**STIX/TAXII** — standardy wymiany threat intelligence. ATT&CK jest dystrybuowany w formacie STIX, co pozwala na automatyczne zasilanie platform TIP (Threat Intelligence Platform).

---

## Kluczowe wnioski z modułu 6

**1. ATT&CK to wspólny język bezpieczeństwa**
SOC, red team, CISO, vendor — wszyscy mówią T1566.001 zamiast "phishing przez złośliwy Word". Precyzja komunikacji przyspiesza reakcję.

**2. Zachowania są stabilne, narzędzia nie**
Atakujący zmieniają hashi malware, IP, domeny — w minuty. Ale technika Process Injection pozostaje Process Injection niezależnie od narzędzia. ATT&CK skupia się na tym co stabilne.

**3. ATT&CK nie jest checklistą do odhaczenia**
To żywa baza wiedzy do ciągłego używania: threat hunting, gap analysis, tworzenie reguł detekcji, ewaluacja narzędzi.

**4. Navigator to must-have**
Wizualizacja pokrycia kontroli na macierzy ATT&CK powinna być standardowym artefaktem każdego programu bezpieczeństwa.

**5. Połączenie z threat intelligence**
ATT&CK bez danych o tym kto atakuje daną branżę jest mniej użyteczny. Połączenie z threat intel (kto nas atakuje) daje priorytetyzację: skupiamy się na technikach używanych przez naszych rzeczywistych przeciwników.

---

## Terminologia — słownik modułu 6

| Termin | Definicja |
|--------|-----------|
| ATT&CK | Adversarial Tactics, Techniques and Common Knowledge — baza wiedzy MITRE |
| Taktyka | Cel który atakujący chce osiągnąć (np. Initial Access, Persistence) |
| Technika | Metoda realizacji celu taktycznego (np. T1566 Phishing) |
| Podtechnika | Szczegółowa implementacja techniki (np. T1566.001 Spearphishing Attachment) |
| APT | Advanced Persistent Threat — zaawansowana, trwała grupa atakująca |
| Navigator | Narzędzie do wizualizacji i pracy z macierzą ATT&CK |
| Threat Hunting | Proaktywne szukanie śladów ataku przed wygenerowaniem alertu |
| Gap Analysis | Analiza luk w pokryciu kontroli względem technik ATT&CK |
| Kill Chain | 7-fazowy model ataku Lockheed Martin |
| Living off the land | Używanie przez atakujących wbudowanych narzędzi systemu |
| TTP | Tactics, Techniques and Procedures — profil zachowań atakującego |
| IOC | Indicator of Compromise — wskaźnik kompromitacji (hash, IP, domena) |
| C2 | Command and Control — infrastruktura do zarządzania zainfekowanymi systemami |
| Lateral Movement | Przemieszczanie się atakującego między systemami w sieci |
| STIX | Structured Threat Information Expression — format wymiany threat intel |

---

*Źródła: Jason Edwards, The Cybersecurity Control Playbook (Wiley, 2025), rozdział 6; MITRE ATT&CK Enterprise Matrix v15 (attack.mitre.org); MITRE ATT&CK Design and Philosophy (2020); Mandiant M-Trends 2024; CrowdStrike Global Threat Report 2024.*
