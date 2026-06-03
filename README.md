# Cybersecurity Control Playbook — Interaktywny kurs cyberbezpieczeństwa

Kompletny, interaktywny kurs cyberbezpieczeństwa oparty na książce Jasona Edwardsa  
**„The Cybersecurity Control Playbook"** (Wiley, 2025).

**21 modułów · 210 pytań quizowych · Glossariusz 200+ pojęć · Tryb nauki z planem**

---

## Struktura projektu

```
Cybersecurity_Control_Playbook/
├── kurs-cyberbezpieczenstwo.html   ← shell nawigacyjny (cały UI + logika)
├── modules/                        ← 61 plików treści
│   ├── m01_kontrole.md             ← teoria (6 000+ słów)
│   ├── m01_kontrole_case.md        ← business case (3 000+ słów)
│   ├── m01_kontrole_quiz.json      ← quiz (10 pytań, format tablicy)
│   ├── ...
│   ├── m20_ids_siem.md / _case.md / _quiz.json
│   └── m21_glossariusz.md          ← słownik 200+ pojęć A–Z
├── start_kurs.bat                  ← uruchomienie jednym kliknięciem
└── README.md
```

Shell HTML ładuje pliki `.md` przez `fetch()` i renderuje je przez `marked.js`.  
Treść jest w czystym Markdown — czytelna w GitHubie, Obsidianie i każdym edytorze.

---

## Jak uruchomić

> Kurs wymaga lokalnego serwera HTTP — przeglądarka blokuje `fetch()` dla plików
> otwieranych bezpośrednio z dysku (`file://`).

### Sposób 1 — jeden klik (Windows)

Kliknij dwukrotnie **`start_kurs.bat`** — skrypt uruchomi serwer Python i otworzy
kurs w przeglądarce:

```
http://localhost:8080/kurs-cyberbezpieczenstwo.html
```

### Sposób 2 — ręcznie (dowolny system)

```bash
cd Cybersecurity_Control_Playbook
python -m http.server 8080
# Otwórz: http://localhost:8080/kurs-cyberbezpieczenstwo.html
```

**Wymagania:** Python 3.x (wbudowany w Windows 10/11), dowolna nowoczesna przeglądarka.

---

## Zawartość kursu — 21 modułów

| # | Moduł | Zagadnienia | Poziom |
|---|-------|-------------|--------|
| 01 | Kontrole bezpieczeństwa | Matryca 3×3, Prewencja/Detekcja/Korekcja, Defence in Depth | Podstawowy |
| 02 | Zarządzanie ryzykiem | Risk Register, FAIR, ALE, Risk Treatment, Risk Appetite | Podstawowy |
| 03 | Bezpieczeństwo MŚP | Quick wins, backup 3-2-1, BEC, BYOD, phishing | Podstawowy |
| 04 | Sieci i infrastruktura | Firewall, NGFW, segmentacja, DMZ, VPN, IDS/IPS, Zero Trust | Średni |
| 05 | Tożsamość i dostęp (IAM) | MFA, FIDO2, PAM, LAPS, RBAC, JIT, UEBA, Pass-the-Hash | Średni |
| 06 | MITRE ATT&CK | Taktyki, techniki, APT, Kill Chain, Navigator, TI | Średni |
| 07 | Mapowanie zagrożeń | Threat Modeling, Purple Team, Atomic Red Team, NIS2 | Zaawansowany |
| 08 | MITRE D3FEND | Harden/Detect/Isolate/Deceive/Evict, Honeypot, FIM | Zaawansowany |
| 09 | Frameworki | NIST CSF, ISO 27001, CIS Controls, SOC 2, NIS2, KSC | Średni |
| 10 | NIST SP 800-53 | Katalog kontroli, SSP, tailoring, FedRAMP, OSCAL | Zaawansowany |
| 11 | CIS 18 Controls | IG1/IG2/IG3, 153 safeguards, roadmapa wdrożenia | Średni |
| 12 | DevSecOps | Shift Left, CI/CD, SAST, DAST, SCA, SBOM, OWASP Top 10 | Średni |
| 13 | Bezpieczeństwo chmury | AWS/Azure/GCP, Shared Responsibility, CSPM, Zero Trust | Zaawansowany |
| 14 | Łańcuch dostaw | Supply chain attack, SBOM, SLSA, TPRM, dependency confusion | Zaawansowany |
| 15 | AI i automatyzacja | SOAR, UEBA, NDR, XDR, AI phishing, prompt injection, LLM | Zaawansowany |
| 16 | Reagowanie na incydenty | PICERL, IRP, forensics, RAM dump, BCP, DRP, RTO/RPO | Zaawansowany |
| 17 | Zgodność i audyt | RODO/GDPR, PCI DSS, HIPAA, audyt, tokenizacja, DPA | Średni |
| 18 | Metryki i raportowanie | KPI/KRI, MTTD, FAIR/ALE, dashboard, raport dla zarządu | Średni |
| 19 | Narzędziownik praktyka | Szablony Risk Register, IRP, offboarding, open-source tools | Podstawowy |
| 20 | IDS i SIEM | Snort, Zeek, Suricata, Wazuh, reguły korelacji, alert fatigue | Zaawansowany |
| 21 | 📖 Glossariusz | Słownik 200+ pojęć A–Z + tabela 80+ skrótów z całego kursu | Reference |

Każdy moduł 1–20 zawiera:
- **Teorię** — 6 000+ słów (~33 min czytania)
- **Business Case** — scenariusz z polskiej firmy (~15 min)
- **Quiz** — 10 pytań z pełnym wyjaśnieniem każdej odpowiedzi

---

## Funkcje interfejsu

### Nawigacja i quizy
- **Sidebar** z listą 21 modułów, paskiem postępu i znacznikami ukończenia
- **3 zakładki** per moduł: Teoria / Case Study / Quiz
- **Quiz z nawigacją** — 10 pytań per moduł z przyciskami Poprzednie/Następne
- **Pasek postępu quizu** — kolorowe kropki (zielona = poprawna, czerwona = błędna)
- **Wynik końcowy** — % i n/10 po odpowiedzeniu na wszystkie pytania

### Feedback po każdym pytaniu
Po udzieleniu odpowiedzi quiz natychmiast pokazuje:
- Twoja odpowiedź podświetlona (zielona = OK, czerwona = błąd)
- **Prawidłowa odpowiedź** zawsze wyróżniona na zielono
- **Wyjaśnienie** dlaczego dana odpowiedź jest poprawna i dlaczego inne są błędne

### Śledzenie postępu
- Automatyczny zapis w `localStorage` przeglądarki
- Data ukończenia każdego modułu widoczna w sidebarze
- Łączny czas nauki mierzony per moduł
- Wyniki quizów (%) na liście modułów
- **Eksport / Import XML** — przenoszenie postępu między komputerami

Format XML postępu:
```xml
<module id="1" status="completed"
  completedAt="2026-06-02T12:34:56Z"
  timeSpent="1240"
  quizCorrect="true"/>
```

### Plan nauki
- Panel **🗓 Plan nauki** w sidebarze
- Checkbox do zaznaczenia modułów na dany dzień
- Przycisk **▶ Zacznij plan** przenosi do pierwszego modułu z planu
- Badge z liczbą zaplanowanych modułów

---

## Format quizu (`_quiz.json`)

Każdy plik quizu zawiera tablicę 10 pytań:

```json
{
  "module": 4,
  "title": "Bezpieczeństwo sieci i infrastruktury",
  "questions": [
    {
      "id": 1,
      "question": "Treść jasno sformułowanego pytania z kontekstem?",
      "options": [
        "Odpowiedź A",
        "Odpowiedź B — poprawna",
        "Odpowiedź C",
        "Odpowiedź D"
      ],
      "correct": 1,
      "explanation": "Wyjaśnienie dlaczego B jest poprawna i dlaczego A, C, D są błędne..."
    }
  ]
}
```

> **Uwaga:** Silnik quizów obsługuje też starszy format z pojedynczym pytaniem
> (`{question, options, correct, explanation}`) dla zachowania kompatybilności wstecznej.

---

## Dodawanie nowych modułów

1. Stwórz 3 pliki w `modules/`:
   ```
   m0X_nazwa.md          ← teoria (min. 6 000 słów)
   m0X_nazwa_case.md     ← business case (min. 3 000 słów)
   m0X_nazwa_quiz.json   ← quiz (format tablicy questions[])
   ```

2. Dodaj wpis do tablicy `MODULES` w `kurs-cyberbezpieczenstwo.html`:
   ```javascript
   { id:X, icon:'🔒', title:'Tytuł modułu', sub:'Podtytuł',
     diff:'Podstawowy', dur:'33 min', src:'RX', slug:'m0X_nazwa' }
   ```

---

## Statystyki projektu

| Metryka | Wartość |
|---------|---------|
| Modułów | 21 |
| Plików treści | 61 |
| Pytań quizowych | 210 |
| Pojęć w glossariuszu | 200+ |
| Słów teorii (łącznie) | ~120 000 |
| Czas nauki (szacowany) | ~17 godzin |

---

## Źródła i literatura

Kurs oparty na:
- **Jason Edwards** — *The Cybersecurity Control Playbook* (Wiley, 2025)
- **Nicole Dove** — *Learning Cybersecurity Fundamentals* (O'Reilly, 2025)
- MITRE ATT&CK Framework (attack.mitre.org)
- MITRE D3FEND Framework (d3fend.mitre.org)
- CIS Controls v8 (cisecurity.org)
- NIST SP 800-53 Rev. 5 (nvlpubs.nist.gov)
- NIST Cybersecurity Framework 2.0
- OWASP Top 10 (2021)
- PCI DSS v4.0

Treść opracowana na potrzeby nauki własnej.  
Wszelkie prawa do oryginałów należą do ich autorów i wydawców.

---

*Ostatnia aktualizacja: czerwiec 2026 · 21 modułów kompletnych*
