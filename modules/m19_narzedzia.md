# Moduł 19: Narzędziownik praktyka

**Rozdział 19 · Jason Edwards, *The Cybersecurity Control Playbook* (Wiley, 2025)**

> Najlepszy plan bezpieczeństwa to ten który jest w użyciu. Szablony, rejestry i narzędzia zamieniają teorię w praktykę.

---

## Rejestr ryzyka (Risk Register)

Centralny dokument zarządzania ryzykiem — lista ryzyk z oceną i planami adresowania.

### Struktura

| ID | Ryzyko | Kategoria | Prawdopodob. (1-5) | Wpływ (1-5) | Score | Właściciel | Adresowanie | Status | Deadline |
|----|--------|-----------|-------------------|-------------|-------|-----------|-------------|--------|---------|
| R-001 | Wyciek danych przez phishing | People | 4 | 5 | 20 | CISO | MFA + szkolenia | W toku | 2026-06 |
| R-002 | Ransomware przez niezałatane systemy | Technical | 3 | 5 | 15 | IT Admin | Patch mgmt + backup | W toku | 2026-04 |
| R-003 | Nieautoryzowany dostęp byłego pracownika | Process | 2 | 4 | 8 | HR+IT | Auto offboarding | Planowane | 2026-05 |

**Score = Prawdopodob. × Wpływ.** Priorytety: 20–25 Critical, 15–19 High, 10–14 Medium, <10 Low.

**Risk Treatment:** Mitigate (kontrola), Accept (świadoma decyzja zarządu), Transfer (ubezpieczenie), Avoid (zaprzestanie działalności).

---

## Rejestr aktywów (Asset Register)

| ID | Nazwa | Typ | IP | Właściciel | Krytyczność | OS | EOL? | Ostatni patch |
|----|-------|-----|----|-----------|------------|----|----|-------------|
| A-001 | SRV-ERP-01 | Server | 192.168.20.10 | IT Admin | Critical | Win Server 2019 | Nie | 2026-02-15 |

**Krytyczność:** Critical / High / Medium / Low.

---

## Rejestr dostawców (Vendor Register)

| # | Dostawca | Usługa | Dostęp do danych | Klasyfik. | Certyfikat | Data weryfik. | DPA |
|---|---------|--------|-----------------|-----------|-----------|--------------|-----|
| 1 | AWS | Cloud hosting | TAK (produkcja) | Critical | SOC 2 Type II | 2025-11 | TAK |
| 2 | Salesforce | CRM | TAK (dane klientów) | High | ISO 27001 | 2025-08 | TAK |

---

## Checklist offboardingu (obowiązkowy tego samego dnia)

- [ ] Konto AD dezaktywowane (tego samego dnia!)
- [ ] Sesje Microsoft 365 unieważnione (`Revoke-MgUserSignInSession`)
- [ ] VPN dostęp usunięty
- [ ] Wszystkie systemy SaaS — dostęp usunięty
- [ ] Laptop odebrany i zresetowany
- [ ] Klucze/karty dostępu zwrócone

---

## Szablon IRP (skrócony)

**Severity Levels:**
- P1 Critical: dane klientów skompromitowane, systemy produkcyjne niedostępne, konto admina przejęte
- P2 High: podejrzana aktywność zagrażająca systemom, malware zawierany
- P3 Medium: izolowany malware na stacji
- P4 Low: skanowanie portów z zewnątrz

**Eskalacja:** P1 → IC w 15 min, zarząd w 30 min, prawnik w 60 min.

**Playbook Ransomware:**
1. Izoluj hosty przez EDR network contain
2. Aktywuj retainer IR
3. RAM dump z aktywnych hostów (przed wyłączeniem!)
4. Oceń zakres i status backupów
5. UODO notification draft (72h zegar)

---

## Narzędzia open-source dla każdego budżetu

| Kategoria | Narzędzie | Opis |
|-----------|-----------|------|
| Asset Management | Snipe-IT | Inwentaryzacja aktywów, self-hosted |
| Vulnerability | OpenVAS/Greenbone | Skaner podatności |
| SIEM | Wazuh | SIEM + HIDS + FIM + ATT&CK |
| Password Manager | Bitwarden | Menedżer haseł, open-source |
| Phishing Simulation | GoPhish | Symulacje phishingowe, self-hosted |
| SSO/IdP | Keycloak | Single Sign-On, open-source |
| Backup storage | Backblaze B2 | ~6 USD/TB/miesiąc |

---

## Kluczowe wnioski z modułu 19

1. **Zacznij od szablonu** — adaptacja jest 5× szybsza niż tworzenie od zera
2. **Risk Register to żywy dokument** — aktualizuj co kwartał
3. **Offboarding tego samego dnia** — aktywne konto byłego pracownika to krytyczne ryzyko
4. **Open-source wystarczy dla MŚP** — Wazuh + Snipe-IT + Bitwarden + GoPhish za ułamek ceny komercyjnych alternatyw

---

## Terminologia — słownik modułu 19

| Termin | Definicja |
|--------|-----------|
| Risk Register | Rejestr ryzyk z oceną i planami adresowania |
| Risk Treatment | Sposób adresowania ryzyka: Mitigate/Accept/Transfer/Avoid |
| CMDB | Configuration Management Database |
| TPRM | Third-Party Risk Management |
| DPIA | Data Protection Impact Assessment |
| Offboarding | Proces odbierania dostępów przy odejściu pracownika |
| Snipe-IT | Open-source system zarządzania aktywami |
| Wazuh | Open-source SIEM + HIDS + FIM |
| GoPhish | Open-source framework do symulacji phishingowych |

---

*Źródła: Jason Edwards, The Cybersecurity Control Playbook (Wiley, 2025), rozdział 19; SANS Security Policy Templates; CIS Controls v8 Implementation Guide.*
