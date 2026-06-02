# Case Study: FinTechPL S.A. — Atak APT wykryty dzięki ATT&CK

**Moduł 6 · MITRE ATT&CK — wprowadzenie**

---

## Kontekst organizacji

**FinTechPL S.A.** to polska firma świadcząca usługi płatnicze i pożyczkowe online. Zatrudnia 420 pracowników, przetwarza rocznie 2,8 mln transakcji. Posiada licencję KNF jako instytucja płatnicza. Obroty: 85 mln PLN.

Infrastruktura IT:
- Aplikacja webowa (frontend + API) — AWS
- Bazy danych klientów — AWS RDS (PostgreSQL)
- Back-office — serwery on-premise w Warszawie
- Active Directory on-premise, synchronizacja z Azure AD
- SOC: 2 analityków (poziom L1/L2), SIEM Splunk
- EDR: CrowdStrike Falcon na stacjach roboczych
- Brak threat intelligence feed
- Brak formalnego threat hunting programu

**Kontekst zagrożeń:** branża fintech jest targetowana przez FIN7, Carbanak i lokalne grupy cyberprzestępcze. FinTechPL nie miała tego świadomości.

---

## Incydent — przebieg

### Tydzień 1 — cichy rekonesans

Atakujący (późniejsza analiza wskazuje na grupę powiązaną z FIN11) przez 6 dni prowadzi zewnętrzny rekonesans: LinkedIn scraping pracowników, analiza DNS, skanowanie publicznych serwisów firmy przez Shodan. Żadna z tych aktywności nie jest widoczna dla FinTechPL.

Techniki ATT&CK:
- **T1591.004** — Gather Victim Org Information: Identify Roles
- **T1596.001** — Search Open Technical Databases: DNS/Passive DNS
- **T1593.001** — Search Open Websites/Domains: Social Media

### Tydzień 2, poniedziałek — Initial Access

Do 3 pracowników działu finansowego trafia e-mail podszywający się pod KNF (Komisję Nadzoru Finansowego) z informacją o "obowiązkowym audycie procedur AML". Załącznik: "Instrukcja_KNF_AML_2026.docx" — złośliwy dokument Word z makrem.

Jeden pracownik (Katarzyna W., specjalista ds. compliance) otwiera dokument i włącza makra po wyświetleniu fałszywego komunikatu "Aby wyświetlić treść, włącz edycję i makra".

Techniki ATT&CK:
- **T1566.001** — Phishing: Spearphishing Attachment
- **T1204.002** — User Execution: Malicious File
- **T1059.001** — PowerShell (makro uruchamia PowerShell)

### Tydzień 2 — Persistence i Discovery

Złośliwy kod ustanawia persistence przez harmonogram zadań Windows i klucz rejestru. Następnie wykonuje rekonesans sieci wewnętrznej: lista hostów, otwarte udziały SMB, konta AD.

Techniki ATT&CK:
- **T1053.005** — Scheduled Task/Job
- **T1547.001** — Boot or Logon Autostart: Registry Run Keys
- **T1018** — Remote System Discovery
- **T1135** — Network Share Discovery
- **T1087.002** — Account Discovery: Domain Account

CrowdStrike EDR generuje **alert o niskim priorytecie** na temat podejrzanego procesu PowerShell na stacji Katarzyny. Alert trafia do kolejki L1 — analityk taguje jako "false positive" bo stacja ma CrowdStrike i jest "zielona" w dashboard. **Krytyczny błąd.**

### Tydzień 3 — Credential Access i Lateral Movement

Atakujący używa Mimikatz (uruchomiony przez process injection w lsass.exe) do wyciągnięcia hashy haseł. Wśród skradzionych danych: hash hasła Tomasza K. — administratora AD z prawami Domain Admin.

Pass-the-hash na kontroler domeny. Atakujący ma teraz Domain Admin.

Techniki ATT&CK:
- **T1055.001** — Process Injection: DLL Injection
- **T1003.001** — OS Credential Dumping: LSASS Memory
- **T1550.002** — Use Alternate Authentication Material: Pass the Hash
- **T1021.002** — Remote Services: SMB/Windows Admin Shares

### Tydzień 4 — Collection i przygotowanie eksfiltracji

Atakujący przez 5 dni systematycznie kopiuje dane z serwerów back-office: baza klientów (imiona, nazwiska, PESEL, numery kont bankowych, historia transakcji — 285 000 rekordów), dokumenty wewnętrzne (polityki, procedury, umowy z partnerami).

Techniki ATT&CK:
- **T1005** — Data from Local System
- **T1039** — Data from Network Shared Drive
- **T1560.001** — Archive Collected Data: Archive via Utility (7zip)

### Tydzień 5 — Wykrycie przez przypadek

Analityk L2 (Piotr M.) przegląda cotygodniowy raport Splunk i zauważa anomalię: konto serwisowe `svc_backup` wykonało 847 zapytań do bazy danych w niedzielę o 3:00 w nocy. Nie jest to normalne — konto backup powinno uruchamiać się tylko w piątek wieczorem.

Piotr eskaluje. Zaczyna się incident response.

Forensics ujawnia 4 tygodnie aktywności atakującego. Ale — i to jest kluczowe — dane zostały zebrane ale **jeszcze nie eksfiltrowane**. Atak został wykryty przed ostatnim krokiem.

---

## Jak ATT&CK zmienił podejście po incydencie

FinTechPL zaangażowała zewnętrzną firmę IR specjalizującą się w ATT&CK-based threat hunting. Wyniki analizy zostały w całości zmapowane na macierz ATT&CK — powstał dokument: **„Profil ataku FinTechPL Q1 2026"** z pełną listą użytych technik.

### Gap Analysis — co zawiodło

Firma zmapowała swoje kontrole na użyte techniki atakującego:

| Technika ATT&CK | Czy była detekcja? | Problem |
|----------------|-------------------|---------|
| T1566.001 Spearphishing | Częściowo | Filtr e-mail przepuścił .docx z makrem |
| T1204.002 User Execution | Nie | Brak szkolenia — użytkownik włączył makra |
| T1059.001 PowerShell | Tak (alert L1) | Alert zlekceważony jako false positive |
| T1547.001 Registry Persistence | Nie | Brak reguły SIEM dla Run Keys |
| T1003.001 LSASS Dump | Tak (EDR) | Alert niskiego priorytetu, przeoczony |
| T1550.002 Pass-the-Hash | Nie | Brak detekcji PtH w SIEM |
| T1021.002 Lateral SMB | Nie | Brak monitoringu lateralnych połączeń |

**Wniosek Gap Analysis:** 5 z 7 technik — brak detekcji lub zlekceważone alerty. Główny problem: nie brak technologii, ale brak reguł korelacji i procesów triage'u alertów.

### Nowe podejście — ATT&CK-driven defense

FinTechPL przyjęła model obrony oparty na ATT&CK:

**Krok 1: Profil przeciwnika**
Na podstawie analizy branży fintech i threat intel — które grupy APT najczęściej atakują firmy podobne do FinTechPL? FIN7, FIN11, Carbanak. Jakie techniki ATT&CK stosują? Lista 40 technik o najwyższym priorytecie.

**Krok 2: Gap Analysis**
Dla każdej z 40 priorytetowych technik: czy mamy detekcję? Czy ją blokujemy? Wynik: 18 technik bez żadnej kontroli, 12 z niepełnym pokryciem.

**Krok 3: Priorytetyzacja**
Nie można naprawić wszystkiego naraz. Priorytety: techniki z najwyższą częstością użycia + najniższym obecnym pokryciem.

**Krok 4: Implementacja reguł**
Nowe reguły SIEM w Splunk dla każdej priorytetowej techniki. Przykład dla T1550.002 (Pass-the-Hash):
```
index=windows EventCode=4624 
Logon_Type=3 
NOT [search index=windows EventCode=4624 Logon_Type=3 | stats count by Account_Name | where count > 5]
| where Account_Name!="ANONYMOUS LOGON"
| where like(Account_Name, "%.%") OR like(Account_Name, "%$")
```

**Krok 5: Threat Hunting**
Cotygodniowe sesje threat hunting prowadzone przez L2 analityków, oparte na hipotezach ATT&CK: "Szukamy artefaktów T1055 (Process Injection) z ostatniego tygodnia".

---

## Analiza finansowa

| Kategoria | Kwota (PLN) |
|-----------|-------------|
| Zewnętrzna firma IR (3 tygodnie) | 95 000 |
| Prawnik (KNF, UODO) | 65 000 |
| Notyfikacja klientów (285 000 osób) | 180 000 |
| Nowe narzędzia i reguły SIEM | 40 000 |
| Szkolenie zespołu SOC z ATT&CK | 25 000 |
| **Suma** | **405 000** |

Dane **nie zostały eksfiltrowane** — firma uniknęła: kary UODO (~1,2 mln PLN), roszczeń klientów, utraty licencji KNF. Wczesne wykrycie (przez przypadek, ale jednak) oszczędziło FinTechPL prawdopodobnie 3–5 mln PLN.

---

## Wnioski

**1. ATT&CK to język post-mortem**
Raport z incydentu zmapowany na ATT&CK mówi więcej niż narracyjny opis ataku. Każda technika z ID to precyzyjne wskazanie gdzie i jak zawiodła obrona.

**2. Gap Analysis ujawnia ślepoty**
FinTechPL miała CrowdStrike i Splunk — dobre narzędzia. Ale bez Gap Analysis nie wiedziała że 18 z 40 priorytetowych technik nie ma żadnej detekcji.

**3. Alerty bez kontekstu są bezużyteczne**
Dwa alerty EDR zostały zlekceważone bo analitycy nie mieli kontekstu — nie wiedzieli że te techniki są częścią profilu atakującego ich branżę. Threat intel + ATT&CK profil = kontekst dla alertów.

**4. Threat hunting nie musi być drogie**
Cotygodniowe 2-godzinne sesje threat hunting przez istniejący zespół L2 — bez dodatkowego personelu. ATT&CK dostarcza gotowe hipotezy do testowania.

---

## Pytania do dyskusji

1. FinTechPL wykryła atak przez przypadek (anomalia w cotygodniowym raporcie). Jakie procesy należy wdrożyć żeby wykrycie nie zależało od przypadku?

2. Analityk L1 zlekceważył alert EDR jako "false positive". Jak system zarządzania alertami powinien być zaprojektowany żeby zapobiec takim błędom?

3. ATT&CK Gap Analysis pokazał 18 technik bez żadnej kontroli. Jak priorytetyzować — od czego zacząć?

4. Firma nie miała threat intelligence feed informującego o technikach używanych przez grupy targetujące branżę fintech. Jakie darmowe i komercyjne źródła TI warto znać?

---

*Przypadek opisany na podstawie syntetycznych danych. Scenariusz odzwierciedla typowe wzorce ataków na sektor fintech według raportów Mandiant 2024 i CERT Polska.*
