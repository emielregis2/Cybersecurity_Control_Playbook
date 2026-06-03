# Case Study: ConsultingPL Sp. z o.o. — Szablony które ocaliły kontrakt

**Moduł 19 · Narzędziownik praktyka**

ConsultingPL (firma doradcza, 95 pracowników) zatrudniła pierwszego CISO po tym jak klient enterprise wymagał potwierdzenia programu bezpieczeństwa przed podpisaniem kontraktu ARR 850 000 PLN. Termin: 60 dni. Problem: zero polityk, zero rejestrów, zero dokumentacji.

---

## Podejście "szablony najpierw"

CISO (Piotr Zalewski) zaadaptował istniejące szablony zamiast pisać od zera:

| Dokument | Źródło szablonu | Czas adaptacji |
|---------|----------------|----------------|
| Polityka bezpieczeństwa | SANS template | 4h |
| Polityka haseł | NIST 800-63B | 2h |
| Polityka BYOD | SANS template | 3h |
| IRP (skrócony) | NIST 800-61 | 6h |

**Łącznie: 15 godzin zamiast szacowanych 80h od zera.**

## Wyniki po 60 dniach

- Risk Register: 23 ryzyka zidentyfikowane w 2h workshopie
- Asset Register: 127 aktywów w Snipe-IT (zainstalowany w 2h)
- Vendor Register: 34 dostawców, **3 bez DPA** — znalezione przez przegląd umów

Klient przeprowadził SIG Lite questionnaire (140 pytań):
- Polityki: 100% pozytywnych
- Procesy: 87% (brak access review — zaplanowany)
- Techniczne: 72% (brak SIEM — w planie Q3)

**Kontrakt podpisany.**

## Co nie zadziałało

❌ Polityka haseł bez wymuszenia technicznego (brak GPO) — klient zauważył niespójność
❌ Rejestr ryzyk bez właścicieli — klient zapytał "kto odpowiada za R-003?"

✅ Lekcja: szablon to punkt startowy. Implementacja + właściciele to obowiązek.

## Pytania do dyskusji

1. Klient wymaga potwierdzenia programu w 60 dni. Jak priorytetyzować: dokumentacja vs faktyczne wdrożenie?
2. Piotr znalazł 3 dostawców bez DPA. Jak postąpić?
3. Asset Register w Snipe-IT zapełniony. Jak utrzymać aktualność bez dużego nakładu pracy?

*Przypadek syntetyczny.*
