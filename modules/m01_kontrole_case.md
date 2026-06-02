# Case Study: Kontrole bezpieczeństwa w praktyce — atak ransomware w firmie produkcyjnej

**Moduł 1 · Business Case**

> *„Mieliśmy wszystkie kontrole. Mieliśmy firewall, antywirus, backup. I zostaliśmy całkowicie sparaliżowani przez 11 dni."*
> — CISO regionalnego producenta przemysłowego, po ataku ransomware w 2023 roku

---

## Wprowadzenie do case study

Poniższy przypadek jest syntezą kilku rzeczywistych incydentów ransomware w polskich i europejskich firmach produkcyjnych, zanonimizowanych i połączonych w jeden spójny scenariusz dydaktyczny. Dane liczbowe opierają się na raportach branżowych (Verizon DBIR 2024, IBM Cost of Data Breach 2024, Mandiant M-Trends 2024).

Firma **ProdukcjaPL** to średniej wielkości producent komponentów przemysłowych, 450 pracowników, obroty 85 milionów złotych rocznie. Posiada dwa zakłady produkcyjne, biuro centralne i dział R&D z własnością intelektualną wartą szacunkowo 30 milionów złotych. Klientami są głównie Tier 1 dostawcy dla automotive i aerospace — wymagający audytów bezpieczeństwa i certyfikacji.

---

## Linia czasu incydentu

### Tydzień −8: Pierwsze oznaki (niewykhycone)

Pracownik działu sprzedaży kliknął link w wiadomości e-mail wyglądającej jak oferta od dostawcy. Link prowadził do strony phishingowej imitującej portal SharePoint — pracownik wprowadził swoje dane logowania do Microsoft 365.

**Co zawiodło:**
- Brak MFA na koncie Microsoft 365 (wdrożone tylko dla IT i managementu)
- Email Security Gateway przepuścił wiadomość (domena była zarejestrowana 3 tygodnie wcześniej — za nowa dla list reputacyjnych)
- Brak szkolenia pracowników sprzedaży z rozpoznawania phishingu (ostatnie szkolenie: 3 lata temu)

Atakujący uzyskał dostęp do skrzynki mailowej i konta Microsoft 365 pracownika. Przez 3 tygodnie czytał korespondencję, mapował strukturę organizacji i szukał dostępu do systemów o wyższej wartości.

### Tydzień −5: Lateralne przemieszczanie

Korzystając z konta pracownika sprzedaży, atakujący odkrył że firma używa wspólnego serwera plików z hasłami zapisanymi w pliku tekstowym (password.txt na pulpicie pracownika IT). Uzyskał dane do serwera plików i konta z podwyższonymi uprawnieniami.

**Co zawiodło:**
- Brak PAM (Privileged Access Management) — hasła administratorów nie były rotowane ani zarządzane
- Brak EDR z wykrywaniem anomalii behawioralnych — logowania z nieznanej lokalizacji i w nietypowych godzinach nie wygenerowały alertu
- Brak Network Traffic Analysis — lateralne skanowanie sieci nie zostało wykryte
- SIEM posiadany przez firmę miał skonfigurowane tylko podstawowe reguły, bez custom rules dla anomalii

### Tydzień −3: Rekonesans i przygotowanie

Atakujący przez 3 tygodnie mapował sieć, identyfikował serwery ERP, serwery backupów i systemy SCADA obsługujące linie produkcyjne. Odkrył że backup wykonywany jest na dysk NAS podpięty do sieci — dostępny z poziomu uzyskanych kont. Wykonał kopię kluczowych danych (własność intelektualna, dane klientów) jako przygotowanie do podwójnego wymuszenia (*double extortion*).

**Co zawiodło:**
- Backup online (NAS w tej samej sieci) — dostępny dla atakującego
- Brak backup offline / tape / immutable backup
- Brak segmentacji sieci — systemy SCADA i serwery ERP w tej samej sieci co komputery pracowników
- Brak File Integrity Monitoring — masowy odczyt plików nie wygenerował alertu
- Brak Data Loss Prevention — eksfiltracja 40 GB danych przez HTTPS nie została wykryta

### Dzień 0: Atak ransomware

W piątek o 23:47 atakujący uruchomił złośliwe oprogramowanie ransomware na wszystkich dostępnych systemach jednocześnie. Do poniedziałkowego poranka zaszyfrowane były:

- Serwer ERP (SAP) — planowanie produkcji, zamówienia, finanse
- Serwer plików — dokumentacja techniczna, projekty, umowy
- 3 serwery backup (NAS)
- 67% stacji roboczych w biurze i zakładach
- Częściowo: jeden z dwóch serwerów SCADA (drugi był odizolowany przez starszy, fizyczny switch)

Atakujący zostawił notatkę z żądaniem: 280 000 USD w BTC w ciągu 72 godzin lub opublikowanie wykradzionych danych klientów i własności intelektualnej.

### Dzień 1-3: Chaotyczna reakcja

Firma nie posiadała przetestowanego planu IR (Incident Response). Reakcja była chaotyczna:

- CISO (jedna osoba odpowiedzialna za bezpieczeństwo) dowiedział się o incydencie o 7:15 w poniedziałek od pracownika produkcji, który nie mógł uruchomić systemu
- Pierwsze 4 godziny: próby zrozumienia skali problemu bez odpowiednich narzędzi forensics
- Godzina 5: decyzja o wyłączeniu całej sieci (paraliż produkcji)
- Godzina 8: kontakt z zewnętrzną firmą IR (Incident Response) — pierwszy specjalista na miejscu po 14 godzinach
- Godzina 36: odkrycie że wszystkie trzy serwery backupów są zaszyfrowane
- Godzina 48: odkrycie eksfiltracji danych (logi sieciowe pokazały duży transfer do zewnętrznego IP trzy tygodnie wcześniej)

**Co zawiodło:**
- Brak przetestowanego planu IR
- Brak zewnętrznego partnera IR gotowego do szybkiej reakcji (brak retainer agreement)
- Brak procedury eskalacji — kto decyduje o płaceniu okupu? kto informuje zarząd? kto kontaktuje klientów?
- Brak forensics capability — firma nie miała narzędzi ani kompetencji do analizy własnych logów
- Brak procedury komunikacji kryzysowej — klienci dowiedzieli się o incydencie z mediów społecznościowych

### Dzień 3-14: Odtwarzanie z ruin

Firma ostatecznie zdecydowała nie płacić okupu (po konsultacji z prawnikami — GDPR compliance). Odtwarzanie odbywało się z:

- Taśmowych backupów sprzed 6 tygodni (ostatni pełny backup przed incydentem)
- Częściowych kopii na prywatnych dyskach kilku pracowników IT (nieautoryzowane shadow IT backupy)
- Rekonstrukcja ręczna części danych z wydruków i zapisów w systemach klientów

Pełne wznowienie produkcji: 11 dni. Częściowa funkcjonalność ERP: 6 dni.

---

## Analiza finansowa incydentu

### Bezpośrednie koszty

| Pozycja | Koszt |
|---|---|
| Zewnętrzna firma IR (14 dni × 5 specjalistów) | 340 000 zł |
| Wymiana sprzętu (67 stacji roboczych + 3 serwery) | 280 000 zł |
| Oprogramowanie odtworzeniowe i licencje | 85 000 zł |
| Forensics i analiza post-incydent | 95 000 zł |
| Prawnik (GDPR, negocjacje z klientami) | 120 000 zł |
| Overtime IT i produkcji (11 dni) | 180 000 zł |
| **Suma bezpośrednia** | **1 100 000 zł** |

### Pośrednie koszty

| Pozycja | Koszt |
|---|---|
| Utracona produkcja (11 dni × ~230 000 zł/dzień) | 2 530 000 zł |
| Utrata zamówień — klienci przeniesieni do konkurencji | 1 800 000 zł |
| Kara umowna za niedotrzymanie terminów dostaw | 420 000 zł |
| Wzrost składek ubezpieczeniowych cyber | 95 000 zł/rok |
| Inwestycje w bezpieczeństwo po incydencie | 650 000 zł |
| **Suma pośrednia** | **5 495 000 zł** |

**Łączny koszt incydentu: ~6 600 000 zł**

Dla porównania: **koszt wdrożenia kontroli zapobiegawczych** (MFA dla wszystkich, EDR, segmentacja sieci, offline backup, szkolenia, plan IR) szacowany był na 180 000-220 000 zł rocznie.

**ROI bezpieczeństwa:** Inwestycja 200 000 zł mogła zapobiec stratom 6 600 000 zł — zwrot 3 200%.

---

## Analiza przez matrycę 3×3

Przeanalizujmy każdą zawiodłą kontrolę przez pryzmat matrycy Edwardsa:

### Prewencyjne-Administracyjne (zawiodły)

- ❌ **Szkolenia awareness** — ostatnie 3 lata temu, brak symulacji phishingowych, brak kultury zgłaszania podejrzanych emaili
- ❌ **Polityka zarządzania hasłami** — brak wymogu managera haseł, brak zakazu zapisywania haseł w plikach tekstowych
- ❌ **Polityka MFA** — MFA obowiązkowe tylko dla IT, nie dla wszystkich pracowników
- ❌ **Procedura onboardingu dostawców** — brak wymagań bezpieczeństwa wobec dostawców (ryzyko supply chain)

### Prewencyjne-Techniczne (zawiodły częściowo)

- ❌ **MFA** — nie wdrożone dla pracowników sprzedaży
- ❌ **Segmentacja sieci** — brak izolacji systemów SCADA, ERP i stacji roboczych
- ❌ **PAM** — brak zarządzania kontami uprzywilejowanymi
- ⚠️ **Email Security Gateway** — działa, ale nie pokrywa świeżych domen phishingowych
- ✅ **Firewall** — działał, ale atakujący operował przez konto o wysokich uprawnieniach (nie był zablokowany)
- ✅ **Antywirus** — obecny, ale ransomware był obfuscated i ominął sygnatury

### Detekcyjne-Administracyjne (zawiodły)

- ❌ **Procedura przeglądów logów** — logi były zbierane, nikt ich nie analizował regularnie
- ❌ **Polityka raportowania anomalii** — pracownik IT widział podejrzane logowania 2 tygodnie przed atakiem, nie wiedział że powinien to zgłosić
- ❌ **Tabletop exercises** — nigdy nie przeprowadzane, brak testowania planu IR

### Detekcyjne-Techniczne (zawiodły)

- ⚠️ **SIEM** — posiadany, ale skonfigurowany tylko z podstawowymi regułami; nie wykrył anomalii
- ❌ **EDR** — nie wdrożony (posiadano tylko AV)
- ❌ **UEBA** — nie wdrożony; logowania z nowej lokalizacji i masowy eksport plików nie wygenerował alertu
- ❌ **DLP** — nie wdrożony; eksfiltracja 40 GB danych przeszła niezauważona
- ❌ **NTA (Network Traffic Analysis)** — brak; lateralne skanowanie sieci przez 3 tygodnie niezauważone

### Korekcyjne-Administracyjne (zawiodły)

- ❌ **Plan Incident Response** — istniał na papierze, nigdy nie był testowany
- ❌ **Retainer z firmą IR** — brak; 14 godzin na pierwszego specjalistę
- ❌ **Procedura komunikacji kryzysowej** — brak; klienci dowiedzieli się z social media
- ❌ **Procedura eskalacji decyzji** — brak; chaos w pierwszych 48 godzinach (kto decyduje o płaceniu?)

### Korekcyjne-Techniczne (zawiodły)

- ❌ **Backup offline / immutable** — brak; wszystkie backupy w tej samej sieci i zaszyfrowane
- ❌ **Testowanie backupów** — backup NAS nigdy nie był testowany przez restore; okazało się że był sprawny (szczęście)
- ⚠️ **Tape backup** — istniał, ale był stary (6 tygodni) i niekompletny

### Co zadziałało

- ✅ **Fizyczna izolacja jednej linii SCADA** — stary switch fizyczny uratował drugą linię produkcyjną przed zaszyfrowanie; przypadek, nie design
- ✅ **Shadow IT backupy na dyskach** — nieautoryzowane, ale uratowały część danych
- ✅ **Ubezpieczenie cyber** — firma miała polisę, która pokryła część kosztów IR

---

## Jakie kontrole zapobiegłyby incydentowi

Edwards wskazuje, że w 90% przypadków ransomware skuteczna obrona wymaga nie zaawansowanych, drogich kontroli — ale poprawnego wdrożenia kilku fundamentalnych:

### Scenariusz 1: Zatrzymanie na etapie phishingu (koszt: 15 000 zł/rok)

**MFA dla wszystkich użytkowników** — nawet jeśli pracownik wprowadził hasło na stronie phishingowej, atakujący nie mógłby zalogować się do Microsoft 365 bez drugiego czynnika. Koszt implementacji dla 450 użytkowników: ~15 000 zł/rok (Microsoft Entra P1 lub Duo).

**Phishing simulation + szkolenia** — cykliczne testy phishingowe z natychmiastowym szkoleniem dla klikających. Badania pokazują redukcję kliknięć phishingowych o 70-80% po roku systematycznych szkoleń. Koszt: ~10 000 zł/rok.

### Scenariusz 2: Zatrzymanie na etapie lateralnego przemieszczania (koszt: 45 000 zł/rok)

**EDR zamiast/obok AV** — nowoczesny EDR z wykrywaniem behawioralnym wykryłby anomalie: logowania z nowych IP, skanowanie sieci wewnętrznej, masowy dostęp do plików. Alert wygenerowałby reakcję tygodnie przed atakiem. Koszt: ~40 000 zł/rok.

**PAM dla kont uprzywilejowanych** — hasła administratorów w systemie PAM, automatyczna rotacja, sesje nagrywane. Atakujący nie mógłby użyć hasła znalezionego w pliku tekstowym. Koszt: ~20 000 zł/rok.

### Scenariusz 3: Ograniczenie zasięgu ataku (koszt: 30 000 zł jednorazowo)

**Segmentacja sieci** — izolacja SCADA i OT od sieci biurowej, izolacja serwerów ERP w osobnym VLAN, Zero Trust dla dostępu uprzywilejowanego. Ransomware nie mógłby się rozprzestrzenić na systemy produkcyjne. Koszt: jednorazowy projekt segmentacji sieci.

**Offline backup** — dodatkowy backup na taśmy lub do izolowanego cloud storage (immutable backup), niedostępny z sieci. Odtworzenie danych po 24 godzinach zamiast 11 dni. Koszt: ~8 000 zł/rok.

### Podsumowanie: koszt ochrony vs. koszt incydentu

| Wariant | Roczny koszt | Co zatrzymuje |
|---|---|---|
| Tylko MFA + szkolenia | 25 000 zł | Phishing → 90% ataków zatrzymane na wejściu |
| + EDR + PAM | 85 000 zł | Lateral movement → atakujący nie ucieka dalej |
| + Segmentacja + offline backup | 120 000 zł | Zasięg i recovery → nawet jeśli ransomware uruchomiony, ograniczone szkody i szybkie odtworzenie |
| **Pełny program podstawowy** | **200 000 zł/rok** | **>95% redukcja prawdopodobieństwa incydentu tego typu** |

Koszt pełnego ataku: **6 600 000 zł**.
Koszt ochrony: **200 000 zł/rok**.
Decyzja biznesowa jest oczywista — a mimo to firma przez lata inwestowała tylko w podstawowe narzędzia, wierząc że firewall i AV wystarczą.

---

## Wnioski i lekcje dla organizacji

### Lekcja 1: Compliance ≠ Bezpieczeństwo

ProdukcjaPL zdała audyt dostawcy rok przed atakiem. Audytor potwierdził posiadanie firewalla, antywirusa, procedur backupów i polityki haseł. Wszystkie cztery kontrole istniały — żadna nie zapobiegła atakowi.

To podręcznikowy przykład compliance checkbox. Organizacja miała papierowe bezpieczeństwo, nie operacyjne.

### Lekcja 2: Detekcja to najważniejsza inwestycja po prewencji

Firma miała SIEM — ale nie miała ludzi ani procesów do jego obsługi. To klasyczny błąd: zakup narzędzia bez zbudowania capability.

Skuteczna detekcja wymaga: narzędzia + reguły + procesy + ludzie. Brak któregokolwiek elementu czyni całość niefunkcjonalną. Lepszy jest prostszy SIEM z dobrze skonfigurowanymi regułami i procesem triage alertów niż zaawansowany SIEM generujący tysiące ignorowanych alertów.

### Lekcja 3: Backup offline to must-have, nie nice-to-have

W 2024 roku backup online jest rozwiązaniem niewystarczającym dla organizacji narażonych na ransomware. Atakujący mapują infrastrukturę backup jako cel nr 1 — bo usunięcie możliwości recovery usuwa alternatywę dla płacenia okupu.

Immutable backup (Azure Immutable Blob Storage, AWS S3 Object Lock, taśmy offline) jest tanią polisą ubezpieczeniową.

### Lekcja 4: Plan IR wymaga testów, nie tylko dokumentacji

Plan IR leżący w szufladzie jest ghost control. Jedynym sposobem na weryfikację jego efektywności jest regularne testowanie przez tabletop exercises i symulacje incydentów.

Rekomendacja Edwardsa: minimum 2 tabletop exercises rocznie — jeden scenariusz ransomware, jeden insider threat lub kompromitacja konta uprzywilejowanego.

### Lekcja 5: Właściciel kontroli = odpowiedzialność operacyjna

CISO ProdukcjaPL był jedyną osobą w firmie z wiedzą o tym jak działają kontrole bezpieczeństwa. Gdy on nie był dostępny w pierwszych godzinach kryzysu — nikt nie wiedział co robić.

Każda kluczowa kontrola musi mieć właściciela, zastępcę właściciela i udokumentowane procedury operacyjne. Wiedza o bezpieczeństwie nie może być silosem jednej osoby.

---

## Pytania do refleksji

1. Które kontrole z matrycy 3×3 były najbardziej krytyczne dla ProdukcjaPL — prewencyjne czy detekcyjne? Uzasadnij.

2. Oceń decyzję firmy o niefiltrowaniu alertów SIEM. Jakie procesy administracyjne powinny towarzyszyć wdrożeniu SIEM?

3. Oblicz ROI inwestycji w podstawowy program bezpieczeństwa (200 000 zł/rok) zakładając 15% prawdopodobieństwo incydentu ransomware rocznie i koszt incydentu 5 000 000 zł.

4. Jak Edwards oceniłby podejście ProdukcjaPL do bezpieczeństwa przed incydentem? Które z 20 rekomendacji z rozdziału 1 były najważniejsze w tym kontekście?

5. Jakie kontrole dziedziczone (inherited) mogłyby pomóc mniejszej firmie jak ProdukcjaPL — i jak powinna weryfikować ich skuteczność?

---

## Perspektywa branżowa: jak inne sektory podchodzą do tego problemu

### Sektor finansowy

Banki i instytucje finansowe są zazwyczaj o 5-10 lat przed produkcją jeśli chodzi o dojrzałość programów bezpieczeństwa. Powody: regulacje (PCI DSS, DORA, rekomendacje KNF), wysoka wartość aktywów cyfrowych i wieloletnie doświadczenia z incydentami.

Kluczowe różnice w podejściu sektora finansowego, które ProdukcjaPL powinna adoptować:

**Obowiązkowy retainer IR.** Każdy bank średniej wielkości posiada umowę z co najmniej jedną zewnętrzną firmą IR, z gwarantowanym czasem reakcji (typowo 4 godziny). ProdukcjaPL straciła 14 godzin na znalezienie kogokolwiek.

**Testy penetracyjne jako standard.** Większość regulowanych instytucji wymaga rocznego pentesting zewnętrznego. ProdukcjaPL nigdy nie miała zewnętrznego testu penetracyjnego — atakujący odkrył podatności, których wewnętrzny team nie był świadomy.

**Tabletop exercises z zarządem.** W sektorze finansowym regularne ćwiczenia symulowane są prowadzone z udziałem zarządu, nie tylko IT. ProdukcjaPL nie miała żadnych ćwiczeń — zarząd dowiedział się o incydencie gdy był już pełnowymiarowy.

### Sektor zdrowia

Sektor opieki zdrowotnej jest najczęściej atakowanym sektorem przez ransomware (Verizon DBIR 2024: #1 w liczbie incydentów). Powody: wrażliwe dane pacjentów, stare systemy medyczne (legacy), presja czasowa (szpital nie może pozwolić sobie na 11 dni przestoju).

Szpitale, które przeżyły ataki ransomware i wyciągnęły wnioski, wdrożyły:

**Air-gap dla systemów krytycznych.** Systemy podtrzymywania życia i monitorowania pacjentów fizycznie odizolowane od sieci biurowej. ProdukcjaPL mogła to samo zrobić dla systemów SCADA — i przypadkowo jeden z nich był odizolowany, co uratowało drugą linię produkcyjną.

**Offline procedury operacyjne.** Szpitale opracowały ręczne procedury dla każdego procesu krytycznego na wypadek awarii systemów IT. ProdukcjaPL nie miała żadnych offline procedur dla zarządzania produkcją — co przedłużyło przestój.

### Wnioski z porównania sektorowego

Sektor produkcyjny systematycznie niedoinwestowuje w cyberbezpieczeństwo w porównaniu do finansów i healthcare — mimo rosnącej ekspozycji na zagrożenia. Główne przyczyny: brak regulacji sektorowych (dla większości produkcji nie ma odpowiednika PCI DSS czy HIPAA), kultura operacyjna skoncentrowana na OEE i ciągłości produkcji (a nie na bezpieczeństwie IT), i historyczne przekonanie że systemy OT są bezpieczne przez odizolowanie.

Ten ostatni mit jest coraz bardziej niebezpieczny — konwergencja IT/OT sprawia, że dawno odizolowane systemy SCADA są dziś podłączone do sieci korporacyjnych, chmury i internetu.

---

## Analiza decyzji: płacić czy nie płacić okup?

ProdukcjaPL zdecydowała nie płacić. To była trudna decyzja, podjęta po konsultacjach z prawnikami i przy świadomości kilku czynników:

### Argumenty za płaceniem

- Szybsze odtworzenie: atakujący zazwyczaj dostarczają klucz dekrypcyjny (w ich interesie jest reputacja wiarygodnego płatnika)
- Uniknięcie publikacji wykradzionych danych
- Mniejszy koszt nominalny (280 000 USD vs. ~6 600 000 zł strat)

### Argumenty przeciwko

**Prawne:** W Polsce i UE płacenie okupu nie jest nielegalne per se, ale może naruszać regulacje dotyczące finansowania działalności przestępczej. Prawnik firmy wskazał ryzyko prawne.

**Etyczne i strategiczne:** Płacenie finansuje dalszą działalność grup ransomware i wzmacnia ich model biznesowy. Organizacje, które zapłaciły, są często atakowane ponownie — przestępcy oznaczają je jako *„płacących"*.

**Techniczne:** Klucze dekrypcyjne dostarczane przez atakujących często nie działają w pełni — szczególnie dla plików ERP i specjalistycznych systemów. Firmy, które zapłaciły, często i tak musiały odtwarzać część danych z backupów.

**GDPR:** Zapłacenie okupu nie zmienia faktu naruszenia GDPR — jeśli dane osobowe zostały wykradzione, firma ma obowiązek zgłoszenia do UODO niezależnie od decyzji o okupie.

### Rekomendacja Edwardsa

Edwards nie daje jednoznacznej rekomendacji — decyzja zależy od konkretnych okoliczności. Ale podkreśla, że **decyzja powinna być podjęta z góry**, jako element planu IR — nie w stresie, w pierwszych 72 godzinach kryzysu, gdy decydenci działają pod presją czasu i emocji.

Procedura IR powinna zawierać: kto decyduje, jakie kryteria, jaki proces (weryfikacja atakującego, negocjacje, płatność przez specjalistyczną firmę), jak komunikować decyzję stakeholderom.

---

## Implikacje GDPR i regulacyjne

ProdukcjaPL przetwarzała dane osobowe pracowników, klientów i partnerów. Atak ransomware połączony z eksfiltrację danych to naruszenie ochrony danych osobowych wymagające działań regulacyjnych.

### Obowiązki firmy po naruszeniu

**Zgłoszenie do UODO w ciągu 72 godzin** od stwierdzenia naruszenia (art. 33 GDPR). Firma przekroczyła ten termin — odkrycie eksfiltracji nastąpiło po 48 godzinach, ale zidentyfikowanie zakresu naruszenia zajęło kolejne dni. To ryzyko dodatkowych kar.

**Powiadomienie osób, których dane dotyczą** jeśli naruszenie może powodować wysokie ryzyko dla praw i wolności tych osób. W przypadku danych klientów biznesowych — sporna kwestia wymagająca analizy prawnej.

**Dokumentacja naruszenia** — szczegółowy opis incydentu, przyczyn, skutków i podjętych działań naprawczych. To dokument, który może być wymagany przez UODO przy kontroli.

### Potencjalne kary

GDPR przewiduje kary do 4% rocznego globalnego obrotu lub 20 milionów EUR (wyższe z dwóch). Dla ProdukcjaPL (obroty 85 mln zł) teoretyczna maksymalna kara: ~3,4 mln zł. W praktyce UODO stosuje kary proporcjonalne do skali naruszenia i podjętych działań naprawczych.

Kluczowe dla wymiaru kary: czy firma wykazała **accountability** — świadomość, proaktywne działania, wdrożone środki naprawcze. Firma, która potrafi udokumentować co zrobiła po incydencie i jakie środki wdrożyła, ma znacznie lepszą pozycję.

---

## Plan naprawczy po incydencie

Po 6 tygodniach od ataku ProdukcjaPL wdrożyła następujący plan naprawczy, przygotowany we współpracy z zewnętrznym CISO:

**Faza 1 (Miesiące 1-3) — Fundamenty:**
- MFA dla wszystkich 450 użytkowników
- Wymiana AV na EDR (Microsoft Defender for Endpoint)
- Offline backup (Azure Immutable Blob Storage, RPO = 4 godziny)
- Szkolenia phishing awareness dla wszystkich pracowników

**Faza 2 (Miesiące 4-6) — Detekcja i procesy:**
- Konfiguracja SIEM z custom rules i procesem triage alertów
- Retainer z firmą IR (4-godzinny czas reakcji)
- Opracowanie i przetestowanie planu IR (tabletop exercise)
- PAM dla 12 kont administratorów

**Faza 3 (Miesiące 7-12) — Dojrzałość:**
- Segmentacja sieci (izolacja OT/SCADA)
- DLP dla ochrony własności intelektualnej
- Zewnętrzny penetration test
- Wdrożenie formalnego rejestru kontroli i risk register

Koszt całkowity fazy 1-3: 650 000 zł (jednorazowo) + 200 000 zł/rok utrzymanie. W porównaniu do 6 600 000 zł kosztu incydentu — to inwestycja, nie koszt.
