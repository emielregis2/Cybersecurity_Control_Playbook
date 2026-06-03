# Case Study: DistribPL Sp. z o.o. — Wdrożenie CIS Controls IG1 w 90 dni

**Moduł 11 · CIS 18 Controls — szczegółowe wdrożenie**

---

## Kontekst organizacji

**DistribPL Sp. z o.o.** to dystrybutor artykułów biurowych i przemysłowych z Łodzi. 68 pracowników, 12 mln PLN obrotów. Sieć: 5 lokalizacji (centrala + 4 magazyny). Infrastruktura: Windows 10/11 stacje, Windows Server 2019, NAS Synology, Microsoft 365, ERP Subiekt GT.

**Sytuacja wyjściowa:** firma nie ma działu IT — outsourcing do lokalnej firmy IT (2 osoby, obsługa helpdesk). Zero formalnych polityk bezpieczeństwa. Zero szkoleń. Backup: raz w tygodniu na NAS, nigdy nie testowany.

**Wyzwalacz zmiany:** ubezpieczyciel cyber (Ergo Hestia) przed odnowieniem polisy wysłał kwestionariusz bezpieczeństwa. Firma odpowiedziała uczciwie — i dostała odmowę odnowienia polisy lub podwyżkę składki o 340%. Zarząd zdecydował: wdrożyć CIS Controls IG1 zanim odnowimy polisę za 90 dni.

**Budżet:** 35 000 PLN jednorazowo + max 15 000 PLN/rok.

---

## Planowanie — priorytetyzacja 56 safeguards IG1

Firma zatrudniła zewnętrznego konsultanta bezpieczeństwa (Jacek Wiśniewski, certyfikat CISSP) na 15 dni. Razem z firmą IT przeprowadzili gap analysis i podzielili 56 safeguards IG1 na trzy kategorie:

**Kategoria A (krytyczne, tydzień 1–2):** 8 safeguards o najwyższym ryzyku
**Kategoria B (ważne, tydzień 3–6):** 24 safeguards
**Kategoria C (uzupełniające, tydzień 7–12):** 24 safeguards

---

## Tydzień 1–2: Kategoria A — Krytyczne działania

### 6.3/6.4/6.5 — MFA dla wszystkich

Stan: zero MFA. Microsoft 365 bez MFA = każde hasło = pełny dostęp.

**Wdrożenie:**
- Microsoft Entra ID (Azure AD) — już posiadane w ramach M365 Business Premium
- Conditional Access Policy: wymagaj MFA dla wszystkich, wszystkich aplikacji, wszystkich lokalizacji
- Authenticator: Microsoft Authenticator (bezpłatny) dla wszystkich 68 pracowników
- Rollout: 3 dni (helpdesk rejestruje każdego pracownika, sesje grupowe po 10 osób)

**Wynik:** 100% użytkowników z MFA w 3 dni. Koszt: 0 PLN (wbudowane w posiadaną licencję).

### 4.3 — Zmiana domyślnych haseł na urządzeniach

Audyt ujawnił: 3 routery z admin/admin, NAS z domyślnym hasłem, 2 drukarki z hasłem na naklejce.

**Wdrożenie:** zmiana wszystkich domyślnych haseł, dokumentacja w Bitwarden Teams (10 PLN/użytkownik/miesiąc × 5 kont IT = 50 PLN/miesiąc).

### 11.2/11.5 — Backup i test odtwarzania

Obecny backup: raz w tygodniu na NAS w tej samej serwerowni. Nigdy nie testowany.

**Wdrożenie:**
- Codzienny backup przyrostowy przez Veeam Backup Essentials (2 500 PLN licencja)
- Backup do NAS lokalnego (istniejący) + backup do Backblaze B2 chmura (30 PLN/miesiąc za 500 GB)
- Reguła 3-2-1: 3 kopie, 2 media (NAS + chmura), 1 offsite (Backblaze)
- **Pierwszy test odtwarzania:** odtworzono serwer ERP ze snapshotu z poprzedniego dnia na maszynie testowej. Czas: 2h 15min. Dokumentacja: check.

---

## Tydzień 3–6: Kategoria B

### 1.1/1.2 — Inwentarz aktywów

Odkryto 127 aktywów (stacje, serwery, drukarki, switch, routery, NAS, urządzenia mobilne). Wpisano do Snipe-IT (open-source, bezpłatny, zainstalowany na serwerze).

Nieoczekiwane odkrycie: 3 nieznane urządzenia w sieci — okazały się starymi routerami "zapomnianymi" w magazynach. Odłączone.

### 2.2 — Eliminacja EOL software

Audit oprogramowania ujawnił: Windows 7 na jednej stacji (EOL od 2020), Office 2010 na 4 stacjach (EOL). Aktualizacja: Windows 10 + Office 365 na wszystkich stacjach.

### 5.3 — Nieaktywne konta

Audit kont AD: 23 konta aktywne dla pracowników którzy odeszli (w ciągu ostatnich 3 lat). Wszystkie dezaktywowane. Wdrożono alert: konto nieaktywne >45 dni → automatyczne powiadomienie do HR.

### 9.5 — DMARC/DKIM/SPF

Stan: firma miała SPF (niepoprawny), brak DKIM i DMARC.

Wdrożenie przez konsultanta:
- SPF: poprawiony rekord DNS
- DKIM: wygenerowanie klucza, konfiguracja w DNS i Exchange Online
- DMARC: `v=DMARC1; p=quarantine; rua=mailto:dmarc@distribpl.pl` (początkowo quarantine, docelowo reject po 30 dniach monitoringu)

### 7.3 — Skanowanie podatności

Pierwsze skanowanie przez Nessus Essentials (bezpłatny, do 16 IP):
- 3 Critical (SMBv1 aktywny na 2 serwerach, stara wersja PHP na serwerze webowym)
- 12 High
- 34 Medium

Naprawione natychmiast: SMBv1 wyłączony, PHP zaktualizowane.

---

## Tydzień 7–12: Kategoria C

### 14.1/14.2 — Program świadomości bezpieczeństwa

Wdrożono KnowBe4 (plan SMB, 8 000 PLN/rok):
- Obowiązkowe szkolenie 30-minutowe dla wszystkich 68 pracowników
- Baseline phishing simulation: **click rate 41%** — 28 z 68 pracowników kliknęło
- Szkolenie remediation dla tych którzy kliknęli
- Plan: symulacje co miesiąc przez 3 miesiące, potem co kwartał

### 8.2 — Zbieranie logów

Centralne logowanie przez Microsoft Sentinel (2 500 PLN/miesiąc) — wdrożono podstawowe reguły:
- Alert: logowanie z nieznanej lokalizacji
- Alert: wiele nieudanych prób logowania
- Alert: nowe konto administratora
- Alert: MFA wyłączone dla konta

### 3.6 — Szyfrowanie endpointów

BitLocker na wszystkich 68 stacjach i laptopach. Klucze odtwarzania w Azure AD. 3 laptopy które 'wychodzą' z biura — priorytet.

### 17.3 — Plan IR

Jednostronicowy plan IR (nie 40-stronicowy dokument — dla 68-osobowej firmy bez SOC):
- Lista kontaktów: Jacek (konsultant zewnętrzny), firma IT, CERT Polska, ubezpieczyciel cyber
- Procedura dla 3 scenariuszy: ransomware, phishing z przejęciem konta, wyciek danych
- Komunikacja: kto informuje klientów, kto informuje UODO (jeśli naruszenie danych)

---

## Wyniki po 90 dniach

| Safeguard | Status |
|-----------|--------|
| 6.3–6.5 MFA | ✅ 100% użytkowników |
| 1.1 Inwentarz | ✅ 127 aktywów |
| 2.2 EOL software | ✅ Wyeliminowane |
| 5.3 Nieaktywne konta | ✅ 23 konta wyłączone |
| 9.5 DMARC | ✅ Quarantine → Reject za 30 dni |
| 7.3 Skanowanie | ✅ Criticals naprawione |
| 11.2/11.5 Backup+test | ✅ Codzienne + test co kwartał |
| 14.1/14.2 Szkolenia | ✅ KnowBe4, click rate 41% → cel 10% |
| 8.2 Logi | ✅ Sentinel z podstawowymi regułami |
| 3.6 Szyfrowanie | ✅ BitLocker na wszystkich laptopach |
| 17.3 Plan IR | ✅ Jednostronicowy, przetestowany tabletop |

**Łączny status IG1:** 48/56 safeguards wdrożonych (86%). 8 safeguards w toku (głównie IG1 wymagające dłuższego czasu wdrożenia).

---

## Wynik z ubezpieczycielem

Po 90 dniach DistribPL wysłała zaktualizowane odpowiedzi do kwestionariusza bezpieczeństwa.

**Wynik:** polisa cyber odnowiona ze składką +45% (zamiast +340% lub odmowy). Oszczędność roczna vs brak wdrożenia: 28 000 PLN.

Koszt wdrożenia: 35 000 PLN jednorazowo. Payback: ~15 miesięcy. Ale realna wartość to wyeliminowane ryzyko incydentu.

---

## Wnioski

**1. 90 dni wystarczy na IG1 dla MŚP**
Przy zdeterminowanym zarządzie i zewnętrznym wsparciu — 86% safeguards IG1 w 90 dni. To realistyczne.

**2. Outsourcing IT bez polityk bezpieczeństwa to ryzyko**
Firma IT robiła świetny helpdesk ale zero security governance. Oddzielenie roli "utrzymanie IT" od "bezpieczeństwo IT" jest kluczowe — nawet dla MŚP.

**3. MFA to najszybszy i najtańszy win**
Wdrożone w 3 dni, koszt 0 PLN (wbudowane w M365). Eliminuje >99% ataków na konta.

**4. Ubezpieczenie cyber wymaga podstaw bezpieczeństwa**
Rynek ubezpieczeń cyber coraz bardziej wymaga minimalnego poziomu bezpieczeństwa. CIS Controls IG1 jest de facto wymaganym minimum przez większość ubezpieczycieli.

---

## Pytania do dyskusji

1. Click rate phishingowy wynosił 41%. Jak zaprojektować program szkoleń który realnie zmniejszy ten wskaźnik w ciągu roku?

2. Firma ma outsourcing IT. Jak powinna wyglądać umowa z firmą IT która obejmuje odpowiedzialność za bezpieczeństwo?

3. DistribPL wydał 35 000 PLN na IG1. Jakie byłyby koszty prawdopodobnego incydentu ransomware gdyby nic nie zrobiono? Jak liczyć ROI bezpieczeństwa?

4. Po wdrożeniu IG1, firma planuje IG2. Jakie safeguardy z IG2 powinny być priorytetem biorąc pod uwagę profil firmy (dystrybucja, 68 osób, Microsoft 365)?

---

*Przypadek opisany na podstawie syntetycznych danych. Scenariusz odzwierciedla typowy profil wdrożenia CIS Controls IG1 w polskiej firmie MŚP.*
