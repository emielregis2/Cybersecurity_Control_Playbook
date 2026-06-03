# Case Study: InsurancePL S.A. — Dashboard który zmienił decyzje zarządu

**Moduł 18 · Metryki i raportowanie bezpieczeństwa**

InsurancePL (firma ubezpieczeniowa, 320 pracowników). CISO Anna Kowalska przez 2 lata dostawała "budżet ograniczony" na każdy wniosek inwestycji. Raportowała przez 40-stronicowe raporty techniczne — nikt ich nie czytał.

## Zmiana podejścia

Zamiast technicznego raportu — jednosłajdowy Executive Dashboard co miesiąc:

| Metryka | Cel | Aktualnie | Trend |
|---------|-----|-----------|-------|
| % kont z MFA | 100% | 67% | ↑ +12% |
| Critical CVE w SLA | >95% | 71% | ↓ -8% |
| Phishing click rate | <5% | 22% | → brak zmian |
| Backup przetestowany | 100% | 84% | ↑ +5% |
| Ryzyko finansowe (ALE) | Trend ↓ | 1,8 mln PLN | ↑ +200k vs Q4 |

**Kluczowy element:** ALE = 1,8 mln PLN — przeliczona metodą FAIR na podstawie prawdopodobieństwa incydentu i szacowanego kosztu.

## Spotkanie z zarządem

**CEO:** "ALE wzrosło o 200 000 PLN kwartalnie. Co musimy zrobić żeby je obniżyć?"

**Anna:** "Trzy działania: (1) MFA dla pozostałych 33% kont — koszt 0 PLN; (2) Automatyczny patch management — MTTM -60%; (3) Security awareness training — click rate z 22% → <5%."

**CEO:** "Ile to kosztuje?"
**Anna:** "95 000 PLN wdrożenie + 40 000 PLN/rok. Redukcja ALE o szacowane 600 000 PLN/rok."

**Wynik:** budżet zatwierdzony tego samego dnia.

## Lekcja

Techniczny raport → ignorowany.
Business dashboard z ALE w PLN → zatwierdzone natychmiast.

Te same dane, inny język = inne decyzje.

## Pytania do dyskusji

1. Jak obliczyć ALE dla firmy która nigdy nie miała poważnego incydentu? Jakich danych zewnętrznych użyć (Verizon DBIR, Ponemon)?
2. Jakie ryzyko niesie pokazywanie zarządowi tylko pozytywnych trendów? Jak zachować wiarygodność?
3. Phishing click rate 22% bez zmian przez 3 miesiące. Co zmienić w programie szkoleń?

*Przypadek syntetyczny.*
