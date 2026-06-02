# Case Study: SaaSPL Sp. z o.o. — Droga do SOC 2 Type II i ISO 27001

**Moduł 9 · Przegląd frameworków cyberbezpieczeństwa**

---

## Kontekst organizacji

**SaaSPL Sp. z o.o.** to polska firma SaaS oferująca platformę do zarządzania projektami dla klientów B2B. Zatrudnia 85 pracowników (35 developerów, 20 sprzedaż/marketing, 15 customer success, 15 operacje/HR/finanse).

Infrastruktura: AWS (eu-central-1), Terraform IaC, Kubernetes, PostgreSQL RDS, Redis, GitHub, Datadog monitoring.

Klienci: 340 firm w Polsce i Europie Zachodniej, w tym 12 klientów enterprise (>1 000 pracowników).

**Problem:**
- Dział sprzedaży traci deale enterprise bo klienci wymagają SOC 2 Type II lub ISO 27001
- Utracone kontrakty w Q1 2026: 3 firmy (łączna wartość ARR: 1,2 mln PLN)
- Jeden duży klient (500 000 PLN ARR) wyznaczył ultimatum: SOC 2 Type II do końca roku lub wypowiedzenie umowy

**Decyzja zarządu:** przyspieszone wdrożenie SOC 2 Type II jako priorytet, równolegle start przygotowań do ISO 27001 na następny rok.

---

## Punkt startowy — gap analysis

CTO (Marta Kowalczyk) i zewnętrzny konsultant przeprowadzają gap analysis względem wymagań SOC 2 (Trust Service Criteria: Security + Availability).

**Wyniki gap analysis:**

| Obszar | Status | Luki |
|--------|--------|------|
| Logical Access Controls | 🟡 Częściowe | Brak MFA dla wszystkich, nadmierny dostęp do prod |
| Change Management | 🟡 Częściowe | PR reviews są, ale brak formalnej polityki |
| Risk Assessment | 🔴 Brak | Żadnego formalnego procesu |
| Vendor Management | 🔴 Brak | Brak rejestru dostawców i oceny ryzyka |
| Incident Response | 🟡 Częściowe | Nieformalne procedury, bez dokumentacji |
| Business Continuity | 🔴 Brak | Brak BCP, backup nie testowany |
| Security Awareness Training | 🔴 Brak | Brak formalnych szkoleń |
| Monitoring & Logging | 🟢 Dobre | Datadog, AWS CloudTrail — dobra baza |
| Encryption | 🟢 Dobre | TLS 1.3, szyfrowanie w spoczynku RDS |
| Vulnerability Management | 🟡 Częściowe | Dependabot, ale brak skanowania infrastruktury |

**Podsumowanie:** 4 obszary zielone lub żółte (dobra baza techniczna), 4 obszary krytyczne wymagające budowania od zera.

---

## Plan wdrożenia — 9 miesięcy do SOC 2 Type II

### Faza 1: Fundament (miesiące 1–2) — Quick Wins

**MFA dla wszystkich systemów:**
- GitHub, AWS Console, Datadog, Google Workspace — wszystkie przez Okta SSO z MFA
- Polityka: passkey lub TOTP, brak SMS OTP dla dostępu do produkcji
- Czas: 2 tygodnie, koszt: Okta ~15 000 PLN/rok

**Zarządzanie dostępem do produkcji:**
- Zasada least privilege — przegląd wszystkich IAM roles w AWS
- Developerzy: brak dostępu do produkcji przez domyślne konta
- Dostęp do prod: wyłącznie przez AWS SSO + JIT (just-in-time) z zatwierdzeniem managera
- Sesje produkcyjne logowane w AWS CloudTrail

**Security Awareness Training:**
- KnowBe4 — platforma szkoleń phishing awareness
- Obowiązkowe szkolenie dla wszystkich pracowników (4h), co kwartał phishing simulation
- Koszt: 8 000 PLN/rok

### Faza 2: Procesy (miesiące 3–5)

**Risk Assessment:**
Formalna ocena ryzyk metodą ISO 27005:
- Identyfikacja aktywów (systemy, dane, procesy)
- Identyfikacja zagrożeń i podatności
- Ocena prawdopodobieństwa i wpływu
- Risk Register w Confluence (100+ ryzyk zidentyfikowanych, 15 wysokich)
- Risk Treatment Plan — każde ryzyko ma właściciela i termin adresowania

**Incident Response Plan:**
Formalny IRP z sekcjami:
- Definicje (co jest incydentem, kategorie severity)
- Role i odpowiedzialności (Incident Commander, Communication Lead)
- Procedury dla top 5 scenariuszy (data breach, ransomware, account compromise, DDoS, supply chain)
- SLA: wykrycie <1h, containment <4h, komunikacja z klientami <24h
- Post-incident review obowiązkowy dla severity 1 i 2

**Business Continuity i Disaster Recovery:**
- RTO: 4 godziny, RPO: 1 godzina (zdefiniowane przez CEO)
- Multi-AZ dla RDS i Redis (już było, udokumentowane)
- Automatyczne backupy RDS — retencja 30 dni (wydłużona z 7)
- **Testowanie DR: symulacja failover co kwartał, udokumentowany wynik**
- Runbook odtwarzania w Confluence — krok po kroku

**Vendor Management:**
- Rejestr 47 zewnętrznych dostawców (SaaS, API, infrastruktura)
- Kategoryzacja: Critical / High / Medium / Low (według dostępu do danych klientów)
- Due diligence dla krytycznych (8 dostawców): sprawdzenie SOC 2/ISO 27001 lub security questionnaire
- Umowy z DPA (Data Processing Agreement) dla przetwarzających dane RODO

### Faza 3: Automatyzacja compliance (miesiące 4–6)

**Platforma: Vanta**
SaaSPL wdraża Vanta — narzędzie do automatyzacji SOC 2 compliance:
- Integracja z AWS, GitHub, Okta, Google Workspace, Datadog
- Automatyczne zbieranie dowodów (evidence): logi dostępu, konfiguracje MFA, wyniki skanowania
- Dashboard gotowości SOC 2: 156 kontroli, zielony/żółty/czerwony
- Automatyczne powiadomienia gdy kontrola przestaje spełniać wymagania

Koszt Vanta: 18 000 PLN/rok.

**Vulnerability Management:**
- AWS Inspector — automatyczne skanowanie ECR images i EC2
- Dependabot — skanowanie zależności (było już, ulepszono alertowanie)
- Trivy w CI/CD pipeline — blokowanie deploymentu gdy CRITICAL CVE w obrazie Docker
- SLA naprawy: Critical 24h, High 7 dni, Medium 30 dni

### Faza 4: Observation Period (miesiące 6–12)

SOC 2 Type II wymaga okresu obserwacji podczas którego audytor weryfikuje że kontrole działają konsekwentnie. SaaSPL wybrała okres 6 miesięcy (minimum to zazwyczaj 6 miesięcy).

W tym czasie:
- Vanta zbiera automatyczne dowody co tydzień
- Miesięczne przeglądy kontroli przez CTO
- Kwartalne testy DR (przeprowadzone 2 razy)
- Phishing simulations (2 rundy, wyniki: 8% click rate → 3% po szkoleniu)
- Access reviews co kwartał (lista kont i uprawnień certyfikowana przez managerów)

### Faza 5: Audyt (miesiąc 12)

Wybór audytora: Johanson Group (specjalizacja SaaS, SOC 2).

**Stage 1 (1 tydzień):** przegląd dokumentacji, polityk, procedur. Wynik: 3 minor findings (brak formalnej polityki retencji logów, nieaktualna polityka haseł, brak procedury key rotation). Wszystkie naprawione w 2 tygodnie.

**Stage 2 (2 tygodnie):** testowanie kontroli, przegląd dowodów z okresu obserwacji, wywiady z pracownikami.

**Wynik:** SOC 2 Type II Report bez kwalifikacji (unqualified opinion) — najlepszy możliwy wynik.

---

## Wyniki biznesowe

### Natychmiastowe

- Klient zagrożony wypowiedzeniem (500 000 PLN ARR) — odnowił umowę na 3 lata
- 2 z 3 utraconych w Q1 dealów wróciły do pipeline po publikacji raportu SOC 2
- Security questionnaires od klientów: skróciły się z 3 tygodni do 2 dni (Vanta generuje odpowiedzi automatycznie)

### Następny rok

SaaSPL uruchamia proces ISO 27001 korzystając z bazy SOC 2:
- Pokrycie: ~60% wymagań ISO 27001 już spełnionych przez SOC 2 program
- Dodatkowy nakład: głównie dokumentacja ISMS i SoA
- Cel: certyfikat ISO 27001 za 9 miesięcy

---

## Analiza kosztów i ROI

| Pozycja | Roczny koszt |
|---------|-------------|
| Vanta (automatyzacja) | 18 000 PLN |
| Okta SSO+MFA | 15 000 PLN |
| KnowBe4 (szkolenia) | 8 000 PLN |
| AWS Inspector + narzędzia | 12 000 PLN |
| Audyt SOC 2 (Johanson) | 65 000 PLN (jednorazowo) |
| Czas wewnętrzny (CTO + 2 devs, 6 mies.) | 120 000 PLN |
| **Łączny koszt rok 1** | **238 000 PLN** |

**Zwrot:**
- Uratowany kontrakt: 500 000 PLN ARR
- Nowe kontrakty enterprise (2 w Q3): 680 000 PLN ARR
- Skrócenie cyklu sprzedaży (mniej security reviews): szacowane 200 000 PLN wartości czasu sprzedaży

**ROI rok 1:** (500 000 + 680 000 + 200 000) / 238 000 = **5,8x**

---

## Wnioski dla dyrektora IT

**1. SOC 2 to inwestycja sprzedażowa, nie koszt compliance**
Dla firm SaaS SOC 2 Type II to odblokowanie rynku enterprise. ROI jest mierzalny w odzyskanych kontraktach i skróconym cyklu sprzedaży.

**2. Automatyzacja compliance (Vanta, Drata, Secureframe) jest opłacalna**
18 000 PLN za Vanta vs szacowane 60 000 PLN czas wewnętrzny na ręczne zbieranie dowodów. Narzędzia zwracają się w pierwszym roku.

**3. Dobra baza techniczna (AWS, logging, szyfrowanie) skraca drogę**
SaaSPL miała dobrą infrastrukturę — główny wysiłek to procesy i dokumentacja. Firmy bez takiej bazy potrzebują więcej czasu i pieniędzy.

**4. SOC 2 i ISO 27001 są komplementarne, nie konkurencyjne**
SOC 2 otwiera rynek USA i enterprise SaaS. ISO 27001 otwiera rynek europejski i sektory regulowane. Wiele firm robi oba — z SOC 2 jako pierwszym krokiem (bo szybszy i tańszy).

---

## Pytania do dyskusji

1. SaaSPL wybrała SOC 2 przed ISO 27001. Dla jakiego typu firmy ta kolejność ma sens, a dla jakiego warto zacząć od ISO 27001?

2. Vanta automatyzuje zbieranie dowodów compliance. Jakie jest ryzyko nadmiernego polegania na automatyzacji w procesie bezpieczeństwa?

3. Gap Analysis pokazał że dostęp developerów do produkcji był nadmierny. Jak zaprojektować dostęp do środowiska produkcyjnego który jest bezpieczny, ale nie blokuje pracy zespołu?

4. Klient wyznaczył ultimatum: SOC 2 Type II do końca roku. Jak priorytetyzować działania gdy masz 9 miesięcy i ograniczony budżet?

---

*Przypadek opisany na podstawie syntetycznych danych. Scenariusz odzwierciedla typową ścieżkę wdrożenia SOC 2 dla polskiej firmy SaaS według doświadczeń firm consulting i platform compliance automation.*
