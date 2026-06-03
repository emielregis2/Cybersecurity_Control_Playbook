# Case Study: TelecoPL S.A. — Wazuh wykrywa atak APT w 47 minut

**Moduł 20 · Systemy IDS i SIEM**

TelecoPL (operator telekomunikacyjny, 650 pracowników). Przed Wazuh: zero centralizacji logów, każdy serwer z lokalnymi logami. MTTD: nieznany.

---

## Wdrożenie Wazuh

- 285 agentów: Windows Server (120), Windows Workstation (80), Linux (85)
- Integracje syslog: Cisco ASA, Palo Alto NGFW, Cisco switches
- Reguły niestandardowe: Pass-the-Hash, Brute force + success, Lateral movement, PowerShell encoded commands
- Koszt infrastruktury: **1 800 PLN/miesiąc**

---

## Incydent — 47 minut od ataku do zawierania

**14:23** — Alert: "Multiple failed SSH logins from 185.220.x.x (TOR exit node) to management VLAN". Severity: Medium.

**14:31** — Alert: "Successful SSH login from same IP to srv-mgmt-01". Reguła korelacji: failed_logins > 5 + success = automatyczna eskalacja do L2.

**14:38** — L2 analityk sprawdza OpenSearch: to samo IP loguje się kolejno na srv-mgmt-02, srv-mgmt-03. Lateral movement pattern.

**14:44** — Wazuh FIM alert: "New cron job added: `/tmp/.hidden/beacon.sh`" — Persistence attempt (ATT&CK T1053).

**14:49** — P1 aktywowany. Izolacja przez Wazuh Active Response (blokuje IP na iptables). Powiadamia IC.

**15:10** — War room. Forensics: beacon.sh = C2 przez DNS tunneling (T1071.004).

**Razem: 47 minut od pierwszego alertu do izolacji.**

---

## Co zadecydowało o sukcesie

✅ **Korelacja logów** — SSH failed + success z tego samego IP = alert. Bez SIEM: dwa zdarzenia w dwóch różnych serwerach, niewidoczne

✅ **FIM na kluczowych katalogach** — `/tmp/`, `/etc/cron.d/` monitorowane. Persistence wykryta natychmiast

✅ **Automatyczna eskalacja** — reguła korelacji podnosiła severity bez decyzji analityka L1

✅ **Active Response** — automatyczne zablokowanie IP na iptables przed manualnym działaniem

---

## ROI Wazuh

| Metryka | Przed | Po |
|---------|-------|-----|
| MTTD | Nieznany (tygodnie) | 8 minut (średnia kwartalna) |
| Koszt infrastruktury SIEM | 0 PLN | 1 800 PLN/miesiąc |
| Koszt alternatywy (Splunk) | — | ~35 000 PLN/miesiąc |
| Oszczędność vs Splunk | — | **~400 000 PLN/rok** |

---

## Pytania do dyskusji

1. Wazuh Active Response automatycznie zablokował IP. Jakie ryzyko niesie automatyzacja containment bez zatwierdzenia przez człowieka?
2. DNS tunneling jest trudny do wykrycia. Jak skonfigurować SIEM do wykrywania C2 przez DNS?
3. Po 3 miesiącach TelecoPL miała 800 alertów dziennie. Jak priorytetyzować tuning?

*Przypadek syntetyczny.*
