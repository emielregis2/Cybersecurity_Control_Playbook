# Moduł 8: Wzmacnianie obrony z MITRE D3FEND

**Rozdział 8 · Jason Edwards, *The Cybersecurity Control Playbook* (Wiley, 2025)**

> ATT&CK mówi jak atakujący działają. D3FEND odpowiada na pytanie: co dokładnie technicznie robi każda kontrola obronna i które techniki atakującego neutralizuje. To dwie strony tej samej monety.

---

## Czym jest MITRE D3FEND

ATT&CK opisuje co robią atakujący. Ale przez lata brakowało symetrycznego frameworku po stronie obronnej — co dokładnie robią obrońcy? Jakie techniki defensywne istnieją? Jak mapują się na techniki ofensywne z ATT&CK?

W 2021 roku MITRE, przy wsparciu NSA, opublikowało **D3FEND** (Detection, Denial, and Disruption Framework Empowering Network Defense) — ontologię technik defensywnych komplementarną do ATT&CK.

D3FEND odpowiada na kluczowe pytanie: **„Skoro atakujący używa T1055 (Process Injection) — jakie konkretne technologie defensywne i jak dokładnie tę technikę blokują lub wykrywają?"**

Baza jest dostępna pod d3fend.mitre.org i zawiera ponad 1000 technik defensywnych zorganizowanych w hierarchię podobną do ATT&CK.

### D3FEND vs ATT&CK — symetria

| Wymiar | ATT&CK | D3FEND |
|--------|--------|--------|
| Perspektywa | Atakujący | Obrońca |
| Opisuje | Techniki ofensywne | Techniki defensywne |
| Cel | Zrozumienie jak atakujący działają | Zrozumienie jak obrona działa |
| Praktyczne użycie | Threat hunting, detekcja, pentest | Dobór kontroli, architektura bezpieczeństwa |
| Integracja | Wzajemne mapowanie | Wzajemne mapowanie |

D3FEND i ATT&CK są projektowane jako komplementarne — każda technika D3FEND jest powiązana z technikami ATT&CK które neutralizuje.

---

## Struktura D3FEND: Taktyki i Techniki Defensywne

D3FEND organizuje techniki obronne w pięć głównych taktyk:

### 1. HARDEN (Utwardzanie)

Techniki zmniejszające powierzchnię ataku przez eliminację lub ograniczenie możliwości które atakujący mógłby wykorzystać. Działają **prewencyjnie** — zanim atak nastąpi.

Przykłady technik Harden:
- **Application Hardening** — usunięcie niepotrzebnych funkcji, wyłączenie makr Office, sandboxing aplikacji
- **Credential Hardening** — silne hasła, MFA, eliminacja domyślnych poświadczeń, rotacja sekretów
- **Message Hardening** — DMARC/DKIM/SPF dla e-mail, szyfrowanie wiadomości
- **Network Hardening** — segmentacja, wyłączenie niepotrzebnych protokołów, hardening routerów
- **Platform Hardening** — CIS Benchmarks, wyłączenie niepotrzebnych usług, aktualizacje
- **Application Configuration Hardening** — bezpieczna konfiguracja aplikacji webowych, baz danych

### 2. DETECT (Wykrywanie)

Techniki identyfikowania złośliwej aktywności. Wykrywanie nie zapobiega atakowi — zmniejsza czas od włamania do odkrycia (dwell time).

Przykłady technik Detect:
- **File System Monitoring** — monitoring zmian plików, FIM (File Integrity Monitoring)
- **Network Traffic Analysis** — analiza ruchu sieciowego, anomalie, NetFlow
- **Process Analysis** — monitoring procesów, wykrywanie anomalii w procesach
- **User Behavior Analysis** — UEBA, anomalie w zachowaniu użytkowników
- **Log Analysis** — korelacja logów, SIEM rules
- **Identifier Analysis** — analiza DNS, certyfikatów, URL

### 3. ISOLATE (Izolacja)

Techniki ograniczania zasięgu ataku przez tworzenie barier między komponentami systemu. Gdy atak się powiedzie — izolacja ogranicza "blast radius".

Przykłady technik Isolate:
- **Execution Isolation** — sandboxing, konteneryzacja, VM, AppArmor/SELinux
- **Network Isolation** — VLAN, firewall, mikrosegmentacja, air gap
- **DNS Isolation** — DNS sinkholes, blokowanie złośliwych domen
- **Credential Isolation** — Credential Guard, oddzielne konta dla różnych ról

### 4. DECEIVE (Zwodnicze)

Techniki dezorientowania atakującego przez tworzenie fałszywych celów i informacji. To aktywna obrona — atakujący traci czas na "fałszywe tropy".

Przykłady technik Deceive:
- **Decoy Object** — honeypoty, honeytokens, honeyfiles, honeypots, honey accounts
- **Decoy Environment** — honeynety — fałszywe środowiska sieciowe
- **Decoy Network Resource** — fałszywe udziały sieciowe, fałszywe serwery
- **Decoy User Credential** — fałszywe konta AD które nie powinny być używane — alert przy logowaniu

### 5. EVICT (Usunięcie)

Techniki usuwania atakującego z systemu po wykryciu. Faza Respond i Recover.

Przykłady technik Evict:
- **Credential Eviction** — wymuszony reset haseł, revocation tokenów, invalidacja sesji
- **Process Eviction** — zakończenie złośliwych procesów, izolacja zainfekowanego hosta
- **File Eviction** — usunięcie złośliwych plików, kwarantanna, clean reinstall
- **Network Eviction** — blokowanie C2 komunikacji, sinkhole złośliwych domen

---

## D3FEND w praktyce — mapowanie na ATT&CK

Kluczową wartością D3FEND jest bezpośrednie mapowanie technik defensywnych na techniki ofensywne ATT&CK. Sprawdźmy kilka przykładów:

### Przykład 1: T1566.001 Phishing → D3FEND

Technika ATT&CK: T1566.001 — Spearphishing Attachment

Techniki D3FEND które ją neutralizują:

**Harden:**
- **D3-AH Application Hardening:** wyłączenie makr Office (Group Policy: disable all macros), Protected View dla plików z Internetu
- **D3-MH Message Hardening:** SPF/DKIM/DMARC — weryfikacja autentyczności nadawcy e-mail
- **D3-UA User Training:** szkolenia rozpoznawania phishingu (nie jest "techniczna" w D3FEND ale jest wymieniona)

**Detect:**
- **D3-EAL Email Analysis:** sandbox dla załączników (Defender ATP, Proofpoint), analiza nagłówków e-mail
- **D3-FCOA File Content Analysis:** statyczna i dynamyczna analiza załączników

**Isolate:**
- **D3-EI Execution Isolation:** otwieranie podejrzanych plików w sandboxie (Defender Sandbox, AnyRun)

### Przykład 2: T1003.001 LSASS Memory Dump → D3FEND

Technika ATT&CK: T1003.001 — OS Credential Dumping: LSASS Memory

Techniki D3FEND:

**Harden:**
- **D3-CH Credential Hardening:** Windows Credential Guard — izolacja LSASS w wirtualnym kontenerze (Hyper-V) niedostępnym dla zwykłych procesów. Mimikatz nie może odczytać.
- **D3-LSAPH LSASS Process Hardening:** Protected Process Light (PPL) dla lsass.exe — ogranicza które procesy mogą otwierać handle do LSASS

**Detect:**
- **D3-PA Process Analysis:** monitoring procesów z dostępem do lsass.exe (Event ID 10 Sysmon), alert gdy nieznany proces otwiera handle do LSASS
- **D3-AM Audit Log Monitoring:** Event ID 4656 (handle request to lsass)

**Deceive:**
- **D3-DCE Decoy Credential:** fałszywe hashe w LSASS które wyglądają jak prawdziwe — gdy atakujący je użyje (Pass-the-Hash), system to wykrywa

### Przykład 3: T1486 Ransomware → D3FEND

Technika ATT&CK: T1486 — Data Encrypted for Impact

**Harden:**
- **D3-BDR Backup and Recovery:** regularne, przetestowane backupy offline — eliminuje motywację do zapłaty okupu
- **D3-PH Platform Hardening:** ograniczenie uprawnień do zapisu na udziałach sieciowych (least privilege)

**Detect:**
- **D3-HFD Honey File Detection:** honeyfiles — pliki-pułapki, alert gdy ransomware próbuje je zaszyfrować
- **D3-FIM File Integrity Monitoring:** alert przy masowej modyfikacji plików w krótkim czasie

**Isolate:**
- **D3-NI Network Isolation:** segmentacja — ogranicza zasięg szyfrowania do jednego segmentu

**Evict:**
- **D3-PE Process Eviction:** EDR z automatic response — izolacja hosta, zakończenie procesu szyfrującego

---

## Ontologia D3FEND — co ją odróżnia

D3FEND to nie tylko lista technik — to **ontologia** (formalna reprezentacja wiedzy z relacjami między pojęciami). Każda technika D3FEND jest opisana przez:

**Digital Artifacts:** jakie obiekty cyfrowe (pliki, procesy, połączenia, klucze rejestru) ta technika analizuje lub modyfikuje.

**How it works:** precyzyjny opis mechanizmu działania techniki.

**ATT&CK Relationships:** które techniki ATT&CK ta technika defensywna neutralizuje i w jaki sposób (blokuje, wykrywa, utrudnia).

**Technologies:** konkretne produkty i technologie które implementują tę technikę.

Ta głębokość opisu pozwala na precyzyjne dobieranie kontroli — nie "potrzebujemy EDR", ale "potrzebujemy EDR który implementuje D3-PA (Process Analysis) i D3-FIM (File Integrity Monitoring) żeby pokryć T1055 i T1486".

---

## D3FEND w architekturze bezpieczeństwa

D3FEND jest szczególnie użyteczny w fazie projektowania architektury bezpieczeństwa — przed wdrożeniem, gdy podejmujesz decyzje jakie technologie kupić i jak je skonfigurować.

### Podejście "Coverage First"

Tradycyjne podejście: "kupmy EDR od XYZ bo jest popularny". Podejście D3FEND:

1. Zidentyfikuj techniki ATT&CK które chcesz pokryć (na podstawie profilu przeciwnika)
2. W D3FEND znajdź techniki defensywne które neutralizują te ATT&CK techniki
3. Oceń jakie produkty implementują te D3FEND techniki
4. Kup produkt który daje najlepsze pokrycie dla Twoich priorytetowych technik ATT&CK

Wynik: zakup uzasadniony danymi, nie marketingiem.

### Security Architecture Review

Gdy projektujesz nowy system (np. platforma e-commerce, aplikacja mobilna), D3FEND daje listę technik defensywnych które powinny być wbudowane w architekturę:

Przykład dla aplikacji webowej:
- **D3-AH Application Hardening:** Content Security Policy (CSP), HSTS, X-Frame-Options
- **D3-OTF Outbound Traffic Filtering:** ograniczenie połączeń wychodzących z serwera aplikacji
- **D3-SCP Strong Cryptographic Protocols:** TLS 1.3, wyłączenie słabych cipher suites
- **D3-CH Credential Hardening:** bcrypt/Argon2 do hashowania haseł, brak przechowywania plaintext

---

## Aktywna obrona — techniki Deceive

Edwards poświęca w rozdziale 8 szczególne miejsce technikom Deceive — aktywnemu zwodzeniu atakującego. To niedoceniana categoria defensywna.

### Honeypoty

**Honeypot** to fałszywy system udający wartościowy cel. Atakujący atakuje honeypot zamiast prawdziwego systemu — traci czas, a obrońca zbiera cenne informacje o technikach atakującego.

Typy honeypotów:
- **Low-interaction honeypot:** emuluje usługi (np. fałszywy SSH server) bez pełnego systemu operacyjnego. Prosty w wdrożeniu, mniej informacji. Przykład: Honeyd, Kippo.
- **High-interaction honeypot:** prawdziwy system operacyjny z prawdziwymi usługami. Atakujący wierzy że atakuje prawdziwy cel. Zbiera dużo informacji, ryzykowniejszy (może być użyty jako pivot).
- **Honeypot w chmurze:** AWS/Azure oferują proste honeytoken w formie credentials które gdy użyte triggerują alert.

### Honeytokeny i Canary Tokens

**Honeytoken** to fałszywy zasób (plik, konto, klucz API, dokument) który wygląda jak wartościowy ale nie jest używany w normalnych operacjach. Każde dotknięcie honeytokena = alert.

Przykłady:
- **Fałszywy klucz AWS** w pliku konfiguracyjnym — gdy atakujący go użyje, AWS wykrywa i alarmuje
- **Fałszywe konto AD** ("backup-admin" z hasłem które wygląda jak prawdziwe) — logowanie na to konto = alert
- **Canary token w dokumencie Word** — gdy atakujący otwiera dokument, token "dzwoni do domu" (HTTP request na znany URL) — odkrycie wycieku dokumentu

**Canarytokens.org** — bezpłatne narzędzie do tworzenia honeytoken. Można wygenerować token w postaci URL, pliku Word, pliku PDF, klucza AWS, adresu e-mail. Gdy ktoś "dotknie" token — alert na e-mail. Bezpłatne, możliwe do wdrożenia w 5 minut.

### DNS Sinkhole

DNS Sinkhole to technika przekierowywania zapytań DNS do znanych złośliwych domen na kontrolowany serwer który rejestruje żądanie i zwraca odpowiedź "nie znaleziono".

Efekt: gdy zainfekowany host próbuje połączyć się z serwerem C2 (Command & Control), zapytanie DNS jest przechwycone przez sinkhole. Połączenie nie dociera do C2, a SOC dostaje alert który host próbował się łączyć.

Implementacja: Pi-hole (open-source), Quad9 (publiczny resolver z filtrowaniem), Cisco Umbrella (enterprise).

---

## Cyber Deception Platform

Dojrzałe organizacje wdrażają kompleksowe platformy deception:

**Attivo Networks (przejęty przez SentinelOne), Illusive Networks, Cameleon (TrapX)** — komercyjne platformy deception które automatycznie wdrażają dziesiątki lub setki honeytoken, honeypotów i fałszywych ścieżek w sieci.

Logika: atakujący po wejściu do sieci musi się poruszać (lateral movement). W każdym segmencie sieci są pułapki — fałszywe udziały, fałszywe serwery, fałszywe poświadczenia. Statystycznie atakujący trafi na pułapkę zanim dotrze do prawdziwego celu.

---

## Integracja D3FEND z programem bezpieczeństwa

### D3FEND jako języki RFP

Gdy firma ogłasza przetarg na narzędzie bezpieczeństwa (np. EDR), wymagania techniczne mogą być sformułowane przez pryzmat D3FEND:

*"Oferowane rozwiązanie musi implementować następujące techniki D3FEND: D3-PA (Process Analysis), D3-FIM (File Integrity Monitoring), D3-PE (Process Eviction), D3-NTF (Network Traffic Filtering) dla co najmniej następujących technik ATT&CK: T1055, T1059, T1003, T1486."*

To eliminuje "techobabble" z ofert sprzedawców i pozwala na obiektywne porównanie produktów.

### D3FEND w dokumentacji bezpieczeństwa

Polityki i procedury bezpieczeństwa mogą odwoływać się do D3FEND:
- "Backup Policy implementuje D3-BDR zgodnie z wymaganiami mitygacji T1486"
- "EDR Configuration zapewnia pokrycie D3-PA dla T1055 i T1003"

To tworzy traceable link między politykami a realnymi technikami zagrożeń.

---

## Praktyczny workflow: ATT&CK + D3FEND razem

Edwards w rozdziale 8 przedstawia kompletny workflow łączący ATT&CK i D3FEND:

```
1. THREAT INTEL
   Zidentyfikuj aktorów zagrożeń dla Twojej branży
   ↓
2. ATT&CK PROFILING  
   Pobierz TTP (techniki ATT&CK) dla tych aktorów
   ↓
3. GAP ANALYSIS (ATT&CK)
   Które techniki ATT&CK nie są pokryte przez obecne kontrole?
   ↓
4. D3FEND LOOKUP
   Dla każdej luki: jakie techniki D3FEND ją adresują?
   ↓
5. TECHNOLOGY SELECTION
   Jakie produkty implementują wymagane techniki D3FEND?
   ↓
6. IMPLEMENTATION
   Wdróż kontrole, skonfiguruj zgodnie z D3FEND
   ↓
7. VALIDATION (Purple Team / Atomic Red Team)
   Przetestuj czy wdrożona kontrola faktycznie wykrywa/blokuje technikę ATT&CK
   ↓
8. DOKUMENTACJA
   Zmapuj kontrole na ATT&CK i D3FEND w Navigator
   POWRÓĆ DO KROKU 1 (cykl ciągłego doskonalenia)
```

---

## Kluczowe wnioski z modułu 8

**1. D3FEND uzupełnia ATT&CK — razem dają pełny obraz**
ATT&CK mówi co robią atakujący. D3FEND mówi co dokładnie robią obrońcy i jak to neutralizuje konkretne ataki. Razem to kompletny framework dla threat-informed defense.

**2. Deceive to niedoceniana siła**
Honeypoty, honeytokeny, canary tokens — tanie, skuteczne, dają early warning. Każda organizacja powinna mieć przynajmniej kilka honeytoken (bezpłatne przez canarytokens.org).

**3. D3FEND precyzuje zakup i konfigurację**
Zamiast kupować "EDR" — kupujesz "EDR implementujący D3-PA i D3-FIM dla pokrycia T1055 i T1486". Precyzja eliminuje marketing i daje obiektywne kryterium wyboru.

**4. Five tactics Harden-Detect-Isolate-Deceive-Evict**
To kompletna taxonomia obrony. Program bezpieczeństwa powinien mieć kontrole we wszystkich pięciu taktykach — nie tylko Detect.

**5. Cykl ciągłego doskonalenia**
ATT&CK + D3FEND + Purple Team = pętla: znaj zagrożenia → dobierz kontrole → przetestuj → popraw. Bezpieczeństwo to maraton, nie sprint.

---

## Terminologia — słownik modułu 8

| Termin | Definicja |
|--------|-----------|
| D3FEND | MITRE framework technik defensywnych komplementarny do ATT&CK |
| Harden | Taktyka D3FEND: zmniejszanie powierzchni ataku przed incydentem |
| Detect | Taktyka D3FEND: wykrywanie złośliwej aktywności |
| Isolate | Taktyka D3FEND: ograniczanie zasięgu ataku |
| Deceive | Taktyka D3FEND: aktywne zwodzenie atakującego |
| Evict | Taktyka D3FEND: usuwanie atakującego po wykryciu |
| Honeypot | Fałszywy system udający wartościowy cel — pułapka na atakujących |
| Honeytoken | Fałszywy zasób (plik, konto, klucz) — alert gdy dotknięty |
| Canary Token | Honeytoken — token który "dzwoni do domu" gdy użyty |
| DNS Sinkhole | Przekierowanie zapytań DNS do złośliwych domen na kontrolowany serwer |
| Cyber Deception | Kompleksowe platformy automatyzujące decepcję w sieci |
| FIM | File Integrity Monitoring — monitoring zmian plików systemowych |
| Credential Guard | Windows feature izolujący LSASS w wirtualnym kontenerze |
| PPL | Protected Process Light — wzmocniona ochrona procesu LSASS |
| Ontologia | Formalna reprezentacja wiedzy z relacjami — struktura D3FEND |
| Dwell time | Czas od włamania do wykrycia — mierzony w dniach |

---

*Źródła: Jason Edwards, The Cybersecurity Control Playbook (Wiley, 2025), rozdział 8; MITRE D3FEND v1.0 (d3fend.mitre.org); NSA Cybersecurity Technical Report: D3FEND; SANS: Deception-based Threat Detection; Canarytokens.org documentation.*
