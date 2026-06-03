# Case Study: ScaleTech S.A. — DevSecOps od zera do pipeline w 6 miesięcy

**Moduł 12 · Zwinne bezpieczeństwo — Agile Security i DevSecOps**

ScaleTech to polska firma SaaS (HR software, 120 pracowników, 8 zespołów developerskich, ~25 deploymentów tygodniowo na AWS). Security review przed wdrożeniem zajmował 2 tygodnie i był regularnie pomijany pod presją delivery.

**Problem:** 3 incydenty w roku: SQL injection w API (dane 4 500 klientów), hardcoded AWS key w repozytorium GitHub (skaner chmury przez 6 godzin), dependency z krytycznym CVE w produkcji przez 90 dni.

**Cel:** DevSecOps pipeline który nie spowalnia delivery, a buduje bezpieczeństwo automatycznie.

---

## Faza 1: Quick wins (miesiąc 1)

**Secret Scanning:**
- GitGuardian wdrożony na całym GitHub Organization
- Pre-commit hook z detect-secrets dla nowych repozytoriów
- Audit historyczny: znaleziono 47 sekretów w historii git (AWS keys, DB passwords, API tokens) — wszystkie zrotowane

**Dependabot:**
- Włączony dla wszystkich 34 repozytoriów
- Security updates: auto-merge dla patch level, review wymagany dla minor/major
- Efekt: 0 Critical CVE w zależnościach przez >30 dni (poprzednio: brak monitoringu)

Oba działania: koszt 0 PLN, wdrożenie 1 tydzień.

---

## Faza 2: SAST w pipeline (miesiąc 2–3)

Wdrożono Semgrep (Community Edition, open-source) zintegrowany z GitHub Actions:

```yaml
semgrep-scan:
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@b4ffde65f46336ab88eb53be808477a3936bae11
    - uses: returntocorp/semgrep-action@v1
      with:
        config: >
          p/owasp-top-ten
          p/nodejs
          p/sql-injection
      env:
        SEMGREP_APP_TOKEN: ${{ secrets.SEMGREP_TOKEN }}
```

**Pierwsze tygodnie:** 340 findings we wszystkich repozytoriach. 80% false positives po analizie. Dostosowanie reguł, suppression komentarze dla legitnych wzorców.

**Po 6 tygodniach:** false positive rate < 15%. Developerzy przestali ignorować alerty.

**SQL Injection fix:** reguła SAST złapała wzorzec który spowodował poprzedni incydent. Naprawiony w 2 dni od wdrożenia Semgrep.

---

## Faza 3: Security Champions (miesiąc 3–4)

Wyznaczono 8 Security Champions — jeden z każdego zespołu. Program:
- 2-dniowe szkolenie: OWASP Top 10, threat modeling, code review
- Tygodniowe spotkania Security Champions Network (30 min)
- Threat modeling dla każdej nowej epics (30-min session)
- Udział w monthly security review

**Wynik po 3 miesiącach:** 3 poważne podatności wykryte w design przez threat modeling zanim napisano kod. Szacowany koszt naprawy gdyby nie zostały wykryte na tym etapie: 80 000 PLN (2 tygodnie inżynierów × 8 osób).

---

## Faza 4: Container Security i IaC Scanning (miesiąc 4–6)

**Trivy w CI/CD:** skanowanie obrazów Docker przy każdym build. Critical/High blokują deployment.

**Checkov dla Terraform:** skanowanie całej infrastruktury AWS. Odkryto: 3 S3 buckety bez szyfrowania, 2 Security Groups z 0.0.0.0/0 na port 22, 1 RDS bez Multi-AZ.

**SBOM generowanie:** Anchore/Syft przy każdym release. Artefakty przechowywane w S3.

---

## Wyniki po 6 miesiącach

| Metryka | Przed | Po |
|---------|-------|-----|
| Critical CVE w prod >30 dni | Brak monitoring | 0 |
| Sekrety w kodzie | 47 znalezione retrospektywnie | 0 nowych przez 4 miesiące |
| SQL injection (typ) | Incydent | Zablokowane przez SAST |
| Czas security review | 2 tygodnie (często pominięty) | 0 (automatyczne) + 30 min threat modeling |
| Deployment frequency | 25/tydzień | 25/tydzień (bez spowolnienia) |
| Security debt (open findings) | Nieznany | 12 Medium, 0 High/Critical |

**ROI:** koszt wdrożenia ~45 000 PLN. Zapobieżone incydenty (szacunek): 3 × 150 000 PLN = 450 000 PLN potencjalnych strat.

---

## Wnioski

1. **Secret scanning i Dependabot to zero-cost, high-value** — pierwsze co wdrożyć
2. **False positives niszczą adopcję** — poświęć czas na tuning SAST zanim rollout
3. **Security Champions > centralny security team** — 8 championów w 8 teamach vs 1 security engineer dla wszystkich
4. **Threat modeling w design > code review** — 10x taniej naprawić w projekcie niż w kodzie

---

*Przypadek syntetyczny, scenariusz typowy dla polskich firm SaaS według doświadczeń DevSecOps consultants.*
