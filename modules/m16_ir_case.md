# Case Study: EnergyPL Sp. z o.o. — Ransomware i odtwarzanie w 72 godziny

**Moduł 16 · Awarie i odpowiedź na incydenty**

EnergyPL to regionalny dystrybutor energii (180 pracowników, systemy SCADA, SAP ERP, Microsoft 365). Piątek 16:45 — pracownik otwiera załącznik "Faktura_2026.zip". W ciągu 3 godzin ransomware Akira szyfruje 847 serwerów i stacji.

---

## Chronologia incydentu

**16:45** — otwarcie złośliwego załącznika na stacji WS-FIN-023.

**19:12** — pierwszy alert CrowdStrike: masowe szyfrowanie plików na udziale sieciowym `\\fileserver01\`. Analityk on-call odbiera SMS.

**19:18** — Incident Commander (CTO, Marek Nowak) powiadomiony. Deklaracja P1.

**19:25** — War room otwarty (Teams kanał `#incident-2026-0314`). Zaangażowani: CTO, CISO, 2 administratorów, firma IR (retainer aktywowany — czas reakcji 2h).

**19:31** — CrowdStrike network contain na WS-FIN-023 i 4 kolejnych hostach z alertami. Za późno — szyfrowanie już na 12 serwerach.

**20:15** — decyzja: odizolować całą sieć produkcyjną. Firewall rules blokują cały ruch east-west. Szyfrowanie zatrzymane.

**20:45** — firma IR połączona zdalnie. Rozpoczęcie zbierania artefaktów (RAM dumps z żywych zainfekowanych serwerów przed wyłączeniem).

**22:00** — UODO notification draft przygotowany przez prawnika (72h zegar tyka od 19:12).

**Sobota 08:00** — zakres: 847 systemów zaszyfrowanych. Backup status: ostatni backup piątek 02:00 (16h przed incydentem). Backupy offline — nieruszone przez ransomware.

**Sobota 10:00** — priorytetyzacja odtwarzania:
1. SAP ERP (core business) — RTO zdefiniowane: 48h
2. Active Directory — konieczne do wszystkiego
3. Systemy SCADA — oddzielna sieć OT, nieruszone
4. Stacje robocze — 180 pracowników

**Niedziela 18:00** — SAP ERP i AD odtworzone z backupów. Weryfikacja czystości (forensics potwierdza brak backdoorów).

**Poniedziałek 08:00** — pracownicy wracają do pracy na 140 stacjach (40 nadal w odtwarzaniu).

**Poniedziałek 09:30** — UODO zgłoszenie wysłane (68h od wykrycia — w terminie).

---

## Co zadziałało

✅ **Retainer IR** — firma forensics dostępna w 2h, w weekend
✅ **Backup offline** — ransomware nie dosięgnął backupów (reguła 3-2-1-1-0)
✅ **War room** — centralna koordynacja, jasny IC, decyzje szybkie
✅ **RAM dump przed wyłączeniem** — kluczowe artefakty dla forensics
✅ **72h UODO** — zgłoszenie w terminie

## Co zawiodło

❌ **Brak MFA na VPN** — initial access przez phishing + brak MFA umożliwił szybkie lateral movement
❌ **Czas detekcji 2h 27min** — zaszyfrowano 847 systemów zanim alarm
❌ **Brak segmentacji** — ransomware mógł się swobodnie poruszać east-west
❌ **Brak tabletop exercise** — pierwsza prawdziwa aktywacja IRP była chaotyczna przez 30 minut

---

## Koszty incydentu

| Pozycja | Kwota |
|---------|-------|
| Firma IR (forensics + 5 dni) | 120 000 PLN |
| Przestój 72h (szacunek utraconego przychodu) | 380 000 PLN |
| Nowy sprzęt (40 stacji bez możliwości odtworzenia) | 80 000 PLN |
| Prawnik (UODO, regulacje) | 35 000 PLN |
| Wdrożenie naprawcze (MFA, segmentacja, EDR tuning) | 95 000 PLN |
| **Łącznie** | **710 000 PLN** |

Okup nie zapłacony — backup offline umożliwił pełne odtworzenie.

---

## Pytania do dyskusji

1. Ransomware zaszyfrował 847 systemów w 2h 27min. Jakie kontrole mogły skrócić ten czas lub ograniczyć zasięg?
2. Firma ma RTO = 48h dla SAP ERP. Czy to wystarczające? Jak biznes powinien definiować RTO?
3. UODO zgłoszenie wysłano po 68h (w terminie 72h). Co by się stało gdyby przekroczono termin?
4. Decyzja o izolacji całej sieci produkcyjnej (pkt 20:15) zatrzymała szyfrowanie ale też zatrzymała działalność firmy. Jak IC powinien ważyć te dwie rzeczy?

---

*Przypadek syntetyczny. Scenariusz odzwierciedla typowy przebieg incydentu ransomware w sektorze energetycznym (CERT Polska, Mandiant 2024).*
