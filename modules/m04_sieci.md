# Moduł 4: Bezpieczeństwo sieci i infrastruktury

**Rozdział 4 · Jason Edwards, *The Cybersecurity Control Playbook* (Wiley, 2025) + Chuck Easttom, *Computer Security Fundamentals* (Pearson, 2019)**

> Sieć to układ krwionośny organizacji. Jeśli atakujący dostanie się do krwioobiegu, może dotrzeć wszędzie. Zadaniem bezpieczeństwa sieciowego nie jest budowanie murów — to monitorowanie i kontrolowanie przepływu.

---

## Dlaczego bezpieczeństwo sieci jest fundamentem wszystkiego

Zanim firma może chronić swoje dane, aplikacje czy użytkowników — musi kontrolować sieć. Sieć to medium, przez które przepływa każda komunikacja: między użytkownikami a systemami, między systemami a Internetem, między oddziałami firmy, między aplikacjami w chmurze a urządzeniami końcowymi.

Każdy atak — phishing, ransomware, kradzież danych, nieautoryzowany dostęp — w pewnym momencie przechodzi przez sieć. Jeśli firma nie widzi tego ruchu, nie może go analizować, filtrować ani blokować. Bezpieczeństwo sieciowe to zdolność do **widzenia, rozumienia i kontrolowania** tego co dzieje się w sieci.

Edwards w rozdziale 4 *Cybersecurity Control Playbook* stawia fundamentalne pytanie: **„Czy wiesz co jest podłączone do Twojej sieci i czy każde z tych urządzeń powinno tam być?"** Dla 80% organizacji odpowiedź brzmi: nie. To jest punkt startowy.

Easttom w *Computer Security Fundamentals* dodaje perspektywę techniczną: sieć jest areną dla dziesiątek typów ataków — od prostego skanowania portów po zaawansowane ataki Man-in-the-Middle, DDoS i eksfiltrację danych tunelowaną przez DNS. Bez znajomości architektury sieciowej nie można skutecznie bronić.

---

## Podstawy architektury sieciowej — co musisz wiedzieć

Zanim przejdziemy do kontroli bezpieczeństwa, musimy zrozumieć jak sieć działa. To nie jest kurs sieci, ale minimum wiedzy konieczne do świadomego wdrażania zabezpieczeń.

### Model warstwowy TCP/IP

Internet i sieci firmowe działają na modelu warstwowym. Każda warstwa ma inne protokoły i inne podatności:

**Warstwa 1 — Fizyczna:** kable, switche, routery. Atak: fizyczny dostęp do sprzętu, podłączenie nieautoryzowanego urządzenia.

**Warstwa 2 — Łącza danych:** protokoły Ethernet, MAC adresy, VLAN-y. Atak: ARP spoofing, MAC flooding, ataki na switch.

**Warstwa 3 — Sieciowa:** IP, routing, ICMP. Atak: IP spoofing, skanowanie sieci, routing attacks.

**Warstwa 4 — Transportowa:** TCP, UDP, porty. Atak: SYN flood, port scanning, session hijacking.

**Warstwa 7 — Aplikacyjna:** HTTP, HTTPS, DNS, SMTP. Atak: XSS, SQL injection, DNS poisoning, phishing.

**Dlaczego to ważne?** Firewall layer 3 nie ochroni przed atakiem na warstwę aplikacji. WAF (Web Application Firewall) nie ochroni przed ARP spoofingiem. Każda warstwa wymaga dedykowanych kontroli.

### Kluczowe protokoły i ich podatności

**DNS (Domain Name System)** — tłumaczy nazwy domen na adresy IP. Podatność: DNS poisoning (podrobiona odpowiedź DNS kieruje użytkownika na złośliwą stronę). Kontrola: DNSSEC, DNS over HTTPS/TLS, monitoring anomalii DNS.

**DHCP (Dynamic Host Configuration Protocol)** — automatycznie przydziela adresy IP urządzeniom. Podatność: DHCP spoofing (atakujący podstawia swój serwer DHCP i przejmuje kontrolę nad ruchem). Kontrola: DHCP snooping na przełącznikach.

**SNMP (Simple Network Management Protocol)** — zarządzanie urządzeniami sieciowymi. Podatność: stare wersje (v1, v2) używają plaintext community strings. Kontrola: wymuszenie SNMPv3 z szyfrowaniem.

**Telnet vs SSH** — Telnet przesyła dane w plaintext (loginy, hasła widoczne w sieci). SSH szyfruje całą komunikację. Reguła: Telnet musi być wyłączony wszędzie. Zawsze SSH.

---

## Strefy bezpieczeństwa sieciowego — segmentacja

Najważniejsza zasada projektowania bezpiecznej sieci: **nie wszystko powinno rozmawiać ze wszystkim.** Segmentacja to podział sieci na odizolowane strefy z kontrolowanym przepływem ruchu między nimi.

### DMZ (Demilitarized Zone)

DMZ to strefa sieciowa pomiędzy Internetem a siecią wewnętrzną. Umieszcza się w niej serwery, które muszą być dostępne z Internetu: serwery WWW, serwery poczty, VPN gateway, serwery DNS.

```
Internet → [Firewall zewnętrzny] → DMZ → [Firewall wewnętrzny] → Sieć wewnętrzna
```

**Logika:** jeśli serwer WWW w DMZ zostanie skompromitowany, atakujący trafia do DMZ — nie do sieci wewnętrznej. Firewall wewnętrzny blokuje dalszy ruch. Bez DMZ skompromitowany serwer WWW daje bezpośredni dostęp do całej sieci firmowej.

**Błąd numer 1:** umieszczanie w DMZ serwerów z dostępem do wewnętrznej bazy danych bez odpowiedniej kontroli. Atakujący kompromituje serwer WWW → serwer WWW ma połączenie do bazy danych w sieci wewnętrznej → game over.

### VLAN-y (Virtual Local Area Networks)

VLAN to logiczna segmentacja sieci na tym samym fizycznym sprzęcie. Urządzenia w różnych VLAN-ach nie komunikują się bezpośrednio — ruch między nimi musi przejść przez router/firewall.

**Typowe segmentacje VLAN w firmie:**
- VLAN 10 — stacje robocze pracowników
- VLAN 20 — serwery produkcyjne
- VLAN 30 — serwery deweloperskie/testowe
- VLAN 40 — urządzenia IoT (drukarki, kamery, systemy kontroli dostępu)
- VLAN 50 — sieć dla gości (Wi-Fi Guest)
- VLAN 60 — urządzenia zarządzające (serwery zarządzania, jump box)

**Dlaczego IoT w osobnym VLAN?** Drukarki, kamery, czytniki kart — często mają słabe zabezpieczenia, rzadko są aktualizowane, mogą mieć domyślne hasła. Izolacja do osobnego VLAN-u sprawia, że skompromitowana drukarka nie może komunikować się z serwerem księgowości.

**Microsegmentacja** — bardziej zaawansowana forma segmentacji, stosowana w środowiskach chmurowych i data center. Pozwala na kontrolę ruchu nie tylko między VLAN-ami, ale między konkretnymi serwerami, a nawet procesami.

### Zero Trust Network Architecture

Tradycyjna architektura sieciowa opierała się na modelu **„castle and moat"**: cokolwiek jest w sieci wewnętrznej jest zaufane, cokolwiek na zewnątrz jest niebezpieczne. Firewall perimetryczny bronił granicy.

Ten model jest przestarzały z kilku powodów:
- Użytkownicy pracują zdalnie (poza perimetrem)
- Aplikacje są w chmurze (poza perimetrem)
- Atakujący, gdy już wejdą do sieci, mogą swobodnie się poruszać (lateral movement)
- Pracownicy mogą być zagrożeniem wewnętrznym

**Zero Trust Network Architecture (ZTNA)** to model oparty na zasadzie: **„Nigdy nie ufaj, zawsze weryfikuj"**. Każde żądanie dostępu — niezależnie od tego czy pochodzi z sieci wewnętrznej czy zewnętrznej — musi być uwierzytelnione, autoryzowane i zaszyfrowane.

Trzy filary ZTNA:
1. **Weryfikuj każdego użytkownika** — silne uwierzytelnianie (MFA), weryfikacja tożsamości przy każdym dostępie
2. **Weryfikuj każde urządzenie** — Device compliance check (czy urządzenie ma aktualny antywirus, pełne szyfrowanie dysku, aktualny system operacyjny?)
3. **Minimalizuj dostęp** — least privilege, dostęp tylko do tego co potrzebne, tylko na czas kiedy potrzebne

---

## Firewalle — serce obrony sieciowej

Firewall to urządzenie lub oprogramowanie kontrolujące ruch sieciowy na podstawie zdefiniowanych reguł. To nie jest jedna technologia — to kategoria, z wieloma typami o różnych możliwościach.

### Typy firewalli

**Packet Filter Firewall (firewall pakietowy)**
Najstarsza i najprostsza forma. Analizuje każdy pakiet niezależnie: źródłowy IP, docelowy IP, port źródłowy, port docelowy, protokół. Decyduje: przepuścić czy odrzucić.

Ograniczenia: nie rozumie kontekstu połączenia, nie widzi zawartości pakietu, podatny na IP spoofing.

Zastosowanie: podstawowa filtracja na granicy sieci, kontrola dostępu na routerach.

**Stateful Inspection Firewall**
Śledzi stan połączeń TCP — wie które pakiety należą do której sesji. Może sprawdzać czy odpowiedź TCP odpowiada wcześniejszemu żądaniu. Znacznie trudniejszy do obejścia niż packet filter.

To jest standard dla większości firmowych firewalli. Większość firewalli klasy business (Cisco ASA, Fortinet, Palo Alto, pfSense) to firewalle stateful inspection.

**Application-layer Firewall / Next-Generation Firewall (NGFW)**
Rozumie protokoły aplikacyjne — może analizować zawartość HTTP, sprawdzać sygnatury malware, blokować konkretne aplikacje (np. BitTorrent), wykonywać SSL inspection (odszyfrowywanie i ponowne szyfrowanie ruchu HTTPS).

NGFW łączy stateful inspection z funkcjami: IDS/IPS, antivirus, application control, URL filtering, user identity awareness.

Zastosowanie: główny firewall perimetryczny w organizacjach od małych po duże.

**Web Application Firewall (WAF)**
Specjalizowany firewall chroniący aplikacje webowe przed atakami warstwy 7: SQL injection, XSS, CSRF, directory traversal. Rozumie protokół HTTP w szczegółach.

Zastosowanie: ochrona serwerów WWW, API, aplikacji e-commerce. Często wdrażany jako reverse proxy przed serwerem aplikacji.

### Reguły firewalla — filozofia i praktyka

**Zasada domyślnego odrzucenia (Default Deny):** jeśli ruch nie jest jawnie dozwolony — jest blokowany. To odwrotność naiwnego podejścia gdzie wszystko jest dozwolone jeśli nie jest jawnie zakazane.

**Kolejność reguł:** reguły są sprawdzane od góry, pierwsza pasująca reguła wygrywa. Typowy porządek:
1. Blokuj znane złośliwe IP/sieci
2. Zezwól na ruch zarządzający (SSH z management VLAN)
3. Zezwól na specyficzne dozwolone usługi
4. Blokuj wszystko inne (default deny)

**Błąd numer 1 w konfiguracji firewalla:** reguła `permit any any` (zezwól na wszystko) lub pozostawienie domyślnych reguł producenta bez przeglądu. Edwards cytuje badania Gartner: 95% incydentów związanych z firewallami wynika z błędnej konfiguracji, nie z luki w oprogramowaniu firewalla.

**Przegląd reguł firewalla:** co kwartał należy przejrzeć wszystkie reguły i usunąć te, które nie są już potrzebne. Reguły dodane „tymczasowo" latami zaśmiecają konfigurację i poszerzają powierzchnię ataku.

---

## VPN — bezpieczne połączenia zdalne

VPN (Virtual Private Network) tworzy szyfrowany tunel między urządzeniem użytkownika a siecią firmową (lub między dwoma sieciami). Nawet jeśli atakujący przechwyci ruch — zobaczy zaszyfrowane dane, których nie może odczytać.

### Typy VPN

**Site-to-Site VPN:** stałe połączenie między dwoma lokalizacjami (np. siedziba główna — oddział). Szyfruje cały ruch między sieciami. Użytkownicy nie muszą nic konfigurować — tunel jest zawsze aktywny.

**Remote Access VPN:** połączenie pojedynczego użytkownika z siecią firmową. Pracownik instaluje klienta VPN, loguje się — i jego urządzenie staje się częścią sieci firmowej (z odpowiednimi uprawnieniami).

**SSL/TLS VPN vs IPsec VPN:**
- IPsec: działa na warstwie 3, wymaga dedykowanego oprogramowania, wydajniejszy, bardziej elastyczny
- SSL VPN: działa przez HTTPS (port 443), może działać przez przeglądarkę, łatwiejszy dla użytkowników, często stosowany dla dostępu do konkretnych aplikacji

### VPN nie jest panaceum

Edwards ostrzega: VPN chroni transmisję, ale nie chroni przed skompromitowanym urządzeniem. Jeśli laptop pracownika jest zainfekowany malware i pracownik łączy się przez VPN — malware ma dostęp do sieci firmowej z pełnymi uprawnieniami pracownika.

Dlatego nowoczesne rozwiązania łączą VPN z:
- **Device compliance check** — urządzenie musi mieć aktualny antyvirus, szyfrowanie dysku, zaktualizowany system
- **MFA** — samo hasło do VPN nie wystarczy
- **Split tunneling kontrolowane** — decyzja czy cały ruch idzie przez VPN (full tunnel) czy tylko ruch firmowy (split tunnel). Full tunnel bezpieczniejszy, ale wolniejszy.

### SD-WAN i alternatywy dla VPN

Nowoczesne organizacje coraz częściej zastępują klasyczny VPN rozwiązaniami **ZTNA (Zero Trust Network Access)**: zamiast dawać dostęp do całej sieci firmowej, użytkownik dostaje dostęp tylko do konkretnych aplikacji, które są mu potrzebne. Microsoft Entra Private Access, Zscaler Private Access, Cloudflare Access — to przykłady takich rozwiązań.

---

## IDS/IPS — wykrywanie i zapobieganie włamaniom

### IDS (Intrusion Detection System)

IDS monitoruje ruch sieciowy i alarmuje gdy wykryje podejrzaną aktywność. **Wykrywa, ale nie blokuje** — to zadanie analityka lub innego systemu. IDS pasywny.

**Typy IDS:**
- **NIDS (Network IDS):** monitoruje ruch w sieci. Umieszcza się go na tap lub SPAN porcie switcha, gdzie widzi cały ruch.
- **HIDS (Host IDS):** działa na konkretnym hoście, monitoruje logi systemowe, integralność plików, wywołania systemowe.

**Metody wykrywania:**
- **Signature-based:** porównuje ruch z bazą znanych wzorców ataków. Skuteczny dla znanych zagrożeń, bezsilny wobec nowych ataków (zero-day).
- **Anomaly-based (behavioral):** buduje model normalnego zachowania sieci i alarmuje przy odchyleniach. Wykrywa nowe ataki, ale generuje więcej false positives.
- **Stateful protocol analysis:** sprawdza czy protokoły są używane zgodnie ze specyfikacją. Anomalia w protokole = potencjalny atak.

**Snort** — najpopularniejszy open-source NIDS. Może działać w trybie sniffer (tylko przechwytuje), packet logger (zapisuje pakiety) lub NIDS (analizuje i alarmuje). Easttom poświęca mu cały podrozdział ze szczegółami konfiguracji.

### IPS (Intrusion Prevention System)

IPS = IDS + możliwość blokowania. Działa inline (ruch przechodzi przez IPS, nie obok niego). Gdy wykryje atak — może odrzucić pakiety, zresetować połączenie, zablokować IP atakującego.

**IPS inline vs NIDS pasywny:**
- NIDS pasywny: widzi kopię ruchu → może alarmować, nie może blokować → nie dodaje opóźnienia
- IPS inline: ruch przechodzi przez IPS → może blokować → dodaje minimalne opóźnienie → ryzyko false positive = zablokowanie legalnego ruchu

Dlatego IPS wymaga bardziej precyzyjnego tuningowania niż NIDS.

**NGFW z IPS:** nowoczesne firewalle Next-Generation zawierają wbudowany IPS. Zamiast oddzielnych urządzeń, jedna platforma łączy firewall + IPS + antivirus + URL filtering.

---

## Monitoring sieci i widoczność

Nie można bronić tego, czego nie widać. Bezpieczeństwo sieciowe wymaga ciągłego monitorowania.

### Flow Analysis — NetFlow, IPFIX, sFlow

Zamiast przechwytywać każdy pakiet (co jest kosztowne i trudne do przechowywania), flow analysis zbiera metadane o połączeniach: kto rozmawiał z kim, przez jaki protokół, ile danych, jak długo.

To nie pozwala czytać zawartości ruchu, ale pozwala wykryć:
- Nieautoryzowane połączenia do zewnętrznych IP
- Anomalne ilości danych wychodzących (eksfiltracja danych)
- Połączenia do znanych złośliwych domen/IP
- Skanowanie portów wewnątrz sieci (lateral movement)
- Komunikacja z Command & Control serwerami malware

**Narzędzia:** Cisco NetFlow, ntopng, Elastic Stack (ELK) z Filebeat, Zeek (wcześniej Bro).

### SIEM (Security Information and Event Management)

SIEM zbiera logi ze wszystkich źródeł (firewalle, IDS, serwery, stacje robocze, aplikacje), koreluje je i wykrywa wzorce wskazujące na incydent bezpieczeństwa.

**Przykład korelacji SIEM:** użytkownik Jan Kowalski loguje się o 3:00 w nocy z IP w Rosji → następnie następuje 1000 nieudanych prób logowania na różne konta → potem 3 udane logowania na konta administratorów. Każde zdarzenie osobno może wyglądać podejrzanie. Razem to wyraźny wzorzec ataku brute force z przejęciem kont.

SIEM może automatycznie wygenerować alert, zablokować konto, wysłać powiadomienie do analityka.

**Popularne SIEM:** Splunk (enterprise, drogie), Microsoft Sentinel (cloud, Azure), IBM QRadar, Elastic SIEM (open-source), Wazuh (open-source, dla mniejszych organizacji).

**Wyzwanie SIEM:** alert fatigue — zbyt wiele alertów, zbyt mało analityków. Kluczowe jest tuningowanie reguł korelacji i priorytetyzacja alertów.

### Network Access Control (NAC)

NAC kontroluje które urządzenia mogą połączyć się z siecią. Zanim urządzenie dostanie adres IP i dostęp do sieci — jest weryfikowane:
- Czy urządzenie jest zarządzane przez firmę?
- Czy ma aktualny antywirus?
- Czy ma wymagane certyfikaty?
- Czy system operacyjny jest aktualny?

Urządzenia niespełniające wymagań są kierowane do sieci kwarantanny.

**Cisco ISE, Aruba ClearPass, ForeScout** — to przykłady rozwiązań NAC klasy enterprise.

---

## Bezpieczeństwo Wi-Fi

Sieć bezprzewodowa to jedna z najczęstszych ścieżek nieautoryzowanego dostępu — szczególnie jeśli jest źle skonfigurowana.

### Protokoły szyfrowania Wi-Fi

**WEP (Wired Equivalent Privacy):** pierwszy protokół szyfrowania Wi-Fi. Złamany od 2001 roku — atakujący może je złamać w kilka minut. **WEP musi być wyłączony wszędzie — bez wyjątków.**

**WPA (Wi-Fi Protected Access):** wprowadzony jako tymczasowe łatanie WEP. Podatny na ataki słownikowe na pre-shared key.

**WPA2:** standard od 2004 roku. WPA2-Personal (PSK — Pre-Shared Key) podatny na ataki słownikowe jeśli klucz jest słaby. WPA2-Enterprise używa 802.1X i RADIUS — każdy użytkownik ma własne poświadczenia.

**WPA3:** najnowszy standard (2018+). Wprowadza SAE (Simultaneous Authentication of Equals) — odporna na offline dictionary attacks. WPA3 powinna być wymagana we wszystkich nowych wdrożeniach.

### Dobre praktyki bezpieczeństwa Wi-Fi

**Oddzielne sieci:** sieć firmowa dla pracowników (WPA3-Enterprise z 802.1X), sieć gości (izolowana, bez dostępu do sieci firmowej), sieć IoT (izolowana, ograniczony dostęp).

**Wyłączenie WPS (Wi-Fi Protected Setup):** WPS to funkcja ułatwiająca łączenie urządzeń przez PIN lub przycisk. Ma znane podatności (atak Reaver łamie WPS PIN w kilka godzin). WPS powinien być wyłączony.

**Ukrycie SSID:** popularne, ale praktycznie nieskuteczne. Ukryty SSID jest łatwy do odkrycia przez narzędzia jak Kismet. Nie daje realnej ochrony.

**Zmiana domyślnych haseł AP:** punkt dostępowy z domyślnym hasłem administratora (admin/admin, admin/password) to otwarte drzwi. Należy zmieniać domyślne hasła natychmiast po wdrożeniu.

**War-driving i ochrona:** Easttom opisuje war-driving jako skanowanie okolicy w poszukiwaniu otwartych lub słabo zabezpieczonych sieci Wi-Fi. Organizacja powinna regularnie sprawdzać czy w okolicy siedziby nie pojawiają się fałszywe punkty dostępowe (evil twin AP) podszywające się pod firmową sieć.

---

## DDoS — ataki na dostępność

DDoS (Distributed Denial of Service) to atak polegający na przeciążeniu zasobów serwera lub sieci tak, żeby przestał obsługiwać legalnych użytkowników.

### Typy ataków DDoS

**Volumetric attacks:** zalewanie łącza ogromną ilością ruchu. Celem jest wyczerpanie przepustowości. Skala: od setek Gbps do Tbps. Botnety (sieci zainfekowanych urządzeń) generują masowy ruch.

**Protocol attacks (np. SYN Flood):** atakujący wysyła tysiące pakietów SYN (inicjujących połączenie TCP) bez kończenia handshake. Serwer trzyma otwarte półotwarte połączenia, wyczerpując tablicę stanów. Countermeasure: SYN cookies, rate limiting.

**Application layer attacks (Layer 7):** ataki na warstwę aplikacji — pozornie legalne żądania HTTP które są bardzo kosztowne obliczeniowo dla serwera. Trudniejsze do wykrycia (ruch wygląda jak normalny).

**Amplification attacks:** atakujący wysyła małe żądanie z podrobionym IP ofiary do serwerów DNS/NTP/SSDP → serwery odpowiadają dużą odpowiedzią do ofiary. Amplifikacja ruchu 50x-100x.

### Ochrona przed DDoS

- **Upstream filtering:** dostawca internetu (ISP) lub CDN (Cloudflare, Akamai) filtruje ruch zanim dotrze do infrastruktury firmy
- **Rate limiting:** ograniczanie liczby żądań z jednego IP
- **Anycast routing:** rozproszenie ruchu na wiele lokalizacji geograficznych
- **CDN z DDoS protection:** Cloudflare, AWS Shield, Azure DDoS Protection
- **BCP38:** filtrowanie spoofowanych pakietów na routerach (egress filtering)

---

## Zarządzanie podatnościami sieciowymi

Sama konfiguracja zabezpieczeń to nie wszystko — sieć musi być regularnie testowana pod kątem podatności.

### Skanowanie podatności

**Nessus** — jeden z najpopularniejszych skanerów podatności. Automatycznie skanuje sieć, identyfikuje urządzenia i usługi, sprawdza znane podatności, generuje raporty z priorytetyzacją.

**OpenVAS** — open-source alternatywa dla Nessus. Wbudowany w Kali Linux.

**Microsoft Baseline Security Analyzer (MBSA)** — Easttom opisuje MBSA jako narzędzie do sprawdzania konfiguracji bezpieczeństwa systemów Windows: brakujące patche, słabe hasła, nieprawidłowe uprawnienia.

**Nmap** — skaner portów i usług. Easttom poświęca mu osobny podrozdział. Nmap może wykryć otwarte porty, uruchomione usługi i ich wersje, system operacyjny. Narzędzie używane przez administratorów i pentesterów.

### Podstawowe komendy Nmap (dla administratora, nie hackera)

```bash
# Skanowanie jednego hosta
nmap 192.168.1.1

# Skanowanie całej podsieci
nmap 192.168.1.0/24

# Szczegółowe informacje o usługach i wersjach
nmap -sV -sC 192.168.1.1

# Wykrywanie systemu operacyjnego (wymaga root)
sudo nmap -O 192.168.1.1

# Skanowanie top 100 portów
nmap --top-ports 100 192.168.1.0/24
```

### Shodan — wyszukiwarka urządzeń podłączonych do Internetu

Shodan to wyszukiwarka, która indeksuje urządzenia dostępne z Internetu: routery, kamery, serwery, urządzenia przemysłowe. Atakujący używają Shodana do znajdowania podatnych celów. Administratorzy powinni używać go do sprawdzania czy ich własna infrastruktura nie jest eksponowana bardziej niż powinna.

Wyszukanie własnej organizacji w Shodanie (po nazwie firmy, zakresie IP) może ujawnić zapomniane serwery, otwarte porty czy urządzenia z domyślnymi hasłami.

---

## Zarządzanie konfiguracją sieciową

### Hardening urządzeń sieciowych

Domyślna konfiguracja routerów i switchy to minimum bezpieczeństwa — producenci priorytetyzują łatwość użycia, nie bezpieczeństwo. Hardening to proces wzmacniania domyślnej konfiguracji:

**Na każdym urządzeniu sieciowym:**
- Zmień domyślne hasła (i użyj silnych haseł lub certyfikatów)
- Wyłącz niepotrzebne usługi (Telnet, HTTP, SNMP v1/v2)
- Włącz SNMPv3 lub wyłącz SNMP jeśli nie jest używany
- Ogranicz dostęp zarządzający do management VLAN lub określonych IP
- Włącz logowanie (syslog) do centralnego serwera logów
- Włącz NTP (synchronizacja czasu) — bez zsynchronizowanego czasu analiza logów z różnych urządzeń jest niemożliwa
- Wyłącz CDP/LLDP jeśli nie jest potrzebny (odkrywa topologię sieci)

**Benchmarki CIS (Center for Internet Security):** darmowe, szczegółowe przewodniki hardeningu dla konkretnych urządzeń i systemów operacyjnych. CIS Benchmark dla Cisco, Juniper, Windows, Linux — punkt startu dla każdego wdrożenia.

### Network Change Management

Każda zmiana w konfiguracji sieci powinna przechodzić przez formalny proces:
1. **Request** — wniosek o zmianę z uzasadnieniem
2. **Review** — przegląd przez architekta sieci/security
3. **Testing** — test w środowisku nieprodukcyjnym
4. **Change window** — zaplanowany czas zmiany (poza godzinami szczytu)
5. **Rollback plan** — plan cofnięcia zmiany jeśli coś pójdzie źle
6. **Documentation** — aktualizacja dokumentacji sieci

Brak change management prowadzi do „konfiguracyjnego dryfu" — stanu gdy rzeczywista konfiguracja sieci różni się od udokumentowanej, a nikt nie wie dlaczego dana reguła istnieje.

---

## Bezpieczeństwo chmury — rozszerzenie sieci firmowej

Coraz więcej organizacji przenosi infrastrukturę do chmury (AWS, Azure, GCP). Tradycyjne perimetryczne myślenie o sieci staje się nieaktualne.

### Shared Responsibility Model

Każdy dostawca chmury definiuje co jest jego odpowiedzialnością, a co klienta:

**AWS/Azure odpowiada za:** bezpieczeństwo fizyczne data center, bezpieczeństwo hiperwizora, dostępność infrastruktury.

**Klient odpowiada za:** konfigurację grup bezpieczeństwa (security groups), zarządzanie dostępem (IAM), szyfrowanie danych, konfigurację usług, monitorowanie.

**Najczęstszy błąd:** założenie, że chmura jest bezpieczna „out of the box". Najgłośniejsze wycieki danych z chmury (Capital One, Twitch, Facebook) były wynikiem błędów konfiguracyjnych, nie włamania do infrastruktury dostawcy.

### Cloud Security Posture Management (CSPM)

Narzędzia CSPM automatycznie skanują konfigurację zasobów chmurowych i wykrywają odchylenia od best practices: otwarte S3 buckety (publicznie dostępne magazyny plików), nadmiernie szerokie uprawnienia IAM, niezaszyfrowane bazy danych, brakujące logi audytowe.

Przykłady: AWS Security Hub, Microsoft Defender for Cloud, Wiz, Prisma Cloud.

---

## Disaster Recovery i ciągłość działania sieci

Bezpieczeństwo sieci to nie tylko ochrona przed atakami — to też zapewnienie dostępności (availability) gdy coś pójdzie nie tak.

### Redundancja sieciowa

**Single point of failure (SPOF):** jedno urządzenie lub łącze, którego awaria powoduje przerwy w działaniu. Należy je eliminować przez redundancję.

- **Redundantne łącza ISP:** dwa różne dostawcy internetu, dwa różne fizyczne wejścia do budynku
- **Redundantne firewalle:** active/passive HA (High Availability) — jeden firewall przejmuje ruch gdy drugi ulegnie awarii
- **Redundantne switche core:** Stack lub MLAG — dwa switche działające jako jeden logiczny
- **Redundantne zasilanie:** UPS (Uninterruptible Power Supply), agregat, dual power supply w serwerach

### RTO i RPO

- **RTO (Recovery Time Objective):** ile maksymalnie czasu zajmie przywrócenie sieci po awarii?
- **RPO (Recovery Point Objective):** ile danych maksymalnie możemy stracić? Jak stara może być ostatnia kopia backup?

Edwards podkreśla: te liczby muszą być zdefiniowane przez biznes, nie przez IT. IT dostarcza rozwiązanie techniczne — biznes decyduje ile jest w stanie zapłacić za określony poziom dostępności.

---

## Klucze do zrozumienia bezpieczeństwa sieci

Poniżej zestawienie najważniejszych zasad z rozdziału:

**1. Widoczność jest fundamentem:** nie możesz bronić tego, czego nie widzisz. Inwentaryzacja urządzeń, monitorowanie ruchu i centralizacja logów to minimum.

**2. Segmentacja ogranicza zasięg ataków:** VLAN-y, DMZ i microsegmentacja sprawiają, że skompromitowanie jednego segmentu nie oznacza kompromitacji całej sieci.

**3. Domyślne odrzucenie (Default Deny):** wszystko co nie jest jawnie dozwolone — jest zablokowane.

**4. Szyfrowanie wszędzie:** HTTP → HTTPS, Telnet → SSH, nieszyfrowane VPN → IPsec/WireGuard. Zakładamy, że atakujący widzi ruch sieciowy.

**5. Regularne testowanie:** skaner podatności, symulacje ataków DDoS, pentesty sieci. Konfiguracja która nie jest testowana — może mieć dziury, o których nie wiesz.

**6. Change management:** każda zmiana konfiguracji → formalny proces. Niekontrolowane zmiany prowadzą do konfiguracyjnego dryfu i podatności.

**7. Redundancja:** eliminacja SPOF, redundantne łącza, HA firewalle. Bezpieczeństwo obejmuje też dostępność.

---

## Terminologia — słownik modułu 4

| Termin | Definicja |
|--------|-----------|
| DMZ | Strefa pośrednia między Internetem a siecią wewnętrzną |
| VLAN | Logiczna segmentacja sieci na tym samym sprzęcie fizycznym |
| NGFW | Firewall nowej generacji z IPS, antivirus, app control |
| IDS | System wykrywania włamań (pasywny — tylko alerty) |
| IPS | System zapobiegania włamaniom (aktywny — może blokować) |
| SIEM | Platforma korelacji logów z różnych źródeł |
| NAC | Kontrola dostępu do sieci — weryfikacja urządzenia przed połączeniem |
| WAF | Firewall aplikacji webowych (chroni przed SQL injection, XSS itd.) |
| DDoS | Atak rozproszony na dostępność usługi |
| Zero Trust | Model bezpieczeństwa: „Nigdy nie ufaj, zawsze weryfikuj" |
| ZTNA | Zero Trust Network Access — dostęp do aplikacji zamiast do sieci |
| NetFlow | Protokół zbierania metadanych o połączeniach sieciowych |
| hardening | Wzmacnianie domyślnej konfiguracji systemu/urządzenia |
| CSPM | Zarządzanie postawą bezpieczeństwa w chmurze |
| RTO | Recovery Time Objective — maksymalny czas przywrócenia po awarii |
| RPO | Recovery Point Objective — maksymalna akceptowalna utrata danych |

---

*Źródła: Jason Edwards, The Cybersecurity Control Playbook (Wiley, 2025), rozdział 4; Chuck Easttom, Computer Security Fundamentals (Pearson, 2019), rozdziały 2, 7, 8; NIST SP 800-41 (Guidelines on Firewalls and Firewall Policy); CIS Benchmarks.*
