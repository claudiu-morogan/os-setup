#!/usr/bin/env bash
set -euo pipefail

# Pretty banner
echo '##############################'
echo '# Preparing to setup your PC #'
echo '#           MASTER           #'
echo '##############################'
echo

# Ensure default projects directory exists
echo "Ensuring $HOME/.projects exists..."
mkdir -p "$HOME/.projects"
chmod 755 "$HOME/.projects" || true

# --- Helpers ---
# Install a list of apt packages only if they're not already installed
ensure_packages() {
  local pkg missing=()
  for pkg in "$@"; do
    if dpkg -s "$pkg" >/dev/null 2>&1; then
      echo "$pkg: already installed, skipping"
    else
      missing+=("$pkg")
    fi
  done
  if [ "${#missing[@]}" -gt 0 ]; then
    echo "Installing: ${missing[*]}"
    sudo apt-get install -y "${missing[@]}"
  fi
}


# --- Collect Git identity ---
read -rp "Enter your Git full name (e.g. Claudiu Morogan): " git_name
read -rp "Enter your Git email address: " git_email

# --- Update system ---
echo
echo "Updating system..."
sudo apt-get update -y
sudo apt-get upgrade -y

# --- Base terminal/dev utilities ---
echo
echo "Installing terminal utilities..."
ensure_packages \
  curl wget git unzip zip ca-certificates gnupg lsb-release \
  build-essential software-properties-common \
  htop tree jq mc xclip python3 python3-pip

set -euo pipefail

# Helper: ensure ~/.inputrc contains setting to ignore case during completion
TARGET="$HOME/.inputrc"
LINE='set completion-ignore-case on'

if [ -f "$TARGET" ]; then
  if grep -qF "$LINE" "$TARGET"; then
    echo "$LINE already present in $TARGET"
    exit 0
  else
    echo "Appending ignore-case setting to $TARGET"
    printf "\n# Enable case-insensitive tab completion\n%s\n" "$LINE" >> "$TARGET"
  fi
else
  echo "Creating $TARGET with ignore-case setting"
  cat > "$TARGET" <<'EOF'
# Readline inputrc - created by os-setup helper
# Enable case-insensitive tab completion
set completion-ignore-case on
EOF
fi

# Ensure reasonable permissions
chmod 644 "$TARGET" || true

echo "Done. Current $TARGET contents:"
sed -n '1,200p' "$TARGET"

# --- Fonts ---
echo
echo "Installing FiraCode..."
ensure_packages fonts-firacode

# --- VS Code (no snap; use Microsoft apt repo) ---
echo
echo "Installing VS Code via Microsoft apt repo..."
if command -v code >/dev/null 2>&1; then
  echo "VS Code already installed. Skipping."
else
  sudo install -d -m 0755 /etc/apt/keyrings
  curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
    | sudo gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg

  ARCH="$(dpkg --print-architecture)"
  echo "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
    | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null

  sudo apt-get update -y
  ensure_packages code
fi



# Installing Docker Engine
echo "Installing Docker Engine (official repo)..."
if command -v docker >/dev/null 2>&1; then
  echo "Docker already installed. Skipping Docker installation."
else
  sudo apt-get remove -y docker docker-engine docker.io containerd runc || true

  sudo apt-get update -y
  ensure_packages ca-certificates curl gnupg lsb-release

  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

  ARCH="$(dpkg --print-architecture)"
  CODENAME="$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")"

  echo "deb [arch=$ARCH signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $CODENAME stable" \
    | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

  sudo apt-get update -y
  ensure_packages docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  sudo systemctl enable --now docker
fi




# Adding ppa for icon pack
# Adding ppa for icon pack
if [ ! -f /etc/apt/sources.list.d/papirus-ubuntu-papirus.list ]; then
  sudo add-apt-repository ppa:papirus/papirus -y && sudo apt-get update -y
else
  echo "Papirus PPA already present, skipping"
fi

echo 'Installing VLC'
ensure_packages vlc vlc-plugin-access-extra libbluray-bdj libdvdcss2

# Docker setup
if ! getent group docker >/dev/null 2>&1; then
  sudo groupadd docker
fi

if ! groups "$USER" | grep -qw docker; then
  sudo usermod -aG docker "$USER"
  echo "$USER added to docker group; you may need to log out and log back in for this to take effect"
else
  echo "$USER is already in the docker group"
fi

docker --version || true

# --- Configure Git ---
echo
echo "Configuring Git..."
git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.editor "code --wait" || true

# --- Add alias for c='clear && cd ~/Desktop' ---
echo
echo "Adding alias c='clear && cd ~/Desktop' ..."
BASHRC="$HOME/.bashrc"
if ! grep -q "alias c=" "$BASHRC"; then
  echo "alias c='clear && cd ~/Desktop'" >> "$BASHRC"
fi

# --- Generate SSH key for Git hosting ---
echo
echo "Setting up SSH key for Git hosting..."

SSH_DIR="$HOME/.ssh"
KEY_PATH="$SSH_DIR/id_ed25519"
PUB_PATH="${KEY_PATH}.pub"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

if [[ -f "$KEY_PATH" ]]; then
  echo "An SSH key already exists at $KEY_PATH"
else
  echo "Generating a new ed25519 SSH key..."
  ssh-keygen -t ed25519 -C "$git_email" -f "$KEY_PATH" -N ""
fi

if ! pgrep -u "$USER" ssh-agent >/dev/null 2>&1; then
  eval "$(ssh-agent -s)"
fi
ssh-add "$KEY_PATH" >/dev/null

echo
echo "Public SSH key:"
echo "------------------------------------------------------------"
cat "$PUB_PATH"
echo "------------------------------------------------------------"

echo "All setup, enjoy!"
