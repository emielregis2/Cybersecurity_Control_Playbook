# Business Case: Jak firma ButikPL zbudowała bezpieczeństwo za 35 000 PLN

**Moduł 3 · Wdrożenie w małej firmie — podejście krok po kroku**

---

## Kontekst organizacji

**ButikPL Sp. z o.o.** to polska firma odzieżowa z Wrocławia: sklep stacjonarny + sklep internetowy (WooCommerce), 28 pracowników, roczny obrót 12 mln PLN. Obsługa klientów detalicznych i kilku małych hurtowników. Dział IT: jeden człowiek — **Tomasz**, 34-letni administrator, który jednocześnie zarządza stroną www, siecią WiFi, kasami fiskalnymi, laptopami pracowników i POS.

Tomasz wiedział, że firma ma problemy z bezpieczeństwem. Miał listę w głowie: brak MFA, hasła na karteczkach, backup "gdzieś w chmurze" (nikt nie wiedział gdzie dokładnie), 6-letni sklep WooCommerce bez aktualizacji od 2 lat. Ale gdy próbował rozmawiać z właścicielką — Marzena odpowiadała: *"Tomku, poradzimy sobie, mamy antywirusa i nikt nam nic nie ukradł przez 8 lat."*

---

## Zdarzenie wyzwalające

Wszystko zmieniło się w listopadzie 2025 roku. Konkurencyjna firma z tego samego segmentu — sklep z Katowic, 40 pracowników — trafiła na pierwsze strony branżowych portali. Powód: wyciek danych 18 000 klientów. Imiona, adresy, historia zakupów, zaszyfrowane hasła. Atakujący zdobyli dostęp przez podatność w nieaktualizowanym WooCommerce.

Kara UODO: 180 000 PLN. Koszty IR i powiadomień: 95 000 PLN. Kilkunastu klientów rozwiązało umowy. Jeden artykuł w Wyborcza.pl i zasięg w social media = reputacyjna katastrofa.

Marzena przeczytała artykuł w piątek rano i o 9:00 zadzwoniła do Tomasza: *"Tomku, przyjdź do mnie. Musimy porozmawiać o tym bezpieczeństwie."*

---

## Diagnoza — co Tomasz znalazł robiąc audyt

Tomasz miał 3 dni na przeprowadzenie mini audytu przed rozmową z Marzeną. Użył prostego frameworku: zinwentaryzuj, oceń, priorytetyzuj.

### Inwentaryzacja aktywów

**Dane krytyczne (to co trzeba chronić):**
- Baza klientów: 23 000 rekordów — imię, nazwisko, adres, historia zakupów, zaszyfrowane hasła (WooCommerce)
- Dane pracowników: kadr 28 osób w systemie kadrowym SaaS (Comarch HRM)
- Dane finansowe: faktury, rozliczenia w Fakturowni.pl i lokalnych plikach Excel
- Loginy i hasła administratorów sklepu, POS, bankowości internetowej

**Systemy krytyczne:**
- Sklep WooCommerce (serwer hostingowy współdzielony) — 70% przychodu
- Kasy fiskalne + terminal POS — obsługa sklepu stacjonarnego
- E-mail firmowy (Google Workspace) — komunikacja z hurtownikami i dostawcami

### Znalezione luki (wyniki audytu Tomasza)

| # | Problem | Ryzyko |
|---|---|---|
| 1 | WooCommerce nieaktualizowany od 23 miesięcy (wersja 6.8 zamiast 9.4) | KRYTYCZNE — znane exploity publiczne |
| 2 | Brak MFA na Google Workspace (28 kont bez) | KRYTYCZNE — phishing = przejęcie e-maila |
| 3 | Hasła "zapisane w głowie" lub na karteczkach — brak password managera | WYSOKIE — reuse, słabe hasła |
| 4 | Backup — Dropbox osobisty Tomasza (~50 GB, niesynchronizowany od 3 tyg.) | KRYTYCZNE — backup de facto nie działa |
| 5 | Sieć WiFi: jedna sieć dla pracowników, klientów i kas fiskalnych | WYSOKIE — brak segmentacji |
| 6 | Konta 3 byłych pracowników nadal aktywne w Google Workspace | WYSOKIE — nieautoryzowany dostęp |
| 7 | Strona www: HTTP zamiast HTTPS (brak SSL na checkout!) | KRYTYCZNE — naruszenie PCI DSS SAQ A |
| 8 | Brak planu IR | WYSOKIE — przy incydencie chaos |
| 9 | Pracownicy nigdy nie mieli szkolenia security awareness | ŚREDNIE — podatność na phishing |
| 10 | Hosting współdzielony dla sklepu — brak izolacji od innych klientów hosta | ŚREDNIE — potencjalny cross-contamination |

---

## Rozmowa z właścicielką — jak Tomasz przekonał Marzenę

Tomasz wiedział że sama techniczna lista problemów Marzeny nie przekona. Przygotował 2-stronicową prezentację z konkretnymi liczbami.

**Slajd 1: Co nam grozi (język biznesu)**

> *"Mamy taką samą podatność w WooCommerce jak firma z Katowic. Jeśli zostaniemy zaatakowani:*
> - *Kara UODO za naruszenie danych 23 000 klientów: 50 000–250 000 PLN*
> - *Koszty IR, prawnik, powiadomienia klientów: 80 000–150 000 PLN*
> - *Przestój sklepu internetowego przy ataku ransomware (1 tydzień × 2 300 PLN/dzień): 16 000 PLN*
> - *Utrata reputacji — nie kwantyfikowalna, ale realna*
>
> Łączne ryzyko: 150 000–400 000 PLN. To jest nasz 'koszt niedziałania'."*

**Slajd 2: Co musimy zrobić i ile to kosztuje**

> *"Proponuję 90-dniowy plan za 35 000 PLN który eliminuje wszystkie krytyczne ryzyka.*
>
> Priorytet 1 (tydzień 1–2, koszt ~2 000 PLN): MFA, aktualizacja WooCommerce, SSL — eliminuje ryzyko kradzieży danych*
>
> Priorytet 2 (tydzień 3–4, koszt ~5 000 PLN): Password manager, backup 3-2-1, dezaktywacja starych kont*
>
> Priorytet 3 (miesiąc 2, koszt ~15 000 PLN): Zmiana hostingu na dedykowany VPS, segmentacja sieci, EDR*
>
> Priorytet 4 (miesiąc 3, koszt ~13 000 PLN): Szkolenia, IRP, audyt PCI DSS*
>
> 35 000 PLN vs. 150 000–400 000 PLN ryzyka. To jest decyzja biznesowa, nie techniczna."*

Marzena przez chwilę milczała, a potem: *"Dobrze Tomku. Masz budżet 40 000 PLN. Ale chcę widzieć postępy co dwa tygodnie."*

---

## Wdrożenie — 90 dni krok po kroku

### Tydzień 1–2: Pożary do ugaszenia (priorytet absolutny)

**Dzień 1–3: Aktualizacja WooCommerce**

Tomasz zrobił snapshot całego hostingu (backup przed aktualizacją — zawsze!), a następnie zaktualizował:
- WordPress: 6.4 → 6.7
- WooCommerce: 6.8 → 9.4
- Wszystkie wtyczki (37 wtyczek — kilka nieaktualizowanych od 3+ lat)

Podczas aktualizacji jedna wtyczka do galerii zdjęć "wysypała" stronę. Dzięki snapshotowi Tomasz przywrócił stan w 15 minut. Lekcja: nigdy nie aktualizuj bez backupu.

**Dzień 3–5: SSL i HTTPS**

Bezpłatny certyfikat Let's Encrypt przez panel hostingowy (5 minut). Wymuszone przekierowanie HTTP → HTTPS. WooCommerce skonfigurowany do wymuszenia HTTPS na całym sklepie, nie tylko checkout.

Dodatkowy efekt: Google lekko poprawił ranking SEO (HTTPS jest czynnikiem rankingowym).

**Dzień 6–10: MFA w Google Workspace**

Tomasz włączył wymóg MFA dla całej organizacji Google Workspace. Każdy pracownik przy następnym logowaniu został poproszony o skonfigurowanie Google Authenticator.

Reakcja pracowników: mieszana. Kilka osób narzekało. Tomasz przygotował 5-minutową instrukcję "jak skonfigurować Google Authenticator na telefonie" + był dostępny przy konfiguracji każdego pracownika przez jeden dzień.

Po tygodniu: 26/28 pracowników — MFA aktywne. Dwoje starszych pracowników z problemami z telefonem — Tomasz skonfigurował hardware token (YubiKey, ~200 PLN/szt.).

**Dezaktywacja starych kont**

3 konta byłych pracowników zablokowane. Hasła zmienione na koncie admina Google Workspace (bo poprzedni admin znał hasło).

---

### Tydzień 3–4: Podstawy operacyjne

**Password Manager — Bitwarden Teams**

Koszt: 30 PLN × 28 użytkowników = 840 PLN/rok.

Tomasz importował wszystkie "firmowe" hasła z karteczek, pliku Excel i własnej pamięci do Bitwarden. Wygenerował nowe silne hasła dla wszystkich systemów firmowych. Zrobił 30-minutowe szkolenie dla każdego działu: *"Od teraz każde nowe hasło do systemu firmowego — generuj z Bitwarden."*

Szczególnie krytyczne: zmiana hasła do panelu hostingowego, bankowości internetowej, panelu Allegro i konta Fakturownia.

**Backup 3-2-1**

- **Kopia 1 (produkcja):** dane na serwerze hostingowym
- **Kopia 2 (chmura firmowa):** automatyczny backup sklepu WooCommerce przez wtyczkę UpdraftPlus do Google Drive firmowego — codziennie o 3:00
- **Kopia 3 (offline):** tygodniowy backup ręczny na dysk zewnętrzny WD 2TB — dysk w szufladzie zamkniętej w biurze (nie podłączony na stałe)

Dodatkowy backup: Google Workspace ma wbudowany backup e-mail i Dysk — Tomasz włączył i przetestował odtwarzanie.

Test odtwarzania: Tomasz celowo usunął plik testowy z produkcji i odtworzył z backupu. Czas: 8 minut. Dokumentacja w Excelu: data testu, wynik, czas odtwarzania.

---

### Miesiąc 2: Infrastruktura

**Zmiana hostingu**

Współdzielony hosting to ryzyko: jeśli inna strona na tym samym serwerze zostanie zaatakowana, może to wpłynąć na ButikPL. Tomasz przeniósł sklep na dedykowany VPS (Contabo lub OVH — ok. 80 PLN/miesiąc za VPS z 4 vCPU, 8 GB RAM).

Na VPS: skonfigurował fail2ban (blokowanie brute force), ModSecurity (WAF dla Apache/Nginx), regularne automatyczne aktualizacje systemu, firewall UFW z minimalną liczbą otwartych portów.

Efekt: sklep szybszy o ~40% (dedykowane zasoby), bezpieczniejszy, pełna kontrola konfiguracji.

**Segmentacja sieci WiFi**

Router Ubiquiti UniFi (koszt: ~600 PLN — wymiana starego routera TP-Link).

Konfiguracja 3 VLAN:
- `VLAN-FIRMA` (hasło znane pracownikom) — komputery, laptopy
- `VLAN-KLIENCI` (sieć gości, wyświetlana jako "ButikPL-Goście") — żaden dostęp do firmowej sieci
- `VLAN-POS` (izolowany) — kasy fiskalne i terminale POS — połączone tylko z siecią operatora płatności

Kasa fiskalna w osobnym VLAN to kluczowy element PCI DSS compliance — Tomasz znalazł to w wytycznych SAQ A.

**Microsoft Defender for Endpoint (uproszczony)**

Tomasz zdecydował się nie na pełny EDR (zbyt drogi dla 28 endpointów) — ale na maksymalne wykorzystanie wbudowanego Windows Defender:
- Windows Security Center: wszystkie moduły włączone
- Cloud-delivered protection: ON
- Tamper protection: ON
- Controlled Folder Access (ochrona przed ransomware): ON dla folderów z dokumentami

Koszt: 0 PLN. Efekt: znaczące wzmocnienie ochrony bez dodatkowego oprogramowania.

---

### Miesiąc 3: Procedury i kultura

**Plan Reagowania na Incydenty**

Tomasz napisał IRP korzystając z szablonu CISA dla małych firm (bezpłatny). Dokument: 6 stron.

Kluczowe elementy:
- Lista kontaktów (Tomasz → Marzena → prawnik firmy → zewnętrzna firma IT)
- Progi eskalacji: kiedy dzwonimy do prawnika (zanim zadzwonimy do policji)
- Procedura izolacji: odłącz kabel — nie wyłączaj zasilania
- Kontakt UODO: zgłoszenie naruszenia w 72h — wzór maila gotowy w szablonie
- Lista zewnętrznej firmy IR (Tomasz podpisał retainer z lokalną firmą IT za 2 000 PLN/rok)

Marzena zatwierdziła IRP. Wydrukowana wersja w szufladzie Tomasza i Marzeny.

**Szkolenie Awareness dla pracowników**

30-minutowe szkolenie stacjonarne dla wszystkich pracowników (w 3 grupach po 9–10 osób):
- Rozpoznawanie phishingu — 5 przykładów prawdziwych e-maili phishingowych z ostatniego roku
- Bezpieczne hasła i password manager — demonstracja Bitwarden
- Co zrobić gdy coś podejrzanego — zgłoś do Tomasza BEZ OBAWY

Tydzień po szkoleniu: Tomasz wysłał testowy e-mail phishingowy. 4 z 28 pracowników kliknęło. Tomasz spotkał się z każdym indywidualnie — bez kary, z edukacją. Następny test za 6 tygodni.

**Audyt PCI DSS SAQ A**

Tomasz wypełnił SAQ A (wymagany przy płatnościach kartami przez zewnętrzny procesor — Przelewy24). 34 pytania, czas: 3 godziny. Wynik: wszystkie wymagania spełnione po wdrożeniu SSL, segmentacji sieci POS i MFA.

Koszt SAQ A: 0 PLN (self-assessment). Tomasz zachował dokumentację do ewentualnej kontroli operatora płatności.

---

## Wyniki po 90 dniach

| Obszar | Stan przed | Stan po |
|---|---|---|
| MFA | 0% kont | 100% kont |
| Aktualizacje WooCommerce | 23 miesiące zaległości | Aktualne; automatyczny monitoring |
| Backup | Niesynchronizowany Dropbox | Działający 3-2-1; testowany |
| Segmentacja sieci | Brak | 3 VLAN: firma/klienci/POS |
| Password Manager | Karteczki i pamięć | Bitwarden dla 28 pracowników |
| PCI DSS | Brak SSL na checkout | SAQ A wypełniony, compliant |
| Plan IR | Nie istniał | 6-stronicowy IRP, zatwierdzony |
| Szkolenia | Nigdy | Pierwsze szkolenie; testy phishing |
| Konta byłych pracowników | 3 aktywne | 0 aktywnych |
| Retainer IR | Brak | 2 000 PLN/rok umowa z firmą IT |

---

## Koszty wdrożenia — rozliczenie

| Pozycja | Koszt |
|---|---|
| Bitwarden Teams (28 userów × rok) | 840 PLN |
| Dyski zewnętrzne (2 szt. WD 2TB) | 560 PLN |
| Router Ubiquiti UniFi | 650 PLN |
| VPS hosting (12 miesięcy) | 960 PLN |
| YubiKey dla 2 pracowników | 400 PLN |
| Retainer firma IT (IR) | 2 000 PLN |
| Czas Tomasza (szacunek 60h × stawka wewnętrzna) | 12 000 PLN |
| Szkolenie awareness zewnętrzne (nie kupili platformy — Tomasz sam) | 0 PLN |
| **Łączny koszt zewnętrzny** | **5 410 PLN** |
| **Łączny koszt z czasem IT** | **~17 410 PLN** |

Tomasz zmieścił się w budżecie 40 000 PLN z dużym zapasem. Marzena przeznaczyła pozostałe ~22 000 PLN na fundusz awaryjny IT.

---

## Co Tomasz zrobiłby inaczej z perspektywy czasu

Po roku Tomasz dostał pytanie od innego administratora IT z branży: *"Gdybyś zaczynał od nowa, co zrobiłbyś inaczej?"*

**1. Zacząłbym od inwentaryzacji, nie od narzędzi.**
Pierwszym impulsem było *"zainstaluj EDR, kup SIEM"*. W rzeczywistości najbardziej wartościowe były: aktualizacja WooCommerce (0 PLN), MFA (0 PLN), dezaktywacja starych kont (0 PLN). Najdroższe często nie są najważniejsze.

**2. Wcześniej napisałbym IRP.**
IRP stoi w szufladzie i nigdy nie był użyty — ale tylko dlatego że nie było incydentu. Napisanie go zajęło 4 godziny i dało Tomaszowi spokój. Gdyby był incydent bez IRP — chaos kosztowałby więcej niż całe wdrożenie.

**3. Wcześniej rozmawiałbym z Marzeną językiem finansowym.**
Przez 3 lata mówił *"powinniśmy to zrobić"*. Zmiana podejścia na *"oto co nas kosztuje jeśli tego nie zrobimy"* przyniosła efekt w 15 minut. Lesson learned.

**4. Zacząłbym szkolić pracowników dzień 1.**
Szkolenie awareness kosztowało 0 PLN dodatkowych i zajęło 3×30 minut. Efekt był natychmiastowy — pracownicy zaczęli pytać zanim kliknęli podejrzany link. To jest najwcześniejszy warning system jaki możesz mieć.

---

## Pytania do refleksji

1. Tomasz miał ograniczony budżet i czas. Czy kolejność wdrożeń którą wybrał była optymalna? Co byś zmienił i dlaczego?

2. Marzena przez lata ignorowała ostrzeżenia Tomasza. Co mogło sprawić że zmienił zdanie? Jak zmienił strategię komunikacji?

3. ButikPL ma sklep internetowy z 23 000 rekordami klientów. Jakie konkretnie zobowiązania wynikają z RODO i jak 90-dniowy plan je adresuje?

4. Jaki byłby ROSI (Return on Security Investment) z wdrożenia MFA dla ButikPL? Przyjmij: prawdopodobieństwo kompromitacji konta bez MFA = 12%/rok, oczekiwany koszt incydentu (BEC fraud) = 60 000 PLN.

5. Tomasz zdecydował się nie kupować dedykowanego EDR i zamiast tego maksymalnie skonfigurować Windows Defender. Czy to dobra decyzja dla firmy o tym profilu? Kiedy EDR zewnętrzny byłby konieczny?

---

*Business case oparty na wzorcach wdrożeń bezpieczeństwa w polskich MŚP sektora retail dokumentowanych przez CERT Polska i partnerów Microsoftu w latach 2023–2025. Dane finansowe są fikcyjne ale oparte na rzeczywistych statystykach branżowych.*

---

## Analiza decyzji: co Tomasz zrobił dobrze a co mógł zrobić lepiej

### Decyzja 1: Aktualizacja WooCommerce jako priorytet #1 — SŁUSZNA

Wersja 6.8 WooCommerce miała 14 znanych krytycznych CVE z publicznie dostępnymi exploitami. W momencie audytu baza CVE miała wpisy sprzed 18 miesięcy — co oznaczało, że przez ponad rok sklep był podatny na ataki które każdy skrypt-kiddie mógł wykonać z gotowego narzędzia.

Szczególnie groźna była CVE dotycząca IDOR (Insecure Direct Object Reference) w API zamówień — atakujący mógł bez uwierzytelnienia pobrać dane dowolnego zamówienia, w tym dane osobowe klienta i adres dostawy. Przy 23 000 klientów: potencjalny masowy wyciek danych = bezpośrednie naruszenie RODO art. 32 → kara UODO.

Koszt mitigacji: 0 PLN + 3 godziny pracy. Koszt niedziałania: nawet kara minimalna 50 000 PLN.

### Decyzja 2: Pominięcie dedykowanego SIEM — KONTROWERSYJNA ALE UZASADNIONA

Tomasz rozważał wdrożenie małego SIEM (np. Wazuh — open source) ale zdecydował się nie wdrażać. Powód: brak czasu i kompetencji na operowanie SIEM. SIEM generuje alerty — ale ktoś musi je czytać i reagować. Przy jednym administratorze IT, SIEM nieoperowany to fałszywe poczucie bezpieczeństwa.

Edwards w rozdziale 3 wspiera tę decyzję: *"Lepiej mieć 3 kontrole dobrze działające niż 10 kontroli niemających aktywnego zarządzania."* Tomasz zainwestował czas w kontrole które mógł utrzymać — i to był właściwy wybór dla ButikPL.

Kiedy SIEM byłby właściwy dla ButikPL? Gdy firma urośnie do 60+ pracowników, zatrudni drugiego IT lub kupi MSSP — wtedy SIEM jako uzupełnienie zewnętrznego monitoringu ma sens.

### Decyzja 3: Szkolenie awareness — samodzielnie zamiast platformy — DOBRA DLA TEGO ETAPU

Tomasz przeprowadził szkolenia samodzielnie zamiast kupować platformę (KnowBe4 kosztowałby ok. 50 PLN/user/rok = 1 400 PLN rocznie). Przy 28 osobach i zerowym budżecie awareness — ta decyzja była pragmatyczna.

Jednak Edwards wskazuje ograniczenie tego podejścia: jednorazowe szkolenie ma krótkoterminowy efekt. Po 3 miesiącach pracownicy zapominają. Platforma z mikro-szkoleniami miesięcznymi + regularnymi symulacjami phishingowymi jest skuteczniejsza długoterminowo.

Rekomendacja Tomasza dla Marzeny na rok 2: *"Zainwestujmy 1 400 PLN/rok w KnowBe4. To tańsze niż jeden incydent phishingowy."*

---

## Lekcja z ButikPL: bezpieczeństwo jako proces, nie projekt

Po 90 dniach Tomasz i Marzena spotkali się na podsumowaniu. Marzena zapytała: *"Dobrze, wdrożyliśmy te rzeczy. Teraz jesteśmy bezpieczni, prawda? Możemy nie wracać do tego tematu przez rok?"*

Tomasz wiedział, że odpowiedź jest kluczowa dla długoterminowego sukcesu programu:

*"Marzena, te 90 dni to był sprint żeby z poziomu 'zero' dojść do 'minimum'. Jesteśmy znacznie bezpieczniejsi niż byliśmy. Ale bezpieczeństwo to nie projekt z datą zakończenia — to ciągły proces. Co kwartał muszę przeglądać: czy są nowe zagrożenia dla WooCommerce? Czy wszyscy pracownicy nadal używają MFA? Czy backupy działają? Czy nowi pracownicy zostali przeszkoleni?*

*Potrzebuję 2 godzin tygodniowo na bieżące bezpieczeństwo i raz na kwartał 4-godzinnego przeglądu. To jest mniej niż 1% czasu naszego działu IT. I to jest cena za spokojny sen."*

Marzena zgodziła się. Tomasz wpisał do kalendarza: **Przegląd bezpieczeństwa — pierwszy piątek każdego kwartału, 4 godziny.**

---

## Porównanie: ButikPL przed i po vs. firma z Katowic

Wróćmy do firmy z Katowic, która zapoczątkowała całą historię. Po jej incydencie zaczęły pojawiać się szczegółowe informacje o tym jak do niego doszło. Porównanie jest uderzające:

| Obszar | Firma z Katowic (ofiary ataku) | ButikPL po 90 dniach |
|---|---|---|
| WooCommerce | Stara wersja z CVE | Aktualna, monitorowana |
| MFA | Brak | 100% kont |
| Backup | "Gdzieś w chmurze" (nieweryfikowany) | 3-2-1, testowany |
| SSL/HTTPS | Tak ale nie na całym sklepie | HTTPS wymuszony wszędzie |
| Segmentacja sieci | Brak | 3 VLAN |
| IRP | Brak | 6-stronicowy, zatwierdzony |
| Szkolenia | Brak | Zrobione + testy phishing |
| PCI DSS | Niezgodny (brak SSL) | SAQ A wypełniony |

Obie firmy były niemal identycznie narażone. Jedna dostała 275 000 PLN kosztów (kara UODO + IR). Druga wydała 17 000 PLN żeby to ryzyko wyeliminować.

Edwards podsumowuje filozofię rozdziału 3: *"W cyberbezpieczeństwie nie chodzi o bycie idealnym. Chodzi o bycie trudniejszym celem niż sąsiad. Atakujący mają ograniczony czas i zasoby — wybierają najłatwiejsze ofiary. Firma z solidnymi podstawami bezpieczeństwa nie jest dla nich interesująca. Atakujący przejdą dalej."*

---

## Skalowalność: co ButikPL będzie potrzebować za 2 lata

Marzena ma plany ekspansji: nowy sklep stacjonarny, 15 dodatkowych pracowników, własny magazyn. Tomasz wie, że obecna infrastruktura bezpieczeństwa nie wystarczy dla firmy 2x większej.

Plan Tomasza na 2 lata:

**Rok 2 (gdy firma osiągnie 40 pracowników):**
- Platforma awareness (KnowBe4 lub Proofpoint) — miesięczne mikro-szkolenia + regularne phishing simulations
- Dedykowany EDR (Microsoft Defender for Business lub CrowdStrike Falcon Go)
- Formalny rejestr ryzyk w Excelu (uproszczony model z modułu 2)
- Vendor assessment checklist dla każdego nowego dostawcy

**Rok 3 (gdy firma osiągnie 45–50 pracowników):**
- Ocena zasadności MSSP (gdy jeden administrator IT już nie wystarcza)
- Zero Trust Network Access (ZTNA) zamiast tradycyjnego VPN
- Formalny BIA dla systemów krytycznych
- Certyfikacja ISO 27001 jeśli klienci B2B zaczną wymagać (coraz częstszy trend)

To jest właśnie skalowalność o której pisze Edwards: nie buduj dziś infrastruktury której nie potrzebujesz — ale planuj ją z myślą o tym gdzie będziesz za 2 lata.

---

*Business case ButikPL pokazuje że solidne bezpieczeństwo w małej firmie jest osiągalne przy budżecie poniżej 20 000 PLN — jeśli masz właściwe priorytety i podejście risk-based. Klucz nie leży w najdroższych narzędziach, lecz w systematycznym adresowaniu rzeczywistych ryzyk.*
