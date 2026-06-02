# Cybersecurity Control Playbook — Kurs ekspercki

Interaktywny kurs cyberbezpieczeństwa oparty na książce Jasona Edwardsa  
**„The Cybersecurity Control Playbook"** (Wiley, 2025).

---

## Architektura kursu

Kurs zbudowany jest w modularnej architekturze — treść każdego modułu
jest oddzielona od interfejsu:

```
Cybersecurity_Control_Playbook/
├── kurs-cyberbezpieczenstwo.html   ← shell nawigacyjny (UI)
├── modules/
│   ├── m01_kontrole.md             ← teoria (6000+ słów)
│   ├── m01_kontrole_case.md        ← business case (3000+ słów)
│   └── m01_kontrole_quiz.json      ← quiz (pytanie + opcje + wyjaśnienie)
├── start_kurs.bat                  ← uruchomienie jednym kliknięciem
└── README.md
```

Shell HTML ładuje pliki `.md` przez `fetch()` i renderuje je przez
`marked.js`. Treść jest w czystym Markdown — czytelna w każdym edytorze,
GitHubie, Obsidianie czy VS Code.

---

## Jak uruchomić

Kurs wymaga lokalnego serwera HTTP (przeglądarka blokuje `fetch()` dla
plików otwieranych bezpośrednio z dysku).

### Sposób 1 — jeden klik (Windows)

Kliknij dwukrotnie **`start_kurs.bat`** — skrypt automatycznie uruchomi
serwer Python i otworzy kurs w przeglądarce pod adresem:

```
http://localhost:8080/kurs-cyberbezpieczenstwo.html
```

### Sposób 2 — ręcznie

```bash
# W folderze projektu:
python -m http.server 8080
# Następnie otwórz w przeglądarce:
# http://localhost:8080/kurs-cyberbezpieczenstwo.html
```

**Wymagania:** Python 3.x (wbudowany w Windows 10/11), dowolna przeglądarka.

---

## Zawartość kursu

| Moduł | Temat | Źródło |
|---|---|---|
| 01 | Czym są kontrole bezpieczeństwa | R1 Edwards |
| 02 | Podejście oparte na ryzyku | R2 Edwards |
| 03 | Wdrożenie w małej firmie | R3 Edwards |
| 04 | Średnie przedsiębiorstwa | R4 Edwards |
| 05 | Duże organizacje i GRC | R5 Edwards |
| 06 | MITRE ATT&CK — wprowadzenie | R6 Edwards |
| 07 | Mapowanie zagrożeń do kontroli | R7 Edwards |
| 08 | Wzmacnianie obrony z MITRE DEFEND | R8 Edwards |
| 09 | Przegląd frameworków (NIST/ISO/CIS) | R9 Edwards |
| 10 | NIST 800-53 w praktyce | R10 Edwards |
| 11 | CIS 18 Controls | R11 Edwards |
| 12 | Zwinne bezpieczeństwo / DevSecOps | R12 Edwards |
| 13 | Bezpieczeństwo chmury | R13 Edwards |
| 14 | Bezpieczeństwo łańcucha dostaw | R14 Edwards |
| 15 | AI i automatyzacja w security | R15 Edwards |
| 16 | Awarie i odpowiedź na incydenty | R16 Edwards |
| 17 | Zgodność i audyt (GDPR/HIPAA/PCI) | R17 Edwards |
| 18 | Metryki i raportowanie | R18 Edwards |
| 19 | Narzędziownik praktyka | R19 Edwards |
| 20 | Systemy IDS i SIEM | Dodatkowy |

Każdy moduł = **~50 minut nauki**:
- Teoria: 6000+ słów (~33 min)
- Business case: 3000+ słów (~17 min)
- Quiz z wyjaśnieniem odpowiedzi

---

## Funkcje interfejsu

### Nawigacja
- **Sidebar** z listą 20 modułów, paskiem postępu i skrótem do każdego
- **3 zakładki** na moduł: Teoria / Case Study / Quiz
- Pełny scroll listy modułów — dostęp do modułu 1–20

### Śledzenie postępu
- Automatyczny zapis w `localStorage` przeglądarki
- **Data ukończenia** każdego modułu (widoczna w sidebarze)
- **Czas nauki** mierzony per moduł i łącznie
- **Wynik quizów %** — procent poprawnych odpowiedzi
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
- Zaznacz checkboxem moduły które chcesz zrobić dziś
- Przycisk **▶ Zacznij plan** przenosi do pierwszego modułu z planu
- Badge pokazuje liczbę zaplanowanych modułów

---

## Dodawanie nowych modułów

1. Stwórz 3 pliki w `modules/`:
   - `m0X_nazwa.md` — teoria (min. 6000 słów)
   - `m0X_nazwa_case.md` — business case (min. 3000 słów)
   - `m0X_nazwa_quiz.json` — quiz

2. Dodaj wpis do tablicy `MODULES` w `kurs-cyberbezpieczenstwo.html`:
```javascript
{ id:X, icon:'🔒', title:'Tytuł modułu', sub:'Podtytuł',
  diff:'Podstawowy', dur:'33 min', src:'RX', slug:'m0X_nazwa' }
```

Format quizu (`_quiz.json`):
```json
{
  "question": "Treść pytania?",
  "options": ["Opcja A", "Opcja B", "Opcja C", "Opcja D"],
  "correct": 2,
  "explanation": "Wyjaśnienie dlaczego C jest poprawne..."
}
```

---

## Źródła

Kurs oparty na:
- **Jason Edwards** — *The Cybersecurity Control Playbook* (Wiley, 2025)
- **Nicole Dove** — *Learning Cybersecurity Fundamentals* (O'Reilly, Early Release 2025)
- **Generative AI for Cybersecurity** (2024)

Treść opracowana na potrzeby nauki własnej. Wszelkie prawa do oryginałów
należą do ich autorów i wydawców.

---

*Ostatnia aktualizacja: czerwiec 2026*
