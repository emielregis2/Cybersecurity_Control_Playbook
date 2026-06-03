# Moduł 16: Awarie i odpowiedź na incydenty

**Rozdział 16 · Jason Edwards, *The Cybersecurity Control Playbook* (Wiley, 2025)**

> Incydent bezpieczeństwa zdarzy się każdej organizacji — pytanie nie brzmi "czy", tylko "kiedy". Różnica między firmą która przetrwa a tą która nie przetrwa leży w tym co zrobiła zanim incydent nastąpił.

---

## Cykl zarządzania incydentami — PICERL

Edwards w rozdziale 16 opisuje cykl życia incydentu jako sześć faz (PICERL):

**Preparation (Przygotowanie):** zanim cokolwiek się stanie — plan IR, szkolenia, narzędzia, playbooks, kontakty zewnętrzne.

**Identification (Identyfikacja):** wykrycie że coś się dzieje — alert SIEM, raport użytkownika, zewnętrzny researcher, powiadomienie od CERT.

**Containment (Ograniczenie):** zatrzymanie rozprzestrzeniania — izolacja zainfekowanych hostów, blokowanie kont, segmentacja sieci.

**Eradication (Eliminacja):** usunięcie zagrożenia — usunięcie malware, zamknięcie backdoorów, wyzerowanie skompromitowanych kont.

**Recovery (Odtworzenie):** przywrócenie normalnego działania — restore z backupów, weryfikacja czystości systemów, stopniowe przywracanie usług.

**Lessons Learned (Wnioski):** post-incident review — co zawiodło, co zadziałało, jak zapobiec w przyszłości.

---

## Przygotowanie — fundament IR

### Incident Response Plan (IRP)

IRP to formalny dokument definiujący jak organizacja reaguje na incydenty bezpieczeństwa. Kluczowe elementy:

**Definicje i klasyfikacja:**
- Co jest incydentem? (nieautoryzowany dostęp, wyciek danych, malware, DDoS)
- Severity levels: P1 (Critical), P2 (High), P3 (Medium), P4 (Low)
- Eskalacja: kto jest informowany przy jakim severity?

**Role i odpowiedzialności:**
- **Incident Commander (IC):** koordynuje całą odpowiedź, podejmuje decyzje
- **Technical Lead:** prowadzi techniczne dochodzenie
- **Communication Lead:** komunikacja wewnętrzna i zewnętrzna
- **Legal/Compliance:** ocena obowiązków regulacyjnych (RODO notification)
- **Executive Sponsor:** reprezentacja zarządu, decyzje biznesowe

**Procedury dla top scenariuszy:**
Playbooks dla najczęstszych typów incydentów:
- Ransomware
- Phishing z kompromitacją konta
- Wyciek danych (data breach)
- DDoS
- Insider threat
- Supply chain compromise

**Kontakty zewnętrzne:**
- Firma forensics/IR (pre-umowa retainer — dostępna 24/7)
- CERT Polska (+48 22 380 82 74)
- Ubezpieczyciel cyber (numer hotline)
- Kancelaria prawna specjalizująca się w RODO
- Dostawca chmury (AWS/Azure support premium)

### Retainer IR

Edwards rekomenduje **pre-incident retainer** z firmą IR. Zamiast szukać forensics firm podczas incydentu (gdy jesteś pod presją czasu), masz umowę która gwarantuje:
- Czas reakcji: 4h (remote), 24h (on-site)
- Stawki godzinowe pre-negocjowane
- Znajomość Twojego środowiska (kickoff meeting przed incydentem)
- Priorytet obsługi nad klientami bez retainera

Koszt retainera: 15 000–50 000 PLN/rok. Koszt IR bez retainera: 5–10x wyższy + opóźnienie.

### Tabletop Exercise

Regularne ćwiczenia stołowe (tabletop exercises) — symulacja incydentu w sali konferencyjnej:
1. Moderator prezentuje scenariusz krok po kroku ("Wtorek 14:30. Analityk SOC widzi alert...")
2. Zespół IR dyskutuje co by zrobili na każdym etapie
3. Moderator wprowadza nowe informacje ("Po godzinie okazuje się że...")
4. Po ćwiczeniu: omówienie gaps, aktualizacja IRP

Minimum: raz w roku. Zalecane: dwa razy w roku, różne scenariusze.

---

## Identyfikacja — wykrywanie incydentu

### Źródła wykrycia

**Alerty techniczne:** SIEM korelacja, EDR behavioural, UEBA anomalia, CSPM misconfiguration.

**Raport użytkownika:** pracownik zgłasza podejrzany e-mail, brak dostępu do plików (ransomware), dziwne zachowanie komputera.

**Zewnętrzny researcher:** ethical hacker znalazł podatność (bug bounty), CERT Polska ostrzega o kampanii.

**Klient/partner:** klient informuje że dostał phishing z Twojej domeny, partner widzi podejrzany ruch z Twoich IP.

**Threat intelligence feed:** IOC z TI matchuje w Twoich logach.

### Triage — wstępna ocena

Gdy alert wpłynie do SOC — analityk przeprowadza triage:
1. **Validate:** czy to prawdziwy incydent czy false positive?
2. **Scope:** ile systemów jest dotkniętych?
3. **Severity:** P1/P2/P3/P4?
4. **Escalate:** czy eskalować do IR team, management, legal?

**Decision tree dla severity:**
- Dane klientów dotknięte → P1
- System produkcyjny niedostępny → P1/P2 zależnie od skali
- Skompromitowane konto uprzywilejowane → P1
- Malware na stacji jednego pracownika (zawierany) → P3
- Skanowanie portów z zewnątrz → P4

---

## Containment — ograniczenie zasięgu

### Short-term Containment

Natychmiastowe działania aby zatrzymać rozprzestrzenianie, zanim pełne dochodzenie:

**Izolacja hosta przez EDR:**
CrowdStrike, SentinelOne mogą izolować host jednym kliknięciem — host traci połączenie z siecią ale zachowuje komunikację z konsolą EDR (do dalszego dochodzenia).

**Dezaktywacja kont:**
Skompromitowane konto AD → wyłącz natychmiast + revoke all sessions (Microsoft: `Revoke-MgUserSignInSession`).

**Blokada na firewallu:**
Złośliwy IP lub domena → block na NGFW, DNS sinkhole.

**Zmiana haseł:**
Wszystkie konta które mogły być skompromitowane → forced password reset.

### Long-term Containment

Po krótkim containment — bardziej kompleksowe izolowanie podczas trwania dochodzenia:
- Przeniesienie zainfekowanych systemów do dedykowanego VLAN kwarantanny
- Dual-homed jump server do analizy forensics bez ryzyka dalszego zarażenia
- Monitoring zainfekowanych systemów (nie wyłączaj! utracisz artefakty w pamięci RAM)

**Krytyczna zasada:** nie gasić zainfekowanego serwera przed zebraniem artefaktów z pamięci RAM — RAM dump zawiera procesy, połączenia sieciowe, klucze szyfrowania, hasła które znikną po wyłączeniu.

---

## Digital Forensics — zbieranie dowodów

### Order of Volatility

Zbieraj dowody od najbardziej ulotnych do najmniej ulotnych:

1. **Zawartość RAM** (znika po wyłączeniu) — procesy, połączenia, klucze, hasła
2. **Proces i połączenia sieciowe** — `ps aux`, `netstat -an`, `lsof -i`
3. **Logi systemowe** — `/var/log/`, Windows Event Log
4. **Filesystem timeline** — mtime/atime/ctime plików
5. **Disk image** — pełna kopia dysku bit-po-bicie
6. **Kopie zapasowe** — backup sprzed incydentu

**RAM dump narzędzia:** `winpmem` (Windows), LiME (Linux kernel module), Magnet RAM Capture.

**Disk imaging:** FTK Imager, `dd` (Linux), Paladin.

### Chain of Custody

Dowody cyfrowe muszą być zbierane z zachowaniem **chain of custody** — dokumentacja kto, co, kiedy zebrał i jak był przechowywany artefakt. Niezbędne jeśli sprawa trafi do sądu.

Formularz chain of custody: identyfikator dowodu, opis, kto zebrał, data/czas, metoda zbioru (hash MD5/SHA256 dla integralności), kto przechowuje.

### Timeline Analysis

Rekonstrukcja chronologii ataku przez korelację logów z różnych źródeł:
- Windows Event Log (logowania, tworzenie procesów)
- Sysmon (szczegółowe zdarzenia procesów, połączeń, rejestru)
- Proxy logs (URL requests)
- Firewall logs (połączenia sieciowe)
- EDR telemetry

Narzędzia: Plaso (log2timeline), Elastic SIEM, Splunk.

---

## Business Continuity Plan (BCP) i Disaster Recovery Plan (DRP)

### Różnica BCP vs DRP

**BCP (Business Continuity Plan):** szerszy plan utrzymania działalności biznesowej podczas i po kryzysie. Obejmuje: procesy biznesowe, komunikację, personel, alternatywne lokalizacje. Pytanie: "Jak firma funkcjonuje gdy coś pójdzie nie tak?"

**DRP (Disaster Recovery Plan):** techniczny plan odtworzenia infrastruktury IT po awarii. Podzbiór BCP. Pytanie: "Jak odtwarzamy systemy IT?"

### Kluczowe metryki

**RTO (Recovery Time Objective):** maksymalny akceptowalny czas przywrócenia systemu po awarii. Definiowany przez biznes (nie IT): "Ile godzin możemy być bez systemu rezerwacji?"

**RPO (Recovery Point Objective):** maksymalna akceptowalna utrata danych. "Ile danych możemy stracić?" = jak stary może być backup z którego przywracamy?

**MTTR (Mean Time to Recover):** średni czas odtwarzania — metryka operacyjna.

**Przykłady:**
- System płatności: RTO = 1h, RPO = 0 (brak akceptowalnej utraty transakcji)
- Portal HR: RTO = 24h, RPO = 24h (backup dzienny wystarczy)
- Strona korporacyjna: RTO = 72h, RPO = 7 dni

### Strategie DR

**Backup and Restore:** przywracanie z backupu. Najtańsze, najdłuższy RTO (godziny/dni).

**Pilot Light:** minimalna infrastruktura zawsze włączona (np. baza danych replikowana), reszta uruchamiana w razie potrzeby. RTO: godziny.

**Warm Standby:** zredukowana wersja środowiska produkcyjnego zawsze działająca. RTO: minuty-godziny.

**Multi-Site Active/Active:** pełne środowisko w dwóch lokalizacjach, ruch rozłożony. RTO: sekundy. Najdroższe.

### Testowanie DR

**Tabletop DR:** omówienie planu bez faktycznego uruchomienia.
**Functional test:** testowanie konkretnych procedur (np. failover bazy danych) w środowisku testowym.
**Full simulation:** pełny test odtwarzania produkcji — wymaga planowanego okna serwisowego.

Edwards podkreśla: **test DR co kwartał i po każdej znaczącej zmianie infrastruktury**. DRP który nie jest testowany = fikcja.

---

## Komunikacja podczas incydentu

### Komunikacja wewnętrzna

**War room:** centralne miejsce koordynacji (fizyczne lub Slack/Teams kanał dedykowany incydentowi). Tylko osoby zaangażowane — bez "obserwatorów".

**Statusy co 30-60 minut** dla zarządu w pierwszych godzinach: co wiemy, co robimy, kiedy następna aktualizacja.

**Need-to-know:** informacje o incydencie tylko dla tych którzy muszą wiedzieć. Nie informuj "całej firmy" — to komplikuje dochodzenie i może alertować insider.

### Komunikacja zewnętrzna

**Klienci i partnerzy:** gdy dotknięci incydentem — informuj proaktywnie, szybko, z konkretnymi informacjami co się stało i co robisz. Nie czekaj aż "zapytają".

**UODO (RODO):** naruszenie danych osobowych → zgłoszenie do UODO w ciągu **72 godzin** od stwierdzenia naruszenia (art. 33 RODO). Jeśli ryzyko dla osób fizycznych jest wysokie → notyfikacja osób dotkniętych (art. 34).

**Media:** jeden rzecznik prasowy, spójny przekaz, nie spekuluj. Prawnik musi zatwierdzić każde publiczne oświadczenie.

**Prawo:** incydenty z elementem przestępczym (ransomware, kradzież danych) → Policja/Prokuratura. CERT Polska — powiadomienie o incydencie jest zalecane, dla podmiotów KSC obowiązkowe.

---

## Post-Incident Review (PIR)

PIR (zwany też After-Action Review lub Lessons Learned) przeprowadzany w ciągu 2 tygodni po zamknięciu incydentu.

**Format (blameless postmortem):**
- Oś czasu incydentu (kiedy co się stało)
- Root cause analysis (dlaczego doszło do incydentu — 5 Whys)
- Co zadziałało dobrze?
- Co nie zadziałało?
- Działania naprawcze z właścicielami i terminami
- Czy IRP wymaga aktualizacji?

**Zasada blameless:** celem PIR jest poprawa systemu, nie wskazywanie winnych. Kultura blame powoduje że ludzie ukrywają błędy zamiast uczyć się z nich.

---

## Kluczowe wnioski z modułu 16

**1. Przygotowanie to inwestycja z najwyższym ROI**
Firma która ćwiczyła IR, ma playbooks i retainer, reaguje w godzinach. Firma bez przygotowania — w chaosie przez dni.

**2. Containment przed eradication**
Najpierw zatrzymaj rozprzestrzenianie, potem usuń. Odwrotna kolejność = atakujący ma czas na dalsze działania.

**3. Nie gasić serwerów przed RAM dump**
Dowody w pamięci operacyjnej znikają bezpowrotnie. Zawsze zbierz RAM dump przed wyłączeniem.

**4. 72h na zgłoszenie do UODO**
Zegar RODO tyka od momentu gdy "stwierdzasz naruszenie" — nie od momentu gdy incydent wystąpił. Dokumentuj kiedy co odkryłeś.

**5. Blameless postmortem**
Incydent to okazja do nauki. Kultura blame uniemożliwia rzeczywistą poprawę.

---

## Terminologia — słownik modułu 16

| Termin | Definicja |
|--------|-----------|
| IRP | Incident Response Plan — plan reagowania na incydenty |
| PICERL | Fazy IR: Preparation, Identification, Containment, Eradication, Recovery, Lessons Learned |
| IC | Incident Commander — koordynator odpowiedzi na incydent |
| Triage | Wstępna ocena incydentu — severity, scope, escalation |
| Containment | Ograniczenie zasięgu incydentu |
| Eradication | Usunięcie zagrożenia z systemów |
| Forensics | Cyfrowe dochodzenie — zbieranie i analiza dowodów |
| RAM Dump | Kopia zawartości pamięci operacyjnej |
| Chain of Custody | Dokumentacja zbierania i przechowywania dowodów cyfrowych |
| Order of Volatility | Kolejność zbierania dowodów od najbardziej ulotnych |
| BCP | Business Continuity Plan — plan ciągłości działania |
| DRP | Disaster Recovery Plan — plan odtwarzania IT |
| RTO | Recovery Time Objective — max czas przywrócenia systemu |
| RPO | Recovery Point Objective — max akceptowalna utrata danych |
| PIR | Post-Incident Review — analiza po incydencie |
| Retainer | Umowa z firmą IR gwarantująca priorytetową obsługę |
| Tabletop Exercise | Ćwiczenie symulacyjne bez angażowania systemów |
| War Room | Centrum dowodzenia podczas incydentu |

---

*Źródła: Jason Edwards, The Cybersecurity Control Playbook (Wiley, 2025), rozdział 16; NIST SP 800-61 Rev. 2 (Computer Security Incident Handling Guide); SANS Incident Handler's Handbook; ISO/IEC 27035 (Information Security Incident Management); CISA Incident Response Playbooks.*
