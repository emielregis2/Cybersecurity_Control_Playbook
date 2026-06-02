# Case Study: MediCare Polska Sp. z o.o. — Wyciek danych przez byłego pracownika

**Moduł 5 · Zarządzanie tożsamością i dostępem (IAM)**

---

## Kontekst organizacji

**MediCare Polska Sp. z o.o.** to sieć prywatnych przychodni medycznych działająca w 5 miastach (Warszawa, Kraków, Wrocław, Gdańsk, Poznań). Zatrudnia 320 pracowników, w tym 85 lekarzy i specjalistów, 120 pracowników rejestracji i administracji, 35 osób IT i zarządczych.

Przetwarzane dane:
- Dane pacjentów (dane osobowe, PESEL, historia medyczna, wyniki badań) — ok. 180 000 rekordów
- Dane finansowe (faktury, płatności, NFZ)
- Dane pracownicze (wynagrodzenia, umowy, oceny)

Infrastruktura IT:
- Główny system HIS (Hospital Information System) — serwer lokalny
- Microsoft 365 (Teams, Outlook, SharePoint)
- System e-recepty — integracja z Centrum e-Zdrowia
- Active Directory — zarządzanie użytkownikami
- Brak SSO — każdy system ma oddzielne konta i hasła
- MFA: tylko dla VPN (od 3 miesięcy), brak dla M365 i HIS

**Zespół IT:** 4 osoby. Łukasz Wiśniewski — administrator systemów (7 lat doświadczenia), lider ds. IT.

---

## Incydent — przebieg chronologiczny

### 3 miesiące przed incydentem — zmiana stanowiska

Agnieszka Nowak (specjalista ds. rozliczeń z NFZ, 6 lat w firmie) składa rezygnację i zostaje zatrudniona przez konkurencyjną sieć przychodni. Odchodzi za porozumieniem stron, ostatni dzień pracy: 15 marca.

W systemie HR odnotowano rozwiązanie umowy. Jednak dział HR nie powiadomił IT o odejściu tego samego dnia. E-mail z informacją wysłano do IT dwa tygodnie później — z prośbą o "zamknięcie konta jak będzie czas".

### Dzień odejścia (15 marca, piątek, 16:45)

Agnieszka Nowak o 16:45 (15 minut przed końcem czasu pracy) eksportuje z systemu HIS bazę danych pacjentów: pełną listę 180 000 pacjentów z danymi osobowymi (imię, nazwisko, PESEL, adres, dane kontaktowe) jako plik Excel. Plik zapisuje na prywatnym pendrive.

Eksport nie generuje żadnego alertu — Agnieszka miała uprawnienia do eksportu danych w ramach swojej roli (rozliczenia NFZ wymagają eksportu danych do plików).

Jednocześnie wysyła na swoje prywatne konto Gmail dokumenty dotyczące procedur rozliczeniowych z NFZ i wzorów umów — z konta Outlook firmowego.

### Tydzień po odejściu (22 marca — 5 kwietnia)

Agnieszka Nowak loguje się do Microsoft 365 firmy (Teams, SharePoint) ze swojego prywatnego laptopa. Konto jest nadal aktywne.

Pobiera dodatkowe dokumenty z SharePoint:
- Listy kontraktów z ubezpieczycielami i warunki finansowe
- Bazy danych lekarzy współpracowników z danymi kontaktowymi
- Wewnętrzne procedury operacyjne przychodni

Łącznie 3 tygodnie dostępu po formalnym zakończeniu zatrudnienia.

### 5 tygodni po odejściu (22 kwietnia) — wykrycie

Łukasz Wiśniewski otrzymuje e-mail od prawnika z pytaniem czy były pracownik Agnieszka Nowak ma nadal dostęp do systemów firmy. Okazuje się że konkurencyjna przychodnia, do której przeszła Agnieszka, wysyła byłym pacjentom MediCare targetowane oferty telefonicznie — pacjenci rozpoznają firmę bo nikt inny nie ma ich numeru telefonu.

Łukasz sprawdza AD — konto Agnieszki aktywne. Sprawdza M365 — ostatnie logowanie: 3 dni temu. Sprawdza logi SharePoint — setki pobrań.

Konto zostaje zablokowane natychmiast.

### Następne dni — forensics i zgłoszenia

MediCare angażuje zewnętrzną firmę zajmującą się cyberbezpieczeństwem i prawników specjalizujących się w RODO.

Forensics ujawnia:
- Eksport bazy 180 000 pacjentów w ostatnim dniu pracy
- 3 tygodnie aktywnych sesji po odejściu
- Pobranie 47 plików z SharePoint o łącznej objętości 890 MB

**Zgłoszenia obowiązkowe:**
- UODO (72 godziny od wykrycia — spóźnione, bo wykrycie nastąpiło tygodnie po incydencie)
- Prokuratura (kradzież danych)
- Pacjenci (indywidualne zawiadomienia — 180 000 osób)

---

## Analiza przyczyn źródłowych

### Przyczyna bezpośrednia
Brak automatycznego (lub szybkiego) procesu dezaktywacji konta przy offboardingu — konto byłej pracownicy pozostało aktywne przez 5+ tygodni.

### Przyczyny systemowe

**1. Brak zintegrowanego procesu offboardingu**
Informacja o odejściu pracownika dotarła do IT z 2-tygodniowym opóźnieniem. Dezaktywacja kont nie była priorytetem. Nie istniała formalna procedura ani checklist offboardingowy.

Rozwiązanie: integracja HRIS z Active Directory — automatyczna dezaktywacja konta w momencie gdy HRIS odnotowuje datę zakończenia umowy.

**2. Nadmierne uprawnienia Agnieszki Nowak**
Rola "specjalista ds. rozliczeń NFZ" rzeczywiście wymaga dostępu do danych pacjentów — ale czy do eksportu 180 000 rekordów naraz? Eksport powinien być ograniczony do zakresu niezbędnego do rozliczeń (np. danego miesiąca, danej przychodni, bez wrażliwych danych diagnostycznych).

Rozwiązanie: granularne uprawnienia w HIS — eksport ograniczony zakresem, bez możliwości masowego eksportu bez dodatkowej autoryzacji.

**3. Brak DLP (Data Loss Prevention)**
System nie monitorował wysyłania dużych plików na prywatne adresy e-mail. Nikt nie wiedział że Agnieszka wysyłała dokumenty na prywatny Gmail.

Rozwiązanie: Microsoft Purview DLP (wbudowany w M365) z regułami blokującymi lub alertującymi wysyłkę plików z danymi osobowymi na zewnętrzne adresy.

**4. Brak alertów na masowy eksport danych**
Eksport 180 000 rekordów nie wygenerował żadnego alertu. To anomalia — normalna praca nie wymaga jednorazowego eksportu całej bazy pacjentów.

Rozwiązanie: UEBA (User and Entity Behavior Analytics) — alert gdy użytkownik eksportuje więcej niż X rekordów w jednej operacji.

**5. Brak MFA dla Microsoft 365**
Konto Agnieszki w M365 było chronione tylko hasłem. Po odejściu użyła tego hasła z prywatnego urządzenia. MFA nie zatrzymałoby tego ataku (miała dostęp do swojego telefonu) — ale zatrzymałoby sytuację gdyby atakujący zewnętrzny przejął jej hasło po odejściu.

**6. Brak monitorowania aktywności byłych pracowników**
Nikt nie sprawdzał logów dostępu. 3 tygodnie aktywnych sesji byłej pracownicy z prywatnego urządzenia — niezauważone.

Rozwiązanie: Microsoft Entra ID Protection i Defender for Cloud Apps — alert gdy nieznane urządzenie lub lokalizacja loguje się na konto.

---

## Analiza finansowa i prawna

### Koszty bezpośrednie

| Kategoria | Kwota (PLN) |
|-----------|-------------|
| Zewnętrzna firma IR (forensics, 2 tygodnie) | 55 000 |
| Kancelaria prawna (RODO, postępowanie karne) | 80 000 |
| Zawiadomienia 180 000 pacjentów (poczta, call center) | 120 000 |
| Nowe systemy bezpieczeństwa (DLP, UEBA, PAM) | 95 000 |
| **Suma bezpośrednia** | **350 000** |

### Kary i roszczenia (w toku)

| Pozycja | Kwota (PLN) |
|---------|-------------|
| Decyzja UODO (kara za naruszenie RODO — dane medyczne) | 1 200 000 (szacunek) |
| Roszczenia pacjentów (pozwy zbiorowe w przygotowaniu) | TBD |
| Szkody reputacyjne (szacowany odpływ pacjentów) | 800 000/rok |

### Koszt prewencji

Wdrożenie automatycznego offboardingu, UEBA i DLP: ~35 000 PLN jednorazowo + 20 000 PLN/rok (subskrypcje).

---

## Plan naprawczy — co MediCare wdrożyła

### Tydzień 1 — działania kryzysowe

1. Dezaktywacja kont wszystkich byłych pracowników (audyt wykazał 12 aktywnych kont osób które odeszły w ostatnich 6 miesiącach)
2. Wymuszony reset haseł dla wszystkich użytkowników M365 i HIS
3. Włączenie MFA dla M365 (Authenticator app dla wszystkich pracowników)
4. Rewokacja aktywnych sesji i tokenów OAuth dla wszystkich kont

### Miesiąc 1 — zmiany procesowe

**Automatyczny offboarding:**
```
HRIS (data zakończenia umowy) 
    → webhook/integracja 
    → AD konto dezaktywowane tego samego dnia
    → M365 sesje unieważnione
    → VPN dostęp usunięty
    → alert do IT i HR Manager
    → ticket do IT (zwrot sprzętu, przekazanie danych)
```

Integracja przez Microsoft Azure AD Connect + PowerShell runbook wyzwalany przez HRIS (API). Koszt: 0 PLN (w ramach M365 E3).

**Checklist offboardingu (nowa procedura):**
Dzień odejścia pracownika:
- [ ] HR informuje IT e-mailem min. 24h wcześniej (lub natychmiast przy nagłym odejściu)
- [ ] IT dezaktywuje konto AD (natychmiast)
- [ ] IT unieważnia sesje M365 i tokeny (natychmiast)
- [ ] IT archiwizuje skrzynkę pocztową (30 dni retencja)
- [ ] IT usuwa z grup aplikacyjnych (HIS, ERP, systemy zewnętrzne)
- [ ] Przełożony odbiera sprzęt i identyfikator
- [ ] IT audit log eksportów w ostatnich 30 dniach (weryfikacja czy nie było anomalii)

### Miesiąc 2 — DLP i UEBA

**Microsoft Purview DLP:**
Reguły zdefiniowane dla danych wrażliwych:
- Dane PESEL → blokada wysyłki zewnętrznej (poza @medicare.pl)
- Pliki z ponad 1000 rekordów → alert do SOC
- Wysyłka do gmail.com, hotmail.com, yahoo.com → blokada lub alert

**Reguły UEBA w Microsoft Sentinel:**
- Alert: użytkownik eksportuje >500 rekordów w jednej operacji
- Alert: logowanie z nieznanego urządzenia
- Alert: logowanie po godzinach pracy (po 20:00 i przed 6:00) z prywatnego urządzenia
- Alert: niemożliwa podróż (logowanie z dwóch różnych krajów w ciągu 2 godzin)

### Miesiąc 3 — granularne uprawnienia HIS

Przegląd i redefinicja uprawnień w systemie HIS:
- Rola "Rejestracja": dostęp do danych pacjentów — tylko aktualne wizyty, brak eksportu
- Rola "Lekarz": dostęp do swoich pacjentów, historia badań, brak eksportu do pliku
- Rola "Rozliczenia NFZ": dostęp do danych rozliczeniowych, eksport ograniczony do bieżącego miesiąca i wybranych przychodni, max 5000 rekordów naraz
- Rola "Administrator HIS": pełny dostęp, każda akcja logowana, wymagane JIT z PAM

---

## Wnioski dla dyrektora IT

Incydent MediCare pokazuje że zagrożenie wewnętrzne (insider threat) — w tym przypadku odchodzący pracownik — jest jednym z najtrudniejszych do wykrycia i najkosztowniejszych rodzajów incydentów bezpieczeństwa.

**1. Procesy biznesowe muszą być zsynchronizowane z IT**
Odejście pracownika to zdarzenie biznesowe, które musi automatycznie wyzwolić działanie IT. Nie może zależeć od tego czy HR wyśle e-maila i czy IT "znajdzie czas". Automatyzacja przez integrację HRIS↔AD jest konieczna.

**2. Legalny dostęp to nie to samo co bezpieczny dostęp**
Agnieszka miała legalne uprawnienia do eksportu danych — ale eksport 180 000 rekordów to anomalia której system powinien wykryć. Granularne uprawnienia i UEBA eliminują ten problem.

**3. Dane medyczne mają szczególny status prawny**
Naruszenie RODO w zakresie danych zdrowotnych (art. 9 RODO — dane szczególnej kategorii) wiąże się z najwyższymi karami. UODO może nałożyć karę do 4% rocznego obrotu lub 20 mln EUR. Dla MediCare to milionowe kary.

**4. Offboarding musi być tak samo priorytetowy jak onboarding**
Nowy pracownik bez dostępu to problem operacyjny — wszyscy to widzą. Były pracownik z dostępem to problem bezpieczeństwa — nikt tego nie widzi dopóki nie dojdzie do incydentu. Oba powinny być priorytetem.

**5. Koszt prewencji: 35 000 PLN. Koszt incydentu: 2+ mln PLN**
ROI bezpieczeństwa w tym przypadku: 57:1. Te liczby należy pokazać zarządowi przed następną dyskusją o budżecie na bezpieczeństwo.

---

## Pytania do dyskusji

1. MediCare nie miało złośliwego ataku zewnętrznego — miało pracownika który zabrał dane przy odejściu. Jakie są granice między "zabrałam swoje notatki" a "kradzieżą danych firmowych"? Jak polityka bezpieczeństwa powinna to adresować?

2. Agnieszka Nowak miała dostęp do eksportu danych — to było konieczne do jej pracy. Jak zaprojektować uprawnienia tak żeby umożliwić legalny dostęp operacyjny, jednocześnie uniemożliwiając masowy eksport?

3. Gdybyś miał wybrać jedną kontrolę, która mogłaby zapobiec temu incydentowi — co by to było i dlaczego?

4. UODO wymaga zgłoszenia naruszenia danych w ciągu 72 godzin. W tym przypadku naruszenie trwało 5 tygodni zanim zostało wykryte. Jakie procesy należy wdrożyć żeby wcześniej wykryć takie incydenty?

---

*Przypadek opisany na podstawie syntetycznych danych — firma i osoby są fikcyjne. Scenariusz odzwierciedla typowe wzorce incydentów insider threat w sektorze medycznym według raportów Ponemon Institute 2023 i CERT Polska 2024.*
