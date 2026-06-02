# Moduł 2: Podejście oparte na ryzyku

**Rozdział 2 · Jason Edwards, *The Cybersecurity Control Playbook* (Wiley, 2025)**

> Bezpieczeństwo oparte na compliance to gra w chowanego z audytorem. Bezpieczeństwo oparte na ryzyku to strategia przetrwania. Jedno daje certyfikat. Drugie daje ochronę.

---

## Dlaczego podejście oparte na ryzyku zmienia wszystko

Organizacje od dekad wdrażają bezpieczeństwo przez pryzmat zgodności: zrób to, co każe standard, zdaj audyt, odznacz kolejne kontrole. Problem w tym, że atakujący nie czyta Twojej listy compliance. Nie atakuje obszarów, które masz „odhaczone" — atakuje tam, gdzie jesteś realnie słaby.

Edwards otwiera rozdział 2 prowokacyjnym stwierdzeniem: *większość organizacji wie o zagrożeniach z zewnątrz, ale nie wie nic o własnym profilu ryzyka.* Mają SIEM, EDR, firewall nowej generacji — i nadal zostają zhakowane, bo nigdy nie zapytały: *które z naszych ryzyk są największe i co robimy gdy się zmaterializują?*

Podejście oparte na ryzyku (*risk-based approach*) to fundamentalna zmiana perspektywy:

- Zamiast pytać *„co każe nam wdrożyć standard?"* pytamy *„co nam realnie grozi?"*
- Zamiast traktować wszystkie zagrożenia równo — priorytetyzujemy przez pryzmat prawdopodobieństwa i skutków
- Zamiast bezpieczeństwa jako projektu — tworzymy ciągły, adaptujący się proces

Efekt? Ograniczone zasoby (bo zawsze są ograniczone) trafiają tam, gdzie generują maksymalną redukcję ryzyka. Nie tam, gdzie wskazuje checklisty audytora.

---

## Fundamenty: czym jest ryzyko cybernetyczne

Zanim zbudujemy cały system zarządzania ryzykiem, Edwards precyzuje co właściwie mierzymy. Ryzyko cybernetyczne to **potencjalne zdarzenie lub warunek, który może spowodować szkodę, stratę lub zakłócenie dla systemów informatycznych, danych lub operacji cyfrowych organizacji**.

Ta definicja ma trzy kluczowe elementy:

### Zagrożenie (Threat)

Aktor lub zdarzenie zdolne do wykorzystania podatności. Zagrożenia dzielimy na trzy kategorie:

**Zewnętrzne:** cyberprzestępcy motywowani finansowo, grupy sponsorowane przez państwa (APT — Advanced Persistent Threats), hakctywiści, konkurenci prowadzący szpiegostwo przemysłowe. Są zazwyczaj dobrze finansowane i wysoko wykwalifikowane. Atakują przez phishing, exploity znanych podatności, ataki na łańcuch dostaw.

**Wewnętrzne:** pracownicy (złośliwi lub niedbali), byli pracownicy z aktywnym dostępem, kontrahenci z nadmiernymi uprawnieniami. Edwards podkreśla: *zagrożenia wewnętrzne są często trudniejsze do wykrycia niż zewnętrzne, bo aktor działa na legalnych uprawnieniach*. Statystyki są bezwzględne — według Verizon DBIR 2024, czynnik ludzki (phishing, błędy konfiguracji, niedbałość) jest obecny w ponad 68% naruszeń.

**Wyłaniające się:** AI-napędzane cyberataki (generowanie spear-phishingu w skali, automatyczne wykrywanie podatności), ataki na łańcuch dostaw (SolarWinds, XZ Utils), zagrożenia dla systemów OT/IoT (konwergencja IT/OT), deepfake fraud (BEC nowej generacji z podrobionymi głosami dyrektorów).

### Podatność (Vulnerability)

Słabość w systemach, politykach lub procedurach, którą zagrożenie może wykorzystać. Kluczowe klasy:

- Techniczne: niezałatane oprogramowanie, błędna konfiguracja, słabe protokoły kryptograficzne
- Procesowe: brak procedury offboardingu, nieprzetestowane backupy, brak MFA
- Ludzkie: brak szkoleń, podatność na inżynierię społeczną, shadow IT
- Fizyczne: brak kontroli dostępu do serwerowni, niezabezpieczone laptopy

### Prawdopodobieństwo (Likelihood)

Ocena szansy, że dane zagrożenie skutecznie wykorzysta istniejącą podatność. Opiera się na: danych wywiadowczych o aktywnych kampaniach ataków, historycznych danych o incydentach w branży, jakości istniejących kontroli prewencyjnych, atrakcyjności organizacji jako celu.

### Wpływ (Impact)

Skutki udanego ataku. Edwards definiuje cztery wymiary:

- **Finansowy:** bezpośrednie koszty (IR, odtworzenie danych, kary), pośrednie (utrata klientów, przestój)
- **Operacyjny:** zakłócenie procesów biznesowych, przestoje systemów krytycznych, utrata produktywności
- **Reputacyjny:** utrata zaufania klientów i partnerów, szkody wizerunkowe
- **Prawny/regulacyjny:** kary GDPR, HIPAA, PCI DSS; roszczenia cywilne; odpowiedzialność osobista zarządu

---

## Identyfikacja ryzyk: od teorii do praktyki

Identyfikacja ryzyk to nie jednorazowe ćwiczenie — to ciągły proces wymagający systematycznych technik.

### Threat Modeling — myśl jak atakujący

Threat modeling to strukturalizowany sposób identyfikowania potencjalnych wektorów ataku. Organizacja mapuje swoje systemy, dane i procesy, a następnie stara się odpowiedzieć na pytanie: *jak atakujący mógłby wyrządzić nam szkodę?*

**Framework STRIDE** (Microsoft) kategoryzuje zagrożenia przez pryzmat tego co atakujący chce osiągnąć:
- **S**poofing — podszywanie się pod użytkownika lub system
- **T**ampering — nieautoryzowana modyfikacja danych
- **R**epudiation — zaprzeczanie wykonanym działaniom
- **I**nformation Disclosure — nieuprawniony dostęp do informacji
- **D**enial of Service — zakłócenie dostępności usług
- **E**levation of Privilege — eskalacja uprawnień

**Framework PASTA** (Process for Attack Simulation and Threat Analysis) jest bardziej biznesowo zorientowany — zaczyna od identyfikacji celów biznesowych i atakowych, a dopiero potem przechodzi do analizy technicznej. Edwards rekomenduje PASTA dla organizacji, które chcą powiązać wyniki threat modelingu bezpośrednio z ryzykiem biznesowym.

**Praktyczny przykład:** Threat modeling systemu płatności e-commerce może ujawnić, że:
- API płatnicze nie waliduje prawidłowo tokenów sesji (Tampering)
- Logi transakcji nie mają integralności kryptograficznej (Repudiation)
- Baza danych kart jest dostępna z serwera webowego (Information Disclosure)

Każde z tych odkryć generuje konkretny wpis do rejestru ryzyk z priorytetem opartym na potencjalnym wpływie (np. naruszenie PCI DSS + utrata danych klientów).

### Vulnerability Scanning — systematyczne wykrywanie słabości

Automatyczne skanery (Nessus, Qualys, OpenVAS) regularnie przeszukują infrastrukturę w poszukiwaniu znanych podatności opisanych w bazie CVE (Common Vulnerabilities and Exposures). Edwards wskazuje na trzy kluczowe praktyki:

**Skanowanie uwierzytelnione vs. nieuniechnione.** Skan bez uwierzytelnienia pokazuje co widzi atakujący z zewnątrz. Skan z uwierzytelnieniem pokazuje pełen stan systemów wewnętrznych. Organizacje dojrzałe robią oba.

**CVSS scoring i jego ograniczenia.** Common Vulnerability Scoring System (CVSS) przypisuje podatnościom oceny od 0 do 10. Ale Edwards przestrzega: *CVSS mówi o potencjalnej groźności podatności w ogóle, nie o ryzyku dla Twojej organizacji*. Podatność CVSS 9.8 w systemie niedostępnym z internetu może być mniej priorytetowa niż podatność CVSS 6.5 w krytycznym systemie produkcyjnym.

**Priorytetyzacja przez EPSS.** Exploit Prediction Scoring System (EPSS) szacuje prawdopodobieństwo, że dana podatność zostanie faktycznie wykorzystana w ciągu 30 dni. To bardziej operacyjna metryka niż sam CVSS.

### Penetration Testing — symulowany atak

Etyczni hakerzy próbują włamać się do systemów organizacji używając tych samych technik co prawdziwi atakujący. Edwards wyróżnia trzy modele:

**Black box:** pentester nie ma żadnych informacji wstępnych — symuluje zewnętrznego atakującego. Najrealistyczniejszy scenariusz, ale czasochłonny.

**White box:** pentester ma pełen dostęp do dokumentacji, kodu źródłowego, schematów sieci. Pozwala na głębszą analizę, szczególnie wartościową dla bezpieczeństwa aplikacji.

**Gray box:** kompromis — pentester ma niektóre informacje (np. konta użytkowników, ale nie schemat sieci). Symuluje scenariusz zagrożenia wewnętrznego lub atakującego, który zdobył częściowy dostęp.

**Red Team vs. Penetration Test.** Pentest ma zdefiniowany zakres i czas. Red Team exercise jest bardziej rozległy — zespół atakujący operuje przez tygodnie, próbując osiągnąć konkretny cel biznesowy (np. dostęp do systemu finansowego), i może użyć inżynierii społecznej, ataków fizycznych i technik OSINT. Red Team ujawnia jak skuteczne są kontrole detekcyjne i korekcyjne — nie tylko prewencyjne.

### Threat Intelligence Feeds — zewnętrzny wywiad

Zewnętrzne źródła danych o aktywnych zagrożeniach, grupach APT, nowych exploitach i kampaniach phishingowych. Klasy threat intelligence:

- **Strategic:** trendy wysokiego poziomu, raporty o grupach APT, prognozy zagrożeń (dla zarządu i CISO)
- **Tactical:** techniki, taktyki i procedury (TTPs) atakujących — mapowane na MITRE ATT&CK
- **Operational:** informacje o aktywnych kampaniach, atakowanych branżach, użytych narzędziach
- **Technical:** IOC (Indicators of Compromise) — adresy IP, domeny, hashe plików złośliwego oprogramowania

Kluczowe źródła: FS-ISAC, CISA AIS, MISP, AlienVault OTX, komercyjne platformy (Recorded Future, CrowdStrike Intelligence). Edwards podkreśla: *threat intelligence ma wartość tylko gdy jest aktualny i zintegrowany z systemami detekcyjnymi — threat intelligence raport czytany raz w miesiącu to makulatura.*

---

## Rejestr ryzyk — centralny dokument programu bezpieczeństwa

Rejestr ryzyk to skatalogowany zbiór wszystkich zidentyfikowanych ryzyk organizacji wraz z ocenami, właścicielami, kontrolami i planami mitigacji. Edwards traktuje go jako **najważniejszy dokument programu bezpieczeństwa** — ważniejszy niż jakikolwiek raport z audytu.

### Struktura wpisu w rejestrze ryzyk

| Pole | Opis | Przykład |
|---|---|---|
| ID | Unikalny identyfikator | RISK-042 |
| Kategoria | Domena z taksonomii | Bezpieczeństwo sieci |
| Opis | Co konkretnie grozi | Nieautoryzowany dostęp przez VPN legacy |
| Zagrożenie | Aktor/zdarzenie | Zewnętrzny atakujący, credential stuffing |
| Podatność | Słabość systemu | Brak MFA na koncie VPN, stary protokół |
| Prawdopodobieństwo | 1-5 (lub %) | 4 — wysokie |
| Wpływ | 1-5 (lub $) | 5 — krytyczny |
| Ocena ryzyka | P × W | 20 — krytyczne |
| Właściciel | Odpowiedzialna osoba | Dyrektor IT |
| Kontrola | Aktualnie istniejąca | Monitoring logowań |
| Gap | Czego brakuje | MFA, rotacja tokenów |
| Plan mitigacji | Co zrobić | Wdrożyć MFA w 30 dni |
| Status | Etap procesu | W toku |
| Termin | Deadline | 2026-07-31 |

### Dynamika rejestru ryzyk

Rejestr ryzyk to żywy dokument — powinien być aktualizowany:
- Po każdym incydencie bezpieczeństwa (nowe ryzyka, zmiana priorytetów)
- Po każdej znaczącej zmianie infrastruktury (nowe systemy, migracje, fuzje)
- Po każdym nowym threat intelligence (nowe kampanie, nowe CVE)
- Regularnie (minimum kwartalnie) — przegląd statusów i ocena aktualności

Edwards ostrzega przed **„zombie risks"** — wpisami w rejestrze, które istnieją od lat z statusem „w toku" i nigdy nie są zamknięte. Taki rejestr jest bardziej niebezpieczny niż brak rejestru, bo daje zarządowi fałszywe poczucie, że ryzyka są zarządzane.

---

## Matryca ryzyk — wizualizacja i priorytetyzacja

Matryca ryzyk (*risk matrix*) to narzędzie wizualne, które pozwala szybko identyfikować które ryzyka wymagają natychmiastowej reakcji. Edwards używa jej jako podstawowego narzędzia komunikacji ryzyka z zarządem.

### Standardowa matryca 5×5

```
WPŁYW
  5 │ 5   10   15   20   25
  4 │ 4    8   12   16   20
  3 │ 3    6    9   12   15
  2 │ 2    4    6    8   10
  1 │ 1    2    3    4    5
    └──────────────────────
      1    2    3    4    5  PRAWDOPODOBIEŃSTWO
```

Strefy:
- **Czerwona (15-25):** Krytyczne — natychmiastowe działanie, eskalacja do zarządu
- **Pomarańczowa (8-14):** Wysokie — plan mitigacji w ciągu 30-90 dni
- **Żółta (3-7):** Średnie — monitorowanie, planowanie długoterminowe
- **Zielona (1-2):** Niskie — akceptacja lub monitoring pasywny

### Ograniczenia matrycy ryzyk

Edwards jest otwarty na słabości tego narzędzia:

**Subiektywność ocen.** Różni eksperci mogą ocenić to samo ryzyko zupełnie różnie. Ryzyko "phishing" — jeden ekspert da prawdopodobieństwo 5 (wysyłamy tysiące maili dziennie), inny da 2 (mamy dobre filtry). Bez metodyki kalibracji wyniki są niespójne.

**Złudzenie precyzji.** Iloczyn 3×4=12 wygląda naukowo, ale jest to 12 z subiektywnych ocen. Nie dawaj cyfrom w matrycy fałszywego poczucia dokładności.

**Brak korelacji między ryzykami.** Matryca traktuje każde ryzyko niezależnie. W rzeczywistości kompromitacja jednego systemu często uruchamia kaskadę innych ryzyk.

Dlatego Edwards rekomenduje używanie matrycy jako *narzędzia konwersacji*, nie jako *wyroczni decyzyjnej*. Jej wartość leży w tworzeniu wspólnego języka między bezpieczeństwem a biznesem — nie w generowaniu dokładnych liczb.

---

## Business Impact Analysis — perspektywa biznesowa

Business Impact Analysis (BIA) to metodologia oceny jak konkretne zdarzenie zakłóci operacje biznesowe. Edwards traktuje BIA jako pomost między technicznym bezpieczeństwem a strategicznym myśleniem biznesowym.

### Proces BIA

**Krok 1: Identyfikacja procesów krytycznych.**
Które procesy biznesowe są krytyczne dla organizacji? Typowo: procesy generujące przychód, procesy obsługi klientów, procesy regulowane przez prawo (np. przetwarzanie płatności), procesy o wysokich kosztach przestoju.

**Krok 2: Określenie zależności.**
Jakie systemy IT obsługują każdy krytyczny proces? Jakie są zależności między systemami? Gdzie są pojedyncze punkty awarii (SPOF)?

**Krok 3: Wyznaczenie RTO i RPO.**
- **RTO (Recovery Time Objective):** maksymalny akceptowalny czas przywrócenia operacji po incydencie
- **RPO (Recovery Point Objective):** maksymalna akceptowalna utrata danych (ile godzin możemy cofnąć się w czasie)

Przykład: System ERP firmy produkcyjnej — RTO = 4 godziny (dłuższy przestój = zatrzymanie linii), RPO = 2 godziny (akceptujemy utratę max 2 godzin zleceń produkcyjnych).

**Krok 4: Kwantyfikacja wpływu finansowego.**
Ile kosztuje godzina przestoju każdego krytycznego systemu? Typowe składniki:
- Utracony przychód (sprzedaż niemożliwa podczas przestoju)
- Koszty operacyjne (pracownicy płatni bez możliwości pracy)
- Koszty nadgodzin (przyspieszenie odtwarzania)
- Kary umowne (SLA z klientami, umowy o dostawy)
- Koszty regulacyjne (kary za naruszenie przepisów)

**Krok 5: Priorytetyzacja przez wpływ.**
Systemy o najwyższym koszcie przestoju → najwyższy priorytet inwestycji w bezpieczeństwo i ciągłość działania.

### BIA jako fundament priorytetyzacji kontroli

Edwards łączy wyniki BIA bezpośrednio z rejestrem ryzyk. Ryzyko atakujące system o RTO = 1 godzina i koszcie przestoju 500 000 zł/godzina powinno mieć dramatycznie wyższy priorytet niż ryzyko atakujące system marginalny — nawet jeśli technicznie oba mają podobne parametry podatności.

To jest moment, w którym bezpieczeństwo przestaje być domeną IT i staje się rozmową biznesową: *"Jakie jest ryzyko dla naszych przychodów i jak go redukujemy?"*

---

## Apetyt na ryzyko i tolerancja ryzyka

Dwa kluczowe pojęcia, które muszą być zdefiniowane przez zarząd — nie przez dział IT.

### Apetyt na ryzyko (Risk Appetite)

Apetyt na ryzyko to ilość i typ ryzyka, które organizacja jest gotowa zaakceptować w dążeniu do swoich celów strategicznych. To deklaracja filozofii zarządzania ryzykiem: *„Jesteśmy gotowi akceptować ryzyko X, bo zyski biznesowe przewyższają potencjalne straty."*

Przykłady apetytu na ryzyko:
- *„Akceptujemy ryzyko przestoju systemów wewnętrznych do 8 godzin, ale zero tolerancji dla przestoju systemów klientów."*
- *„Akceptujemy ryzyko phishingu na poziomie 5% skuteczności, bo koszt eliminacji do zera przewyższa zyski."*
- *„Nie akceptujemy żadnego ryzyka naruszenia danych kartowych — PCI DSS to absolutny priorytet."*

### Tolerancja ryzyka (Risk Tolerance)

Tolerancja to akceptowalny zakres odchyleń od apetytu. Praktycznie: *jak bardzo możemy przekroczyć nasz apetyt na ryzyko zanim wyzwoli to eskalację?*

Jeśli apetyt mówi *„przestój do 4 godzin"*, tolerancja może być *„do 6 godzin z powiadomieniem zarządu"* lub *„do 8 godzin z aktywacją BCP."*

### Dlaczego to musi definiować zarząd, nie IT

Edwards jest tu kategoryczny: *CISO, który sam definiuje apetyt na ryzyko, przejmuje decyzje, które należą do zarządu.* To nie jest kwestia kompetencji technicznych — to kwestia accountability biznesowej. Zarząd ponosi odpowiedzialność za decyzje o ryzyku, więc musi je współtworzyć.

Praktycznie oznacza to:
1. CISO przedstawia scenariusze ryzyk z szacowanymi kosztami i prawdopodobieństwami
2. Zarząd decyduje ile ryzyka organizacja jest gotowa zaakceptować
3. CISO buduje program bezpieczeństwa w ramach zdefiniowanego apetytu

---

## Taksonomia ryzyk — wspólny język organizacji

Taksonomia ryzyk to hierarchiczna klasyfikacja ryzyk organizacji — jej celem jest stworzenie wspólnego języka, którym cała organizacja mówi o ryzyku.

### Po co taksonomia?

Bez taksonomii każdy dział używa innego języka. IT mówi o CVE i CVSS. Prawnik mówi o odpowiedzialności. Finanse mówią o ekspozycji finansowej. Nikt się nie rozumie, ryzykiem zarządza się w silosach.

Taksonomia eliminuje ten problem przez standaryzację. Gdy ryzyko jest opisane jako *„Zagrożenie > Zewnętrzne > Ransomware > Finansowe"* — każdy w organizacji wie o czym mówimy i może przypisać właściciela, budżet i kontrole.

### Struktura taksonomii Edwardsa

**Poziom 1 — Domeny:**
- Ryzyko technologiczne
- Ryzyko operacyjne
- Ryzyko regulacyjne i compliance
- Ryzyko ludzkie
- Ryzyko stron trzecich (dostawcy, partnerzy)
- Ryzyko fizyczne

**Poziom 2 — Subkategorie** (przykład dla Ryzyko technologiczne):
- Bezpieczeństwo sieci
- Bezpieczeństwo aplikacji
- Bezpieczeństwo danych
- Zarządzanie tożsamością i dostępem (IAM)
- Bezpieczeństwo infrastruktury chmurowej
- Bezpieczeństwo systemów końcowych (endpointów)

**Poziom 3 — Konkretne ryzyka** (przykład dla Bezpieczeństwo sieci):
- Niezałatane urządzenia sieciowe
- Niewystarczająca segmentacja sieci
- Niezaszyfrowana transmisja danych
- Błędna konfiguracja firewalla
- Brak monitorowania ruchu sieciowego

### Integracja z threat intelligence

Taksonomia nie jest dokumentem statycznym. Edwards rekomenduje regularne aktualizacje w oparciu o:
- Nowe raporty CISA i NIST (co kwartał)
- Threat intelligence feeds (bieżąco)
- Wyniki własnych incydentów i post-mortemów
- Zmiany w regulacjach i wymaganiach branżowych

Przykład: Gdy w 2023 roku seria ataków supply chain przez złośliwe pakiety npm stała się powszechna, organizacje używające SBOM (Software Bill of Materials) mogły natychmiast dodać do taksonomii subkategorię *„Ryzyko złośliwego kodu w zależnościach open source"* i zidentyfikować ekspozycję.

---

## Przywództwo: CISO jako tłumacz między technikaliami a biznesem

Edwards poświęca znaczną część rozdziału 2 roli przywództwa w risk management — bo bez zaangażowania zarządu cały system zarządzania ryzykiem jest akademicznym ćwiczeniem.

### Trzy fundamentalne role CISO

**Identyfikator ryzyk:** CISO i jego team identyfikują i kwantyfikują ryzyka używając metod opisanych w tym module. To jest ich ekspertyza techniczna.

**Tłumacz:** CISO tłumaczy ryzyka techniczne na język biznesowy. *„CVE-2024-XXXX pozwala na Remote Code Execution"* → *„Atakujący może przejąć pełną kontrolę nad naszym systemem ERP i zaszyfrować dane produkcyjne — szacowany koszt przestoju: 2 mln zł za dzień."*

**Doradca decyzyjny:** CISO przedstawia opcje mitigacji z kosztami i skutecznością. Zarząd decyduje. CISO wykonuje decyzję — nawet gdy się z nią nie zgadza (ale powinien wtedy udokumentować swoje zastrzeżenia).

### Dashboardy ryzyk dla zarządu

Edwards rekomenduje tworzenie wizualnych dashboardów, które pozwalają zarządowi na bieżąco monitorować profil ryzyka organizacji. Kluczowe elementy:

- **Heat map ryzyk:** matryca z aktualnym rozkładem ryzyk (nowe vs. mitigowane vs. zaakceptowane)
- **Trend chart:** jak zmienia się liczba i ocena ryzyk krytycznych w czasie
- **KRI dashboard:** kluczowe wskaźniki ryzyka (mean time to patch, phishing success rate, % systemów z aktualnym patchem)
- **Top 5 ryzyk:** najważniejsze ryzyka tego miesiąca z krótkim opisem i statusem mitigacji

Dobry dashboard zarządowy nie powinien mieć więcej niż jedną stronę A4 lub jeden ekran. Jeśli CISO potrzebuje 20 slajdów żeby wyjaśnić profil ryzyka — to jest problem z komunikacją, nie z ilością informacji.

### Kultura świadoma ryzyka (Risk-Aware Culture)

Zarządzanie ryzykiem nie może być domeną wyłącznie CISO i zespołu IT. Edwards opisuje trzy poziomy kultury świadomości ryzyka:

**Poziom 1 — Informowanie:** Pracownicy są informowani o politykach bezpieczeństwa i zagrożeniach. Pasywna rola.

**Poziom 2 — Zaangażowanie:** Pracownicy aktywnie uczestniczą w identyfikacji ryzyk — zgłaszają anomalie, phishing, nieautoryzowane urządzenia. Szkolenia z threat reportingu.

**Poziom 3 — Integracja:** Każda decyzja biznesowa uwzględnia perspektywę ryzyka. Nowy projekt = automatyczny security review. Nowy dostawca = vendor risk assessment. Nowy proces = threat modeling.

Edwards obserwuje, że organizacje na poziomie 3 rzadziej doświadczają katastrofalnych naruszeń — nie dlatego, że mają lepszą technologię, ale dlatego, że ryzyko jest identyfikowane wcześniej przez więcej oczu.

---

## Ciągła ocena ryzyk — nie projekt, lecz praktyka operacyjna

Najważniejsze przesłanie rozdziału 2 Edwards powtarza wielokrotnie: risk assessment nie jest projektem z datą zakończenia. To praktyka operacyjna, która musi być wbudowana w rytm organizacji.

### Harmonogram przeglądów

**Bieżąco (real-time):**
- Threat intelligence feeds integrowane z SIEM
- Alerty o nowych CVE dotyczących posiadanych systemów
- Monitoring KRI (Key Risk Indicators) w dashboardzie

**Tygodniowo:**
- Przegląd nowych vulnerability scan results
- Aktualizacja statusów aktywnych mitigacji w rejestrze ryzyk

**Miesięcznie:**
- Przegląd top ryzyk z właścicielami
- Aktualizacja ocen ryzyk (czy coś się zmieniło?)
- Raport KRI dla CISO/zarządu

**Kwartalnie:**
- Pełny przegląd rejestru ryzyk
- Aktualizacja taksonomii
- Ocena skuteczności kontroli (tabletop exercises, testy backupów)
- Raport dla zarządu z trendem ryzyk

**Rocznie:**
- Pełny risk assessment (w tym threat modeling, pentest, BIA)
- Przegląd apetytu na ryzyko z zarządem
- Walidacja taksonomii i rejestru ryzyk przez zewnętrzny podmiot

### Key Risk Indicators (KRI) — mierzalne dowody zarządzania ryzykiem

KRI to metryki, które sygnalizują narastanie ryzyka — zanim ono się zmaterializuje. Przykłady:

| KRI | Cel | Sygnał alarmowy |
|---|---|---|
| % systemów z aktualnymi patchami krytycznymi | > 98% w 30 dni | < 90% |
| Średni czas detekcji incydentu (MTTD) | < 4 godziny | > 24 godziny |
| % pracowników bez szkolenia security awareness | < 5% | > 15% |
| Liczba kont uprzywilejowanych bez MFA | 0 | > 0 |
| Czas od zgłoszenia podatności do mitigacji | < 14 dni (krytyczne) | > 30 dni |
| Skuteczność phishingu w symulacjach | < 5% kliknięć | > 15% kliknięć |
| % dostawców krytycznych bez oceny bezpieczeństwa | 0% | > 10% |

Gdy KRI przekracza próg alarmowy — to sygnał do przeglądu danego obszaru ryzyka i potencjalnej aktualizacji oceny w rejestrze ryzyk.

---

## Narzędzia zaawansowane: automatyzacja i AI w risk management

Edwards poświęca osobną sekcję narzędziom wspierającym dojrzałe programy zarządzania ryzykiem.

### Platformy GRC

GRC (Governance, Risk, Compliance) to kategoria oprogramowania integrującego wszystkie aspekty zarządzania ryzykiem: rejestr ryzyk, mapowanie kontroli, zarządzanie incydentami, compliance tracking, raportowanie. Przykłady: ServiceNow GRC, Archer, MetricStream, LogicGate.

Dla mniejszych organizacji alternatywy: FAIR (Factor Analysis of Information Risk) jako metodologia, narzędzia open source jak MONARC lub SimpleRisk.

### Automatyzacja vulnerability management

Integracja skanera podatności z CMDB (Configuration Management Database) pozwala automatycznie:
- Przypisywać podatności do właścicieli systemów
- Eskalować niezałatane krytyczne CVE po przekroczeniu SLA
- Generować metryki patch compliance do rejestru ryzyk

### AI i machine learning w identyfikacji ryzyk

Nowoczesne platformy (CrowdStrike, Microsoft Sentinel, Darktrace) używają ML do:
- Identyfikacji anomalnych wzorców zachowań użytkowników (UEBA) — sygnał zagrożeń wewnętrznych
- Korelacji zdarzeń z różnych źródeł — identyfikacja multi-stage attacks
- Predykcji przyszłych ataków na podstawie threat intelligence i historycznych wzorców

Edwards przestrzega: *AI nie zastąpi ludzkiego osądu w risk management. Może przetworzyć więcej danych szybciej — ale decyzja o akceptacji ryzyka musi pozostać ludzka.*

---

## 20 rekomendacji Edwardsa z rozdziału 2

1. **Wdróż kompleksową identyfikację ryzyk** przez threat modeling, skanowanie podatności i penetration testing.

2. **Zbuduj dynamiczny rejestr ryzyk** — centralny, regularnie aktualizowany, z właścicielami dla każdego ryzyka.

3. **Użyj matrycy ryzyk do priorytetyzacji** — ale pamiętaj o jej subiektywności i ograniczeniach.

4. **Przeprowadź Business Impact Analysis** — powiąż ryzyka z kosztami biznesowymi i RTO/RPO.

5. **Zdefiniuj apetyt na ryzyko** wspólnie z zarządem — to nie jest decyzja techniczna.

6. **Stwórz taksonomię ryzyk** — ustandaryzuj język komunikacji o ryzyku w całej organizacji.

7. **Przypisz właścicieli ryzyk** — każde ryzyko musi mieć konkretną odpowiedzialną osobę.

8. **Buduj kulturę świadomości ryzyka** — szkolenia, zgłaszanie anomalii, integracja z procesami biznesowymi.

9. **Zachęcaj do współpracy crossfunkcjonalnej** — IT, finanse, HR, prawnik powinni razem zarządzać ryzykiem.

10. **Tłumacz ryzyka techniczne na biznesowe** — CISO musi mówić językiem zarządu.

11. **Twórz dashboardy ryzyk dla zarządu** — wizualne, zwięzłe, skupione na decyzjach.

12. **Integruj cyberbezpieczeństwo z celami biznesowymi** — pokaż jak security wspiera przychody i zaufanie klientów.

13. **Przygotowuj się do dyskusji z radą nadzorczą** — konkretne liczby, scenariusze, plany mitigacji.

14. **Wdróż ciągłe procesy oceny ryzyk** — nie jednorazowe projekty, lecz operacyjny rytm.

15. **Śledź wyłaniające się zagrożenia** — threat intelligence, ISAC, CISA alerts.

16. **Używaj KRI do mierzenia skuteczności mitigacji** — metryki, nie przekonania.

17. **Inwestuj w narzędzia automatyzujące risk management** — skaluj możliwości przez technologię.

18. **Dostosuj strategie do rozmiaru organizacji** — małe firmy potrzebują innych priorytetów niż korporacje.

19. **Prowadź scenario planning** — ćwicz scenariusze ryzyk zanim się zmaterializują.

20. **Wbuduj zarządzanie ryzykiem w kulturę organizacji** — to nie projekt IT, to praktyka biznesowa.

---

## Podsumowanie rozdziału

Podejście oparte na ryzyku to nie metodologia — to zmiana sposobu myślenia o bezpieczeństwie. Zamiast pytać *"czy zdamy audyt?"* pytamy *"co nam realnie zagraża i jak to skutecznie adresujemy?"*

Cztery kluczowe idee rozdziału 2, które wrócą przez cały kurs:

**Po pierwsze:** Ryzyko = zagrożenie × podatność × prawdopodobieństwo × wpływ. Rozumienie tych czterech składowych jest fundamentem każdej decyzji bezpieczeństwa.

**Po drugie:** Rejestr ryzyk to centralny, żywy dokument programu bezpieczeństwa. Bez niego zarządzanie ryzykiem jest chaotyczne i reaktywne.

**Po trzecie:** BIA i apetyt na ryzyko łączą bezpieczeństwo z biznesem — bez tego połączenia bezpieczeństwo jest silosem IT, nie strategicznym aktywem.

**Po czwarte:** Continuous risk assessment to nie opcja — to jedyna sensowna odpowiedź na ciągle zmieniający się krajobraz zagrożeń.

W następnym module: **Wdrożenie w małej firmie** — jak stosować podejście oparte na ryzyku gdy masz ograniczone zasoby, jeden człowiek od IT i budżet na cyberbezpieczeństwo, który właśnie został obcięty o 30%.

---

## Scenario planning — ćwicz zanim zagrożenie stanie się incydentem

Scenario planning to technika, w której organizacja symuluje różne scenariusze ryzyk, aby:
- Przetestować skuteczność istniejących kontroli
- Zidentyfikować luki w planach reagowania
- Kalibrować oceny prawdopodobieństwa i wpływu
- Przygotować zespoły na rzeczywiste incydenty

Edwards rozróżnia trzy typy ćwiczeń:

**Tabletop exercises** — dyskusja przy stole. Zespół (IT, zarząd, prawnik, PR) omawia scenariusz krok po kroku: *"Otrzymaliśmy alert o zaszyfrowanych plikach na 50 serwerach o 23:47 w piątek wieczór. Co robimy?"* Bez rzeczywistego sprzętu, bez stresu — ale ujawnia kto co robi, kto decyduje i gdzie są luki w procedurach.

**Functional exercises** — testowanie konkretnych funkcji systemu. Czy backup rzeczywiście przywraca dane? Ile czasu trwa failover? Czy procedura eskalacji działa jak powinna?

**Full-scale exercises** — pełna symulacja. Czerwony zespół atakuje, niebieski broni, zielony (obserwatorzy) ocenia. Kosztowne i zakłócające, ale dają najrealistyczniejszy obraz gotowości.

### Scenariusze warte regularnego ćwiczenia (według Edwardsa)

**Scenariusz 1: Ransomware w środku nocy**
Parametry: Zaszyfrowanie 60% systemów w piątek o 23:00. Backupy online też zaszyfrowane. Atakujący żąda 500 000 USD w 72 godziny lub opublikuje dane klientów.
Pytania testowe: Kto decyduje o płaceniu? Jak komunikujemy z klientami? Kiedy informujemy UODO? Jak szybko możemy przywrócić operacje z backupów offline?

**Scenariusz 2: Insider threat — były pracownik**
Parametry: Były administrator IT, zwolniony 3 tygodnie temu, nadal ma aktywne konto VPN. Logi pokazują masowy download danych klientów.
Pytania testowe: Czy procedura offboardingu obejmuje dezaktywację wszystkich kont? Jak szybko możemy zidentyfikować co zostało skopiowane? Jakie są zobowiązania prawne?

**Scenariusz 3: Skompromitowany dostawca**
Parametry: Jeden z top-10 dostawców oprogramowania informuje, że ich aktualizacja zawierała złośliwy kod — taki jak atak SolarWinds.
Pytania testowe: Czy wiemy które systemy używają oprogramowania tego dostawcy? Jak szybko możemy odizolować te systemy? Czy mamy SBOM (Software Bill of Materials)?

**Scenariusz 4: DDoS przed Black Friday**
Parametry: Zmasowany atak DDoS na sklep internetowy 2 godziny przed Black Friday. Atak trwa, CDN jest przeciążony.
Pytania testowe: Jaki jest plan mitygacji DDoS? Kiedy aktywujemy backup provider? Jak komunikujemy z klientami? Jakie są straty finansowe za każdą godzinę?

---

## Integracja risk management z procesami biznesowymi

Dojrzały program zarządzania ryzykiem jest niewidoczny dla większości pracowników — bo jest wbudowany w standardowe procesy biznesowe. Edwards nazywa to **"embedding risk management"**.

### Risk assessment w procesie nowych projektów

Każdy nowy projekt IT lub biznesowy powinien przechodzić przez security risk assessment na etapie planowania. Nie jako oddzielny krok po zakończeniu projektu — bo wtedy zmiana kosztuje 10x więcej.

Model DevSecOps: security jest wbudowane w każdy etap cyklu SDLC:
- **Design:** threat modeling, identyfikacja wymagań bezpieczeństwa
- **Development:** SAST (Static Application Security Testing), code review
- **Testing:** DAST (Dynamic Application Security Testing), penetration test
- **Deployment:** konfiguracja hardening, secrets management
- **Operations:** monitoring, vulnerability scanning, incident response

### Risk assessment w onboardingu dostawców

Każdy nowy dostawca z dostępem do systemów lub danych organizacji powinien przechodzić Vendor Risk Assessment:
- Kwestionariusz bezpieczeństwa (SIG — Standardized Information Gathering)
- Przegląd certyfikatów (ISO 27001, SOC 2 Type II)
- Weryfikacja prawa kontraktowego (klauzule bezpieczeństwa, prawo do audytu)
- Klasyfikacja ryzyka (krytyczny/wysoki/średni/niski) determinująca częstotliwość przeglądów

### Risk assessment w zarządzaniu zmianami

Każda zmiana w infrastrukturze IT powinna wyzwalać review wpływu na profil ryzyka:
- Nowy serwer: czy jest w zakresie vulnerability scanning? Czy hardening został zastosowany?
- Migracja do chmury: czy Shared Responsibility Model jest jasno zdefiniowany? Czy kontrole bezpieczeństwa w chmurze są odpowiednie?
- Nowa aplikacja biznesowa: czy przeszła DAST/SAST? Czy dane osobowe są odpowiednio chronione?

---

## Najczęstsze błędy w programach zarządzania ryzykiem

Edwards dokumentuje wzorce porażki, które widzi regularnie w audytowanych organizacjach:

### Błąd 1: Risk register jako projekt compliance

Organizacja tworzy rejestr ryzyk przed audytem ISO 27001, zdobywa certyfikat, a przez kolejne 3 lata rejestr nie jest aktualizowany. To klasyczny przypadek compliance checkbox — narzędzie istnieje, ale nie pełni swojej funkcji.

**Symptom:** Rejestr ryzyk z datą ostatniej aktualizacji sprzed ponad roku lub z dziesiątkami wpisów ze statusem "W toku" bez progresji.

### Błąd 2: Ryzyko oceniane przez IT bez kontekstu biznesowego

Dział IT ocenia ryzyko podatności w systemie legacy jako "niskie" bo system jest "stary i nikt nie wie jak działa." Tymczasem ten system przetwarza 30% transakcji finansowych firmy. BIA ujawniłby, że to ryzyko krytyczne.

**Symptom:** Oceny ryzyk nie zawierają informacji o wartości biznesowej atakowanych aktywów.

### Błąd 3: Brak właścicieli ryzyk poza IT

Rejestr ryzyk ma właściciela "IT Security" dla wszystkich ryzyk. W rzeczywistości ryzyko związane z phishingiem pracowników HR powinno mieć właściciela w HR. Ryzyko procesów płatniczych — w finansach.

**Symptom:** Jeden dział (IT) odpowiada za zarządzanie ryzykami całej organizacji.

### Błąd 4: Priorytetyzacja przez podatności, nie przez wpływ

Organizacja płaci zewnętrznej firmie za vulnerability scan i otrzymuje raport z 500 podatnościami. IT zaczyna naprawiać je od najwyższego CVSS score. Tymczasem podatność CVSS 9.8 w systemie testowym jest mniej krytyczna niż CVSS 6.5 w systemie produkcyjnym obsługującym klientów.

**Symptom:** Priorytetyzacja podatności oparta wyłącznie na CVSS bez uwzględnienia kontekstu biznesowego.

### Błąd 5: Brak testowania planów ciągłości

Organizacja ma dokumentację BCP/DRP. Nikt jej nie testował przez 2 lata. Podczas ataku ransomware okazuje się, że procedura przywracania backupów zakłada obecność administratora, który odszedł z firmy 18 miesięcy temu i zabrał ze sobą wiedzę o konfiguracji.

**Symptom:** Data ostatniego testu BCP/DRP > 12 miesięcy.

---

## Słownik kluczowych pojęć (Rozdział 2)

| Termin | Definicja |
|---|---|
| **Risk-Based Approach** | Metodologia zarządzania bezpieczeństwem oparta na identyfikacji i priorytetyzacji realnych ryzyk, a nie na wymaganiach compliance |
| **Threat** | Aktor lub zdarzenie zdolne do wyrządzenia szkody przez wykorzystanie podatności |
| **Vulnerability** | Słabość w systemie, polityce lub procesie, którą zagrożenie może wykorzystać |
| **Risk Register** | Centralny katalog wszystkich zidentyfikowanych ryzyk z ocenami, właścicielami i planami mitigacji |
| **Risk Matrix** | Narzędzie wizualne mapujące ryzyka na osi prawdopodobieństwa i wpływu |
| **BIA** | Business Impact Analysis — ocena wpływu zdarzenia na procesy biznesowe |
| **RTO** | Recovery Time Objective — maksymalny czas przywrócenia operacji |
| **RPO** | Recovery Point Objective — maksymalna utrata danych po incydencie |
| **Risk Appetite** | Ilość i typ ryzyka akceptowanego przez organizację w dążeniu do celów |
| **Risk Tolerance** | Akceptowalny zakres odchyleń od zdefiniowanego apetytu na ryzyko |
| **Risk Taxonomy** | Hierarchiczna klasyfikacja ryzyk standaryzująca język organizacji |
| **KRI** | Key Risk Indicator — metryka sygnalizująca narastanie ryzyka |
| **Threat Modeling** | Strukturalizowana analiza potencjalnych wektorów ataku |
| **STRIDE** | Framework threat modelingu (Spoofing, Tampering, Repudiation, Information Disclosure, DoS, Elevation) |
| **PASTA** | Process for Attack Simulation and Threat Analysis — biznesowo zorientowany framework threat modelingu |
| **Tabletop Exercise** | Symulacja scenariusza incydentu w formie dyskusji grupowej |
| **APT** | Advanced Persistent Threat — zaawansowany, długotrwały atak (często państwowy) |
| **CVSS** | Common Vulnerability Scoring System — skala oceny groźności podatności (0-10) |
| **EPSS** | Exploit Prediction Scoring System — prawdopodobieństwo wykorzystania podatności w ciągu 30 dni |
| **GRC** | Governance, Risk, Compliance — zintegrowane podejście zarządcze |
| **SBOM** | Software Bill of Materials — spis komponentów oprogramowania |
| **Zombie Risk** | Wpis w rejestrze ryzyk bez aktywnego zarządzania, "martwy" przez zaniedbanie |
| **SPOF** | Single Point of Failure — element systemu, którego awaria powoduje kompletne zatrzymanie |

---

## Risk management a regulacje: GDPR, NIS2, DORA

Edwards podkreśla że risk-based approach jest nie tylko dobrą praktyką — jest wymogiem prawnym w większości nowoczesnych regulacji.

### GDPR — art. 32: Bezpieczeństwo przetwarzania

Artykuł 32 RODO wymaga wdrożenia *„odpowiednich środków technicznych i organizacyjnych"* — a ich adekwatność oceniana jest właśnie przez pryzmat ryzyka. Organizacja musi przeprowadzić ocenę ryzyka dla przetwarzania danych osobowych i dobrać kontrole proporcjonalnie do wyników tej oceny.

**DPIA (Data Protection Impact Assessment)** — wymagana przy przetwarzaniu wysokiego ryzyka. To de facto risk assessment z perspektywy ochrony danych: identyfikacja zagrożeń dla praw podmiotów danych, ocena prawdopodobieństwa i powagi, wdrożenie proporcjonalnych środków. Jeśli ryzyka nie można zredukować do akceptowalnego poziomu — wymagana jest konsultacja z organem nadzorczym (UODO).

### NIS2 — nowe wymagania dla operatorów usług kluczowych

Dyrektywa NIS2 (obowiązuje w UE od październik 2024) rozszerza wymogi zarządzania ryzykiem cyberbezpieczeństwa na znacznie większą liczbę podmiotów. Kluczowe wymagania:

- Systematyczna ocena ryzyk cyberbezpieczeństwa
- Środki zarządzania ryzykiem proporcjonalne do jego skali
- Procedury zarządzania incydentami
- Bezpieczeństwo łańcucha dostaw (ocena dostawców)
- Szkolenia i polityki bezpieczeństwa
- Raportowanie znaczących incydentów w ciągu 24/72 godzin

Odpowiedzialność zarządu: NIS2 explicite nakłada odpowiedzialność na organy zarządzające za wdrożenie środków zarządzania ryzykiem. Zarząd może być pociągnięty do osobistej odpowiedzialności za zaniedbania.

### DORA — specyfika sektora finansowego

Digital Operational Resilience Act (obowiązuje w UE od 17 stycznia 2025) to regulacja specyficzna dla sektora finansowego. Wymaga m.in.:

- **ICT Risk Management Framework** — formalny program zarządzania ryzykiem ICT zgodny z modelem DORA
- **Threat-led Penetration Testing (TLPT)** — dla największych instytucji: regularne testy penetracyjne sterowane threat intelligence
- **ICT Third-Party Risk Management** — formalna ocena i monitoring dostawców ICT
- **Incident Reporting** — raportowanie poważnych incydentów do EBA/ESMA/EIOPA

Dla dyrektora IT w firmie finansowej DORA to nie opcja — to prawo z konkretnym harmonogramem i karami za nieprzestrzeganie.

### Konkluzja regulacyjna

Edwards podsumowuje: *"Organizacje, które zbudowały solidny risk-based program bezpieczeństwa, spełniają wymagania GDPR, NIS2 i DORA niemal automatycznie — bo te regulacje opisują właśnie dobre praktyki zarządzania ryzykiem. Organizacje compliance-first, które zbierają certyfikaty zamiast zarządzać ryzykiem, regularnie zalewane są wymaganiami każdej nowej regulacji."*

---

## Kwantyfikacja ryzyka — model FAIR

Dla organizacji wymagających bardziej precyzyjnego pomiaru ryzyka niż subiektywna matryca 5×5, Edwards rekomenduje metodologię **FAIR (Factor Analysis of Information Risk)**.

### Zasada FAIR

FAIR rozkłada ryzyko na mierzalne składniki:

```
Ryzyko = Częstotliwość Strat (Loss Event Frequency)
       × Wartość Straty (Loss Magnitude)
```

**Loss Event Frequency** = jak często zdarzenie może nastąpić:
- Contact frequency (jak często zagrożenie kontaktuje się z aktywem)
- Probability of Action (czy aktor zdecyduje się działać)
- Vulnerability (czy atak się powiedzie)

**Loss Magnitude** = ile kosztuje gdy zdarzenie nastąpi:
- Primary loss: bezpośrednie straty organizacji
- Secondary loss: kary, roszczenia, utrata reputacji

### Dlaczego FAIR jest lepszy od matrycy 3×3?

Matryca 3×3 lub 5×5 daje odpowiedź *"wysokie/średnie/niskie"* — co jest bezużyteczne dla decyzji o budżecie. Zarząd pyta: *"Ile stracimy jeśli zostaniemy zaatakowani?"* Matryca nie odpowiada. FAIR odpowiada: *"Oczekiwana roczna strata = 2,3 mln PLN (zakres: 0,8–5,7 mln PLN przy 90% confidence interval)."*

To przekłada się bezpośrednio na decyzje inwestycyjne: jeśli mitigacja ryzyka kosztuje 300 000 PLN rocznie i redukuje oczekiwaną roczną stratę z 2,3 mln do 0,4 mln — ROI z inwestycji w bezpieczeństwo jest oczywisty.

---

## Praktyczne narzędzia i szablony

Edwards zamieszcza w rozdziale 2 zestaw praktycznych szablonów. Kluczowe dla wdrożenia:

### Template 1: Risk Register (minimalny)

Minimalna wersja rejestru ryzyk dla małej/średniej organizacji w Excelu/Google Sheets:
- Kolumny: ID | Opis ryzyka | Kategoria | Zagrożenie | Podatność | P (1-5) | W (1-5) | Ocena | Właściciel | Kontrola | Gap | Plan | Termin | Status
- Filtrowanie po Ocenie ryzyka i Statusie
- Widok "Dashboard": PivotTable z rozkładem ryzyk po kategoriach i ocenach

### Template 2: Risk Taxonomy (startowy)

Gotowa do adaptacji taksonomia 3-poziomowa z 6 domenami, 24 subkategoriami i 120 konkretnymi ryzykami. Dostępna w Appendix C książki Edwardsa.

### Template 3: BIA Worksheet

Arkusz do przeprowadzenia BIA z sekcjami:
- Identyfikacja procesów krytycznych
- Zależności systemowe
- RTO/RPO dla każdego procesu
- Szacunek kosztu przestoju ($/godzina)
- Priorytety odtworzenia

### Template 4: KRI Dashboard

Excel/PowerBI template z podstawowymi KRI: patch compliance, MTTD, phishing success rate, privileged account MFA coverage, vendor assessment coverage.

---

## Integracja modułu 2 z resztą kursu

Risk-based approach z rozdziału 2 jest fundamentem na którym opierają się wszystkie późniejsze moduły:

- **Moduł 3–5 (wdrożenia wg skali):** jak dostosować risk assessment do zasobów małej firmy vs. korporacji
- **Moduł 6–8 (MITRE ATT&CK):** jak mapować zagrożenia z taksonomii ATT&CK do rejestru ryzyk
- **Moduł 9–11 (frameworki):** NIST CSF, ISO 27001, CIS Controls jako struktury zarządzania ryzykiem
- **Moduł 16 (IR):** jak wyniki BIA definiują priorytety reagowania na incydenty
- **Moduł 17 (compliance):** jak risk-based approach naturalnie spełnia wymagania GDPR, NIS2, PCI DSS
- **Moduł 18 (metryki):** KRI jako system wczesnego ostrzegania dla programu zarządzania ryzykiem

Organizacja, która solidnie wdrożyła risk-based approach z modułu 2, ma gotowy fundament pod wszystko co następuje. Wszystkie inne moduły to szczegółowe implementacje tej filozofii w różnych kontekstach.

---

*Moduł 2 kończy się tutaj. W module 3 zobaczymy jak wdrożyć risk-based approach w firmie z 50 pracownikami, jednym administratorem IT i budżetem cyberbezpieczeństwa równym zeru — bo właśnie takie są realia dla większości polskich MŚP.*

---

## Ćwiczenie praktyczne: zbuduj mini rejestr ryzyk

Najlepszym sposobem utrwalenia wiedzy z modułu 2 jest natychmiastowe ćwiczenie praktyczne. Edwards zaleca:

**Krok 1.** Wybierz jeden proces biznesowy, który dobrze znasz (np. onboarding nowego pracownika, obsługa zamówień, wystawianie faktur).

**Krok 2.** Zidentyfikuj 5 ryzyk dla tego procesu stosując STRIDE lub prosty pytajnik: *Co może pójść nie tak? Kto mógłby zaszkodzić? Jakie błędy ludzkie są możliwe? Co jeśli system przestanie działać?*

**Krok 3.** Dla każdego ryzyka oceń: Prawdopodobieństwo (1–5) i Wpływ (1–5). Oblicz ocenę ryzyka.

**Krok 4.** Posortuj ryzyka od największej oceny. Top 2 ryzyka — zdefiniuj właściciela i jeden konkretny plan mitigacji.

**Krok 5.** Zastanów się: ile kosztowałby przestój tego procesu przez 8 godzin? To jest Twój punkt startowy do BIA.

Pięć ryzyk, dwadzieścia minut pracy — i masz prototyp rejestru ryzyk. Tyle wystarczy żeby zacząć. Reszta to iteracja.

---

*Moduł 2 — koniec. Następny: **Moduł 3 — Wdrożenie w małej firmie**: risk-based approach gdy masz ograniczony budżet, jeden etat IT i presję ze strony zarządu, żeby "jakoś to ogarnąć tanio".*
