# Case Study: LogistykaPL Sp. z o.o. — Atak przez niezabezpieczoną sieć Wi-Fi

**Moduł 4 · Bezpieczeństwo sieci i infrastruktury**

---

## Kontekst organizacji

**LogistykaPL Sp. z o.o.** to firma logistyczna z Łodzi zatrudniająca 180 pracowników. Obsługuje klientów z branży e-commerce, zarządzając magazynami, flotą 40 pojazdów oraz platformą śledzenia przesyłek. Obroty roczne: 22 mln PLN.

Infrastruktura IT (stan przed incydentem):
- Serwer plików on-premise (NAS QNAP)
- System WMS (Warehouse Management System) — oprogramowanie do zarządzania magazynem, serwer lokalny
- System TMS (Transport Management System) — SaaS w chmurze
- ERP (Comarch ERP Optima) — serwer lokalny
- Sieć Wi-Fi: jeden punkt dostępowy dla pracowników + jeden dla gości, **ta sama sieć**
- Firewall: router Mikrotik hAP (klasa SOHO, konfiguracja domyślna, bez IDS)
- Brak segmentacji VLAN
- Brak monitoringu sieciowego

**Zespół IT:** 1 administrator IT (Marcin, 28 lat, doświadczenie 3 lata), zatrudniony 8 miesięcy przed incydentem.

---

## Incydent — przebieg chronologiczny

### Dzień 0 (wtorek, godzina 14:23) — punkt wejścia

Kierowca zewnętrznej firmy kurierskiej, Piotr W., przyjeżdża do siedziby LogistykaPL w celu odbioru dokumentów. Recepcja przekazuje mu hasło do sieci Wi-Fi dla gości: `logistyka2022` (zapisane na karteczce na ladzie recepcji).

Piotr W. podłącza swój laptop do sieci. Na jego laptopie działa złośliwe oprogramowanie — adware z funkcją sniffowania sieci, zainstalowane kilka dni wcześniej przez kliknięcie w fałszywy link. Malware automatycznie rozpoczyna skanowanie sieci.

**Problem nr 1:** sieć dla gości i sieć pracownicza to ta sama sieć. Brak jakiejkolwiek izolacji.

### Dzień 0 (godzina 14:31 — 15:12) — rekonesans

Malware na laptopie kuriera wykonuje automatyczne skanowanie sieci lokalnej (192.168.1.0/24). W ciągu 41 minut identyfikuje:
- **192.168.1.10** — NAS QNAP z otwartym portem 8080 (panel administracyjny HTTP, bez HTTPS)
- **192.168.1.20** — serwer ERP (port 3050 — Firebird baza danych, dostępna z sieci lokalnej bez uwierzytelniania)
- **192.168.1.30** — serwer WMS (port 22 — SSH, domyślna konfiguracja, port otwarty na całą sieć)
- **192.168.1.1** — router Mikrotik (port 80 — Winbox i panel HTTP, domyślne hasło admin/admin)

**Problem nr 2:** NAS QNAP używa panelu HTTP zamiast HTTPS — hasło administratora przesyłane w plain text.

**Problem nr 3:** baza danych ERP (Firebird) dostępna bezpośrednio z sieci lokalnej bez dodatkowego uwierzytelniania.

**Problem nr 4:** router z domyślnym hasłem admin/admin.

### Dzień 0 (godzina 15:47) — kompromitacja routera

Malware automatycznie loguje się do panelu administracyjnego routera Mikrotik używając domyślnych danych: admin/admin. Zmienia konfigurację DNS — wskazuje na kontrolowany przez atakującego serwer DNS (tzw. DNS hijacking). Od tej chwili wszystkie zapytania DNS z sieci LogistykaPL mogą być przekierowywane.

Zmiana jest subtelna — wprowadzona jako dodatkowy (drugi) serwer DNS, więc większość zapytań nadal trafia do legalnego serwera DNS. Zmiana pozostaje niezauważona.

**Problem nr 5:** brak monitoringu zmian konfiguracji routera. Brak alertów przy logowaniu do routera.

### Dzień 0–4 — eksfiltracja danych

W ciągu następnych 4 dni atakujący (zdalnie, przez skompromitowany router jako pivot point) przeprowadza powolną eksfiltrację:
- Listy klientów z systemu ERP (nazwy firm, NIP-y, adresy, dane kontaktowe)
- Historię zamówień z WMS
- Dokumenty handlowe z NAS (PDF-y umów, ofert cenowych)

Eksfiltracja jest celowo powolna — kilkanaście MB dziennie — żeby nie wzbudzić podejrzeń.

**Problem nr 6:** brak NetFlow/flow analysis — nikt nie widzi ruchu wychodzącego.

### Dzień 5 (poniedziałek, godzina 9:15) — wykrycie incydentu

Klient LogistykaPL — sieć sklepów e-commerce — otrzymuje e-mail od konkurencji z dokładną ofertą cenową LogistykaPL i propozycją niższych stawek. Klient dzwoni do dyrektora handlowego LogistykaPL z pytaniem skąd konkurencja zna ich warunki handlowe.

Dyrektor handlowy eskaluje do zarządu. Zarząd kontaktuje się z Marcinem (administrator IT).

### Dzień 5 (godzina 11:00 — 23:00) — response

Marcin przez 12 godzin próbuje samodzielnie zrozumieć co się stało. Sprawdza logi NAS — nie ma logów dostępu (logowanie nie było włączone). Sprawdza logi serwera ERP — jest, ale niepełne. Sprawdza router — widzi zmieniony DNS, ale nie wie kiedy to zostało zmienione (logi routera nadpisane przez ograniczony bufor).

Marcin zmienia hasła do wszystkich systemów, przywraca oryginalną konfigurację DNS, blokuje dostęp do panelu routera z sieci lokalnej.

**Nie wie jednak:** jak długo atak trwał, jakie dane zostały skopiowane, czy malware nadal jest gdzieś w sieci.

### Dzień 6 — zaangażowanie zewnętrznych specjalistów

LogistykaPL zatrudnia zewnętrzną firmę incident response. Forensics ujawnia pełen obraz: 4 dni eksfiltracji, ~2,3 GB danych, 847 rekordów klientów.

---

## Analiza przyczyn źródłowych (Root Cause Analysis)

### Przyczyna bezpośrednia
Złośliwy kod na laptopie kuriera dostał się do sieci firmowej przez brak segmentacji sieci Wi-Fi.

### Przyczyny pośrednie (głębsze problemy)

**1. Brak segmentacji sieciowej**
Sieć dla gości i sieć pracownicza to ta sama sieć VLAN. Gość z zainfekowanym urządzeniem miał bezpośredni dostęp do serwerów produkcyjnych. Rozwiązanie: oddzielne VLAN-y, Guest Wi-Fi izolowane od sieci wewnętrznej.

**2. Urządzenia sieciowe z domyślnymi hasłami**
Router z hasłem admin/admin to fundamentalny błąd. Domyślne hasła są pierwszą rzeczą którą sprawdza każde automatyczne narzędzie atakujące. Rozwiązanie: polityka zmiany domyślnych haseł przy każdym wdrożeniu urządzenia.

**3. Brak szyfrowania wewnętrznego ruchu zarządzającego**
Panel NAS przez HTTP (nie HTTPS) — hasło przesyłane plaintext. W sieci z snifferem to wystarczy do przejęcia konta. Rozwiązanie: wymuszenie HTTPS na wszystkich panelach zarządzających.

**4. Nadmierna ekspozycja usług w sieci lokalnej**
Baza danych Firebird dostępna bezpośrednio z sieci lokalnej bez dodatkowego uwierzytelniania. Serwery baz danych nie powinny być dostępne bezpośrednio — tylko przez dedykowany serwer aplikacji. Rozwiązanie: firewall wewnętrzny lub reguły iptables ograniczające dostęp do bazy danych wyłącznie do serwera aplikacji.

**5. Brak monitoringu sieciowego**
Żaden z systemów nie rejestrował połączeń sieciowych. Eksfiltracja 2,3 GB danych przez 4 dni — nikt nie widział. Rozwiązanie: NetFlow monitoring, SIEM z regułami detekcji anomalii ruchu.

**6. Brak logowania na kluczowych systemach**
NAS bez włączonego logowania dostępu — niemożliwe ustalenie co i kiedy zostało skopiowane. Rozwiązanie: obowiązkowe logowanie dostępu do zasobów na wszystkich systemach przechowujących dane.

---

## Analiza finansowa incydentu

| Kategoria kosztu | Kwota (PLN) |
|-----------------|-------------|
| Zewnętrzna firma IR (forensics + 5 dni pracy) | 38 000 |
| Prawnik (UODO — zawiadomienie o naruszeniu danych osobowych) | 12 000 |
| Kara UODO (szacunkowa, w trakcie postępowania) | 50 000–200 000 |
| Utracone kontrakty (2 klientów wypowiedziało umowy) | 340 000/rok |
| Przeprojektowanie sieci (nowy sprzęt + konfiguracja) | 45 000 |
| Dodatkowe godziny pracy Marcina i zarządu | 18 000 |
| **Łączny koszt (bez kary UODO)** | **453 000** |

**Koszt preventywnej segmentacji sieci** (który mógł to wszystko zapobiec): ~15 000 PLN (VLAN-y na istniejącym sprzęcie + managed switch z możliwością VLAN).

**ROI bezpieczeństwa:** 453 000 PLN strat vs 15 000 PLN inwestycji. Wskaźnik 30:1.

---

## Plan naprawczy — co LogistykaPL wdrożyła po incydencie

### Faza 1 (tydzień 1–2) — natychmiastowe działania

**1.1 Segmentacja Wi-Fi**
Wdrożenie trzech oddzielnych sieci bezprzewodowych:
- `LogistykaPL-Corp` (WPA3-Enterprise z 802.1X, VLAN 10) — tylko firmowe urządzenia
- `LogistykaPL-Guest` (WPA3-Personal, izolacja klientów, VLAN 50) — brak dostępu do sieci wewnętrznej
- `LogistykaPL-IoT` (WPA2, izolacja, VLAN 40) — czytniki kodów, drukarki magazynowe

**1.2 Zmiana wszystkich domyślnych haseł**
Inwentaryzacja wszystkich urządzeń sieciowych i systemów. Zmiana haseł na silne (min. 20 znaków, losowe). Dokumentacja w menedżerze haseł (Bitwarden Business).

**1.3 Wyłączenie dostępu HTTP, wymuszenie HTTPS**
Na routerze, NAS, panelach zarządzających — wyłączenie HTTP, włączenie HTTPS z ważnymi certyfikatami.

### Faza 2 (miesiąc 1) — segmentacja i monitoring

**2.1 Wdrożenie VLAN-ów**
- VLAN 10 — stacje robocze (192.168.10.0/24)
- VLAN 20 — serwery produkcyjne (192.168.20.0/24)
- VLAN 30 — management (192.168.30.0/24)
- VLAN 40 — IoT (192.168.40.0/24)
- VLAN 50 — goście (192.168.50.0/24)

Zakup managed switcha Cisco SG350 (2 200 PLN) i routera Mikrotik CCR2004 z RB (5 800 PLN). Konfiguracja przez zewnętrznego specjalistę.

**2.2 Firewall reguły między VLAN-ami**
Reguły zezwalające tylko na niezbędny ruch:
- VLAN 10 (stacje) → VLAN 20 (serwery): tylko port 3000 (WMS), 8080 (ERP)
- VLAN 50 (goście) → Internet: tylko port 80, 443
- VLAN 50 (goście) → reszta: DENY ALL
- VLAN 40 (IoT) → Internet: DENY ALL
- VLAN 40 (IoT) → reszta: DENY ALL

**2.3 NetFlow monitoring**
Włączenie NetFlow na routerze Mikrotik. Wdrożenie Ntopng Community Edition (open-source, bezpłatny). Dashboard pokazuje top talkers, połączenia z nieznanymi IP, anomalie.

**2.4 Centralne logowanie**
Wdrożenie Wazuh (open-source SIEM) na dedykowanym serwerze (stary serwer, 8 GB RAM). Zbiera logi z: routera (syslog), NAS (syslog), serwera ERP (Windows Event Log), serwera WMS.

### Faza 3 (miesiąc 2–3) — dojrzałość operacyjna

**3.1 Procedura onboardingu gości**
Nowe zasady dostępu do sieci dla gości:
- Hasło do sieci gości zmieniane co tydzień
- Hasło wydawane osobiście przez recepcję po wpisaniu do rejestru (imię, nazwisko, firma, cel wizyty)
- Czas ważności sesji: 8 godzin
- Captive portal z potwierdzeniem akceptacji polityki bezpieczeństwa

**3.2 Polityka zarządzania urządzeniami sieciowymi**
- Inwentaryzacja wszystkich urządzeń sieciowych (24 urządzenia znalezione — 6 nieznanych)
- Quarterly review konfiguracji routera i firewalla
- Zmiana haseł co 90 dni
- Backup konfiguracji przed każdą zmianą

**3.3 Szkolenie Marcina**
Dofinansowanie kursu Network Security Fundamentals (Cisco NetAcad) i certyfikatu CompTIA Security+. Budżet: 8 000 PLN.

---

## Wnioski dla dyrektora IT

Incydent w LogistykaPL pokazuje jak brak podstawowych kontroli sieciowych może zamienić rutynową wizytę kuriera w poważny wyciek danych. Kilka kluczowych obserwacji:

**1. Goście w sieci to ryzyko zarządzalne, nie nieuniknione**
Każda organizacja musi gościć osoby z zewnątrz. Właściwa segmentacja sprawia, że gość może mieć internet bez dostępu do zasobów firmy. To kwestia konfiguracji, nie drogiego sprzętu.

**2. „Nie mamy nic wartościowego" to mit**
LogistykaPL nie przechowywała haseł bankowych ani numerów kart płatniczych. Ale lista 847 klientów z danymi kontraktowymi była warta dla konkurencji tyle, że zapłacili atakującemu za jej dostarczenie. Dane biznesowe — warunki handlowe, ceny, listy klientów — mają realną wartość rynkową.

**3. Koszt naprawy jest wielokrotnie wyższy niż koszt prewencji**
15 000 PLN na segmentację sieci vs 453 000 PLN kosztów incydentu. To nie jest wyjątkowy przypadek — to reguła.

**4. Jeden administrator IT bez narzędzi jest ślepy**
Marcin pracował uczciwie, ale bez NetFlow, SIEM i logowania — był ślepy. Nie mógł wykryć ataku, który trwał 4 dni. Narzędzia open-source (Wazuh, Ntopng) eliminują to ślepoznaznanie za minimalny koszt.

**5. Procedury muszą poprzedzać incydenty**
Po incydencie LogistykaPL zrozumiała czego brakowało. Ale procedura zmiany domyślnych haseł, polityka dostępu gości, quarterly review konfiguracji — to rzeczy które powinny istnieć od pierwszego dnia.

---

## Pytania do dyskusji

1. Gdybyś był Marcinem i miał budżet 20 000 PLN na zabezpieczenie sieci — od czego byś zaczął i dlaczego?

2. LogistykaPL używa systemu WMS i ERP on-premise. Czy migracja do SaaS wyeliminowałaby ryzyko które zmaterializowało się w tym case study? Jakie nowe ryzyka by to stworzyło?

3. Firma rozważa wdrożenie polityki "Zero Trust" — żadne urządzenie nie jest zaufane, nawet podłączone do sieci firmowej. Jakie byłyby wyzwania organizacyjne (nie techniczne) przy wdrożeniu takiej polityki?

4. Atak zaczął się od zainfekowanego laptopa gościa. Czy firma może/powinna weryfikować bezpieczeństwo urządzeń gości? Gdzie jest granica między bezpieczeństwem a prywatnością?

---

*Przypadek opisany na podstawie syntetycznych danych — firma i osoby są fikcyjne. Scenariusz odzwierciedla typowe wzorce ataków w firmach sektora MŚP według raportów CERT Polska 2023 i Verizon DBIR 2024.*
