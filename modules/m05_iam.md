# Moduł 5: Zarządzanie tożsamością i dostępem (IAM)

**Rozdział 5 · Jason Edwards, *The Cybersecurity Control Playbook* (Wiley, 2025) + Chuck Easttom, *Computer Security Fundamentals* (Pearson, 2019)**

> Hasło to najsłabszy element całego systemu bezpieczeństwa — bo jest jedynym elementem zależnym wyłącznie od człowieka. Człowiek jest omylny, zapominalski, leniwy i podatny na manipulację. Dlatego hasło samo w sobie nie może być ostatnią linią obrony.

---

## Dlaczego tożsamość jest nowym perimetrem bezpieczeństwa

W poprzednim module mówiliśmy o sieci jako pierwszej linii obrony. Ale co jeśli atakujący ma ważne poświadczenia? Wtedy firewall go przepuszcza. VPN go przepuszcza. NAC go przepuszcza — bo z perspektywy systemów wygląda jak legalny użytkownik.

Verizon DBIR 2024 podaje że **86% naruszeń danych dotyczy skradzionych lub słabych poświadczeń**. Nie exploitów, nie zaawansowanego malware — po prostu ktoś zna hasło. To jest fundamentalny problem tożsamości.

Edwards w rozdziale 5 *Cybersecurity Control Playbook* stawia tezę: **„W erze chmury i pracy zdalnej tożsamość jest nowym perimetrem bezpieczeństwa."** Nie adres IP, nie lokalizacja sieciowa — ale kto i z jakim urządzeniem prosi o dostęp.

Zarządzanie tożsamością i dostępem (IAM — Identity and Access Management) to zestaw procesów, polityk i technologii, które odpowiadają na trzy pytania:
- **Kto jesteś?** (uwierzytelnienie — Authentication)
- **Co możesz robić?** (autoryzacja — Authorization)
- **Co zrobiłeś?** (audyt — Accountability)

Te trzy A tworzą fundament IAM.

---

## Uwierzytelnienie — kim jesteś?

Uwierzytelnienie to proces weryfikacji tożsamości. Systemy mogą weryfikować tożsamość przez trzy kategorie czynników:

**Coś co wiesz (Knowledge Factor):** hasło, PIN, odpowiedź na pytanie bezpieczeństwa. Najsłabszy czynnik — można ukraść, odgadnąć, wyłudzić.

**Coś co masz (Possession Factor):** token sprzętowy (YubiKey), kod SMS/TOTP z aplikacji (Google Authenticator, Microsoft Authenticator), karta inteligentna. Silniejszy — wymaga fizycznego posiadania urządzenia.

**Coś czym jesteś (Inherence Factor):** biometria — odcisk palca, rozpoznawanie twarzy, skan tęczówki, głos. Najwygodniejszy dla użytkownika, trudny do podrobienia, ale nieodwoływalny (nie możesz zmienić odcisku palca jak hasła).

### Hasła — dlaczego wciąż zawodzą

Mimo że hasła są najsłabszym ogniwem, wciąż dominują. Powód: są tanie w implementacji i zrozumiałe dla użytkowników. Ale mają fundamentalne problemy:

**Problem 1: Użytkownicy wybierają złe hasła**
Analiza 100 milionów wycieków haseł (Have I Been Pwned) pokazuje że najczęstsze hasła to: `123456`, `password`, `123456789`, `qwerty`, `hasło`. Gdy firma wymaga "złożonego hasła", użytkownicy stosują wzorce: `Haslo1!`, `Password1`, `Firma2024!`.

**Problem 2: Reużywanie haseł**
Przeciętny użytkownik ma 100+ kont internetowych i używa 5–10 haseł do wszystkich. Gdy jedno konto zostaje skompromitowane (np. LinkedIn w 2016: 164 mln haseł), atakujący próbuje tych samych haseł na innych serwisach (credential stuffing). 66% użytkowników używa tego samego hasła na wielu serwisach.

**Problem 3: Phishing kradnie hasła**
Użytkownik, który kliknie w przekonującą fałszywą stronę logowania, podaje hasło atakującemu bezpośrednio. Żadna złożoność hasła nie chroni przed phishingiem.

**Problem 4: Keyloggers i malware**
Złośliwe oprogramowanie może rejestrować naciśnięcia klawiszy i wyciągać hasła zanim zostaną zaszyfrowane.

### Polityka haseł — co naprawdę działa

Przez lata standard NIST wymagał: minimalna długość 8 znaków, wielkie litery, cyfry, znaki specjalne, zmiana co 90 dni. To podejście okazało się kontrproduktywne — użytkownicy spełniali wymagania rotacji przez wzorce: `Haslo1!` → `Haslo2!` → `Haslo3!`.

**NIST SP 800-63B (aktualizacja 2017, potwierdzona 2024) rekomenduje:**
- Minimalna długość: 8 znaków (preferowane 15+)
- Brak wymagań złożoności (wielkie/małe/cyfry/znaki) — zamiast tego długość
- **Brak obowiązkowej rotacji** chyba że istnieje dowód kompromitacji
- Sprawdzanie haseł pod kątem znanych wycieków (HIBP API)
- Brak podpowiedzi hasła i "pytań bezpieczeństwa"

Logika: `correct-horse-battery-staple` (passphrase, 28 znaków) jest silniejsze od `P@ssw0rd1!` (10 znaków, "spełnia wymagania złożoności") i znacznie łatwiejsze do zapamiętania.

### Menedżer haseł — jedyne rozsądne rozwiązanie

Jedynym sposobem na posiadanie unikalnych, silnych haseł do każdego z 100+ kont jest menedżer haseł. Użytkownik zapamiętuje jedno silne hasło główne — resztą zarządza menedżer.

**Dla firm:** Bitwarden Business, 1Password Teams, Keeper, LastPass Enterprise. Centralne zarządzanie politykami, audyt słabych haseł, emergency access.

**Dla osób prywatnych:** Bitwarden (open-source, bezpłatny), 1Password, Dashlane.

Easttom podkreśla: "najsilniejszy firewall na świecie nie pomoże jeśli administrator używa hasła 'admin123' do panelu zarządzającego."

---

## MFA — wieloskładnikowe uwierzytelnianie

MFA (Multi-Factor Authentication) wymaga co najmniej dwóch różnych czynników uwierzytelniania. Jest to **najważniejsza pojedyncza kontrola techniczna** jeśli chodzi o ochronę kont użytkowników.

Nawet jeśli atakujący zna hasło — bez drugiego czynnika (który jest przy użytkowniku) nie może się zalogować.

Według Microsoft: **MFA blokuje 99,9% automatycznych ataków na konta**. To nie jest przesada — credential stuffing, brute force, spraying ataków — wszystkie zawodzą jeśli konto ma MFA.

### Typy MFA i ich bezpieczeństwo

**SMS OTP (kod SMS):** najpopularniejszy, ale najsłabszy z form MFA. Kod wysyłany przez SMS. Podatności: SIM swapping (atakujący przekonuje operatora do przeniesienia numeru telefonu), SS7 attack (atak na protokół telekomunikacyjny), phishing w czasie rzeczywistym (atakujący przechwytuje kod na bieżąco).

**Dla firm: SMS OTP jest dopuszczalny jako lepsze niż nic, ale nie powinien być jedyną opcją MFA dla kont administracyjnych.**

**TOTP (Time-based One-Time Password):** kod generowany przez aplikację (Google Authenticator, Microsoft Authenticator, Authy). Kod zmienia się co 30 sekund, ważny przez 90 sekund. Nie wymaga zasięgu sieci komórkowej. Bezpieczniejszy niż SMS — ale wciąż podatny na phishing (użytkownik może podać kod na fałszywej stronie).

**Push notifications (Duo, Microsoft Authenticator):** aplikacja wysyła powiadomienie push na telefon, użytkownik zatwierdza/odrzuca. Wygodniejsze niż przepisywanie kodu. Podatność: MFA fatigue — atakujący wysyła dziesiątki powiadomień push licząc, że użytkownik kliknie "akceptuj" żeby to zakończyć. Mitygacja: number matching (użytkownik musi wpisać wyświetloną liczbę w aplikacji).

**FIDO2/WebAuthn (klucze sprzętowe i Passkeys):** najsilniejsza forma MFA. FIDO2 jest odporny na phishing — klucz kryptograficznie wiąże się z konkretną domeną, więc fałszywa strona nie może wyłudzić poświadczeń. YubiKey, Google Titan Key — przykłady kluczy sprzętowych.

**Passkeys** — nowszy standard oparty na FIDO2, wbudowany w systemy operacyjne (Windows Hello, Face ID, Touch ID). Zastępuje hasło + MFA jednym mechanizmem kryptograficznym. Microsoft, Google, Apple implementują passkeys aktywnie. Edwards nazywa passkeys "końcem ery haseł".

### Kiedy wymagać MFA

Absolutne minimum — MFA dla:
- Wszystkich kont administracyjnych (serwery, chmura, sieć)
- Dostępu do systemów finansowych i HR
- Dostępu przez VPN (zewnętrzni użytkownicy)
- Poczty e-mail (CEO/zarząd jako pierwsi — BEC ataki targetują konta kierownictwa)
- Menedżera haseł

Ideał — MFA dla wszystkich użytkowników, wszystkich systemów. Wyjątki (konta serwisowe, automatyzacje) wymagają alternatywnych kontroli.

---

## Autoryzacja — co możesz robić?

Uwierzytelnienie mówi: *kto jesteś*. Autoryzacja mówi: *co możesz zrobić*. To dwie różne rzeczy — użytkownik może być poprawnie uwierzytelniony, ale nie mieć uprawnień do konkretnych zasobów.

### Zasada minimalnych uprawnień (Least Privilege)

**Least Privilege** to fundament autoryzacji: każdy użytkownik, system i proces powinien mieć dostęp wyłącznie do tego, co jest niezbędne do wykonania swojej funkcji — i nic więcej.

W praktyce: pracownik działu sprzedaży potrzebuje dostępu do CRM i systemu fakturowania. Nie potrzebuje dostępu do serwera plików HR, systemu kadrowego ani konfiguracji sieci.

**Dlaczego to ważne dla bezpieczeństwa?** Gdy konto pracownika sprzedaży zostaje skompromitowane — atakujący dostaje dostęp do CRM i fakturowania. Gdyby ten pracownik miał dostęp do wszystkiego — atakujący dostaje dostęp do wszystkiego.

**W praktyce: nadmierny dostęp jest regułą, nie wyjątkiem**
- Nowi pracownicy otrzymują dostęp "jak poprzednik" bez analizy co naprawdę potrzebują
- Dostępy nie są odbierane gdy zmienia się rola pracownika
- IT daje szerszy dostęp "żeby było łatwiej" i nie było ticketów o brakujący dostęp
- Odchodzący pracownicy mają konta aktywne tygodniami po odejściu

Edwards cytuje badania: w typowej organizacji 40% kont ma więcej uprawnień niż potrzeba. 20% kont odchodzących pracowników jest aktywnych 30+ dni po rozwiązaniu umowy.

### Modele kontroli dostępu

**DAC (Discretionary Access Control — uznaniowa kontrola dostępu):** właściciel zasobu decyduje kto ma do niego dostęp. Model stosowany w Windows NTFS i Linux (chmod). Elastyczny, ale może prowadzić do bałaganu uprawnień.

**MAC (Mandatory Access Control — obowiązkowa kontrola dostępu):** etykiety bezpieczeństwa przypisane do użytkowników i zasobów, system automatycznie wymusza zasady. Stosowany w systemach wojskowych i rządowych (Top Secret, Secret, Confidential). Trudny w administracji, ale bardzo rygorystyczny.

**RBAC (Role-Based Access Control — kontrola dostępu oparta na rolach):** uprawnienia przypisane do ról, użytkownicy przypisani do ról. Pracownik księgowości dostaje rolę "Księgowość" z odpowiednimi uprawnieniami. To najczęściej stosowany model w firmach — łatwy w zarządzaniu, skalowalny.

**ABAC (Attribute-Based Access Control — kontrola oparta na atrybutach):** decyzja o dostępie oparta na atrybutach użytkownika, zasobu i kontekstu. Przykład: pracownik (atrybut: dział=HR, poziom=senior) może przeglądać pliki kadrowe (atrybut: typ=HR, klasyfikacja=poufne) gdy loguje się z urządzenia firmowego (atrybut: managed=true) w godzinach pracy (kontekst: czas=8:00-18:00). Bardziej granularny niż RBAC, ale złożony w implementacji.

### Access Review — przegląd uprawnień

Nawet przy dobrze zaprojektowanym modelu kontroli dostępu — uprawnienia z czasem driftują. Pracownicy zmieniają role, projekty się kończą, tymczasowe dostępy stają się permanentne.

**Access Review (przegląd dostępu)** to regularny (kwartalny lub półroczny) przegląd kto ma dostęp do czego. Właściciele systemów przeglądają listy użytkowników i certyfikują lub odbierają dostępy.

**IGA (Identity Governance and Administration):** klasa narzędzi automatyzujących zarządzanie cyklem życia tożsamości, przeglądy dostępu i polityki dostępu. Przykłady: SailPoint, Saviynt, Microsoft Identity Governance.

---

## Privileged Access Management (PAM)

Konta uprzywilejowane (administrator systemu, DBA, root, Domain Admin) mają rozszerzony dostęp — mogą modyfikować konfiguracje, usuwać dane, zarządzać innymi kontami. To czyni je najcenniejszym celem dla atakujących.

**Problem:** administratorzy często używają kont uprzywilejowanych do codziennej pracy (sprawdzanie poczty, przeglądanie internetu) z kont z prawami Domain Admin. Jedna złośliwa strona WWW lub jeden phishing — i atakujący ma Domain Admin.

### Zasada separacji kont

Edwards rekomenduje: **każdy administrator powinien mieć dwa konta:**
1. **Konto zwykłe** (jan.kowalski) — do codziennej pracy: poczta, Teams, dokumenty
2. **Konto uprzywilejowane** (adm-jan.kowalski lub jan.kowalski-adm) — wyłącznie do zadań administracyjnych

Konto uprzywilejowane nie powinno:
- Mieć dostępu do internetu i poczty
- Być używane do codziennych zadań
- Mieć permanentnych uprawnień (patrz: JIT poniżej)

### Just-In-Time (JIT) Access

Zamiast permanentnego dostępu uprzywilejowanego — dostęp czasowy, przyznawany na żądanie, wygasający automatycznie.

Przykład: administrator potrzebuje praw do serwera produkcyjnego żeby wgrać patch. Składa żądanie w systemie PAM. System przyznaje dostęp na 2 godziny. Po 2 godzinach dostęp wygasa automatycznie. Cała sesja jest nagrywana.

**Korzyści JIT:**
- Atakujący, który przejmie konto administratora, nie ma permanentnych uprawnień
- Każde użycie uprawnień jest udokumentowane z uzasadnieniem
- Anomalie (dostęp w nocy, z nieznanego IP) mogą być automatycznie blokowane

**Narzędzia PAM:** CyberArk, BeyondTrust, Delinea, HashiCorp Vault, Teleport (open-source).

### Break-Glass Account

Scenariusz: wszystkie systemy MFA są niedostępne podczas awarii. Administrator nie może zalogować się przez normalną ścieżkę. Co wtedy?

Break-glass account to konto awaryjne z szerokim dostępem, używane wyłącznie w nagłych sytuacjach. Hasło jest w fizycznie zabezpieczonej kopercie w sejfie. Każde użycie break-glass generuje alarm i wymaga uzasadnienia.

---

## Zarządzanie cyklem życia tożsamości

Tożsamość pracownika istnieje przez cały okres zatrudnienia — od zatrudnienia do odejścia. Każdy etap ma implikacje bezpieczeństwa.

### Onboarding — tworzenie kont

**Provisioning:** automatyczne tworzenie kont, przypisywanie uprawnień na podstawie roli i działu. Konto AD → konto e-mail → dostęp do systemów → urządzenie firmowe.

**Złota zasada:** pracownik powinien mieć konto gotowe pierwszego dnia pracy, z dostępem dokładnie do tego, czego potrzebuje na swojej roli. Nie mniej (frustracja, tickety), nie więcej (ryzyko).

**Rola HRIS:** system HR powinien być źródłem prawdy. Gdy HRIS rejestruje nowego pracownika → automatycznie wyzwala provisioning w IT. Wymaga integracji HR-IT.

### Role Change — zmiana stanowiska

Pracownik przenosi się z działu sprzedaży do marketingu. Powinno nastąpić:
- Usunięcie uprawnień do systemów sprzedażowych
- Dodanie uprawnień do systemów marketingowych
- Zachowanie uprawnień wspólnych

W praktyce: często dodawane są uprawnienia do nowej roli, stare rzadko są odbierane. Po kilku zmianach stanowisk pracownik ma "permission sprawl" — uprawnienia z każdej poprzedniej roli.

### Offboarding — usuwanie kont

Kluczowe: **konto musi być dezaktywowane tego samego dnia co odejście pracownika**. Nie "następnego tygodnia gdy IT znajdzie czas". Nie "jak się dowiemy". Tego samego dnia.

Checklist offboardingu:
- [ ] Dezaktywacja konta AD/Azure AD
- [ ] Revokacja sesji (wylogowanie ze wszystkich urządzeń)
- [ ] Odebranie dostępu do systemów chmurowych (Salesforce, Slack, GitHub, AWS)
- [ ] Przekazanie lub zarchiwizowanie danych (poczta, pliki)
- [ ] Odebranie urządzeń firmowych
- [ ] Zmiana haseł współdzielonych (jeśli pracownik je znał)
- [ ] Dezaktywacja kont serwisowych powiązanych z pracownikiem

Edwards cytuje IBM: średni czas między odejściem pracownika a dezaktywacją konta to 5,3 dnia. W tym czasie były pracownik (lub ktoś kto przejął jego hasło) ma pełny dostęp.

---

## Single Sign-On (SSO) i federacja tożsamości

W typowej firmie pracownik ma konta w dziesiątkach systemów: CRM, ERP, HR, narzędzia projektowe, poczta, conferencing. Każde wymaga oddzielnego hasła. To prowadzi do złych praktyk (jedno hasło do wszystkiego) lub frustracji.

### SSO (Single Sign-On)

SSO pozwala użytkownikowi zalogować się raz i automatycznie uzyskać dostęp do wielu systemów. Użytkownik uwierzytelnia się do centralnego dostawcy tożsamości (Identity Provider — IdP), który wydaje token dostępowy. Token jest prezentowany innym systemom (Service Providers — SP) zamiast hasła.

**Korzyści:**
- Jeden zestaw poświadczeń → jedno miejsce do zarządzania, jedno miejsce do monitorowania
- Mniej haseł = mniejsze ryzyko reużywania haseł
- MFA wdrożone raz na IdP = MFA dla wszystkich aplikacji
- Łatwiejszy offboarding: dezaktywacja jednego konta w IdP = brak dostępu do wszystkich systemów

**Popularne IdP:** Microsoft Entra ID (dawniej Azure AD), Okta, Google Workspace, OneLogin, Ping Identity.

**Protokoły SSO:**
- **SAML 2.0 (Security Assertion Markup Language):** starszy standard, XML-based, szeroko wspierany przez aplikacje enterprise
- **OAuth 2.0:** framework autoryzacji (nie uwierzytelniania) — "Zaloguj przez Google/Facebook"
- **OpenID Connect (OIDC):** warstwa uwierzytelniania na OAuth 2.0. Nowoczesny standard, JSON-based, używany przez aplikacje webowe i mobilne

### Federacja tożsamości

Federacja pozwala na zaufanie między różnymi dostawcami tożsamości. Pracownik firmy A może logować się do systemu partnera (firma B) używając swoich poświadczeń z firmy A — bez tworzenia dodatkowego konta w systemach firmy B.

Praktyczny przykład: firma wdrożyła Microsoft Entra ID. Chce dać dostęp do swojego systemu dostawcom zewnętrznym. Przez federację (Azure AD B2B) dostawca loguje się swoimi firmowymi poświadczeniami.

---

## Uprzywilejowane konta serwisowe i API

Do tej pory mówiliśmy o ludziach. Ale w nowoczesnej infrastrukturze IT równie ważne są konta nieludzkie: konta serwisowe (service accounts) używane przez aplikacje i automatyzacje, oraz klucze API.

### Problemy z kontami serwisowymi

- Hasła kont serwisowych rzadko rotowane (bo wymaga aktualizacji we wszystkich miejscach gdzie są używane)
- Hasła zakodowane na sztywno w kodzie źródłowym (hardcoded credentials) — klasyczny błąd developerów
- Nadmierne uprawnienia — konto serwisowe z prawami Domain Admin "bo było łatwiej"
- Brak właściciela — nikt nie wie do czego dany service account jest używany

### Secrets Management

Rozwiązaniem jest **Secrets Manager** — centralne repozytorium przechowujące i rotujące sekrety (hasła, klucze API, certyfikaty, klucze SSH).

Zamiast hardcoded hasła w kodzie:
```python
# ŹLE - hardcoded credentials
db_password = "SuperSecretPassword123!"
connection = connect(host="db.firma.pl", password=db_password)
```

Aplikacja dynamicznie pobiera sekret ze Secrets Manager:
```python
# DOBRZE - secret pobierany z Vault
import hvac
client = hvac.Client()
db_password = client.secrets.kv.v2.read_secret("db/production")["data"]["password"]
connection = connect(host="db.firma.pl", password=db_password)
```

**HashiCorp Vault** — najpopularniejszy Secrets Manager (open-source + enterprise). AWS Secrets Manager, Azure Key Vault, GCP Secret Manager — alternatywy chmurowe.

**Rotacja sekretów:** Vault może automatycznie rotować hasła do baz danych co N dni. Aplikacja zawsze pobiera aktualne hasło — nie musi nic wiedzieć o rotacji.

---

## Biometria — mocne i słabe strony

Biometria jako czynnik uwierzytelniania jest wygodna i rosnąca w popularności. Ale ma unikalne własności które trzeba rozumieć.

**Zalety:**
- Nie można zapomnieć
- Trudna do sfałszowania (właściwa implementacja)
- Wygodna — Face ID, Touch ID to UX który użytkownicy lubią

**Wady i ryzyka:**
- **Nieodwoływalność:** jeśli baza odcisków palców zostanie wyciek-nięta — nie możesz zmienić odcisku palca. Hasło możesz zmienić.
- **Spoofing:** w słabszych implementacjach możliwe podrabianie (zdjęcie zamiast twarzy). Właściwa implementacja wymaga "liveness detection".
- **Prywatność:** dane biometryczne to dane osobowe szczególnej kategorii (RODO). Wymagają szczególnej ochrony.
- **Dostępność:** osoba bez palca lub z problemem rozpoznawania twarzy musi mieć alternatywną metodę uwierzytelniania.

**Gdzie biometria jest dobra:** uwierzytelnianie urządzeń końcowych (laptop, telefon) jako drugi czynnik MFA w połączeniu z kluczem sprzętowym lub kryptoasystemem. To co robi Windows Hello for Business — biometria odblokuje klucz TPM, klucz TPM uwierzytelnia do systemu.

---

## Ataki na tożsamość — co próbują zrobić atakujący

### Phishing i credential harvesting

Najczęstsza ścieżka przejęcia konta. Fałszywa strona logowania (np. podszywająca się pod Microsoft 365 login) przechwytuje hasło i kod MFA w czasie rzeczywistym (adversary-in-the-middle phishing, AiTM).

Narzędzia jak Evilginx2, Modlishka działają jako reverse proxy — użytkownik widzi prawdziwą stronę przez proxy, proxy kradnie cookies sesji. Klasyczne MFA (SMS, TOTP) nie chroni przed AiTM — dlatego FIDO2/passkeys jest odporne (cryptographic binding do domeny).

### Credential Stuffing

Automatyczne testowanie par login+hasło z wycieków na innych serwisach. Serwisy takie jak HIBP (Have I Been Pwned) pozwalają sprawdzić czy dany e-mail był w wycieku. Atak działa gdy użytkownik reużywa haseł.

Ochrona: MFA, detekcja anomalii logowania, sprawdzanie haseł pod kątem znanych wycieków przy tworzeniu hasła.

### Password Spraying

Zamiast próbowania wielu haseł dla jednego konta (co blokuje konto po X nieudanych próbach), atakujący próbuje jednego lub kilku haseł dla wielu kont. `Winter2024!` lub `Firma2024!` będzie pasować do kilku kont w każdej organizacji.

Ochrona: MFA, monitoring anomalii (wiele kont z tym samym hasłem złym z różnych IP), ban popularnych haseł.

### Pass-the-Hash i Pass-the-Ticket

Ataki na Windows environments. Zamiast łamać hasło, atakujący kradnie hash hasła z pamięci systemu (narzędzie Mimikatz) i używa go do uwierzytelniania bez znajomości plaintext hasła.

Pass-the-Ticket atakuje Kerberos — kradnie ticket Kerberos z pamięci i używa go do dostępu do zasobów.

Ochrona: Credential Guard (Windows 10+), Protected Users security group, Privileged Access Workstation (PAW), regularne resety haseł kont serwisowych i administratorów.

### Golden Ticket Attack

Jeśli atakujący skompromituje konto KRBTGT (specjalne konto w Active Directory), może tworzyć fałszywe tickety Kerberos dla dowolnego użytkownika — w tym Domain Admin. Ta technika (Golden Ticket) daje permanentny dostęp do całej domeny.

Reset KRBTGT hasła (dwukrotnie) jest kluczowy po każdej kompromitacji domeny AD.

---

## Identifiers i Directory Services

### Active Directory (AD)

Większość firm opartych na Windows używa Active Directory jako centralnego katalogu tożsamości. AD przechowuje konta użytkowników, grupy, polityki grupowe (GPO), uprawnienia do zasobów.

**Kluczowe pojęcia AD:**
- **Domain Controller (DC):** serwer zarządzający AD. Kompromitacja DC = kompromitacja całej domeny
- **OU (Organizational Unit):** logiczna struktura organizacji w AD (Działy, Lokalizacje)
- **GPO (Group Policy Object):** polityki konfiguracji stosowane do użytkowników i komputerów
- **LDAP:** protokół używany przez AD do zapytań o obiekty w katalogu

**Hardening Active Directory:**
- Tiered Administration Model: oddzielenie uprawnień dla Tier 0 (DC, PKI), Tier 1 (serwery), Tier 2 (stacje robocze)
- Microsoft LAPS: automatyczna rotacja haseł kont lokalnych Administrator na każdej stacji
- Protected Users security group: konta w tej grupie nie mogą używać słabszych protokołów uwierzytelniania
- Audit logging: logowanie zmian w AD (tworzenie kont, zmiany grup, GPO)

### Entra ID (dawniej Azure AD)

Cloudowy odpowiednik Active Directory. Zarządza tożsamościami dla Microsoft 365, Azure i aplikacji SaaS (przez SSO). W środowiskach hybrydowych AD synchronizuje się z Entra ID przez Azure AD Connect.

**Entra ID Protection:** moduł oceniający ryzyko logowania w czasie rzeczywistym. Logowanie z nieznanego kraju, zainfekowanego urządzenia, niemożliwa podróż (logowanie z Warszawy i Tokio w tej samej godzinie) → automatyczne wymaganie MFA lub blokada.

---

## Compliance i regulacje

### RODO a IAM

RODO (GDPR) ma bezpośredni wpływ na zarządzanie tożsamościami:
- **Prawo do bycia zapomnianym:** system IAM musi umożliwić usunięcie wszystkich kont i danych osobowych użytkownika na żądanie
- **Minimalizacja danych:** przechowuj tylko tyle danych o tożsamości ile niezbędne
- **Audytowalność:** możliwość wykazania kto miał dostęp do jakich danych, kiedy
- **Zgłaszanie naruszeń:** 72 godziny na zgłoszenie do UODO gdy doszło do naruszenia danych (w tym kradzieży poświadczeń)

### SOX, PCI DSS a IAM

- **SOX (Sarbanes-Oxley):** wymaga separacji obowiązków w procesach finansowych. Osoba tworząca żądanie płatności nie może być tą samą, która je zatwierdza
- **PCI DSS:** wymaga MFA dla wszystkich dostępów do środowiska CDE (Cardholder Data Environment), kwartalnych przeglądów dostępu, natychmiastowego odwoływania dostępu byłych pracowników

---

## Kluczowe zasady IAM — podsumowanie

**1. MFA wszędzie, zaczynając od kont administracyjnych i e-maila**
To jedna kontrola z najwyższym ROI. 99,9% ataków brute force blokowane, credential stuffing nieskuteczny.

**2. Least Privilege — minimalne uprawnienia**
Każdy dostęp nadany jest kosztem — zmniejsza poziom bezpieczeństwa. Nadawaj tylko to co niezbędne.

**3. Przeglądy dostępu (Access Reviews) co kwartał**
Uprawnienia driftują. Regularny przegląd to "odchwaszczanie" niepotrzebnych dostępów.

**4. Offboarding tego samego dnia**
Aktywne konto byłego pracownika to otwarte drzwi. Dezaktywacja musi być natychmiastowa.

**5. Menedżer haseł i polityka haseł oparta na długości**
Brak rotacji haseł (chyba że skompromitowane), sprawdzanie pod kątem znanych wycieków, passphrase zamiast złożoności.

**6. PAM dla kont uprzywilejowanych**
Konta uprzywilejowane wymagają szczególnej ochrony: JIT access, session recording, separation of accounts.

**7. Secrets Manager dla kont serwisowych i API**
Żadnych hardcoded credentials. Centralne repozytorium, automatyczna rotacja.

**8. Monitorowanie tożsamości**
UEBA (User and Entity Behavior Analytics), Entra ID Protection, logowanie do SIEM — anomalie w logowaniu muszą być wykrywane w czasie rzeczywistym.

---

## Terminologia — słownik modułu 5

| Termin | Definicja |
|--------|-----------|
| IAM | Identity and Access Management — zarządzanie tożsamością i dostępem |
| MFA | Multi-Factor Authentication — wieloskładnikowe uwierzytelnianie |
| TOTP | Time-based One-Time Password — kod OTP generowany przez aplikację |
| FIDO2 | Standard uwierzytelniania odporny na phishing (YubiKey, Passkeys) |
| SSO | Single Sign-On — jedno logowanie do wielu systemów |
| RBAC | Role-Based Access Control — uprawnienia oparte na rolach |
| ABAC | Attribute-Based Access Control — uprawnienia oparte na atrybutach |
| Least Privilege | Minimalne uprawnienia potrzebne do wykonania zadania |
| PAM | Privileged Access Management — zarządzanie kontami uprzywilejowanymi |
| JIT | Just-In-Time Access — czasowy dostęp uprzywilejowany na żądanie |
| IdP | Identity Provider — dostawca tożsamości (Okta, Entra ID) |
| SAML | Security Assertion Markup Language — protokół SSO |
| OIDC | OpenID Connect — nowoczesny protokół uwierzytelniania |
| Provisioning | Automatyczne tworzenie kont i uprawnień dla nowych pracowników |
| Offboarding | Proces odbierania dostępów przy odejściu pracownika |
| Credential Stuffing | Atak polegający na testowaniu wyciekłych haseł na innych serwisach |
| Pass-the-Hash | Atak używający skrótu hasła zamiast hasła plaintext |
| Active Directory | Katalog tożsamości Microsoft dla środowisk Windows |
| LAPS | Local Administrator Password Solution — rotacja haseł lokalnych adminów |
| UEBA | User and Entity Behavior Analytics — detekcja anomalii zachowania |

---

*Źródła: Jason Edwards, The Cybersecurity Control Playbook (Wiley, 2025), rozdział 5; Chuck Easttom, Computer Security Fundamentals (Pearson, 2019), rozdział 12; NIST SP 800-63B (Digital Identity Guidelines); Microsoft Entra documentation; CIS Controls v8, Control 5 (Account Management) i Control 6 (Access Control Management).*
