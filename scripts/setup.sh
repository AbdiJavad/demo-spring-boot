#!/usr/bin/env bash
set -e

IS_CODESPACES=false
if [[ "$1" == "--codespaces" ]]; then
  IS_CODESPACES=true
fi

echo "[*] Starting setup..."
echo "OS: $(uname -a)"

install_linux() {
  echo "[*] Detected Linux. Installing packages with apt..."
  sudo apt-get update -y
  sudo apt-get install -y wget curl unzip zip git
  # Java & Maven are installed by devcontainer features, but ensure presence:
  if ! command -v java >/dev/null 2>&1; then
    sudo apt-get install -y openjdk-17-jdk
  fi
  if ! command -v mvn >/dev/null 2>&1; then
    sudo apt-get install -y maven
  fi
}

install_macos() {
  echo "[*] Detected macOS. Checking Homebrew..."
  if ! command -v brew >/dev/null 2>&1; then
    echo "[!] Homebrew نصب نیست. لطفاً از https://brew.sh نصب کنید و دوباره اجرا کنید."
    exit 1
  fi
  brew update
  brew install openjdk@17 maven git
  sudo ln -sf $(brew --prefix)/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk || true
}

case "$(uname)" in
  Linux*) install_linux ;;
  Darwin*) install_macos ;;
  *) echo "[!] سیستم‌عامل پشتیبانی نمی‌شود"; exit 1 ;;
esac

echo "[*] Versions:"
java -version || true
mvn -v || true
git --version || true

if $IS_CODESPACES ; then
  echo "[*] Codespaces detected. Creating Maven wrapper if missing..."
  if [ ! -f "mvnw" ]; then
    mvn -N wrapper
  fi
  echo "[*] Done. You can run: mvn spring-boot:run"
fi

echo "[*] Setup finished successfully."