@echo off
echo Uruchamianie kursu Cybersecurity Control Playbook...

:: Przejdz do folderu projektu
cd /d "C:\Users\dariu\Documents\Cybersecurity_Control_Playbook"

:: Zabij stary serwer jesli dziala
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8080 "') do taskkill /F /PID %%a >nul 2>&1

:: Uruchom serwer HTTP w tle
start /B python -m http.server 8080

:: Odczekaj chwile
timeout /t 2 /nobreak >nul

:: Otworz w przegladarce
start http://localhost:8080/kurs-cyberbezpieczenstwo.html

echo Kurs dostepny pod: http://localhost:8080/kurs-cyberbezpieczenstwo.html
