# Case Study: MedDevice Sp. z o.o. — Log4Shell w zależności dostawcy

**Moduł 14 · Bezpieczeństwo łańcucha dostaw**

MedDevice to producent oprogramowania dla diagnostyki medycznej (30 pracowników, 85 szpitali jako klientów). System używa kilku bibliotek Java — w tym log4j-core 2.14.1 w bibliotece zewnętrznego dostawcy analitycznego (DataAnalyticsPL Sp. z o.o.).

**10 grudnia 2021:** CVE-2021-44228 (Log4Shell) — CVSS 10.0. Każdy serwer z log4j-core <2.15.0 jest zdalnie exploitowalny.

**Problem MedDevice:**
- Brak SBOM — nie wiadomo czy używają log4j
- DataAnalyticsPL dostarcza bibliotekę jako JAR bez dokumentacji zależności
- 85 szpitali dzwoni z pytaniem "czy jesteście bezpieczni?"

---

## Godzina 0–24: Chaos bez SBOM

CTO (Andrzej Malinowski) zaczyna ręczne szukanie:
- Przeszukiwanie kodu źródłowego przez `grep -r "log4j" .`
- Sprawdzanie pom.xml i build.gradle
- Kontakt z DataAnalyticsPL — "sprawdzamy, wrócimy jutro"

Po 18 godzinach: niepewność — bezpośrednia zależność log4j nie znaleziona, ale tranzytywna?

**DataAnalyticsPL po 36 godzinach:** "Tak, używamy log4j-core 2.14.1 w naszej bibliotece. Aktualizacja w tygodniu."

**Skutek braku SBOM:** 36 godzin niepewności, 85 szpitali w panice, reputacyjne szkody.

---

## Godzina 36+: Działania natychmiastowe

Podczas oczekiwania na patch od DataAnalyticsPL — workaround: `-Dlog4j2.formatMsgNoLookups=true` w JVM startup flags. Wdrożony na wszystkich 85 klientach w ciągu 8 godzin.

Po tygodniu: nowa wersja biblioteki od DataAnalyticsPL z log4j 2.16.1.

---

## Plan po incydencie: SBOM i TPRM

**Wdrożenie SBOM:**
```bash
# Generowanie SBOM dla każdego release
mvn org.cyclonedx:cyclonedx-maven-plugin:makeAggregateBom
# Output: bom.xml (CycloneDX format)
```

**Wymaganie SBOM od dostawców:**
Nowy paragraf w umowach z DataAnalyticsPL i 3 innymi dostawcami bibliotek:
*"Dostawca zobowiązuje się dostarczać SBOM (format CycloneDX lub SPDX) dla każdej wersji dostarczanej biblioteki wraz z informacją o znanych podatnościach (CVE) dla wszystkich komponentów."*

**Inwentaryzacja dostawców:**
Stworzono rejestr 23 zewnętrznych zależności (biblioteki, SDK, API) z klasyfikacją ryzyko i kontaktem awaryjnym.

**Automatyczne CVE monitoring:**
OWASP Dependency-Check w CI/CD pipeline — budowanie blokowane przy Critical CVE.

---

## Porównanie: z SBOM vs bez

| Krok | Bez SBOM (rzeczywistość) | Z SBOM (scenariusz) |
|------|--------------------------|---------------------|
| Identyfikacja ekspozycji | 36 godzin | 15 minut (query SBOM) |
| Komunikacja z klientami | "sprawdzamy" przez 36h | "tak/nie" w godzinę |
| Wdrożenie workaround | 8 godzin po identyfikacji | 8 godzin od 0 |
| Pełna remediacja | 10 dni | 10 dni (patch od dostawcy) |

---

## Wnioski

1. **SBOM skraca identyfikację z 36h do 15 minut** — ROI jest natychmiastowy przy każdym CVE
2. **Wymagaj SBOM od dostawców bibliotek** — jeśli dostawca nie może dostarczyć SBOM, to poważny red flag
3. **Tranzytywne zależności są niewidoczne bez SBOM** — Log4Shell był w zależności zależności
4. **Plan komunikacji kryzysowej dla supply chain** — 85 klientów czekało na odpowiedź. Miej gotowy template

---

*Scenariusz oparty na rzeczywistych wzorcach reakcji na Log4Shell w grudniu 2021. Firma syntetyczna.*
