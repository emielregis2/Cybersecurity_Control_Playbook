# Moduł 20: Systemy IDS i SIEM

**Rozdział 20 · Jason Edwards, *The Cybersecurity Control Playbook* (Wiley, 2025)**

> SIEM bez dobrych reguł to eksplodujący alarm. SIEM z dobrymi regułami to najlepszy analityk w firmie — nigdy nie śpi, nigdy się nie nudzi, nigdy nic nie przeoczy.

---

## IDS/IPS — głębsze spojrzenie

### Snort — anatomia reguły

```
alert tcp $EXTERNAL_NET any -> $HTTP_SERVERS $HTTP_PORTS \
(msg:"ET WEB_SERVER PHP Remote File Inclusion"; \
flow:established,to_server; content:"http://"; nocase; \
classtype:web-application-attack; sid:2001831; rev:5;)
```

Elementy: **action** (alert/drop/log), **protocol**, **source/destination**, **options** (msg, content, pcre, classtype).

### Zeek (dawniej Bro)

Framework analizy sieciowej wyższego poziomu — parsuje protokoły i generuje logi strukturalne:
- `conn.log` — każde połączenie TCP/UDP (src, dst, port, bytes, duration)
- `http.log` — każde żądanie HTTP
- `dns.log` — każde zapytanie DNS
- `ssl.log` — każde połączenie TLS

Idealne jako input dla SIEM — bogate w kontekst, maszynowo-czytelne.

### Suricata

Nowoczesna wielowątkowa alternatywa dla Snort — obsługuje IDS i IPS inline, kompatybilna z regułami ET (Emerging Threats). Aktualizowane codziennie, bezpłatne (ET Open) lub komercyjne (ET Pro).

---

## SIEM — architektura

```
[Sources] → [Collection] → [Normalization] → [Correlation] → [Alerting] → [Response]
```

**Sources:** firewalle, Windows Event Log, Linux syslog, EDR, proxies, cloud (CloudTrail, Azure Audit).

**Collection:** syslog (UDP 514), WEF (Windows Event Forwarding), agenty (Filebeat, Winlogbeat).

**Normalization:** ustandaryzowanie pól z różnych źródeł do wspólnego schematu (src_ip, dst_port, user).

**Correlation Engine:** łączenie zdarzeń z różnych źródeł w kontekst przez reguły korelacji.

---

## Reguły korelacji — przykłady

### Pass-the-Hash (Microsoft Sentinel KQL)

```kql
SecurityEvent
| where EventID == 4624
| where LogonType == 3
| where AuthenticationPackageName == "NTLM"
| where AccountName !endswith "$"
| summarize count() by AccountName, IpAddress, bin(TimeGenerated, 5m)
| where count_ > 3
```

### C2 Beaconing Detection

Agregacja połączeń do tego samego IP co 30 sekund — regularne interwały = C2 beacon. Zeek conn.log + aggregation per dst_ip per 5-minutowe okno.

### Impossible Travel

Logowanie z dwóch lokalizacji niemożliwych do pogodzenia czasowo → kompromitacja konta.

---

## Alert Fatigue — tuning SIEM

1. **Measure first:** przez 2 tygodnie nie blokuj — zbieraj dane jakie alerty generujesz i ile FP
2. **Baseline normal:** co jest normalnym zachowaniem w Twojej sieci?
3. **Whitelist before rule-write:** skanery podatności, backup agenty, CI/CD IP
4. **Prioritize ruthlessly:** Must alert (konto admina kompromitowane) vs Could log (normalne skanowanie portów)
5. **Measure again:** co miesiąc FPR per reguła. >80% FPR → napraw lub wyłącz

**Cel: analityk widzi 50 alertów dziennie, każdy wymaga uwagi.**

---

## Wazuh — open-source SIEM

Dojrzały, aktywnie rozwijany open-source SIEM:
- **HIDS:** wykrywanie włamań na hoście
- **FIM:** File Integrity Monitoring (alert gdy kluczowe pliki zmienione)
- **Log Analysis:** zbieranie i analiza logów
- **Vulnerability Detection:** skanowanie CVE
- **ATT&CK mapping:** alerty mapowane na techniki ATT&CK

**Architektura:** Wazuh Manager + Agenty (Windows/Linux/macOS) + OpenSearch + Kibana/OpenSearch Dashboards.

**Wymagania:** 8 GB RAM, 4 vCPU, 200 GB SSD dla 100 agentów.
**Koszt:** 0 PLN (open-source) + infrastruktura (~500 PLN/miesiąc).

---

## Log Retention

| Regulacja | Wymaganie |
|-----------|-----------|
| PCI DSS | 12 miesięcy (3 mies. hot) |
| RODO art. 32 | "Odpowiedni okres" |
| NIS2 | Dostępne dla organu nadzoru |

**Praktyczne podejście:**
- **Hot storage (SIEM):** 90 dni — szybki dostęp dla analityki
- **Cold storage (S3 Glacier/Azure Archive):** 12 miesięcy — ~0.004 USD/GB/miesiąc
- **Szacowany rozmiar:** ~1-5 GB/endpoint/dzień z Sysmon

---

## Kluczowe wnioski z modułu 20

1. **SIEM to inwestycja w widoczność** — bez niej ataki trwają tygodniami
2. **Reguły korelacji > sygnatury** — behawioralne reguły wykrywają ataki bez znanych sygnatur
3. **Tuning to ciągły proces** — mierz FPR regularnie, tuninguj bezlitośnie
4. **Wazuh to realna opcja dla MŚP** — HIDS + FIM + SIEM + ATT&CK za koszt infrastruktury
5. **Retencja musi być zaplanowana** — 90 dni hot + 12 miesięcy cold to dobre minimum

---

## Terminologia — słownik modułu 20

| Termin | Definicja |
|--------|-----------|
| SIEM | Security Information and Event Management |
| IDS/IPS | Intrusion Detection/Prevention System |
| NIDS | Network IDS — monitoruje ruch sieciowy |
| HIDS | Host IDS — monitoruje aktywność na hoście |
| Snort | Open-source NIDS |
| Suricata | Nowoczesny wielowątkowy IDS/IPS |
| Zeek/Bro | Framework analizy sieciowej |
| ET Rules | Emerging Threats Rules — baza sygnatur |
| Wazuh | Open-source SIEM + HIDS + FIM |
| Alert Fatigue | Przeciążenie analityków nadmiarem alertów |
| FIM | File Integrity Monitoring |
| CEF | Common Event Format — standard normalizacji logów |
| SPL | Search Processing Language — język Splunk |
| KQL | Kusto Query Language — język Microsoft Sentinel |
| Dwell Time | Czas przebywania atakującego przed wykryciem |
| Hot Storage | Szybki storage dla aktywnej analizy |
| Cold Storage | Tani archiwalny storage dla compliance |

---

*Źródła: Jason Edwards, The Cybersecurity Control Playbook (Wiley, 2025), rozdział 20; Snort User Manual; Suricata User Guide; Wazuh Documentation; Microsoft Sentinel KQL Reference.*
