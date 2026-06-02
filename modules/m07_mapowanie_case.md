# Case Study: RetailChain Polska — Purple Team odkrywa krytyczne luki

**Moduł 7 · Mapowanie zagrożeń do kontroli**

---

## Kontekst organizacji

**RetailChain Polska Sp. z o.o.** to sieć 85 sklepów detalicznych z centralą w Krakowie. Zatrudnia 1 400 pracowników (250 w centrali, reszta w sklepach). Przetwarza płatności kartą (~4 mln transakcji/rok), co oznacza zakres PCI DSS.

Infrastruktura IT:
- Centrala: Active Directory, ERP (SAP), systemy HR, serwery plików
- Sklepy: terminale POS (Ingenico), lokalne routery, połączenie VPN z centralą
- E-commerce: platforma WooCommerce na AWS
- Bezpieczeństwo: Sophos EDR (stacje), Check Point NGFW, Microsoft Sentinel (SIEM), Qualys (skaner podatności)
- SOC: zewnętrzny (MSSP) — monitoring 24/7, 2 analityków dedykowanych

**Sytuacja wyjściowa:** firma przeszła audyt PCI DSS bez zastrzeżeń 8 miesięcy temu. CISO (Marek Jabłoński) ma poczucie że "jesteśmy bezpieczni". Zarząd naciska na udowodnienie skuteczności inwestycji w bezpieczeństwo (3,2 mln PLN rocznie).

---

## Decyzja: pierwsze ćwiczenie Purple Team

Marek Jabłoński decyduje się na ćwiczenie Purple Team — zamiast tradycyjnego Red Team (drogi, rzadki, raport po fakcie). Cel: sprawdzić co faktycznie wykrywa Sentinel + Sophos, zanim zrobi to prawdziwy atakujący.

**Metodologia:**
- 3-dniowe ćwiczenie z zewnętrzną firmą security (Purple Team facilitator)
- Zakres: 15 technik ATT&CK priorytetowych dla sektora retail (FIN7, Magecart profile)
- Format: każda technika emulowana → sprawdzenie detekcji → dokumentacja wyniku → ewentualna naprawa
- Udział Blue Team (analitycy MSSP) w czasie rzeczywistym

**Profil przeciwnika:** Magecart (skimming kart na e-commerce) + FIN7 (targeted attacks na retail POS).

---

## Wyniki ćwiczenia — technika po technice

### Test 1: T1566.001 Spearphishing Attachment
**Emulacja:** wysłanie e-maila z złośliwym dokumentem Excel (makro) do 5 pracowników w kontrolowanym środowisku testowym.

**Wynik:** Sophos Email Gateway zablokował 4 z 5 wiadomości. Jedna przeszła (format .xlsm z hasłem do archiwum ZIP — omija skanowanie).

**Detekcja w Sentinel:** brak alertu dla wiadomości która przeszła.

**Decyzja:** dodanie reguły blokowania zaszyfrowanych archiwów z makrami Office.

---

### Test 2: T1059.001 PowerShell Execution
**Emulacja:** uruchomienie PowerShell z flagami `-EncodedCommand -NonInteractive -WindowStyle Hidden`.

**Wynik:** Sophos EDR wygenerował alert — **wykryto w 23 sekundy**. ✅

**Detekcja w Sentinel:** alert pojawił się po 4 minutach (opóźnienie ingestion logów).

**Wniosek:** detekcja działa, ale latency 4 minuty może być problemem dla szybkich ataków. Optymalizacja pipeline'u logów.

---

### Test 3: T1003.001 LSASS Memory Dump (Mimikatz)
**Emulacja:** uruchomienie Mimikatz z uprawnieniami administratora lokalnego.

**Wynik:** Sophos EDR **zablokował próbę** zanim Mimikatz uruchomił się w pełni. ✅

**Ale:** Purple Team próbuje obejścia przez Process Hollowing (T1055.012) — złośliwy kod uruchomiony w kontekście legalnego procesu. Mimikatz przez Process Hollowing — **Sophos nie wykrył**. 🔴

**Decyzja:** konfiguracja dodatkowej reguły Sophos dla dostępu do LSASS przez nieznane procesy (Event ID 10 Sysmon).

---

### Test 4: T1550.002 Pass-the-Hash
**Emulacja:** używając wcześniej "skradzionego" (testowego) hasha NTLM do uwierzytelnienia na innym hoście.

**Wynik:** **brak detekcji** w Sentinel ani Sophos. 🔴

**Analiza:** reguła dla PtH wymaga korelacji między Event ID 4624 (Logon Type 3) a brakiem Event ID 4648 (Explicit Credentials). Taka reguła nie istniała w Sentinel.

**Decyzja:** stworzenie dedykowanej reguły korelacji w Sentinel dla Pass-the-Hash. Czas implementacji: 2 godziny (zrobione podczas ćwiczenia).

---

### Test 5: T1021.001 Remote Desktop Protocol (lateral movement)
**Emulacja:** logowanie przez RDP ze stacji testowej na serwer back-office używając skradzionych poświadczeń.

**Wynik:** logowanie się powiodło. Alert w Sentinel — **tak, ale priorytet "Low"** — analityk MSSP nie eskalował. 🟡

**Analiza:** reguła istnieje, ale próg eskalacji jest zbyt wysoki. Pojedyncze logowanie RDP ze stacji pracowniczej na serwer nie jest automatycznie eskalowane.

**Decyzja:** modyfikacja reguły — eskalacja gdy stacja pracownicza (nie administrator) loguje się przez RDP na serwer produkcyjny.

---

### Test 6: T1505.003 Web Shell na WooCommerce
**Emulacja:** upload złośliwego PHP Web Shell przez podatność w pluginie WooCommerce (symulowana — nie prawdziwa podatność).

**Wynik:** AWS WAF nie wykrył. Web Shell uruchomiony. **Brak detekcji.** 🔴

**Analiza:** reguły AWS WAF są zbyt ogólne. Brak monitoringu integralności plików na serwerze web (FIM).

**Decyzja:** wdrożenie FIM (File Integrity Monitoring) na serwerze WooCommerce + aktualizacja reguł WAF dla PHP webshell patterns.

---

### Test 7: T1486 Data Encrypted for Impact (Ransomware symulacja)
**Emulacja:** skrypt szyfrujący pliki testowe na udziale sieciowym (\\testshare\purple_team_test).

**Wynik:** Sophos wykrył szyfrowanie po zaszyfrowanych **847 plikach**. Alert wygenerowany, szyfrowanie zatrzymane. 🟡

**Problem:** 847 plików zaszyfrowanych zanim zatrzymano. W środowisku produkcyjnym — to już jest katastrofa.

**Analiza:** Sophos Intercept X ma ochronę przed ransomware, ale próg wykrycia jest zbyt wysoki (wymaga zaszyfrowania pewnej liczby plików zanim pattern jest rozpoznany).

**Decyzja:** tune'owanie Sophos — zmniejszenie progu detekcji, honeyfile deployment (plik który nie powinien być dotknięty — jeśli jest szyfrowany → natychmiastowy alert).

---

## Podsumowanie wyników Gap Analysis

| Technika ATT&CK | Status przed | Status po |
|----------------|-------------|-----------|
| T1566.001 Spearphishing | 🟡 Częściowe | 🟢 Poprawione |
| T1059.001 PowerShell | 🟢 Działa | 🟢 Działa (optymalizacja latency) |
| T1003.001 LSASS Dump | 🟡 Częściowe | 🟡 Nadal luka przez PH |
| T1550.002 Pass-the-Hash | 🔴 Brak | 🟢 Nowa reguła Sentinel |
| T1021.001 RDP Lateral | 🟡 Low priority | 🟢 Eskalacja poprawiona |
| T1505.003 Web Shell | 🔴 Brak | 🟡 FIM wdrożone |
| T1486 Ransomware | 🟡 Częściowe | 🟡 Próg obniżony + honeyfiles |

**Wynik 3-dniowego ćwiczenia:** 4 nowe lub poprawione reguły detekcji, 2 zmiany konfiguracji, 1 nowe narzędzie (FIM), kompleksowa dokumentacja pokrycia dla PCI DSS.

---

## Analiza finansowa Purple Team

| Pozycja | Koszt |
|---------|-------|
| Zewnętrzna firma Purple Team (3 dni) | 35 000 PLN |
| Czas wewnętrzny (CISO + SOC MSSP) | 18 000 PLN |
| Wdrożenie FIM (Wazuh agent) | 8 000 PLN |
| **Łącznie** | **61 000 PLN** |

**Wartość odkrytych luk:**
- T1550.002 bez detekcji: potencjalny lateral movement przez całą domenę AD → skompromitowanie Domain Admin → ransomware. Koszt potencjalnego incydentu: 2–5 mln PLN.
- T1505.003 Web Shell: dostęp do danych kart płatniczych na WooCommerce → naruszenie PCI DSS → kara do 500 000 USD + utrata możliwości przetwarzania kart.

ROI ćwiczenia Purple Team: minimalnie 30:1.

---

## Wnioski

**1. PCI DSS compliance ≠ rzeczywiste bezpieczeństwo**
Firma przeszła audyt PCI DSS bez zastrzeżeń. Mimo to Purple Team odkrył krytyczne luki (brak detekcji PtH, brak FIM). Compliance sprawdza czy masz kontrole na papierze — Purple Team sprawdza czy działają.

**2. Purple Team jest tańszy i skuteczniejszy niż Red Team**
3 dni, 61 000 PLN, natychmiastowe poprawki. Klasyczny Red Team: 2 tygodnie, 150 000+ PLN, raport który leży w szufladzie przez 3 miesiące.

**3. Honeyfiles to prosta i skuteczna technika**
Plik "Wynagrodzenia_2026.xlsx" w folderze HR który nigdy nie powinien być odczytany — jeśli jest, alert natychmiast. Koszt: 0 PLN. Skuteczność: wysoka.

**4. Regularne małe testy > rzadkie duże testy**
Zamiast rocznego Red Team — miesięczne testy Atomic Red Team + kwartalne Purple Team sessions. Szybsza pętla informacji zwrotnej, stała poprawa.

---

## Pytania do dyskusji

1. RetailChain wydaje 3,2 mln PLN rocznie na bezpieczeństwo. Jak Purple Team pomaga uzasadnić lub zoptymalizować ten budżet?

2. Test T1486 (ransomware) zaszyfrował 847 plików zanim Sophos zareagował. Jakie dodatkowe kontrole (poza tunowaniem EDR) mogłyby ograniczyć ten "blast radius"?

3. Zewnętrzny MSSP nie eskalował alertu RDP (priorytet "Low"). Jakie umowne i techniczne mechanizmy powinny zapewniać że ważne alerty nie są pomijane?

4. Firma planuje rozszerzenie ćwiczeń Purple Team na sklepy (terminale POS, lokalna infrastruktura). Jakie dodatkowe techniki ATT&CK byłyby priorytetem dla środowiska POS?

---

*Przypadek opisany na podstawie syntetycznych danych. Scenariusz odzwierciedla typowe wyniki pierwszego ćwiczenia Purple Team według doświadczeń firm security consulting w sektorze retail.*
