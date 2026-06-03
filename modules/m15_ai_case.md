# Case Study: BankFintechPL S.A. — SOAR wdrożony i AI phishing jako nowe zagrożenie

**Moduł 15 · AI i automatyzacja w cyberbezpieczeństwie**

BankFintechPL to instytucja płatnicza (280 pracowników, 1,2 mln klientów detalicznych). SOC: 6 analityków L1/L2, Splunk SIEM, CrowdStrike EDR, Microsoft 365. Problemem: 1 200 alertów dziennie, analitycy przepracowani, MTTD (Mean Time to Detect) = 4,5 godziny.

---

## Część 1: SOAR wdrożenie

**Problem:** phishing response zajmował analitykowi L1 45 minut: sprawdzenie URL, zebranie odbiorców, usunięcie e-maili, blokada domeny, komunikacja z użytkownikiem.

**Rozwiązanie:** Palo Alto XSOAR z playbook Phishing Response.

```
TRIGGER: Użytkownik raportuje e-mail jako phishing (Outlook "Report Phishing" button)

AUTOMATED PLAYBOOK:
1. Pobierz nagłówki e-maila (Exchange API) → wyciągnij URL i załączniki
2. Submit URL do VirusTotal → pobierz ocenę
3. Submit URL do URLScan.io → screenshot strony
4. Jeśli VT score > 30:
   a. Usuń e-mail ze skrzynek wszystkich odbiorców (Exchange purge)
   b. Dodaj domenę do blokady w Exchange Transport Rule
   c. Sprawdź proxy logs — kto kliknął URL?
5. Jeśli click detected:
   a. Pobierz listę klikających użytkowników
   b. Sprawdź ostatnie logowania w Entra ID (anomalie?)
   c. Utwórz Jira ticket P1
   d. Wyślij Slack alert do SOC Lead
6. Zamknij alert + wygeneruj raport

CZAS AUTOMATYCZNY: 3-4 minuty vs 45 minut ręcznie
```

**Wyniki po 3 miesiącach:**
- Phishing response: 45 min → 4 min (90% redukcja)
- MTTD ogólny: 4,5h → 1,8h
- Analitycy L1 obsługują 3x więcej alertów
- False positive rate: 12% (dobrze strojony playbook)

---

## Część 2: AI Phishing — nowe zagrożenie

6 tygodni po wdrożeniu SOAR bank zostaje zaatakowany kampanią AI phishing. 

**Incydent:**
Prezes (Tomasz Adamski) otrzymuje e-mail od "swojego asystenta Karola" z prośbą o pilny przelew 285 000 PLN "bo system bankowy jest niedostępny". E-mail jest:
- Napisany w idealnej polszczyźnie z charakterystycznym stylem Karola
- Zawiera kontekst prawdziwego projektu który jest w toku
- Odpowiada na e-maila który prezes wysłał poprzedniego dnia (dostęp do korespondencji?)
- Podpis identyczny jak prawdziwy Karol

Prezes prawie zrealizował przelew — jego asystentka w ostatniej chwili zadzwoniła do Karola (który nic nie wiedział o e-mailu).

**Analiza:** atakujący użył:
- LLM do analizy publicznych wypowiedzi Karola i generowania jego stylu
- LinkedIn scraping do znajomości kontekstu projektu
- Prawdopodobnie wcześniejszy dostęp do e-maila lub OSINT

---

## Odpowiedź na AI phishing

**Techniczne:**
1. Dodanie reguły SOAR: e-maile z zewnątrz do C-level z instrukcją przelewu → automatyczne oznaczenie i alert do SOC
2. DMARC policy = reject (był quarantine)
3. Microsoft Defender for Office 365 P2 — AI-powered phishing detection (wcześniej P1)

**Procesowe:**
1. Nowa polityka: przelewy >50 000 PLN wymagają weryfikacji przez telefon na znany numer
2. Szkolenie dla C-level: "AI phishing jest nieodróżnialny od prawdziwego — zawsze weryfikuj kanałem alternatywnym"
3. Usunięcie z polityki szkoleniowej nacisku na "szukaj błędów językowych" — to nie działa dla AI phishing

**Polityka AI:**
1. Zakaz wklejania korespondencji firmowej do publicznych LLM (ChatGPT)
2. Wdrożenie Microsoft 365 Copilot (prywatne środowisko) jako oficjalne narzędzie AI
3. DLP reguła blokująca wysyłanie dokumentów firmowych przez API do zewnętrznych LLM

---

## Wyniki końcowe

| Metryka | Przed | Po (SOAR+AI defense) |
|---------|-------|---------------------|
| MTTD | 4,5h | 1,8h |
| Phishing response time | 45 min | 4 min |
| BEC attempt success rate | Prawie 1 (zatrzymany przypadkowo) | 0 (procedura weryfikacji) |
| AI usage policy | Brak | Pełna polityka |

---

## Wnioski

1. **SOAR zwraca się szybko** — 90% redukcja czasu phishing response w 3 miesiące
2. **AI phishing eliminuje "szukaj błędów"** — szkolenia muszą ewoluować na "zawsze weryfikuj alternatywnym kanałem"
3. **Polityka AI to pilna potrzeba** — pracownicy używają LLM bez świadomości ryzyka wycieku danych
4. **Wiele warstw** — SOAR + AI detection + procedury weryfikacji + DLP = defense in depth

---

*Przypadek syntetyczny, typowy wzorzec SOAR + AI threats według raportów Gartner 2024 i Mandiant.*
