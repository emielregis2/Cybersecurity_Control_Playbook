# Moduł 3: Wdrożenie cyberbezpieczeństwa w małej firmie

**Rozdział 3 · Jason Edwards, *The Cybersecurity Control Playbook* (Wiley, 2025)**

> Małe firmy mają ten sam internet, tych samych atakujących i te same podatności co korporacje. Mają za to 10% budżetu i 5% ludzi. To nie jest wymówka — to jest kontekst, który wymaga innego podejścia.

---

## Dlaczego małe firmy są atakowane częściej niż myślisz

Powszechny mit: *„Jestem za mały żeby mnie ktoś atakował."* Edwards rozbija go na początku rozdziału 3 danymi, które nie pozostawiają złudzeń.

Według Verizon Data Breach Investigations Report 2024, **46% wszystkich naruszeń danych dotyczy małych firm** zatrudniających poniżej 1000 pracowników. Cyberprzestępcy doskonale wiedzą, że małe firmy:

- Rzadko mają dedykowany zespół bezpieczeństwa
- Nie aktualizują oprogramowania regularnie
- Nie szkolą pracowników w rozpoznawaniu zagrożeń
- Nie mają planów reagowania na incydenty
- Są często podwykonawcami lub dostawcami większych firm — i stanowią *łatwiejsze wejście* do łańcucha dostaw

To ostatnie jest kluczowe: atakujący nie atakują bezpośrednio korporacji z zabezpieczonymi perimetrami. Atakują ich dostawców, podwykonawców i partnerów — małe firmy, które mają dostęp do systemów lub danych dużego gracza, ale bez jego infrastruktury bezpieczeństwa.

Edwards cytuje SolarWinds, NotPetya i atak na Target — wszystkie trzy zaczęły się od kompromitacji mniejszego podmiotu z dostępem do środowiska docelowego. Mała firma może być bramą do czegoś znacznie większego.

---

## Unikalne wyzwania małej firmy

Zanim przejdziemy do rozwiązań, Edwards precyzuje z czym konkretnie mierzy się mała firma. To nie jest po prostu „mała wersja problemu korporacyjnego" — to jakościowo inny problem.

### Ograniczone zasoby ludzkie

Typowy scenariusz: jedna do trzech osób w IT, które obsługują helpdesk, zarządzają infrastrukturą, wdrażają systemy i „przy okazji" mają się zajmować bezpieczeństwem. W praktyce bezpieczeństwo ląduje na samym końcu listy priorytetów — bo zawsze jest coś ważniejszego: awaria drukarki, problemy z siecią, nowy pracownik do skonfigurowania.

Edwards nie krytykuje administratorów IT w małych firmach — wręcz przeciwnie, nazywa ich **„jednosobowymi armiami"**. Problem leży w strukturze: nie można oczekiwać od jednej osoby ekspertyzy w bezpieczeństwie sieci, kryptografii, zarządzaniu tożsamością, IR i compliance jednocześnie. To niemożliwe nawet przy najlepszych chęciach.

### Ograniczony budżet

Typowy budżet IT na bezpieczeństwo w małej firmie (50–200 pracowników): **20 000–80 000 PLN rocznie**. Dla porównania: jedno narzędzie EDR klasy enterprise to 100–200 PLN/endpoint/rok, SIEM to 50–200 tys. PLN rocznie, a pojedyncze szkolenie security awareness dla całego zespołu to 30–60 tys. PLN.

Ale Edwards nie mówi że to bez wyjścia. Jego teza jest odwrotna: **przy właściwym priorytetyzowaniu 50 000 PLN może kupić więcej realnej ochrony niż 500 000 PLN wydane bez strategii**.

### Niska świadomość bezpieczeństwa w zarządzie

Właściciel firmy myśli o przychodach, klientach i operacjach. Cyberbezpieczeństwo pojawia się w jego radarze dopiero gdy coś się dzieje — atak, incydent, artykuł w prasie o podobnej firmie. To naturalne, ale tworzy problem: decyzje o budżecie bezpieczeństwa są podejmowane reaktywnie (po incydencie) zamiast proaktywnie.

Zadaniem osoby odpowiedzialnej za IT w małej firmie jest zmiana tej dynamiki — i Edwards poświęca temu sporo miejsca w rozdziale 3.

### Ryzyko łańcucha dostaw

Mała firma korzysta średnio z 20–50 zewnętrznych usług SaaS, narzędzi i dostawców. Każdy z nich to potencjalny wektor ataku. Dostawca oprogramowania do fakturowania, firma hostingowa, narzędzie do e-mail marketingu, zewnętrzna księgowość z VPN do systemu ERP — wszystkie te podmioty mają mniej lub bardziej bezpośredni dostęp do danych lub systemów firmy.

Mała firma rzadko ma zasoby żeby weryfikować bezpieczeństwo każdego dostawcy. Ale powinna przynajmniej zadać minimum pytań przy wyborze i onboardingu — co Edwards formalizuje w prostej checkliście vendor security.

### Wyzwania skalowalności

Firma rosnąca z 20 do 60 pracowników w dwa lata podwaja powierzchnię ataku — ale rzadko podwaja zasoby bezpieczeństwa. Nowi pracownicy to nowe konta, nowe urządzenia, nowe zachowania ryzykowne. Nowe systemy to nowe podatności. Bez planowania bezpieczeństwo nie nadąża za wzrostem.

---

## Filozofia bezpieczeństwa dla małej firmy: mniej znaczy więcej

Edwards proponuje dla małych firm zupełnie inną filozofię niż ta stosowana w enterprise. Zamiast budować kompletny program bezpieczeństwa obejmujący wszystkie domeny — **skup się na małym zestawie kontroli z najwyższym ROI.**

Zasada Pareto w bezpieczeństwie małej firmy: **20% kontroli eliminuje 80% ryzyka.** Które 20%? Edwards identyfikuje je przez pryzmat najczęstszych wektorów ataku na małe firmy (dane FBI, CISA, Sophos):

1. **Phishing** → 68% incydentów zaczyna się od e-maila
2. **Słabe/skradzione hasła** → 61% naruszeń związanych z dostępem
3. **Niezałatane oprogramowanie** → 40% exploitów atakuje znane podatności z dostępnymi patchami
4. **Brak backupu** → ransomware skuteczne gdy nie ma możliwości odtworzenia
5. **Brak planu IR** → incydent kosztuje 3-5x więcej bez przygotowania

Kontrole adresujące te pięć wektorów mogą kosztować mniej niż 50 000 PLN rocznie i wyeliminują zdecydowaną większość ryzyk realnie zagrażających małej firmie.

---

## Priorytetowe kontrole dla małej firmy

Edwards tworzy w rozdziale 3 tabelę priorytetyzacji kontroli przez pryzmat kosztu i wpływu. Poniżej kompletna analiza każdej z nich.

### 1. Multi-Factor Authentication (MFA) — Priorytet: KRYTYCZNY

**Koszt:** Niski (wbudowane w Microsoft 365, Google Workspace; aplikacje authenticator — bezpłatne)

**Wpływ:** Wysoki — MFA blokuje ponad 99,9% ataków na konta (dane Microsoft Security Intelligence Report). Nawet jeśli hasło zostało skradzione przez phishing, atakujący bez drugiego składnika uwierzytelnienia nie dostanie się na konto.

**Gdzie wdrożyć najpierw:**
1. E-mail (priorytet absolutny — e-mail to klucz do wszystkiego innego)
2. VPN i dostęp zdalny
3. Konta administratorów systemów
4. Aplikacje finansowe i kadrowe
5. Wszystkie pozostałe usługi SaaS

**Jak wdrożyć w Microsoft 365 bez kosztów dodatkowych:**
- Azure AD — włącz Security Defaults (automatyczne MFA dla wszystkich kont)
- Microsoft Authenticator — darmowa aplikacja mobilna
- Czas wdrożenia: 2–4 godziny dla 50 użytkowników

**Typowy opór:** *„Pracownicy narzekają że to trudne."* Edwards odpowiada: jeden phishing na e-mail CEO i przelew 200 000 PLN do przestępcy. Warto?

### 2. Backup danych — Priorytet: KRYTYCZNY

**Koszt:** Średni (30–60 PLN/użytkownik/miesiąc dla rozwiązania chmurowego)

**Wpływ:** Wysoki — jedyna skuteczna odpowiedź na ransomware. Bez backupu firmy płacą okup lub tracą dane.

**Strategia 3-2-1 dla małej firmy:**
- **3** kopie danych (produkcja + 2 backup)
- **2** różne media (np. chmura + dysk zewnętrzny)
- **1** kopia offline/off-site (niedostępna z sieci produkcyjnej)

**Praktyczne rozwiązania:**
- **Microsoft 365 Backup** (wbudowany w plan E3+) — backup e-mail i SharePoint
- **Backblaze Business** — prosty, tani backup chmurowy (ok. 7 USD/komputer/miesiąc)
- **Veeam Free** — backup maszyn wirtualnych
- **Dyski zewnętrzne rotowane** — tania opcja offline backup

**Krytyczna zasada:** Backup nie istnieje dopóki nie przetestowałeś odtwarzania. Raz na kwartał przywróć losowo wybrany plik/folder i zmierz czas. Dokumentuj wyniki.

### 3. Endpoint Detection & Response (EDR) — Priorytet: WYSOKI

**Koszt:** Średni (100–200 PLN/urządzenie/rok)

**Wpływ:** Wysoki — EDR wykrywa złośliwe zachowanie *po* wejściu malware, zanim zdąży wyrządzić szkodę. Tradycyjny antywirus sygnaturowy nie wykryje zero-days i nowych wariantów. EDR wykrywa anomalne zachowanie (nowe procesy, modyfikacje rejestru, szyfrowanie plików) niezależnie od sygnatury.

**Opcje dla małej firmy:**
- **Microsoft Defender for Business** (~12 USD/user/miesiąc w Microsoft 365 Business Premium) — zintegrowany z M365, prosty w zarządzaniu
- **CrowdStrike Falcon Go** — tańsza edycja dla SMB
- **Malwarebytes ThreatDown** — dobra opcja budget, prosta konsola
- **SentinelOne Singularity Commercial** — silniejsza ochrona, wyższa cena

**Minimum viable EDR dla małej firmy:** Microsoft Defender for Business + włączony tamper protection + Cloud Protection = solidna ochrona w ramach już posiadanej licencji M365.

### 4. Zarządzanie hasłami (Password Manager) — Priorytet: WYSOKI

**Koszt:** Niski (20–50 PLN/użytkownik/rok)

**Wpływ:** Wysoki — eliminuje reuse haseł i słabe hasła. 61% naruszeń danych związanych jest z hasłami.

**Dlaczego password manager jest kluczowy:** Przeciętny pracownik ma 50–100 kont online. Bez menedżera używa 3–5 haseł do wszystkiego, z czego połowa to warianty `Firma2024!`. Jeden phishing lub jeden breach zewnętrznej usługi daje atakującemu dostęp do wszystkiego.

**Rekomendowane opcje:**
- **Bitwarden Teams** (ok. 30 PLN/user/rok) — open source, tani, audytowany
- **1Password Business** (~90 PLN/user/rok) — najprostszy UX, świetne wsparcie
- **Keeper Business** (~60 PLN/user/rok) — dobra opcja compliance

**Wdrożenie:** Generuj losowe hasła 20+ znaków dla każdego serwisu. Włącz obowiązkowy password manager przez Group Policy lub MDM. Szkolenie 30 minut na starcie = nawyk na lata.

### 5. Szkolenia Security Awareness — Priorytet: WYSOKI

**Koszt:** Niski (30–60 PLN/pracownik/rok dla platformy + symulacje phishingowe)

**Wpływ:** Średni do wysokiego — redukuje skuteczność phishingu o 60–80% przy regularnych szkoleniach

**Kluczowe elementy skutecznego programu:**

*Szkolenia awareness:* Nie PowerPoint raz w roku — to nie działa. Mikro-szkolenia 5–10 minut miesięcznie na konkretny temat (rozpoznanie phishingu, bezpieczeństwo haseł, bezpieczne zachowanie na urządzeniach mobilnych). Platformy: KnowBe4, Proofpoint Security Awareness, Sophos Phish Threat.

*Symulacje phishingowe:* Wysyłaj testowe e-maile phishingowe co 2–4 tygodnie. Pracownicy którzy klikają otrzymują natychmiastowe szkolenie (teachable moment). Mierz trend kliknięć — powinien spadać z każdym miesiącem.

*Kultura bez karania:* Pracownik który kliknął i się przyznał jest Twoim sojusznikiem. Pracownik który kliknął i się boi powiedzieć jest Twoim największym ryzykiem. Edwards podkreśla: kultura psychologicznego bezpieczeństwa przy raportowaniu incydentów jest ważniejsza niż sam program szkoleń.

### 6. Aktualizacje i zarządzanie patchami — Priorytet: WYSOKI

**Koszt:** Niski (wbudowane w systemy operacyjne; narzędzia zarządzania patchami: 20–50 PLN/urządzenie/rok)

**Wpływ:** Wysoki — 40% exploitów atakuje znane podatności z dostępnymi patchami

**Zasada Edwardsa:** Krytyczne patche bezpieczeństwa → wdrożenie w ciągu 72 godzin. Wysokie patche → 7 dni. Pozostałe → 30 dni.

**Automatyzacja dla małej firmy:**
- **Windows Update for Business** — bezpłatne, centralne zarządzanie patchami Windows przez Azure AD
- **Intune** (w Microsoft 365 Business Premium) — pełne MDM dla Windows, iOS, Android
- **ManageEngine Patch Manager Plus Free** — do 25 urządzeń bezpłatnie

**Najczęstszy błąd:** Odkładanie restartów "na potem" — patch zainstalowany ale nieaktywny. Definiuj okna maintenance i wymuszaj restart.

### 7. Segmentacja sieci WiFi — Priorytet: ŚREDNI

**Koszt:** Niski (konfiguracja routera/AP — 0–2 godziny pracy)

**Wpływ:** Średni — separacja sieci gości od sieci firmowej eliminuje jeden z najprostszych wektorów ataku

**Minimalna segmentacja dla małej firmy:**
- **VLAN firmowy:** komputery, drukarki, serwery — tylko dla pracowników
- **VLAN gości:** klienci, goście — bez dostępu do sieci firmowej
- **VLAN IoT:** kamery, smart urządzenia, systemy alarmowe — izolowane od reszty

Większość nowoczesnych routerów SMB (Cisco Meraki, Ubiquiti UniFi, Mikrotik) obsługuje VLAN i sieci gości natywnie.

### 8. Plan reagowania na incydenty (IRP) — Priorytet: WYSOKI

**Koszt:** Niski (czas: 4–8 godzin na opracowanie dokumentu)

**Wpływ:** Bardzo wysoki — organizacje z IRP reagują o 74% szybciej i ponoszą o 58% niższe koszty incydentu (IBM Cost of Data Breach Report 2025)

**Minimalne IRP dla małej firmy — 5 stron dokumentu:**

1. **Kontakty alarmowe:** kto do kogo dzwoni, w jakiej kolejności (właściciel → IT → prawnik → PR)
2. **Progi eskalacji:** kiedy angażujemy zewnętrzną firmę IR? (zaszyfrowanie > X plików, dostęp do danych klientów, przestój > Y godzin)
3. **Procedury izolacji:** jak odciąć zaatakowany system od sieci (odłącz kabel/WiFi, nie wyłączaj zasilania)
4. **Kontakt z prawnikiem i UODO:** kiedy mamy obowiązek zgłoszenia naruszenia (72h RODO)
5. **Lista zasobów do odtworzenia:** kolejność przywracania systemów po incydencie

Edwards podkreśla: **nie czekaj na incydent żeby napisać IRP.** IRP napisany w trakcie ataku to chaos. IRP napisany przed atakiem to 4–8 godzin spokojnej pracy, które mogą uratować firmę.

---

## Outsourcing bezpieczeństwa: kiedy MSSP ma sens

Dla wielu małych firm optymalnym rozwiązaniem nie jest budowanie własnych kompetencji bezpieczeństwa — ale ich outsourcing do Managed Security Service Provider (MSSP).

### Co to jest MSSP?

MSSP to firma specjalizująca się w świadczeniu usług bezpieczeństwa: monitoring 24/7, zarządzanie podatnościami, incident response, zarządzanie firewallem i endpoint, szkolenia awareness, compliance support. Działa jak zewnętrzny SOC (Security Operations Center) i zespół bezpieczeństwa w jednym.

### Kiedy MSSP ma sens dla małej firmy?

- Brak kompetencji bezpieczeństwa in-house — administrator IT nie zna się na threat hunting
- Wymagania klientów lub regulatora (certyfikacje, audyty, wymagania kontraktowe)
- Koszty budowania wewnętrznych kompetencji przewyższają koszt MSSP
- Potrzeba monitoringu 24/7 bez obsadzania dyżurów

### Czego szukać w MSSP dla małej firmy?

Edwards przygotowuje 10-punktową listę kryteriów wyboru MSSP:

**1. Doświadczenie z małymi firmami:** Wielu MSSP jest nastawionych na enterprise i nie ma oferty dla SMB. Szukaj providera z dedykowaną ofertą SMB i referencjami od firm twojej skali.

**2. SLA (Service Level Agreement):** Jakie są gwarantowane czasy reakcji? MSSP powinien gwarantować powiadomienie o incydencie w ciągu 15–30 minut i aktywną reakcję w ciągu 1–4 godzin.

**3. Skalowalność:** Usługi powinny rosnąć razem z firmą bez konieczności renegocjacji kontraktu przy każdej zmianie.

**4. Integracja z twoim stackiem:** MSSP musi integrować się z Microsoft 365 lub Google Workspace — nie możesz zmieniać infrastruktury pod MSSP.

**5. Transparentność raportowania:** Regularny raport miesięczny z incydentów, KRI, statusu podatności. Dostęp do dashboardu real-time.

**6. Certyfikacje:** SOC 2 Type II, ISO 27001 — MSSP sam musi być bezpieczny.

**7. Ceny i warunki kontraktu:** Stała miesięczna opłata (predictable cost), bez ukrytych opłat za incydenty. Elastyczne warunki wypowiedzenia.

**8. Dedykowany account manager:** Znajomość twojego środowiska to klucz do skutecznej ochrony.

**9. Proaktywność:** Czy MSSP tylko reaguje na alerty, czy aktywnie poluje na zagrożenia (threat hunting) i rekomenduje poprawy?

**10. Alignment kulturowy:** Czy MSSP rozumie twój biznes? Provider obsługujący głównie przemysł ciężki może nie rozumieć specyfiki firmy handlowej.

### Koszty MSSP dla małej firmy

Typowy zakres dla firmy 50–100 pracowników w Polsce: **3 000–8 000 PLN miesięcznie** za podstawowy pakiet (monitoring 24/7, zarządzanie endpoint, IR podstawowy). To odpowiednik 36 000–96 000 PLN rocznie — czyli prawdopodobnie mniej niż zatrudnienie dedykowanego pracownika bezpieczeństwa.

---

## Cyberbezpieczeństwo jako przewaga konkurencyjna

Edwards wprowadza w rozdziale 3 koncepcję, która dla wielu małych firm jest zupełnym przełomem: **bezpieczeństwo jako differentiator, nie jako koszt.**

W branżach gdzie dane klientów są wrażliwe (finanse, zdrowie, prawo, e-commerce, obsługa klientów korporacyjnych) — certyfikaty bezpieczeństwa i udokumentowane procedury są coraz częściej wymagane przez klientów B2B przed podpisaniem kontraktu.

**Konkretne przykłady:**
- Przetargi publiczne wymagają coraz częściej NIS2-compliance lub ISO 27001
- Korporacje wymagają od dostawców wypełnienia kwestionariusza bezpieczeństwa (SIG, CAIQ)
- Firmy finansowe wymagają od partnerów PCI DSS compliance
- Klienci z UE pytają o RODO i środki techniczne ochrony danych

Mała firma, która zainwestowała w podstawowy program bezpieczeństwa i potrafi to udokumentować, **wygrywa przetargi które inne małe firmy przegrywają**. To jest realny ROI z inwestycji w cyberbezpieczeństwo — często niewidoczny w obliczeniach kosztowych.

Edwards przytacza przykład małej firmy doradczej (30 pracowników), która dzięki certyfikacji ISO 27001 wygrała kontrakt z globalną korporacją wartości 2 mln EUR rocznie — kontrakt, do którego rywalizowały firmy 10x większe. Koszt certyfikacji ISO 27001: ~80 000 PLN. ROI: oczywisty.

---

## AI jako mnożnik siły dla małej firmy

Rozdział 3 Edwardsa poświęca oddzielną sekcję roli AI w demokratyzacji bezpieczeństwa dla małych firm. To szczególnie aktualne w 2025/2026 roku, gdy narzędzia AI stały się powszechnie dostępne.

### AI w threat detection

Platformy takie jak Microsoft Defender for Business, CrowdStrike Falcon Go czy Darktrace Essential używają ML do automatycznej identyfikacji anomalii — bez konieczności zatrudniania analityka SOC. AI analizuje wzorce zachowania użytkowników i systemów 24/7 i generuje alerty tylko przy prawdziwych anomaliach (redukcja alert fatigue).

### AI w zarządzaniu patchami

Narzędzia AI mogą automatycznie priorytetyzować patche bazując na EPSS (prawdopodobieństwo exploitacji), CVSS i kontekście środowiska. Eliminuje to ręczną analizę setek CVE przez administratora, który i tak nie ma na to czasu.

### AI w szkoleniach awareness

Platformy takie jak KnowBe4 używają AI do personalizacji szkoleń — pracownik który wielokrotnie klika w phishing dostaje więcej ćwiczeń z rozpoznawania phishingu. Platforma adaptuje trudność symulacji do poziomu każdego pracownika.

### AI w compliance i raportowaniu

Narzędzia AI mogą automatycznie skanować środowisko pod kątem zgodności z polityką bezpieczeństwa (np. wszystkie konta mają MFA? wszystkie urządzenia mają aktualne patche?) i generować raporty gotowe do audytu. Dla małej firmy bez dedykowanego compliance officera to ogromna oszczędność czasu.

### Ostrzeżenie Edwardsa dotyczące AI

Edwards jest wyważony: *"AI to mnożnik siły — ale nie zastępuje podstaw. Mała firma bez MFA, backupu i szkoleń awareness, która kupuje AI security tool, to jak zabezpieczanie fortecy najnowocześniejszym systemem alarmowym przy otwartej bramie."* AI pomaga gdy masz podstawy. Bez podstaw — daje fałszywe poczucie bezpieczeństwa.

---

## Jak przekonać właściciela/zarząd do inwestycji w bezpieczeństwo

Jeden z najbardziej praktycznych fragmentów rozdziału 3 Edwards poświęca na naukę prowadzenia rozmowy o budżecie bezpieczeństwa z właścicielem firmy lub zarządem. To umiejętność, której brakuje większości specjalistów IT.

### Czego NIE mówić (język IT)

❌ *"Mamy podatność CVE-2024-XXXX na serwerze z CVSS 9.8 i musimy zainstalować patch."*

❌ *"Potrzebujemy EDR bo nasze AV nie wykrywa zero-days."*

❌ *"Compliance NIS2 wymaga od nas wdrożenia zarządzania incydentami."*

To jest język który właściciel firmy słyszy jako: *"Potrzebujemy pieniędzy na coś technicznego, czego nie rozumiem."* I budżetu nie dostaniesz.

### Co mówić (język biznesu)

✅ *"Jeśli zostaną nam zaszyfrowane dane przez ransomware, nie będziemy w stanie obsługiwać zamówień przez tydzień. Szacowany koszt: 400 000 PLN w utraconym przychodzie + kar od klientów. Rozwiązanie które to wyeliminuje kosztuje 40 000 PLN rocznie."*

✅ *"Nasz największy klient właśnie zażądał w nowym kontrakcie potwierdzenia że mamy MFA i backupy. Bez tego stracimy kontrakt wart 600 000 PLN rocznie."*

✅ *"Pracownik kliknął w phishing, ktoś ma dostęp do jego e-maila. Bez MFA atakujący widzi całą korespondencję z klientami. Włączenie MFA zajmie 3 godziny i jest bezpłatne w naszym Microsoft 365."*

**Reguła Edwardsa:** Każdy argument za inwestycją w bezpieczeństwo musi zawierać liczbę: albo koszt incydentu, albo wartość chronionego kontraktu, albo wysokość potencjalnej kary. Liczba + kontekst biznesowy = budżet.

---

## Rekomendowane 20 kroków dla małej firmy (Edwards R3)

1. **Zacznij od higieny podstawowej** — aktualizuj wszystkie systemy; włącz automatyczne aktualizacje
2. **Użyj wbudowanych funkcji bezpieczeństwa** — firewall, antywirus, szyfrowanie dysku (BitLocker/FileVault) wbudowane w systemy
3. **Wdróż MFA wszędzie** — priorytet: e-mail, VPN, admin accounts, aplikacje finansowe
4. **Edukuj pracowników** — proste wytyczne: phishing, hasła, urządzenia mobilne; nie teorię — konkretne zasady
5. **Regularnie backupuj dane** — automatyczne kopie do chmury + offline; testuj odtwarzanie kwartalnie
6. **Używaj silnych unikalnych haseł** — wdróż menedżer haseł dla całego zespołu
7. **Korzystaj z bezpieczeństwa chmurowego** — Microsoft 365 lub Google Workspace mają wbudowane narzędzia
8. **Rozważ MSSP** — jeśli brak in-house expertise; szukaj ofert SMB z SLA
9. **Opracuj plan IR** — 5-stronicowy dokument: kto, co, kiedy, jak kontaktuje i reaguje
10. **Ogranicz uprawnienia użytkowników** — least privilege; pracownicy mają dostęp tylko do tego co potrzebują
11. **Zabezpiecz sieci WiFi** — WPA3 + oddzielna sieć dla gości
12. **Adoptuj SECaaS** — subskrypcyjne usługi bezpieczeństwa: email filtering, endpoint protection
13. **Buduj kulturę zgłaszania** — pracownicy muszą czuć że mogą zgłosić błąd bez kary
14. **Testuj odtwarzanie regularnie** — backup bez testowania to złudzenie bezpieczeństwa
15. **Polityka haseł** — minimum 12 znaków, kombinacja typów, rotacja raz w roku (lub przy kompromitacji)
16. **Zabezpiecz urządzenia mobilne** — MDM (Microsoft Intune), wymóg PIN/FaceID, możliwość zdalnego wymazania
17. **Używaj narzędzi open source** — ClamAV, OpenVPN, Snort, Suricata — dobre za darmo
18. **Monitoruj zagrożenia** — subskrybuj alerty CERT Polska, CISA, Cybersecurity News
19. **Przeglądaj konta użytkowników** — kwartalny audyt: dezaktywuj byłych pracowników i nieużywane konta
20. **Planuj skalowalność** — wybieraj narzędzia które rosną z firmą; unikaj rozwiązań "tylko dla 20 userów"

---

## Słownik pojęć (Rozdział 3)

| Termin | Definicja |
|---|---|
| **MFA** | Multi-Factor Authentication — uwierzytelnianie wieloskładnikowe, wymaga 2+ dowodów tożsamości |
| **EDR** | Endpoint Detection & Response — oprogramowanie wykrywające i reagujące na zagrożenia na urządzeniach końcowych |
| **MSSP** | Managed Security Service Provider — zewnętrzna firma świadcząca usługi bezpieczeństwa |
| **SECaaS** | Security-as-a-Service — subskrypcyjne usługi bezpieczeństwa |
| **IRP** | Incident Response Plan — plan reagowania na incydenty bezpieczeństwa |
| **SOC** | Security Operations Center — centrum monitorowania i reagowania na incydenty |
| **Least Privilege** | Zasada minimalnych uprawnień — użytkownik ma dostęp tylko do zasobów niezbędnych do pracy |
| **3-2-1 Backup** | Strategia backupu: 3 kopie, 2 media, 1 offline/off-site |
| **Phishing Simulation** | Testowe e-maile phishingowe wysyłane pracownikom w celu szkolenia i pomiaru skuteczności |
| **Patch Management** | Proces zarządzania aktualizacjami oprogramowania i systemów |
| **WPA3** | Najnowszy standard szyfrowania WiFi (Wi-Fi Protected Access 3) |
| **MDM** | Mobile Device Management — zarządzanie bezpieczeństwem urządzeń mobilnych |
| **VLAN** | Virtual Local Area Network — logiczna segmentacja sieci |
| **Air-Gapped Backup** | Kopia zapasowa fizycznie odizolowana od sieci — niedostępna dla ransomware |
| **Zero Trust** | Model bezpieczeństwa zakładający brak zaufania dla każdego użytkownika/systemu bez weryfikacji |
| **Security Hygiene** | Podstawowe praktyki bezpieczeństwa: aktualizacje, hasła, backup, szkolenia |
| **Supply Chain Risk** | Ryzyko wynikające z bezpieczeństwa dostawców i partnerów zewnętrznych |
| **Alert Fatigue** | Przeciążenie nadmierną liczbą alertów bezpieczeństwa — prowadzi do ignorowania prawdziwych zagrożeń |
| **Teachable Moment** | Szkolenie natychmiastowe po błędzie pracownika — np. kliknięciu testowego phishingu |
| **Differentiator** | Cecha odróżniająca firmę od konkurencji — bezpieczeństwo jako przewaga rynkowa |

---

*Moduł 3 kończy się tutaj. W module 4 zobaczymy jak te same zasady skalują się do średnich przedsiębiorstw (100–1000 pracowników) — gdzie masz więcej zasobów, ale też bardziej złożone środowisko, więcej regulacji i wyższe wymagania od klientów korporacyjnych.*

---

## Praktyczny roadmap wdrożenia — 90-dniowy plan dla małej firmy

Edwards zamieszcza w rozdziale 3 konkretny plan działania, który pozwala firmie bez żadnego programu bezpieczeństwa osiągnąć solidną podstawę w ciągu 90 dni — bez zatrudniania dodatkowych osób i bez ogromnego budżetu.

### Faza 1: Dni 1–30 — Fundamenty (koszt: 0–5 000 PLN)

**Tydzień 1: Inwentaryzacja i ocena**
- Spisz wszystkie urządzenia (komputery, laptopy, serwery, NAS, drukarki sieciowe, urządzenia mobilne)
- Spisz wszystkie konta i aplikacje (kto ma dostęp do czego)
- Zidentyfikuj dane krytyczne: gdzie są przechowywane dane klientów, dane finansowe, IP firmy?
- Wynik: lista aktywów i pierwsze 5 ryzyk do adresowania

**Tydzień 2: MFA i hasła**
- Włącz Security Defaults w Azure AD (automatyczne MFA dla Microsoft 365)
- Zidentyfikuj konta bez MFA — utwórz listę i ustaw deadline 14 dni
- Wdróż menedżer haseł (Bitwarden Teams lub 1Password) — onboarding dla całego zespołu
- Wynik: MFA aktywne dla 100% kont, każdy pracownik używa password managera

**Tydzień 3: Aktualizacje i podstawy endpointów**
- Włącz automatyczne aktualizacje Windows na wszystkich komputerach
- Sprawdź i zaktualizuj wszystkie aplikacje (Chrome, Adobe, Office, Java — najczęściej zaniedbywane)
- Włącz Microsoft Defender (wbudowany) z Cloud Protection i Tamper Protection
- Wynik: zero znanych podatności na aktywnych stacjach roboczych

**Tydzień 4: Backup**
- Uruchom automatyczny backup Microsoft 365 (email, OneDrive, SharePoint)
- Skonfiguruj backup lokalnych danych do chmury (Backblaze lub Azure Backup)
- Kup 2 dyski zewnętrzne dla krytycznych danych — offline backup rotowany tygodniowo
- Wynik: działający backup 3-2-1, przetestuj odtworzenie jednego pliku

**Koszt fazy 1:** Microsoft 365 Business Premium (jeśli już posiadany — 0 dodatkowych; jeśli nie — ok. 100 PLN/user/miesiąc) + Bitwarden Teams (~30 PLN/user/rok) + dyski zewnętrzne (300–500 PLN)

---

### Faza 2: Dni 31–60 — Wzmocnienie (koszt: 10 000–30 000 PLN)

**Tydzień 5–6: Segmentacja sieci i WiFi**
- Skonfiguruj oddzielną sieć WiFi dla gości (bez dostępu do sieci firmowej)
- Jeśli router to obsługuje: utwórz VLAN dla urządzeń IoT (kamery, drukarki, smart TV)
- Zmień domyślne hasła na wszystkich urządzeniach sieciowych
- Wynik: sieć gości odizolowana, urządzenia IoT w osobnym segmencie

**Tydzień 7–8: Plan IR i polityki**
- Napisz podstawowy IRP (5 stron, wzór w Appendix D książki Edwardsa)
- Napisz Politykę Haseł, Politykę Korzystania z Urządzeń Mobilnych, Politykę Pracy Zdalnej
- Zrób pierwsze szkolenie security awareness dla całego zespołu (2 godziny)
- Wynik: IRP gotowy, podstawowe polityki zatwierdzone, pracownicy przeszkoleni

**Koszt fazy 2:** Konfiguracja sieci (własna praca lub 1–2h firma sieciowa: 300–600 PLN) + platforma awareness (KnowBe4/Proofpoint): ok. 50 PLN/user/rok + czas na polityki

---

### Faza 3: Dni 61–90 — Dojrzałość (koszt: 20 000–50 000 PLN)

**Tydzień 9–10: Zaawansowana ochrona endpointów**
- Jeśli Microsoft 365 Business Premium — aktywuj Microsoft Defender for Business (pełny EDR)
- Jeśli nie — oceń alternatywy: CrowdStrike Falcon Go, Malwarebytes ThreatDown
- Skonfiguruj centralne zarządzanie przez Defender portal lub Intune
- Wynik: EDR aktywny na 100% urządzeń, alerty monitorowane

**Tydzień 11: Audyt kont i uprawnień**
- Przejrzyj wszystkie konta Active Directory / Azure AD
- Dezaktywuj konta byłych pracowników i kontrahentów
- Usuń nadmierne uprawnienia administratora (kto naprawdę potrzebuje lokalnego admina?)
- Wynik: lista aktywnych kont zgodna ze stanem zatrudnienia, least privilege wdrożone

**Tydzień 12: Pierwszy mini risk assessment**
- Używając wiedzy z modułu 2 — zidentyfikuj 10 największych ryzyk
- Stwórz uproszczony rejestr ryzyk w Excelu (ID, opis, ocena, właściciel, plan)
- Zaprezentuj zarządowi top 5 ryzyk z kosztami i planem mitigacji
- Wynik: pierwszy formalny rejestr ryzyk, zarząd poinformowany, budżet na kolejne 6 miesięcy

**Koszt fazy 3:** Microsoft Defender for Business (wliczony w M365 Business Premium) lub EDR zewnętrzny: 100–200 PLN/urządzenie/rok + czas admina

---

### Podsumowanie 90-dniowego planu

| Faza | Kluczowe działania | Szacowany koszt |
|---|---|---|
| 1–30 dni | MFA, hasła, backup, aktualizacje | 500–5 000 PLN |
| 31–60 dni | Sieć, IRP, szkolenia, polityki | 3 000–10 000 PLN |
| 61–90 dni | EDR, audyt kont, risk assessment | 10 000–30 000 PLN |
| **Łącznie** | **Solidna podstawa bezpieczeństwa** | **~15 000–45 000 PLN** |

Dla porównania: przeciętny koszt incydentu ransomware dla małej firmy w Polsce (50–200 pracowników) według danych Sophos State of Ransomware 2025: **350 000–1 200 000 PLN.** ROI z inwestycji — oczywisty.

---

## Najczęstsze błędy małych firm w cyberbezpieczeństwie

Edwards dokumentuje w rozdziale 3 pięć wzorców które regularnie widzi w małych firmach — i które są przyczyną większości incydentów.

### Błąd 1: Antywirus = bezpieczeństwo

Wiele małych firm ma poczucie bezpieczeństwa dzięki antywirusowi sygnaturowemu zainstalowanemu na komputerach. Problem: tradycyjny AV wykrywa ~50–60% złośliwego oprogramowania w testach niezależnych laboratoriów (AV-TEST). Nie wykrywa fileless malware, nowych wariantów ransomware, złośliwych makro w dokumentach Office, ani living-off-the-land attacks.

**Rozwiązanie:** AV to warstwa pierwsza, nie jedyna. MFA + backup + EDR = realna ochrona.

### Błąd 2: "Mamy backup w chmurze" (ale nigdy nie testowali odtwarzania)

Backup który nie był testowany to nie backup — to gromadzenie danych bez gwarancji przydatności w nagłej sytuacji. Edwards przytacza typowy scenariusz: firma przez 3 lata backupuje dane do chmury. Po ataku ransomware okazuje się, że backup konfiguracji jest niekompletny, serwis chmurowy zmienił API rok temu, a skrypt backupu po cichu zawodził od 8 miesięcy.

**Rozwiązanie:** Testuj odtwarzanie co kwartał. Miej checklistę z dokumentacją wyników testów.

### Błąd 3: Admin accounts = codzienne konta

Pracownicy (lub sam admin) pracują codziennie na kontach z uprawnieniami administratora lokalnego lub Domain Admin. Gdy złośliwy kod wykona się w kontekście takiego konta — ma natychmiastowy dostęp do całej infrastruktury.

**Rozwiązanie:** Zasada Least Privilege + PAW (Privileged Access Workstation) dla adminów lub przynajmniej oddzielne konto admin używane tylko gdy potrzebne.

### Błąd 4: Jeden firewall = bezpieczna sieć

Firewall na obwodzie sieci chroni przed zagrożeniami zewnętrznymi — ale nic nie zrobi gdy zagrożenie wejdzie przez phishing (e-mail), malware na pendrive lub złośliwą aktualizację oprogramowania. Większość współczesnych ataków omija firewall przez legalne protokoły (HTTPS, DNS).

**Rozwiązanie:** Defense-in-depth: firewall + segmentacja wewnętrzna + EDR na endpointach + monitoring sieci.

### Błąd 5: Polityki bezpieczeństwa tylko na papierze

Firma ma Politykę Bezpieczeństwa Informacji, Regulamin IT, Politykę Haseł — wszystkie zatwierdzone przez zarząd, wszystkie nieczytane przez pracowników, wszystkie niedostosowane do realiów firmy. Dokumenty compliance które nie zmieniają zachowań ludzi są bezużyteczne.

**Rozwiązanie:** Krótkie, czytelne polityki + onboarding każdego nowego pracownika + regularne przypomnienia + kultura bezkarnego zgłaszania błędów.

---

## Integracja z modułem 2: jak stosować risk-based approach przy ograniczonym budżecie

Małe firmy nie mogą zmitigować wszystkich ryzyk jednocześnie. Tu wraca zasada z modułu 2: **priorytetyzuj przez pryzmat wpływu na biznes, nie przez pryzmat technicznej groźności podatności**.

Edwards proponuje uproszczoną wersję risk assessment dla małej firmy — tyle ile absolutne minimum:

**Krok 1:** Zidentyfikuj 3 najcenniejsze aktywa (np. dane klientów, system fakturowania, skrzynka e-mail CEO)

**Krok 2:** Dla każdego aktywu: co by się stało gdyby zostało zaszyfrowane? Skradzione? Niedostępne przez tydzień?

**Krok 3:** Odpowiedź na te pytania = twoja lista priorytetów inwestycji bezpieczeństwa

To jest 20-minutowe ćwiczenie które daje lepszy wynik niż żaden risk assessment — a jest osiągalne dla jednoosobowego IT w małej firmie.

---

## Regulacje które dotyczą małych firm — i nie ma od nich ucieczki

Mała firma nie jest zwolniona z regulacji. Edwards wymienia kluczowe wymogi, które dotyczą większości polskich małych firm niezależnie od branży:

**RODO (GDPR):** Każda firma przetwarzająca dane osobowe klientów lub pracowników podlega RODO. Wymogi: rejestr czynności przetwarzania (RCP), odpowiednie środki techniczne i organizacyjne (art. 32), procedura zgłaszania naruszeń (72h do UODO). Brak wdrożenia → kary do 10 mln EUR lub 2% obrotu.

**Ustawa o Krajowym Systemie Cyberbezpieczeństwa (UKSC/NIS2):** Dotyczy operatorów usług kluczowych i dostawców usług cyfrowych. Rozszerzone wdrożenie NIS2 może objąć więcej podmiotów MŚP jako dostawców krytycznej infrastruktury. Warto sprawdzić czy twoja firma nie wchodzi w zakres.

**PCI DSS:** Każda firma przyjmująca płatności kartami (terminal POS, sklep internetowy) musi spełnić wymagania PCI DSS. Dla małych firm zazwyczaj Self-Assessment Questionnaire (SAQ) — ale wymogi są realne i muszą być wdrożone.

**Branżowe:** Usługi medyczne (HIPAA, krajowe regulacje), finanse (KNF, DORA), prawne (tajemnica zawodowa). Sprawdź regulacje specyficzne dla swojej branży.

---

*Moduł 3 kończy się tutaj. Następny: **Moduł 4 — Średnie przedsiębiorstwa**: kiedy masz 100–1000 pracowników, kilka lokalizacji, dedykowany zespół IT — ale wciąż daleko do budżetu enterprise.*

---

## Zabezpieczanie pracy zdalnej i urządzeń mobilnych

Praca zdalna stała się standardem dla wielu małych firm po 2020 roku i nigdy w pełni nie wróciła do modelu biurowego. Edwards poświęca osobną sekcję wyzwaniom bezpieczeństwa w modelu hybrydowym i zdalnym.

### Ryzyka pracy zdalnej specyficzne dla małej firmy

Gdy pracownik pracuje zdalnie z domu, firma traci kontrolę nad wieloma elementami środowiska:
- **Sieć domowa** — zazwyczaj słabo zabezpieczona, często współdzielona z rodziną i urządzeniami smart home
- **Urządzenia osobiste** — BYOD (Bring Your Own Device) bez MDM = zero widoczności i kontroli
- **Dostęp z niezaufanych lokalizacji** — kawiarnia, hotel, lotnisko — sieci publiczne to otwarte zaproszenie dla MITM
- **Brak fizycznej kontroli** — dokumenty wydrukowane, rozmowy przy ludziach, niezablokowany ekran

### Minimalne wymagania bezpieczeństwa dla pracownika zdalnego

Edwards proponuje checklistę którą każdy pracownik zdalny powinien spełnić:

**Urządzenia:**
- Komputer firmowy (lub osobisty z MDM i pełnym szyfrowaniem dysku — BitLocker/FileVault)
- Aktualne oprogramowanie — brak wyjątków nawet dla pracowników zdalnych
- EDR zainstalowany i aktywny
- Automatyczne blokowanie ekranu po 5 minutach bezczynności

**Sieć:**
- VPN obligatoryjny przy dostępie do systemów firmowych (nie "zalecany" — obligatoryjny)
- Zakaz korzystania z publicznych sieci WiFi bez VPN
- Hasło do domowej sieci WiFi: minimum 12 znaków, WPA2/WPA3

**Zachowania:**
- Nie drukuj dokumentów wrażliwych na prywatnych drukarkach
- Rozmowy służbowe — upewnij się że nie ma osób postronnych w pobliżu
- Blokuj komputer zawsze gdy odchodzisz — nawet na chwilę

### VPN dla małej firmy

VPN szyfruje ruch między pracownikiem zdalnym a zasobami firmowymi. Opcje dla małej firmy:

**Rozwiązania chmurowe (najprostsze):**
- **Microsoft Entra ID Application Proxy** — bezpieczny dostęp do aplikacji on-premise bez tradycyjnego VPN
- **Cloudflare Access** (w planie Zero Trust Free do 50 użytkowników — bezpłatne!) — nowoczesne podejście zero trust
- **Tailscale** — mesh VPN, prosty w konfiguracji, do 3 użytkowników bezpłatnie

**Tradycyjne VPN:**
- **OpenVPN** — open source, bezpłatny dla małych instalacji, wymaga serwera
- **WireGuard** — nowszy, szybszy protokół, bezpłatny
- **Cisco Meraki Client VPN** — jeśli już masz Meraki w sieci

### Zarządzanie urządzeniami mobilnymi (MDM)

Smartfony pracowników mają dostęp do e-maila firmowego, aplikacji biznesowych i często do firmowego OneDrive/Google Drive. Bez MDM: jeśli telefon zostanie zgubiony lub skradziony — dane firmowe są dostępne dla każdego.

**Microsoft Intune** (wliczony w Microsoft 365 Business Premium):
- Wymóg PIN/FaceID na telefonie
- Szyfrowanie danych
- Zdalne wymazanie urządzenia (remote wipe) — bez wpływu na dane osobiste pracownika
- Conditional Access: dostęp do e-maila firmowego tylko z urządzeń zarejestrowanych w MDM

Wdrożenie Intune dla 50 użytkowników: 4–8 godzin pracy IT. Efekt: kontrola nad wszystkimi urządzeniami dostającymi się do danych firmowych.

---

## Shadow IT: niewidzialny problem małych firm

Shadow IT to aplikacje i usługi używane przez pracowników bez wiedzy i zgody IT. Edwards wskazuje że w małych firmach shadow IT jest szczególnie powszechne — bo procedury są mniej formalne i nikt nie pyta przed zainstalowaniem czegoś nowego.

### Skala problemu

Badania Gartner wskazują, że średnio 30–40% aktywności IT w firmach odbywa się przez shadow IT. W małych firmach ten odsetek może być wyższy. Typowe przykłady:
- Pracownicy wysyłają pliki przez WeTransfer, Dropbox osobisty lub WhatsApp — omijając firmowe kanały
- Dział marketingu używa Canvy lub Mailchimp bez zaangażowania IT
- Handlowcy trzymają bazę klientów w Google Sheets na prywatnym koncie Google
- Pracownicy używają AI tools (ChatGPT, Claude) do pracy z danymi firmowymi bez polityki

### Ryzyko shadow IT

Każda aplikacja shadow IT to:
- Potencjalny wyciek danych (pracownik wysyła plik z danymi klientów do niekontrolowanego serwisu)
- Luka w compliance (dane w serwisach bez umowy RODO)
- Nieaktualizowane oprogramowanie (nikt nie zarządza patchami dla apki którą IT nie wie że istnieje)
- Utrata kontroli po odejściu pracownika (dane zostają na jego prywatnych kontach)

### Jak adresować shadow IT w małej firmie

Pierwsza i najważniejsza zasada Edwardsa: **nie walcz z shadow IT przez zakazywanie — walcz przez oferowanie lepszych alternatyw.** Pracownicy używają shadow IT bo narzędzia firmowe są nieporęczne lub w ogóle nie istnieją. Rozwiązanie:

1. **Zidentyfikuj potrzeby** — dlaczego pracownicy sięgają po zewnętrzne narzędzia? Co im nie daje standardowy stack?
2. **Zapewnij oficjalne alternatywy** — bezpieczny Dropbox/OneDrive z polityką dostępu, oficjalne AI policy, zatwierdzone narzędzia marketingowe
3. **Edukuj, nie karz** — pracownik który używał Dropboksa osobistego bo "nie wiedział że jest firmowy OneDrive" to błąd onboardingu, nie złośliwość
4. **Monitoruj minimalistycznie** — Microsoft 365 Defender ma funkcję wykrywania shadow apps; używaj do identyfikacji ryzyk, nie do szpiegowania

---

## Bezpieczeństwo e-commerce i płatności online

Dla firm prowadzących sklepy internetowe lub przyjmujących płatności online Edwards dodaje specyficzne wymagania.

### PCI DSS Self-Assessment Questionnaire (SAQ)

Każda firma przyjmująca płatności kartami wypełnia SAQ odpowiedni do swojego modelu:
- **SAQ A** — sklep internetowy korzystający wyłącznie z zewnętrznego procesora płatności (Stripe, Przelewy24, PayU) — najprostszy, ~30 pytań
- **SAQ A-EP** — strona wysyłająca dane karty do zewnętrznego procesora — bardziej wymagający
- **SAQ D** — firma obsługująca dane kart bezpośrednio — pełny audit, ~300 pytań

Dla małego e-commerce korzystającego z Stripe/Przelewy24 bez bezpośredniego dostępu do danych karty: SAQ A, wypełnienie zajmuje 2–4 godziny, większość wymogów jest spełniona przez samego procesora płatności.

### Bezpieczeństwo aplikacji webowej

Sklep internetowy to aplikacja webowa — i musi być zabezpieczona. Minimum dla małej firmy:
- Regularne aktualizacje platformy (WooCommerce, Magento, PrestaShop) — to najczęściej atakowany komponent
- SSL/TLS na całej stronie (nie tylko na checkout) — bezpłatny przez Let's Encrypt
- WAF (Web Application Firewall) — Cloudflare Free oferuje podstawowy WAF bezpłatnie
- Monitoring dostępności i bezpieczeństwa — UptimeRobot (bezpłatny) + Sucuri SiteCheck (bezpłatne skanowanie)

---

## Podejście do bezpieczeństwa fizycznego

Edwards przypomina że cyberbezpieczeństwo nie kończy się na granicy sieci — fizyczny dostęp do sprzętu to też wektor ataku.

### Podstawy bezpieczeństwa fizycznego dla małej firmy

- **Zamknięty serwerownik/szafa rack** — dostęp wyłącznie dla IT; klucz u konkretnej osoby
- **Szyfrowanie dysków** — BitLocker na Windows, FileVault na Mac — gdy laptop zostanie skradziony, dane są bezpieczne
- **Polityka czystego biurka** — żadnych dokumentów z danymi klientów na biurkach pod koniec dnia
- **Niszczenie dokumentów** — niszczarka (crosscut min.) dla dokumentów z danymi osobowymi lub finansowymi
- **Kamera i rejestr dostępu** — dla serwerowni i obszarów z wrażliwymi danymi
- **Kontrola dostępu gości** — goście w biurze nie powinni być pozostawieni bez opieki w obszarach z komputerami

---

## Kwantyfikacja ROI z bezpieczeństwa dla zarządu małej firmy

Podsumowując, Edwards daje w rozdziale 3 gotowy framework do kalkulacji ROI z inwestycji bezpieczeństwa — specjalnie dla właścicieli firm i zarządów małych firm.

### Formuła ROSI (Return on Security Investment)

```
ROSI = (Oczekiwana Strata z Incydentu × Redukcja Ryzyka %) – Koszt Kontroli
```

**Przykład: MFA dla 50-osobowej firmy**
- Oczekiwana strata z kompromitacji konta e-mail CEO: 80 000 PLN (BEC fraud)
- Prawdopodobieństwo zdarzenia bez MFA: 15% rocznie
- Oczekiwana roczna strata: 80 000 × 15% = 12 000 PLN
- Redukcja ryzyka przez MFA: ~99%
- Koszt MFA (Microsoft Authenticator): 0 PLN
- ROSI = (12 000 × 99%) – 0 = **+11 880 PLN rocznie**

**Przykład: Szkolenia phishing dla 50 pracowników**
- Oczekiwana strata z udanego phishingu: 200 000 PLN
- Prawdopodobieństwo bez szkoleń: 20% rocznie
- Redukcja ryzyka przez szkolenia: 60%
- Koszt szkoleń: 2 500 PLN/rok (50 PLN/user)
- ROSI = (200 000 × 20% × 60%) – 2 500 = (24 000 × 60%) – 2 500 = **21 500 PLN rocznie**

Takie obliczenia przekładają decyzję o budżecie bezpieczeństwa na język finansowy który każdy właściciel firmy rozumie.

---

*Moduł 3 zakończony. Przejdź do quizu żeby sprawdzić czy potrafisz wybrać właściwe priorytety dla małej firmy z ograniczonym budżetem.*
