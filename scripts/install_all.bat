@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
echo [*] Starting Windows setup (Java 17 + Maven + Git)

:: Check admin
net session >nul 2>&1
if %errorLevel% NEQ 0 (
  echo [!] لطفاً این فایل را با Run as administrator اجرا کنید.
  pause
  exit /b 1
)

:: Try winget
where winget >nul 2>&1
if %errorLevel% EQU 0 (
  echo [*] winget detected. Installing packages...
  winget install -e --id Microsoft.OpenJDK.17 --accept-source-agreements --accept-package-agreements
  winget install -e --id Apache.Maven --accept-source-agreements --accept-package-agreements
  winget install -e --id Git.Git --accept-source-agreements --accept-package-agreements
) else (
  echo [!] winget در دسترس نیست.
  echo     لطفاً دستی نصب کنید:
  echo     - OpenJDK 17: https://adoptium.net
  echo     - Maven: https://maven.apache.org/download.cgi
  echo     - Git for Windows: https://git-scm.com/download/win
  pause
)

echo [*] Checking versions...
java -version
mvn -v
git --version

echo [*] Setup finished. برای اجرای پروژه:
echo     mvn spring-boot:run
pause