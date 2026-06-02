# Case Study: ManufacturingPL S.A. — Honeypot łapie APT

**Moduł 8 · Wzmacnianie obrony z MITRE D3FEND**

---

## Kontekst organizacji

**ManufacturingPL S.A.** to producent komponentów dla branży automotive z siedzibą w Gliwicach. Zatrudnia 850 pracowników, eksportuje do 12 krajów. Kluczowa własność intelektualna: projekty CAD, procesy produkcyjne, receptury materiałów — wartość szacowana przez zarząd na 40 mln EUR.

Infrastruktura IT:
- Środowisko Windows Server (AD, Exchange on-prem)
- Systemy CAD/CAM (CATIA, SolidWorks) — stacje inżynierów
- MES (Manufacturing Execution System) — sterowanie produkcją
- ERP (SAP) — finanse, logistyka
- Sieć OT (Operational Technology) — częściowo odseparowana od IT
- Security: Trend Micro AV, Check Point Firewall, brak EDR, brak SIEM

**Kontekst zagrożeń:** sektor automotive jest regularnie atakowany przez grupy APT zainteresowane kradzieżą IP (Chiny, Rosja). ManufacturingPL jest podwykonawcą Tier-1 dla dwóch dużych OEM — atrakcyjny cel dla szpiegostwa przemysłowego.

---

## Decyzja: wdrożenie D3FEND-based defense

Nowy CISO (Joanna Wiśniewska, zatrudniona 4 miesiące wcześniej) przeprowadza assessment bezpieczeństwa. Wyniki: firma ma podstawowe kontrole (AV, firewall) ale żadnych zaawansowanych zdolności detekcji. Threat model wskazuje na ryzyko APT zainteresowanego IP.

Budżet na bezpieczeństwo: 450 000 PLN (nowy, zwiększony z 180 000).

**Podejście D3FEND:** zamiast kupować wszystko na raz, Joanna mapuje priorytetowe techniki ATT&CK (profil APT targetującego automotive: APT10, APT41) na D3FEND i wybiera kontrole o najwyższym pokryciu przy akceptowalnym koszcie.

**Priorytetowe D3FEND taktyki:**
1. **Harden** — zmniejszyć powierzchnię ataku
2. **Detect** — zbudować widoczność (EDR + SIEM)
3. **Deceive** — wdrożyć pułapki (szybko i tanio)

---

## Wdrożenie — faza po fazie

### Faza 1: Harden (miesiąc 1)

**D3-CH Credential Hardening:**
- Wymuszenie MFA dla wszystkich kont (Microsoft Authenticator)
- Wdrożenie Microsoft LAPS (rotacja haseł kont lokalnych Administrator)
- Przegląd kont serwisowych — zredukowanie z 47 do 12 (usunięcie nieużywanych)
- Włączenie Credential Guard na stacjach inżynierów (Windows 10 Enterprise)

**D3-PH Platform Hardening:**
- Wdrożenie CIS Benchmark Level 1 dla Windows 10/Server 2019
- Wyłączenie SMBv1 (podatny na EternalBlue/WannaCry) — znaleziony na 23 hostach
- Wyłączenie Telnet na wszystkich urządzeniach sieciowych
- Aktualizacja firmware routerów (zaległości 2 lata)

**D3-AH Application Hardening:**
- Wyłączenie makr Office dla wszystkich (Group Policy) — wyjątek dla działu finansowego (signed macros only)
- Włączenie Protected View dla plików z Internetu i poczty

Koszt Faza 1: 35 000 PLN (głównie czas pracy + licencje Windows Enterprise upgrade).

### Faza 2: Detect (miesiąc 2-3)

**Wdrożenie EDR (CrowdStrike Falcon):**
Pokrywa techniki D3FEND: D3-PA (Process Analysis), D3-FIM (File Integrity), D3-EI (Execution Isolation)
Koszt: 85 000 PLN/rok (850 endpointów × 100 PLN)

**Wdrożenie SIEM (Microsoft Sentinel):**
Integracja z: Active Directory, Check Point (firewall logs), Exchange (email logs), CrowdStrike (EDR alerts)
Pokrywa: D3-AM (Log Analysis), D3-UBA (User Behavior Analysis)
Koszt: 55 000 PLN/rok

**Sysmon deployment:**
Microsoft Sysinternals Sysmon na wszystkich stacjach — szczegółowe logowanie procesów, połączeń, zmian rejestru.
Koszt: 0 PLN (bezpłatny), czas wdrożenia: 3 dni.

### Faza 3: Deceive (miesiąc 2 — równolegle)

Joanna decyduje się na wdrożenie technik Deceive jako szybkiego i taniego uzupełnienia — zanim dojrzałe narzędzia Detect będą w pełni skonfigurowane.

**Canary Tokens (canarytokens.org — bezpłatne):**

Wdrożono 15 tokenów w ciągu jednego dnia:
- 3 × pliki Word "Projekty_konfidencjonalne_Q1_2026.docx" — na udziałach sieciowych z projektami CAD
- 3 × klucze AWS w pliku .env na serwerze deweloperskim
- 2 × pliki PDF "Receptury_tajne_automotive.pdf" — w folderach R&D
- 3 × tokeny w adresach e-mail (fake contact list)
- 2 × DNS tokeny — fałszywe hosty w sieci wewnętrznej
- 2 × honeykonta AD: `backup_svc_old` i `admin_test_2024` — konta które nie powinny być używane

**Konfiguracja honey accounts AD:**
```powershell
# Utwórz honeykonto
New-ADUser -Name "backup_svc_old" -AccountPassword (ConvertTo-SecureString "Welc0me123!" -AsPlainText -Force) -Enabled $true

# Ustaw atrybut SPN żeby wyglądało jak konto serwisowe
Set-ADUser backup_svc_old -ServicePrincipalNames @{Add="MSSQLSvc/fakeserver.firma.local:1433"}

# Alert w SIEM: każde logowanie na to konto = krytyczny incydent
```

Koszt Faza 3 Deceive: 0 PLN (Canary Tokens bezpłatne) + 4 godziny pracy.

---

## Incydent — 6 tygodni po wdrożeniu

### Czwartek, 23:47 — pierwszy alert

Sentinel generuje alert: **"Canary Token triggered — file accessed"**. Plik: "Projekty_konfidencjonalne_Q1_2026.docx" otwarty z hosta `WS-ENG-042` przez użytkownika `piotr.walczak`.

Alert o północy — analityk on-call (dyżur telefoniczny) odbiera SMS.

### Pierwsze 30 minut — triage

Analityk sprawdza CrowdStrike dla hosta WS-ENG-042:
- 22:15: uruchomiony PowerShell z enkodowaną komendą
- 22:18: PowerShell skanuje udziały sieciowe (`\\*\$`)
- 22:31: kopiowanie plików z `\\server-cad\projekty\` do `C:\Users\piotr.walczak\AppData\Local\Temp\`
- 23:12: próba połączenia wychodzącego na `185.220.x.x` (TOR exit node) — zablokowana przez Check Point
- 23:47: otwarcie canary token file

**Wniosek:** stacja WS-ENG-042 skompromitowana, trwa eksfiltracja projektów CAD. Canary token dał early warning.

### Działania IR

1. CrowdStrike — network contain (izolacja hosta) — 23:52
2. Wymuszone wylogowanie i reset hasła piotr.walczak — 23:58
3. Revocation tokenów MFA — 00:03
4. Sentinel hunt: czy inne hosty wykazują podobną aktywność? — 3 hosty podejrzane
5. Izolacja 3 dodatkowych hostów — 00:45
6. Kontakt z piotr.walczak (pracownik śpi) — potwierdzono że nie on był przy komputerze

### Forensics (następny dzień)

Ścieżka włamania:
- Initial Access: T1566.001 — spearphishing z złośliwym dokumentem CAD (pliku .DXF z exploitem dla starszej wersji AutoCAD)
- Execution: T1059.001 — PowerShell
- Discovery: T1083, T1135 — skanowanie plików i udziałów
- Collection: T1005 — zbieranie plików CAD
- Exfiltration: T1041 — próba przez C2 zablokowana przez firewall

**Eksfiltracja zablokowana przez firewall.** Canary token dał 95 minut wcześniejsze ostrzeżenie przed próbą eksfiltracji.

---

## Analiza: co zadziałało

### D3-DCE Decoy Credential / Decoy Object (Canary Token)

Canary token w pliku dał early warning zanim atakujący zdążył wyeksfiltrować dane. Bez honeytokena — atakujący zbierałby dane przez wiele godzin lub dni bez żadnego alertu.

**Kluczowa obserwacja:** CrowdStrike widział podejrzane procesy od 22:15. Ale analityk dyżurny nie odebrał żadnego alertu przez 1,5 godziny — alerty z EDR miały priorytet Medium i czekały na przegląd rano. Canary token wygenerował alert krytyczny który SMS-ował analityka.

### D3-NI Network Isolation (Check Point)

Próba połączenia na TOR exit node zablokowana przez Check Point — jeśli Canary Token nie wykrył, ta blokada była last line of defense.

### D3-CH Credential Hardening (Credential Guard)

Atakujący próbował dumpować LSASS — Credential Guard (wdrożony 6 tygodni wcześniej) uniemożliwił pobranie haseł w formie plaintext. Nie mógł wykonać pass-the-hash. Lateral movement ograniczony do stacji Piotra.

---

## Analiza finansowa

| Pozycja | Kwota |
|---------|-------|
| Canary Tokens (narzędzie) | 0 PLN |
| Czas wdrożenia Canary Tokens | 4h × 150 PLN = 600 PLN |
| Wdrożenie Credential Guard | ~8h × 150 PLN = 1 200 PLN |
| **Łączny koszt kontroli które wykryły/ograniczyły atak** | **~1 800 PLN** |

**Wartość potencjalnie uratowana:** projekty CAD warte 40 mln EUR. Nawet minimalne wartościowanie: 1 800 PLN vs potencjalny wyciek własności intelektualnej za miliony euro.

---

## Wnioski

**1. Deceive daje early warning który Detect może przeoczyć**
EDR widział podejrzane procesy od 22:15 — ale alert czekał na poranny przegląd. Canary token SMS-ował analityka o 23:47. Czasem najtańsza kontrola jest najskuteczniejsza.

**2. Harden przed Detect — Credential Guard ograniczył lateral movement**
Gdyby Credential Guard nie był wdrożony 6 tygodni wcześniej, atakujący mógłby wykonać pass-the-hash i dotrzeć do serwera CAD bezpośrednio. Utwardzenie zredukowało zasięg ataku.

**3. D3FEND pomógł priorytetyzować przy ograniczonym budżecie**
Joanna nie wdrożyła wszystkiego na raz — D3FEND pomógł wybrać kontrole o najwyższym coverage dla profilu APT targetującego manufacturing. Credential Guard + Canary Tokens kosztowały ~1 800 PLN i były kluczowe.

**4. Cykl ATT&CK + D3FEND + Purple Team działa**
Po incydencie ManufacturingPL przeprowadził retrospektywę: które techniki ATT&CK użył atakujący? Które kontrole D3FEND zadziałały? Które zawiodły? Wynik: roadmapa kolejnych ulepszeń.

---

## Pytania do dyskusji

1. Canary Token — prosty plik Word z tokenem — dał kluczowy alert. Jakie inne "tanie" techniki decepcji warto wdrożyć w każdej organizacji niezależnie od budżetu?

2. Analityk dyżurny otrzymał SMS ze względu na canary token, ale alerty EDR czekały do rana. Jak powinien być skonfigurowany system alertów żeby krytyczne zdarzenia zawsze docierały do człowieka w czasie rzeczywistym?

3. ManufacturingPL ma środowisko OT (maszyny produkcyjne). Jakie szczególne wyzwania bezpieczeństwa stwarza OT i które techniki D3FEND są tu szczególnie istotne?

4. Atakujący użył exploitu dla starszej wersji AutoCAD. Jak program zarządzania podatnościami powinien obejmować aplikacje specjalistyczne (CAD/CAM) które często nie są aktualizowane ze względu na certyfikacje?

---

*Przypadek opisany na podstawie syntetycznych danych. Scenariusz odzwierciedla typowe wzorce ataków APT na sektor manufacturing według raportów Mandiant 2024 i CERT Polska.*
