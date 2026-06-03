# Case Study: EcommercePL Sp. z o.o. — Droga do PCI DSS i kara UODO

**Moduł 17 · Zgodność i audyt**

EcommercePL (sklep internetowy, 2,1 mln PLN obrotów/rok) przetwarza 450 000 transakcji kartą rocznie (PCI DSS Level 3). W listopadzie 2025 Visa zgłasza podejrzenie naruszenia danych kart po wykryciu fraudów na kartach używanych w sklepie.

**Odkrycie:** skimmer JavaScript wstrzyknięty do strony checkout przez skompromitowany plugin WooCommerce. Aktywny przez 3 miesiące. Dane 12 800 kart potencjalnie skradzione.

**Podwójne naruszenie:** dane kart (PCI DSS) + dane osobowe kupujących (RODO).

---

## Koszty naruszenia

**PCI DSS (Visa/Mastercard):**
- Kara kontraktowa przez acquirer: 75 000 EUR
- Koszty forensics PCI (wymagany przez sieci kartowe): 45 000 EUR
- Re-issuance kart: 128 000 EUR
- Zwiększone opłaty interchange przez 12 miesięcy: 40 000 EUR

**RODO:**
- Kara UODO: 85 000 PLN
- Zawiadomienie 12 800 osób: 38 000 PLN

**Operacyjne:**
- Zawieszenie możliwości przyjmowania kart (2 tygodnie): ~180 000 PLN utracony przychód
- Utrata klientów (~15% odejść): ~315 000 PLN ARR

**Łącznie: ~900 000 PLN + ~1,1 mln PLN rocznych strat**

---

## Co poszło nie tak (PCI DSS lens)

**Wymaganie 6 (Secure Systems):** plugin WooCommerce z krytyczną podatnością nieaktualizowany przez 5 miesięcy.

**Wymaganie 10 (Monitoring):** brak integrity monitoring dla plików JavaScript — skimmer działał niewidocznie 3 miesiące.

**Wymaganie 11 (Testing):** brak kwartalnych skanów zewnętrznych (obowiązkowych dla Level 3).

**Zakres CDE:** cały sklep w zakresie PCI DSS zamiast tokenizacji przez Stripe/PayU.

---

## Plan naprawczy

**Natychmiast:**
1. Tokenizacja kart przez Stripe — zakres PCI DSS radykalnie zredukowany (SAQ A zamiast SAQ D)
2. FIM (File Integrity Monitoring) na wszystkich plikach JS
3. Content Security Policy (CSP) blokujący ładowanie zewnętrznych skryptów

**Strukturalnie:**
- Automatyczne aktualizacje pluginów co tydzień
- Kwartalne zewnętrzne skanowanie podatności (ASV)
- WAF z regułami dla Magecart/skimming patterns

**Po wdrożeniu tokenizacji:** SAQ A (22 pytania vs 329 w SAQ D) — zakres PCI DSS zmniejszony o ~93%.

---

## Wnioski

1. **Tokenizacja radykalnie redukuje ryzyko i koszt compliance** — SAQ A vs SAQ D
2. **FIM na plikach produkcyjnych** — skimmer działał 3 miesiące bez wykrycia
3. **Podwójne ryzyko regulacyjne** (PCI DSS + RODO) wymaga dwutorowego podejścia
4. **Koszt prewencji: ~15 000 PLN** vs koszt incydentu: ~2 mln PLN

---

*Scenariusz syntetyczny, typowy dla incydentów Magecart w e-commerce.*
