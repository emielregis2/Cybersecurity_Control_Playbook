# Business Case: Atak ransomware w firmie logistycznej LogiPL

**Moduł 2 · Podejście oparte na ryzyku — zastosowanie w praktyce**

---

## Kontekst organizacji

**LogiPL Sp. z o.o.** to polska firma logistyczna z siedzibą w Łodzi, zatrudniająca 280 pracowników. Obsługuje sieć magazynów w 6 miastach, operuje flotą 120 pojazdów i zarządza łańcuchem dostaw dla 40 klientów korporacyjnych — w tym trzech dużych sieci handlowych. Roczny obrót: 85 mln PLN.

Infrastruktura IT obejmuje: system TMS (Transportation Management System) SaaS, system WMS (Warehouse Management System) on-premise na własnych serwerach, ERP do zarządzania finansami i kadrami, sieć VPN dla kierowców i kierowników magazynów, 280 stacji roboczych Windows.

Dział IT: 3 osoby — Marek (kierownik IT, 42 lata, w firmie 8 lat), Piotr (administrator systemów) i Kasia (helpdesk). Budżet IT na bezpieczeństwo: 120 000 PLN rocznie, przeznaczany głównie na licencje antywirusowe, firewall UTM i wsparcie dla ERP.

---

## Zdarzenie inicjujące — czwartek, 22:47

Piotr odbiera alarm z systemu monitoringu o niezwykłej aktywności na serwerze WMS. Loguje się zdalnie i widzi to czego się bał: setki plików w folderach magazynowych mają zmienione rozszerzenia na `.locked`. Na pulpicie serwera plik tekstowy:

```
YOUR FILES ARE ENCRYPTED
Pay 180,000 USD in Bitcoin within 72 hours
Contact: [adres onion]
If you contact police or FBI - we publish your client data
```

Marek zostaje obudzony o 23:15. Do 3:00 w nocy razem z Piotrem ustalają zakres ataku: zaszyfrowane są wszystkie trzy serwery WMS (zarządzanie magazynami), serwer backupów w sieci lokalnej i cztery stacje robocze. Serwery ERP i TMS (chmurowy) są nienaruszone — atakujący nie dotarł do segmentu z ERP ani do VPN klientów.

Natychmiastowe decyzje: odcięcie serwerów WMS od sieci, powiadomienie zarządu, kontakt z firmą IR (Incident Response) — z którą, na szczęście, LogiPL podpisało umowę retainer 6 miesięcy wcześniej.

---

## Analiza przyczyn źródłowych

Zespół IR w ciągu 48 godzin ustala wektor ataku i przebieg kompromitacji:

**T-21 dni:** Pracownik magazynu w Poznaniu otwiera załącznik w e-mailu podszywającym się pod fakturę od dostawcy. Plik Excel z makro pobiera i instaluje Qakbot — loader malware.

**T-20 do T-3 dni:** Qakbot działa cicho. Zbiera hasła z przeglądarek, wykrada tokeny NTLM. Wysyła dane do C2 (Command & Control). Atakujący analizuje topologię sieci przez 3 tygodnie.

**T-3 dni:** Atakujący używa wykradzionych danych do lateral movement — porusza się przez sieć używając legalnych poświadczeń. Dociera do konta administratora domeny przez podatność w starym protokole SMBv1 na serwerze legacy.

**T-0, 20:00:** Atakujący instaluje ransomware (wariant LockBit 3.0) i ustawia timer na 2:47 rano. Równolegle kopiuje ~40 GB danych klientów na zewnętrzny serwer (double extortion).

**T-0, 22:47:** Timer odpala zaszyfrowanie. Alarm w systemie monitoringu.

### Kluczowe podatności które umożliwiły atak

| Podatność | Gdzie | Dlaczego istniała |
|---|---|---|
| Brak filtrowania makro w załącznikach email | Stacje robocze | "Klienci wysyłają pliki Excel z makro, nie możemy blokować" |
| SMBv1 aktywny na serwerze legacy | Serwer WMS-2 (stary) | Serwer z 2014 roku, wymagał SMBv1 dla starszego oprogramowania |
| Backup w tej samej sieci co serwery produkcyjne | Serwer backup | "Szybszy transfer, tańsze rozwiązanie niż backup offline" |
| Brak segmentacji sieci między stacjami a serwerami | Cała sieć | "Sieć projektowana 8 lat temu, nikt nie robił przeglądu" |
| Brak MFA na kontach administratorów | Active Directory | "Pracujemy wewnętrznie, po co MFA?" |
| Brak security awareness training | Cały personel | "Zrobiliśmy szkolenie 3 lata temu" |

---

## Koszty incydentu — pełne rozliczenie

### Koszty bezpośrednie

| Pozycja | Kwota (PLN) |
|---|---|
| Firma IR — praca 480 godzin | 240 000 |
| Nowe serwery (wymiana skompromitowanych) | 85 000 |
| Licencje EDR (Endpoint Detection & Response) | 48 000 |
| Wdrożenie MFA dla adminów i VPN | 18 000 |
| Segmentacja sieci (nowe przełączniki, konfiguracja) | 35 000 |
| Prawnicy (UODO, umowy z klientami) | 42 000 |
| Powiadomienia klientów o naruszeniu danych | 15 000 |
| **Razem koszty bezpośrednie** | **483 000** |

### Koszty pośrednie (przestój i utrata przychodów)

Systemy WMS były niedostępne przez **9 dni roboczych.** W tym czasie:
- 6 magazynów operowało na papierze lub ograniczonych procedurach awaryjnych
- 3 klientów korporacyjnych aktywowało kary umowne za opóźnienia dostaw
- 1 klient (sieć handlowa) zawiesił kontrakt na czas weryfikacji bezpieczeństwa

| Pozycja | Kwota (PLN) |
|---|---|
| Utracony przychód (9 dni × ~300K dziennie × 15% marża) | 405 000 |
| Kary umowne od 3 klientów | 180 000 |
| Nadgodziny pracowników (obsługa manualna) | 65 000 |
| Utrata kontraktu (zawieszony klient, estymacja roczna) | 1 200 000 |
| **Razem koszty pośrednie** | **1 850 000** |

### **Łączny koszt incydentu: 2 333 000 PLN**

Dla porównania: roczny budżet IT na bezpieczeństwo wynosił **120 000 PLN**. Jeden incydent kosztował **19-krotność** rocznego budżetu bezpieczeństwa.

---

## Co by się stało gdyby LogiPL stosowało risk-based approach

Przyjrzyjmy się jak wyglądałaby sytuacja LogiPL gdyby 12 miesięcy przed incydentem przeprowadzili rzetelny risk assessment.

### Krok 1: Threat Modeling — co by ujawnił?

Threat modeling dla systemu WMS metodą STRIDE ujawniłby natychmiast:
- **Spoofing:** czy możliwe jest podszywanie się pod konto admina? → Tak, brak MFA
- **Tampering:** czy możliwa jest modyfikacja danych magazynowych? → Tak, brak segmentacji
- **Repudiation:** czy mamy pełne logi audytowe? → Częściowe, retencja tylko 30 dni
- **Information Disclosure:** czy dane klientów są odpowiednio chronione? → Nie, dostępne ze stacji roboczych
- **Denial of Service:** co się stanie gdy WMS przestanie działać? → Brak BIA, nikt nie wie

Pięć pytań STRIDE, pięć czerwonych flag — w ciągu jednej sesji.

### Krok 2: Rejestr ryzyk — jak wyglądałby rok wcześniej?

Przykładowe wpisy które powinny istnieć:

| ID | Ryzyko | P | W | Ocena | Właściciel | Status |
|---|---|---|---|---|---|---|
| RISK-007 | Ransomware przez phishing | 4 | 5 | 20 | Marek IT | Brak kontroli |
| RISK-012 | Backup w tej samej sieci | 3 | 5 | 15 | Marek IT | Znane, nieadresowane |
| RISK-015 | SMBv1 na serwerze legacy | 3 | 4 | 12 | Piotr | W planie migracji |
| RISK-023 | Brak MFA na kontach admin | 4 | 4 | 16 | Marek IT | Odłożone "na potem" |
| RISK-031 | Brak segmentacji sieci | 3 | 5 | 15 | Marek IT | Brak budżetu |

**RISK-007 (ocena 20 — krytyczne)** powinno wyzwolić natychmiastowe działanie: wdrożenie szkoleń phishingowych, filtrów makro, sandbox dla e-maili.

**RISK-023 (ocena 16 — wysokie)** — MFA dla adminów. Koszt wdrożenia: 18 000 PLN. Gdyby MFA było aktywne, lateral movement przez skradzione hasła byłby zablokowany.

### Krok 3: BIA — ile kosztuje jeden dzień przestoju WMS?

Prosty arkusz BIA:
- Przychód dzienny: ~85 mln PLN / 250 dni = **340 000 PLN/dzień**
- Marża operacyjna: ~15% = **51 000 PLN/dzień** utracony przychód
- Koszty obsługi manualnej (nadgodziny): **7 000 PLN/dzień**
- Ryzyko kar umownych: **20 000 PLN/dzień** (szacunek)
- **Łączny koszt przestoju WMS: ~78 000 PLN/dzień**

Przy 9 dniach przestoju: **702 000 PLN** — i to bez utraty kontraktu.

Gdyby zarząd LogiPL znał tę liczbę rok wcześniej, decyzja o przeznaczeniu 150 000 PLN na backup offline, segmentację sieci i MFA byłaby oczywista: ROI z tych inwestycji to 702 000 / 150 000 = **4,7x tylko za jeden incydent**.

### Krok 4: Apetyt na ryzyko — rozmowa której nie było

Marek IT wiedział o większości tych ryzyk. Zgłaszał je zarządowi słownie, ale bez konkretnych liczb. Odpowiedź zarządu była standardowa: *"Bezpieczeństwo jest ważne, ale teraz ważniejsza jest ekspansja na rynek czeski. IT poradzi sobie z tym co ma."*

Gdyby Marek przyszedł do zarządu z dokumentem:

> *"Ryzyko ransomware — ocena krytyczna (20/25). Prawdopodobny koszt incydentu: 1,5–3 mln PLN. Koszt mitigacji: 150 000 PLN rocznie. Rekomendujemy wdrożenie w Q1. Proszę o decyzję zarządu co do apetytu na to ryzyko."*

Zarząd musiałby albo zaakceptować ryzyko świadomie (i to jest udokumentowane!), albo zatwierdzić budżet. Tak działa risk-based approach — przenosi decyzję tam gdzie należy: do zarządu.

---

## Reakcja po incydencie — co LogiPL zrobiło

Po zakończeniu fazy IR i przywróceniu systemów, Marek przeprowadził pełny risk assessment i zbudował od zera program bezpieczeństwa:

### Natychmiastowe działania (0–30 dni)
- Wdrożenie MFA dla wszystkich kont administratorów i VPN
- Blokada makro w załącznikach e-mail (whitelist dla zaufanych nadawców)
- Izolacja serwera legacy z SMBv1 (VLAN dedykowany, ograniczony dostęp)
- Migracja backupów: backup online + backup offline (taśmy/zewnętrzny datacenter)
- Wdrożenie EDR na wszystkich stacjach roboczych i serwerach

### Średnioterminowe działania (30–90 dni)
- Segmentacja sieci: VLAN dla serwerów WMS, VLAN dla stacji roboczych, VLAN dla urządzeń mobilnych
- Security awareness training dla wszystkich pracowników + symulacja phishingowa
- Penetration test sieci po rekonfiguracji
- Zbudowanie rejestru ryzyk (15 wpisów priorytetowych)

### Strategiczne działania (90–180 dni)
- BIA dla wszystkich krytycznych systemów
- Formalizacja procesu IR: runbooks, contact tree, umowy z zewnętrznym SOC
- Tabletop exercise z zarządem (scenariusz ransomware)
- Wdrożenie KRI dashboard: patch compliance, MFA coverage, phishing success rate

### Budżet programu bezpieczeństwa po incydencie

Zarząd zaaprobował zwiększenie budżetu bezpieczeństwa z 120 000 PLN do **480 000 PLN rocznie** — 4-krotny wzrost. Marek skomentował to gorzko: *"Żałuję, że potrzebowaliśmy incydentu który kosztował 2,3 mln żeby dostać budżet który powinniśmy mieć od lat. Ale przynajmniej teraz zarząd rozumie co to znaczy «koszt bezpieczeństwa» i «koszt jego braku»."*

---

## Lekcje dla dyrektora IT — co wziąć z tego case study

### Lekcja 1: Liczby przekonują bardziej niż argumenty techniczne

Marek mówił o "ryzyku ransomware" przez 2 lata. Nikt nie słuchał. Gdy po incydencie pokazał zarządowi tabelę: *koszt incydentu 2,3 mln PLN vs. koszt mitigacji 150 000 PLN* — cisza w sali. Zanim przedstawisz zarządowi jakiekolwiek ryzyko — policz je w złotówkach.

### Lekcja 2: Backup offline to nie "nice to have" — to podstawa BCP

Backup w tej samej sieci co systemy produkcyjne to nie backup — to dodatkowa kopia danych dla ransomware. Zasada 3-2-1: 3 kopie, 2 różne media, 1 offline (air-gapped). Koszt: 30-50 tys. PLN. Wartość: bezcenna podczas incydentu.

### Lekcja 3: Risk assessment bez właściciela to akademickie ćwiczenie

RISK-023 (brak MFA) istniało w głowie Marka od lat. Nie było w rejestrze, nie miało właściciela, nie miało terminu. Formalizacja ryzyka — nawet w prostym Excelu — zmienia charakter rozmowy z "wiemy, że powinniśmy" na "RISK-023, właściciel: Marek, termin: 2026-09-30, status: otwarte".

### Lekcja 4: Zarząd musi współtworzyć decyzje o ryzyku

Marek wziął na siebie de facto decyzję o akceptacji ryzyk których nie mógł zmitigować bez budżetu. To był błąd — nie etyczny, ale proceduralny. Risk-based approach wymaga, żeby brak budżetu na mitigację był udokumentowaną decyzją zarządu, nie milczącą akceptacją administratora IT.

### Lekcja 5: Czas reakcji jest wprost proporcjonalny do przygotowania

LogiPL miało umowę retainer z firmą IR — to skróciło czas reakcji o minimum 24 godziny. Firmy bez takiej umowy czekają na pierwszą odpowiedź IR 48-72 godziny. Przy koszcie 78 000 PLN/dzień — 2 dodatkowe dni przestoju to 156 000 PLN. Retainer IR kosztuje 20-40 tys. PLN rocznie.

---

## Pytania do refleksji (do dyskusji grupowej lub samodzielnej analizy)

1. Jak LogiPL powinno było przeprowadzić BIA rok przed incydentem? Co konkretnie powinno zawierać?

2. Gdybyś był Markiem IT i miał 15 minut na zarządzie — jak przedstawiłbyś ryzyko ransomware w sposób, który zmusiłby zarząd do działania?

3. Jakie KRI (Key Risk Indicators) powinny być monitorowane w LogiPL? Zaproponuj 5 z progami alarmowymi.

4. Dlaczego backup w tej samej sieci jest uznawany za podatność, a nie kontrolę? Jak powinien wyglądać bezpieczny backup?

5. Jak zmieniłoby się ryzyko dla LogiPL gdyby mieli wdrożony SIEM z regułami detekcji dla lateral movement i C2 communication?

---

*Ten case study oparty jest na realnych wzorcach ataków ransomware dokumentowanych przez CERT Polska, Europol i FBI w latach 2022–2025. Dane liczbowe są fikcyjne, ale oparte na rzeczywistych statystykach dla polskich firm MŚP sektora logistycznego.*

---

## Analiza pogłębiona: jak atakujący działał krok po kroku

Aby zrozumieć dlaczego konkretne kontrole by zapobiegły incydentowi, przyjrzyjmy się szczegółowo każdej fazie ataku i mapujmy ją na framework MITRE ATT&CK.

### Faza 1: Initial Access (T-21 dni)

**Co się stało:** Pracownik magazynu Marek W. (imię zmienione) otworzył e-mail z tematem „Faktura korygująca FV/2025/11/3847" z załącznikiem Excel. Plik wyglądał jak typowa korespondencja handlowa — logo dostawcy, właściwy format faktury. Makro załadowało się automatycznie.

**MITRE ATT&CK:** T1566.001 — Spearphishing Attachment, T1204.002 — Malicious File

**Kontrola która by zapobiegła:**
- Blokada automatycznego uruchamiania makro (Group Policy) — koszt: 0 PLN (konfiguracja)
- Sandbox dla załączników e-mail (np. Microsoft Defender for Office 365 Plan 2) — koszt: ~15 PLN/użytkownik/miesiąc
- Security awareness training z symulacją phishingową — koszt: ~50 PLN/pracownik/rok

**Dlaczego LogiPL tego nie miało:** Decyzja sprzed 4 lat: "Blokowanie makro blokuje pliki od klientów. Nie możemy." Nikt nie sprawdził czy faktycznie tak wiele plików od klientów wymaga makro. (Audyt post-incident pokazał: 3 z 40 klientów, i każdego można było obsłużyć inaczej.)

---

### Faza 2: Execution i Persistence (T-21 do T-10 dni)

**Co się stało:** Qakbot zainstalował się w profilu użytkownika (bez uprawnień admina — tego nie potrzebował). Nawiązał szyfrowane połączenie z C2 przez port 443 — wygląda jak normalny ruch HTTPS.

**MITRE ATT&CK:** T1059.005 — Command and Scripting Interpreter, T1071.001 — Web Protocols (C2 over HTTPS)

**Kontrola która by zapobiegła:**
- EDR (Endpoint Detection & Response) z behavioral analysis — wykrywa anomalne zachowanie procesu Excel (tworzenie nowych procesów, połączenia sieciowe z nowych lokalizacji)
- DNS filtering (np. Cisco Umbrella, Cloudflare Gateway) — blokuje komunikację z domenami C2 klasyfikowanymi jako złośliwe
- Network traffic analysis (SIEM z regułą: "excel.exe initiates network connection") — alert dla administratora

**Dlaczego LogiPL tego nie miało:** Antywirus sygnaturowy nie wykrył Qakbota (nowa odmiana, sygnatury nie aktualne). Brak EDR, brak SIEM. Qakbot działał przez 21 dni niewidoczny.

---

### Faza 3: Credential Access i Lateral Movement (T-10 do T-1)

**Co się stało:** Qakbot wyekstrahował hashe NTLM z pamięci LSASS (narzędzie Mimikatz lub podobne). Pass-the-hash na serwer WMS-2 z aktywnym SMBv1. Atakujący uzyskał dostęp do konta lokalnego admina serwera.

Z serwera WMS-2 przeprowadził Kerberoasting — wyekstrahował bilety Kerberos kont usługowych z hasłami słabymi do złamania offline. W ciągu 6 godzin złamał hasło konta svc_backup (hasło: `Backup2019!`) — konto serwisowe z uprawnieniami Domain Admin.

**MITRE ATT&CK:** T1550.002 — Pass the Hash, T1558.003 — Kerberoasting, T1078 — Valid Accounts

**Kontrole które by zapobiegły:**
- Wyłączenie SMBv1 (Microsoft zaleca od 2017 roku) — koszt: 0 PLN
- Protected Users Security Group dla kont admina — hashe NTLM nie są cachowane
- Silne hasła dla kont serwisowych (losowe 25+ znaków) + MSA/gMSA (automatyczna rotacja)
- Segmentacja sieci: stacja pracownika nie powinna mieć połączenia sieciowego z serwerem WMS
- Zasada Least Privilege: konto svc_backup nie potrzebuje uprawnień Domain Admin

---

### Faza 4: Exfiltration (T-1)

**Co się stało:** Atakujący z uprawnieniami Domain Admin zmapował dyski sieciowe zawierające dane klientów. W ciągu 4 godzin przesłał ~40 GB przez szyfrowane połączenie HTTPS na zewnętrzny serwer (MEGAsync — legalny serwis cloudowy, trudny do zablokowania przez URL filtering).

**MITRE ATT&CK:** T1041 — Exfiltration Over C2 Channel, T1048.002 — Exfiltration Over Alternative Protocol

**Kontrole które by zapobiegły:**
- DLP (Data Loss Prevention) — alerty przy masowym transferze plików przez nowe aplikacje
- Network traffic anomaly detection — 40 GB upload w 4 godziny to anomalia
- Data classification + access controls — dane klientów powinny mieć ograniczony dostęp (need-to-know)

**Obowiązki prawne które to generuje:** Transfer danych osobowych klientów poza organizację bez autoryzacji → naruszenie RODO art. 33. LogiPL miało **72 godziny** od momentu stwierdzenia naruszenia na zgłoszenie do UODO. Zgłoszono po 58 godzinach — w terminie, ale tylko dlatego że firma IR znała procedury.

---

### Faza 5: Impact — zaszyfrowanie (T-0)

**Co się stało:** LockBit 3.0 zaszyfrował pliki używając algorytmu AES-256 z kluczem RSA-4096. Klucz deszyfrujący jest tylko u atakujących. Backup online — też zaszyfrowany, bo był dostępny z konta Domain Admin.

**MITRE ATT&CK:** T1486 — Data Encrypted for Impact

**Kontrole które by zapobiegły:**
- Immutable backup (backup z flagą WORM — Write Once Read Many) — nie można nadpisać ani zaszyfrować
- Air-gapped backup (fizycznie odizolowany od sieci) — zaszyfrowanie niemożliwe
- Tiered access dla backupów: backup system nie powinien być dostępny z Domain Admin konta produkcyjnego

---

## Scenariusz alternatywny: LogiPL z dojrzałym risk-based programem

Wyobraźmy sobie LogiPL 18 miesięcy przed incydentem, gdzie Marek IT przeprowadził risk assessment i uzyskał budżet 200 000 PLN na priorytetowe inwestycje.

**Inwestycje w kolejności ROI:**

1. **MFA dla adminów i VPN** (18 000 PLN) → blokuje Pass-the-Hash i Kerberoasting
2. **Security awareness + phishing simulation** (14 000 PLN/rok) → redukuje skuteczność phishingu o 60-80%
3. **EDR na wszystkich endpoint** (48 000 PLN/rok) → wykrywa Qakbot w fazie Execution
4. **Wyłączenie SMBv1, hardening AD** (0 PLN + 40h pracy) → eliminuje jeden kluczowy wektor
5. **Immutable backup offline** (35 000 PLN) → gwarantuje odtworzenie bez płacenia okupu
6. **Segmentacja sieci** (45 000 PLN) → blokuje lateral movement
7. **Retainer IR** (20 000 PLN/rok) → skraca czas reakcji o 24-48h

**Łączny koszt: ~180 000 PLN**

Przy tym zestawie kontroli:
- Phishing dociera do pracownika → EDR wykrywa anomalne zachowanie Excel → alert → 4 godziny reakcji zamiast 21 dni kompromitacji
- Lub: phishing udaje się, Qakbot instaluje się → próba lateral movement blokowana przez segmentację sieci
- Lub: atakujący dociera do serwerów → backup offline nienaruszony → odtworzenie w 6 godzin, zero okupu, zero danych klientów u atakujących

**Oczekiwana strata przy incydencie z dobrymi kontrolami:** 80-120 000 PLN (koszt IR + przestój do 1 dnia)
**Oczekiwana strata bez kontroli (jak faktycznie):** 2 333 000 PLN

**ROI z inwestycji 180 000 PLN:** (2 333 000 - 120 000) / 180 000 = **11,7x** — w jednym incydencie.

---

## Kontekst regulacyjny: co LogiPL musiało zrobić po incydencie

### Zgłoszenie do UODO

Art. 33 RODO: zgłoszenie naruszenia do organu nadzorczego w ciągu 72 godzin od stwierdzenia. LogiPL zgłosiło incydent po 58 godzinach — w terminie. Zgłoszenie zawierało:
- Opis naruszenia i kategorie danych
- Przybliżoną liczbę poszkodowanych osób (ok. 12 000 rekordów klientów)
- Kontakt DPO (Data Protection Officer)
- Podjęte działania zaradcze
- Ryzyko dla praw i wolności osób fizycznych

### Powiadomienie osób fizycznych

Art. 34 RODO: przy wysokim ryzyku dla praw i wolności → powiadomienie osób. UODO oceniło, że ryzyko jest wysokie (dane kontaktowe + dane transakcyjne). LogiPL wysłało e-maile/listy do 12 000 osób.

**Koszt powiadomień:** 15 000 PLN — wliczony w koszty bezpośrednie incydentu.

### Potencjalne kary RODO

Przy naruszeniu art. 32 (brak odpowiednich środków bezpieczeństwa) UODO może nałożyć karę do 10 mln EUR lub 2% globalnego obrotu. LogiPL wykazało, że podjęło działania post-incident i współpracowało z organem — kara administracyjna: **85 000 PLN** (upomnienie + kara proporcjonalna).

Dla porównania: gdyby LogiPL miało wdrożony formalny program zarządzania ryzykiem i dokumentację risk assessment — UODO prawdopodobnie poprzestałoby na upomnieniu bez kary finansowej. Dokumentacja due diligence jest kluczowa.

---

*Business case oparty na syntezie rzeczywistych ataków ransomware w Polsce (dane CERT Polska, Kaspersky, Sophos State of Ransomware 2025) i metodologii analizy kosztów incydentów IBM Cost of Data Breach Report 2025.*
