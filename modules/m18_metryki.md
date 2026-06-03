# Moduł 18: Metryki i raportowanie bezpieczeństwa

**Rozdział 18 · Jason Edwards, *The Cybersecurity Control Playbook* (Wiley, 2025)**

> Jeśli nie możesz tego zmierzyć, nie możesz tym zarządzać. Jeśli nie potrafisz wyjaśnić tego zarządowi w ciągu 2 minut, nie masz ich uwagi — ani budżetu.

---

## Dlaczego metryki bezpieczeństwa są trudne

**Paradoks negatywny:** sukces wygląda jak "nic się nie stało". Jak pokazać wartość czegoś co zapobiegło incydentowi który się nie zdarzył?

**Lagging vs leading indicators:** większość intuicyjnych metryk (liczba incydentów, koszty breachów) to lagging — mierzą przeszłość. Zarząd potrzebuje leading — mierzących ryzyko przyszłe.

---

## Poziom 1: Metryki operacyjne (SOC/IT)

**Vulnerability Management:**
- % Critical CVE naprawionych w SLA (cel: >95%)
- MTTM — Mean Time to Mitigate Critical CVE
- Liczba systemów bez aktualnych patchy >30 dni

**Incident Response:**
- MTTD — Mean Time to Detect (od wystąpienia do wykrycia)
- MTTR — Mean Time to Respond (od wykrycia do zawierania)
- Liczba incydentów według severity (miesięczny trend)

**Identity & Access:**
- % użytkowników z MFA (cel: 100%)
- Liczba aktywnych kont byłych pracowników (cel: 0)

**Awareness:**
- Phishing simulation click rate (cel: <5%)
- % pracowników przeszkolonych (cel: 100%/rok)

---

## Poziom 2: Metryki programu (CISO)

- CIS Controls Score (% safeguards wdrożonych z IG1/IG2)
- ATT&CK Coverage Score (% technik z detekcją)
- Security Debt (liczba × czas otwartych High/Critical findings)
- % zgodności z frameworkiem (NIST CSF, ISO 27001)

---

## Poziom 3: Metryki biznesowe (Zarząd/CEO)

**Risk Quantification — model FAIR:**
- ALE = ARO × SLE
- Przykład: "Prawdopodobieństwo wycieku: 15% × Koszt: 2 mln PLN = ALE 300 000 PLN/rok"

**Business Continuity:**
- Aktualny vs wymagany RTO dla krytycznych systemów
- % systemów z przetestowanym DRP

---

## Security Dashboard — zasady projektowania

1. **Dostosuj do audytorium:** SOC = real-time alerty, CISO = trendy tygodniowe, Zarząd = ryzyko miesięczne
2. **Trend > snapshot:** "47 vulnerabilities dziś vs 83 miesiąc temu → -43%" > samo "47"
3. **RAG (Red/Amber/Green):** każda metryka z progami określającymi kiedy wymaga działania
4. **Actionable:** każda metryka na czerwono musi mieć oczywisty "następny krok"

---

## Raportowanie do zarządu

### Struktura Executive Security Report

1. **Headline:** stan bezpieczeństwa w jednym zdaniu + trend
2. **Top Risks:** 3–5 ryzyk opisanych biznesowo (nie technicznie)
3. **Metrics Summary:** 5–8 wskaźników z RAG i trendami
4. **Incidents:** zestawienie — co, jak zareagowano, wnioski
5. **Program Progress:** co wdrożono, co planowane

### Tłumaczenie technicznego na biznesowe

| Techniczne | Biznesowe |
|-----------|----------|
| "47 otwartych CVE" | "3 luki dające atakującemu pełny dostęp do ERP" |
| "MTTD = 4.5h" | "Wykrywamy ataki po 4.5h — branżowy cel <1h" |
| "Brak MFA na 23% kont" | "23% kont chronionych tylko hasłem — atakujący ze skradzionym hasłem ma natychmiastowy dostęp" |

### Uzasadnienie budżetu przez ryzyko

**Nieefektywne:** "Potrzebujemy SIEM za 500 000 PLN."

**Efektywne:** "Brak SIEM = ataki niewidoczne przez 4.5h. Każda godzina kosztuje 50 000 PLN (historia incydentów). SIEM (500 000 PLN) zmniejszy MTTD do <1h. Break-even przy jednym zapobiegniętym incydencie."

---

## Model dojrzałości programu bezpieczeństwa

| Level | Nazwa | Opis |
|-------|-------|------|
| 1 | Initial | Brak procesów, reaktywne, chaos |
| 2 | Managed | Podstawowe procesy, planowanie projektowe |
| 3 | Defined | Standardowe procesy w całej organizacji, metryki |
| 4 | Quantitatively Managed | Decyzje oparte na danych, FAIR model |
| 5 | Optimizing | Ciągłe doskonalenie, predyktywne metryki |

**Cel dla większości organizacji: Level 3 → 4.**

---

## Kluczowe wnioski z modułu 18

1. **Trzy zestawy metryk dla trzech audytoriów** — SOC, CISO, Zarząd mają różne potrzeby
2. **Trend > snapshot** — kontekst historyczny jest niezbędny
3. **Mów językiem PLN i ryzyka do zarządu** — "47 CVE" nie robi wrażenia; "2 mln PLN ryzyka" robi
4. **Automatyzuj zbieranie** — SIEM, Vanta, SecurityScorecard eliminują ręczne screenshoty
5. **Metryki napędzają zachowania** — mierz jakość analizy, nie ilość zamkniętych ticketów

---

## Terminologia — słownik modułu 18

| Termin | Definicja |
|--------|-----------|
| KPI | Key Performance Indicator |
| KRI | Key Risk Indicator |
| MTTD | Mean Time to Detect |
| MTTR | Mean Time to Respond/Recover |
| MTTM | Mean Time to Mitigate |
| ALE | Annualized Loss Expectancy = ARO × SLE |
| FAIR | Factor Analysis of Information Risk — model kwantyfikacji ryzyka |
| RAG | Red/Amber/Green — system semaforowy |
| Security Debt | Zaległości: liczba × czas otwartych findings |
| Lagging Indicator | Metryka opisująca przeszłość |
| Leading Indicator | Metryka przewidująca przyszłe ryzyko |
| Security Posture | Ogólny stan bezpieczeństwa organizacji |
| Maturity Model | Model oceny dojrzałości (1–5 poziomów) |

---

*Źródła: Jason Edwards, The Cybersecurity Control Playbook (Wiley, 2025), rozdział 18; NIST IR 7564; CIS Controls v8 Metrics; FAIR Institute.*
