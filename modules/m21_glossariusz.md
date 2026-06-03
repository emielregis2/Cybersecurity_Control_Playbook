# Moduł 21: Słownik pojęć — Kompletny Glossariusz Kursu

**Kompilacja wszystkich pojęć wprowadzonych w modułach 1–20**

---

> Ten moduł jest Twoim słownikiem odniesienia. Każde pojęcie które pojawiło się w kursie jest tutaj zdefiniowane w jednym miejscu — alfabetycznie, z numerem modułu gdzie zostało wprowadzone.

---

## A

| Termin | Definicja | Moduł |
|--------|-----------|-------|
| **ABAC** | Attribute-Based Access Control — kontrola dostępu oparta na atrybutach użytkownika, zasobu i kontekstu | M5 |
| **Access Control** | System zarządzania dostępem do zasobów — kto co może robić | M5 |
| **Access Review** | Kwartalny przegląd uprawnień użytkowników — certyfikowanie lub odbieranie dostępów | M5 |
| **ALE** | Annualized Loss Expectancy — roczna oczekiwana strata = ARO × SLE | M18 |
| **Anomaly-based Detection** | Wykrywanie zagrożeń przez odchylenia od normy (vs sygnatury) | M6, M20 |
| **APT** | Advanced Persistent Threat — zaawansowana, trwała grupa atakująca | M6 |
| **Asset Register** | Inwentaryzacja aktywów IT — hardware, software, lokalizacja, właściciel | M11, M19 |
| **ATT&CK** | MITRE Adversarial Tactics, Techniques and Common Knowledge — baza technik atakujących | M6 |
| **ATO** | Authorization to Operate — formalne zezwolenie dla systemu (NIST 800-53) | M10 |
| **Atomic Red Team** | Biblioteka testów dla każdej techniki ATT&CK (Red Canary) | M7 |
| **Audit Log** | Zapis zdarzeń systemowych dla celów bezpieczeństwa i forensics | M10, M20 |

## B

| Termin | Definicja | Moduł |
|--------|-----------|-------|
| **Bastion Host** | Dedykowany serwer zarządzania sieciowego — jedyna droga do infrastruktury | M4 |
| **BCP** | Business Continuity Plan — plan utrzymania działalności podczas kryzysu | M16 |
| **BEC** | Business Email Compromise — atak kompromitujący firmową pocztę | M15 |
| **Beaconing** | Regularna komunikacja malware z C2 — wykrywalna przez wzorzec czasowy | M15, M20 |
| **BitLocker** | Szyfrowanie dysków Windows — wbudowane w Windows Pro/Enterprise | M3, M11 |
| **BSIMM** | Building Security In Maturity Model — benchmark dojrzałości AppSec | M12 |
| **Bug Bounty** | Program zachęcający zewnętrznych badaczy do zgłaszania podatności | M12 |

## C

| Termin | Definicja | Moduł |
|--------|-----------|-------|
| **C2** | Command and Control — infrastruktura do zarządzania zainfekowanymi systemami | M6 |
| **Canary Token** | Fałszywy zasób alertujący gdy jest użyty | M8 |
| **CDE** | Cardholder Data Environment — środowisko danych kart (PCI DSS) | M17 |
| **CEF** | Common Event Format — standard normalizacji logów dla SIEM | M20 |
| **Chain of Custody** | Dokumentacja zbierania i przechowywania dowodów cyfrowych | M16 |
| **CI/CD** | Continuous Integration / Continuous Delivery — automatyczny pipeline | M12 |
| **CIS Benchmarks** | Szczegółowe przewodniki hardening dla konkretnych systemów | M4, M11 |
| **CIS Controls** | 18 grup kontroli bezpieczeństwa z priorytetyzacją IG1/IG2/IG3 | M9, M11 |
| **CNAPP** | Cloud-Native Application Protection Platform — unifikacja CSPM+CWPP | M13 |
| **Compensating Control** | Alternatywna kontrola zastępująca tę której nie można wdrożyć | M10 |
| **Containment** | Ograniczenie zasięgu incydentu — faza IR po identyfikacji | M16 |
| **CSPM** | Cloud Security Posture Management — skanowanie misconfiguracji w chmurze | M13 |
| **CVE** | Common Vulnerabilities and Exposures — standardowy identyfikator podatności | M7 |
| **CWPP** | Cloud Workload Protection Platform — ochrona workloadów w chmurze | M13 |
| **CycloneDX** | Format SBOM (OWASP) — maszynowo-czytelny spis komponentów | M14 |

## D

| Termin | Definicja | Moduł |
|--------|-----------|-------|
| **D3FEND** | MITRE framework technik defensywnych — Harden/Detect/Isolate/Deceive/Evict | M8 |
| **DAC** | Discretionary Access Control — właściciel zasobu decyduje o dostępie | M5 |
| **DAST** | Dynamic Application Security Testing — testowanie działającej aplikacji | M12 |
| **Data Classification** | Klasyfikacja danych według wrażliwości (Public/Internal/Confidential/Restricted) | M11 |
| **Deepfake** | Syntetyczny obraz/audio/video generowany przez AI | M15 |
| **Default Deny** | Zasada firewalla: blokuj wszystko co nie jest jawnie dozwolone | M4 |
| **Dependency Confusion** | Atak przez publikację złośliwego pakietu o nazwie jak wewnętrzny | M14 |
| **DevSecOps** | Development + Security + Operations — bezpieczeństwo wbudowane w SDLC | M12 |
| **DMZ** | Demilitarized Zone — strefa między Internetem a siecią wewnętrzną | M4 |
| **DKIM** | DomainKeys Identified Mail — podpis kryptograficzny wychodzących e-maili | M11 |
| **DLP** | Data Loss Prevention — system zapobiegania wyciekom danych | M5, M15 |
| **DMARC** | Domain-based Message Authentication — polityka autentyczności e-mail | M11 |
| **DPA** | Data Processing Agreement — umowa przetwarzania danych (RODO art. 28) | M14, M17 |
| **DPIA** | Data Protection Impact Assessment — ocena wpływu na ochronę danych | M19 |
| **DRP** | Disaster Recovery Plan — techniczny plan odtwarzania infrastruktury IT | M16 |
| **Dwell Time** | Czas przebywania atakującego w sieci przed wykryciem | M20 |

## E–F

| Termin | Definicja | Moduł |
|--------|-----------|-------|
| **EDR** | Endpoint Detection and Response — zaawansowana ochrona z detekcją behawioralną | M2, M15 |
| **EOL** | End of Life — oprogramowanie bez wsparcia producenta | M11 |
| **Eradication** | Usunięcie zagrożenia z systemów — faza IR po containment | M16 |
| **ET Rules** | Emerging Threats Rules — baza sygnatur dla Snort/Suricata | M20 |
| **Evidence** | Dowód audytowy potwierdzający działanie kontroli bezpieczeństwa | M17 |
| **FAIR** | Factor Analysis of Information Risk — model kwantyfikacji ryzyka w PLN | M18 |
| **False Negative** | Alert który nie wygenerował alamu mimo realnego zagrożenia | M20 |
| **False Positive** | Alert bezpieczeństwa który jest fałszywym alarmem | M12, M20 |
| **FedRAMP** | Program autoryzacji usług chmurowych dla rządu USA (NIST 800-53) | M10 |
| **FIDO2** | Standard uwierzytelniania odporny na phishing (YubiKey, Passkeys) | M5 |
| **FIM** | File Integrity Monitoring — monitoring zmian plików systemowych | M8, M20 |
| **Finding** | Odkryta niezgodność lub słabość wykryta podczas audytu | M17 |
| **Forensics** | Cyfrowe dochodzenie — zbieranie i analiza dowodów po incydencie | M16 |
| **FraudGPT** | LLM bez guardrails bezpieczeństwa — używany przez cyberprzestępców | M15 |

## G–H

| Termin | Definicja | Moduł |
|--------|-----------|-------|
| **Gap Analysis** | Analiza luk między obecnymi kontrolami a wymaganym pokryciem | M7, M9 |
| **Golden Ticket** | Atak Kerberos po kompromitacji KRBTGT — fałszywe bilety dla każdego | M5 |
| **GoPhish** | Open-source framework do symulacji phishingowych | M19 |
| **GRC** | Governance, Risk and Compliance — systemy zarządzania | M18 |
| **GuardDuty** | AWS managed threat detection — wykrywanie zagrożeń przez ML | M13 |
| **Hallucination** | Błędna, pewnie brzmiąca odpowiedź modelu LLM | M15 |
| **Hardening** | Wzmacnianie domyślnej konfiguracji systemu/urządzenia | M4 |
| **HIDS** | Host Intrusion Detection System — wykrywanie włamań na hoście | M4, M20 |
| **HIPAA** | Health Insurance Portability and Accountability Act — USA dane zdrowotne | M17 |
| **Honeypot** | Fałszywy system udający wartościowy cel — pułapka na atakujących | M8 |
| **Honeytoken** | Fałszywy zasób (plik, konto, klucz API) alertujący gdy użyty | M8 |

## I–J

| Termin | Definicja | Moduł |
|--------|-----------|-------|
| **IAM** | Identity and Access Management — zarządzanie tożsamością i dostępem | M5, M13 |
| **IC** | Incident Commander — koordynator odpowiedzi na incydent | M16 |
| **IDS** | Intrusion Detection System — pasywne wykrywanie włamań | M4, M20 |
| **IG1/IG2/IG3** | Implementation Groups — trzy poziomy CIS Controls | M9, M11 |
| **IOC** | Indicator of Compromise — wskaźnik kompromitacji (hash, IP, domena) | M6 |
| **IOD/DPO** | Inspektor Ochrony Danych / Data Protection Officer (RODO) | M17 |
| **IPS** | Intrusion Prevention System — aktywne blokowanie włamań | M4, M20 |
| **IRP** | Incident Response Plan — plan reagowania na incydenty | M16, M19 |
| **ISO 27001** | Certyfikowalny standard zarządzania bezpieczeństwem informacji | M9, M17 |
| **ISMS** | Information Security Management System | M9 |
| **JIT** | Just-In-Time Access — tymczasowy dostęp uprzywilejowany na żądanie | M5 |

## K–L

| Termin | Definicja | Moduł |
|--------|-----------|-------|
| **Kill Chain** | 7-fazowy model ataku Lockheed Martin | M6 |
| **KPI** | Key Performance Indicator | M18 |
| **KQL** | Kusto Query Language — język zapytań Microsoft Sentinel | M20 |
| **KSC** | Krajowy System Cyberbezpieczeństwa — polska implementacja NIS2 | M9 |
| **LAPS** | Local Administrator Password Solution — automatyczna rotacja haseł localadmin | M5 |
| **Lateral Movement** | Przemieszczanie się atakującego między systemami w sieci | M6 |
| **Lagging Indicator** | Metryka opisująca przeszłość (np. liczba incydentów) | M18 |
| **Leading Indicator** | Metryka przewidująca przyszłe ryzyko (np. % bez MFA) | M18 |
| **Least Privilege** | Zasada minimalnych uprawnień — tylko co niezbędne do zadania | M5 |
| **LLM** | Large Language Model — duży model językowy (GPT-4, Claude, Gemini) | M15 |
| **LSASS** | Local Security Authority Subsystem — proces Windows przechowujący hashe | M5, M8 |

## M–N

| Termin | Definicja | Moduł |
|--------|-----------|-------|
| **MAC** | Mandatory Access Control — etykiety bezpieczeństwa wymuszane przez system | M5 |
| **Macie** | AWS — wykrywanie wrażliwych danych (PII) w S3 przez ML | M13 |
| **Maturity Model** | Model oceny dojrzałości procesu (1-5 poziomów) | M18 |
| **MFA** | Multi-Factor Authentication — wieloskładnikowe uwierzytelnianie | M5 |
| **Mimikatz** | Narzędzie do wyciągania haseł z pamięci Windows | M5, M8 |
| **MSSP** | Managed Security Service Provider — zewnętrzny dostawca SOC | M14 |
| **MTTD** | Mean Time to Detect — średni czas wykrycia incydentu | M18, M20 |
| **MTTM** | Mean Time to Mitigate — czas naprawy podatności | M18 |
| **MTTR** | Mean Time to Respond/Recover | M16, M18 |
| **NAC** | Network Access Control — weryfikacja urządzeń przed połączeniem | M4 |
| **NDR** | Network Detection and Response — ML w analizie ruchu sieciowego | M15 |
| **NGFW** | Next-Generation Firewall — z IPS, antivirus, app control | M4 |
| **NIDS** | Network Intrusion Detection System | M4, M20 |
| **NIS2** | Dyrektywa UE o bezpieczeństwie sieci i systemów (2024) | M9 |
| **NIST CSF** | NIST Cybersecurity Framework — framework oparty na 6 funkcjach | M9 |
| **NIST SP 800-53** | Katalog ponad 1000 kontroli bezpieczeństwa | M10 |

## O–P

| Termin | Definicja | Moduł |
|--------|-----------|-------|
| **Offboarding** | Proces odbierania dostępów przy odejściu pracownika | M5, M19 |
| **OPA** | Open Policy Agent — polityki bezpieczeństwa jako kod | M15 |
| **Order of Volatility** | Kolejność zbierania dowodów od najbardziej ulotnych (RAM → dysk) | M16 |
| **OWASP Top 10** | Lista 10 najczęstszych kategorii podatności w aplikacjach webowych | M12 |
| **PAM** | Privileged Access Management — zarządzanie kontami uprzywilejowanymi | M5 |
| **Passkey** | Standard FIDO2 zastępujący hasło — odporny na phishing | M5 |
| **Pass-the-Hash** | Atak używający skrótu hasła zamiast hasła plaintext | M5 |
| **PCI DSS** | Payment Card Industry Data Security Standard | M17 |
| **PHI** | Protected Health Information — chronione dane zdrowotne (HIPAA) | M17 |
| **PICERL** | Fazy IR: Preparation → Identification → Containment → Eradication → Recovery → Lessons | M16 |
| **PIR** | Post-Incident Review — blameless postmortem | M16 |
| **Pinning** | Zablokowanie zależności na konkretną wersję lub hash | M14 |
| **Playbook** | Szczegółowe kroki dla konkretnego scenariusza incydentu | M15, M19 |
| **Policy as Code** | Polityki bezpieczeństwa zakodowane i automatycznie egzekwowane | M13 |
| **Polymorphic Malware** | Malware mutujące kod — omija detekcję sygnaturową | M15 |
| **Pre-commit Hook** | Skrypt uruchamiany przed git commit — np. skanowanie sekretów | M12 |
| **Prompt Injection** | Atak na modele AI przez złośliwe instrukcje w danych wejściowych | M15 |
| **Prowler** | Open-source narzędzie do audytu bezpieczeństwa AWS | M13 |
| **Purple Team** | Współpraca Red i Blue Team dla poprawy detekcji | M7 |

## Q–R

| Termin | Definicja | Moduł |
|--------|-----------|-------|
| **QSA** | Qualified Security Assessor — certyfikowany audytor PCI DSS Level 1 | M17 |
| **RAG** | Red/Amber/Green — system semaforowy oceny metryk | M18 |
| **RAM Dump** | Kopia zawartości pamięci operacyjnej | M16 |
| **RASP** | Runtime Application Self-Protection — agent w działającej aplikacji | M12 |
| **RBAC** | Role-Based Access Control — uprawnienia oparte na rolach | M5 |
| **Retainer IR** | Umowa z firmą IR gwarantująca priorytetową obsługę | M16 |
| **RODO/GDPR** | Rozporządzenie o ochronie danych osobowych UE 2018 | M17 |
| **RPO** | Recovery Point Objective — max akceptowalna utrata danych | M16 |
| **RTO** | Recovery Time Objective — max czas przywrócenia systemu | M16 |

## S

| Termin | Definicja | Moduł |
|--------|-----------|-------|
| **SAQ** | Self-Assessment Questionnaire — PCI DSS samoocena | M17 |
| **SAST** | Static Application Security Testing — analiza kodu bez uruchamiania | M12 |
| **SBOM** | Software Bill of Materials — spis komponentów oprogramowania | M12, M14 |
| **SCA** | Software Composition Analysis — skanowanie podatności w zależnościach | M12, M14 |
| **Security Champion** | Developer ze szkoleniem security — łącznik z zespołem security | M12 |
| **Security Debt** | Zaległości: liczba × czas otwartych High/Critical findings | M18 |
| **Security Group** | Statefull firewall na poziomie instancji w AWS/Azure | M13 |
| **Security Posture** | Ogólny stan bezpieczeństwa organizacji | M18 |
| **Segmentacja sieci** | Podział na izolowane VLAN-y z kontrolowanym ruchem | M4 |
| **SIEM** | Security Information and Event Management — korelacja logów | M4, M20 |
| **SLSA** | Supply-chain Levels for Software Artifacts — poziomy bezpieczeństwa build | M14 |
| **SOAR** | Security Orchestration, Automation and Response | M15 |
| **SOC** | Security Operations Center | M15 |
| **SOC 2** | Standard audytowy dla dostawców usług (Trust Service Criteria) | M9 |
| **SOC 2 Type I/II** | Type I: projekt kontroli; Type II: skuteczność przez okres obserwacji | M9 |
| **SPF** | Sender Policy Framework — lista autoryzowanych serwerów wysyłki | M11 |
| **SPL** | Search Processing Language — język zapytań Splunk | M20 |
| **SPDX** | Software Package Data Exchange — format SBOM (Linux Foundation) | M14 |
| **Snort** | Open-source NIDS | M4, M20 |
| **SSDF** | NIST Secure Software Development Framework (SP 800-218) | M14 |
| **SSO** | Single Sign-On — jedno logowanie do wielu systemów | M5 |
| **SSP** | System Security Plan — dokument implementacji NIST 800-53 | M10 |
| **STIX** | Structured Threat Information Expression — format TI | M6 |
| **Suricata** | Nowoczesny wielowątkowy IDS/IPS | M20 |
| **Supply Chain Attack** | Atak przez kompromitację zaufanego dostawcy lub komponentu | M14 |

## T–Z

| Termin | Definicja | Moduł |
|--------|-----------|-------|
| **Tabletop Exercise** | Symulacja incydentu bez angażowania systemów | M16 |
| **Tailoring** | Dostosowanie baseline NIST 800-53 przez scoping i parametryzację | M10 |
| **Threat Hunting** | Proaktywne szukanie śladów ataku przed alertem SIEM | M6, M7 |
| **Threat Intelligence** | Informacje o zagrożeniach: IOC, TTP, grupy APT | M6 |
| **Threat Modeling** | Systematyczna identyfikacja zagrożeń dla systemu | M7, M12 |
| **Tokenizacja** | Zastąpienie wrażliwych danych bezużytecznym tokenem | M17 |
| **TOTP** | Time-based One-Time Password — kod OTP co 30 sekund | M5 |
| **TPRM** | Third-Party Risk Management — zarządzanie ryzykiem dostawców | M14, M19 |
| **TTP** | Tactics, Techniques, Procedures — profil zachowań grupy ATT&CK | M6 |
| **Typosquatting** | Złośliwy pakiet o nazwie podobnej do popularnego | M14 |
| **UEBA** | User and Entity Behavior Analytics — anomalie przez ML | M5, M15 |
| **UODO** | Urząd Ochrony Danych Osobowych — polski organ nadzorczy RODO | M17 |
| **VPC** | Virtual Private Cloud — izolowana sieć wirtualna w chmurze | M13 |
| **VPN** | Virtual Private Network — szyfrowany tunel | M4 |
| **WAF** | Web Application Firewall | M4 |
| **War Room** | Centrum dowodzenia podczas incydentu | M16 |
| **Wazuh** | Open-source SIEM + HIDS + FIM + ATT&CK mapping | M19, M20 |
| **WormGPT** | LLM bez guardrails — używany przez cyberprzestępców | M15 |
| **XDR** | Extended Detection and Response — endpoint + sieć + tożsamość | M15 |
| **Zeek/Bro** | Framework analizy sieciowej — strukturalne logi protokołów | M20 |
| **Zero Trust** | Model: 'Nigdy nie ufaj, zawsze weryfikuj' | M4, M5, M13 |
| **ZTNA** | Zero Trust Network Access — dostęp do aplikacji bez VPN | M4, M13 |

---

## Skróty — szybka tabela referencyjna

| Skrót | Rozwinięcie | Kategoria |
|-------|-------------|-----------|
| ABAC | Attribute-Based Access Control | IAM |
| ALE | Annualized Loss Expectancy | Risk |
| APT | Advanced Persistent Threat | Threat Intel |
| ATO | Authorization to Operate | Compliance |
| BCP | Business Continuity Plan | DR/BC |
| BEC | Business Email Compromise | Attacks |
| C2 | Command and Control | Attacks |
| CDE | Cardholder Data Environment | PCI DSS |
| CI/CD | Continuous Integration/Delivery | DevSecOps |
| CMDB | Configuration Management Database | Assets |
| CNAPP | Cloud-Native Application Protection Platform | Cloud |
| CSPM | Cloud Security Posture Management | Cloud |
| CVE | Common Vulnerabilities and Exposures | Vuln Mgmt |
| DAC | Discretionary Access Control | IAM |
| DAST | Dynamic Application Security Testing | AppSec |
| DLP | Data Loss Prevention | Data |
| DPA | Data Processing Agreement | Legal/RODO |
| DPIA | Data Protection Impact Assessment | Legal/RODO |
| DRP | Disaster Recovery Plan | DR/BC |
| EDR | Endpoint Detection and Response | Endpoint |
| ET | Emerging Threats | NIDS Rules |
| FAIR | Factor Analysis of Information Risk | Risk |
| FedRAMP | Federal Risk Authorization Management Program | Compliance |
| FIDO2 | Fast Identity Online 2 | Auth |
| FIM | File Integrity Monitoring | Detection |
| GRC | Governance Risk Compliance | Mgmt |
| HIDS | Host IDS | Detection |
| IAM | Identity and Access Management | IAM |
| IDS | Intrusion Detection System | Detection |
| IOC | Indicator of Compromise | Threat Intel |
| IOD | Inspektor Ochrony Danych | Legal/RODO |
| IPS | Intrusion Prevention System | Prevention |
| IRP | Incident Response Plan | IR |
| ISMS | Information Security Management System | Mgmt |
| JIT | Just-In-Time | IAM |
| KPI | Key Performance Indicator | Metrics |
| KRI | Key Risk Indicator | Metrics |
| KSC | Krajowy System Cyberbezpieczeństwa | Compliance |
| LAPS | Local Administrator Password Solution | IAM |
| LLM | Large Language Model | AI |
| MAC | Mandatory Access Control | IAM |
| MFA | Multi-Factor Authentication | Auth |
| MSSP | Managed Security Service Provider | Services |
| MTTD | Mean Time to Detect | Metrics |
| MTTR | Mean Time to Respond/Recover | Metrics |
| MTTM | Mean Time to Mitigate | Metrics |
| NAC | Network Access Control | Network |
| NDR | Network Detection and Response | Detection |
| NGFW | Next-Generation Firewall | Network |
| NIDS | Network IDS | Detection |
| NIS2 | Network and Information Security Directive 2 | Compliance |
| OPA | Open Policy Agent | Automation |
| PAM | Privileged Access Management | IAM |
| PCI DSS | Payment Card Industry Data Security Standard | Compliance |
| PHI | Protected Health Information | HIPAA |
| PICERL | Phases of IR | IR |
| PIR | Post-Incident Review | IR |
| QSA | Qualified Security Assessor | PCI DSS |
| RAG | Red/Amber/Green | Metrics |
| RASP | Runtime Application Self-Protection | AppSec |
| RBAC | Role-Based Access Control | IAM |
| RPO | Recovery Point Objective | DR/BC |
| RTO | Recovery Time Objective | DR/BC |
| SAQ | Self-Assessment Questionnaire | PCI DSS |
| SAST | Static Application Security Testing | AppSec |
| SBOM | Software Bill of Materials | Supply Chain |
| SCA | Software Composition Analysis | DevSecOps |
| SIEM | Security Information and Event Management | Detection |
| SLSA | Supply-chain Levels for Software Artifacts | Supply Chain |
| SOAR | Security Orchestration Automation Response | Automation |
| SOC | Security Operations Center | Operations |
| SPF | Sender Policy Framework | Email |
| SPL | Search Processing Language | SIEM |
| KQL | Kusto Query Language | SIEM |
| SPDX | Software Package Data Exchange | Supply Chain |
| SSO | Single Sign-On | IAM |
| SSP | System Security Plan | NIST 800-53 |
| TI | Threat Intelligence | Intel |
| TOTP | Time-based OTP | Auth |
| TPRM | Third-Party Risk Management | Supply Chain |
| TTP | Tactics Techniques Procedures | Threat Intel |
| UEBA | User Entity Behavior Analytics | Detection |
| UODO | Urząd Ochrony Danych Osobowych | Legal/RODO |
| VPC | Virtual Private Cloud | Cloud |
| VPN | Virtual Private Network | Network |
| WAF | Web Application Firewall | AppSec |
| XDR | Extended Detection and Response | Detection |
| ZTNA | Zero Trust Network Access | Network |

---

*Wersja 1.0 — czerwiec 2026. Kompilacja pojęć z modułów 1–20 kursu.*
