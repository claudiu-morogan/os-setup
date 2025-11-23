# OS Setup Script

Welcome to the **OS Setup Script**! This script will help you set up your PC with essential tools and applications.

## Features

- Updates the system
- Installs terminal utilities (mc, htop, neofetch, xclip, git, docker, curl, python3, pip)
- Adds PPA for icon pack
- Installs VLC media player
- Sets up Docker
- Generates an SSH key (commented out by default)
- Installs FiraCode font
- Installs development tools (VSCode, PHPStorm, Datagrip)

## Usage

1. Clone the repository:
    ```bash
    git clone <repository-url>
    cd os-setup
    ```

2. Make the script executable:
    ```bash
    chmod +x install.sh
    ```

# OS Setup Script

A small installer that automates common system configuration and developer tooling setup on a
Debian/Ubuntu-based system. The repository contains a single script: `install.sh`.

Read the script before running it to understand and customize the exact steps it will perform.

**Script:** `install.sh`

## What this script actually does

- Updates the system package lists and upgrades installed packages (`apt-get update && upgrade`).
- Installs base terminal and development utilities via APT:
    `curl`, `wget`, `git`, `unzip`, `zip`, `ca-certificates`, `gnupg`, `lsb-release`, `build-essential`,
    `software-properties-common`, `htop`, `tree`, `jq`, `mc`, `xclip`, `python3`, `python3-pip`.
- Installs the Fira Code font (`fonts-firacode`).
- Installs Visual Studio Code using the official Microsoft APT repository (not via Snap).
- Installs Docker Engine from Docker's official repository and the packages:
    `docker-ce`, `docker-ce-cli`, `containerd.io`, `docker-buildx-plugin`, `docker-compose-plugin`.
    The script enables and starts the Docker service and attempts to add the current user to the
    `docker` group.
- Adds the Papirus icon theme PPA (`ppa:papirus/papirus`) if not already present.
- Installs VLC and related packages: `vlc`, `vlc-plugin-access-extra`, `libbluray-bdj`, `libdvdcss2`.
- Configures Git global settings (name, email, default branch `main`, core editor `code --wait`).
- Adds a small alias to `~/.bashrc`: `alias c='clear && cd ~/Desktop'` (if not present).
- Generates an `ed25519` SSH keypair at `~/.ssh/id_ed25519` if one does not already exist,
    starts `ssh-agent`, and adds the key to the agent; the public key is printed to the terminal.

## Prerequisites

- A Debian/Ubuntu-based distribution (the script relies on `apt` and Ubuntu/Debian OS-release fields).
- A user with `sudo` privileges.
- The script does not rely on Snap for VS Code (it uses the Microsoft apt repo). If you prefer snaps,
    edit `install.sh` accordingly.

## Usage

1. Clone the repository and change into it:

```bash
git clone <repository-url>
cd os-setup
```

2. Make the installer executable:

```bash
chmod +x install.sh
```

3. Inspect `install.sh` and edit any steps you want to change (packages, repos, or optional parts).

4. Run the installer:

```bash
./install.sh
```

The script will prompt for your Git name and email, and will request `sudo` when it needs elevated
privileges. It prints the generated SSH public key at the end so you can copy it to your Git host.

## Notes & Troubleshooting

- If Docker commands require `sudo` after the script runs, log out and log back in (or reboot) so
    group membership changes take effect.
- If an APT install fails, fix the underlying issue and re-run the script or install the failing
    package manually.
- The script installs specific packages listed above — remove or add packages in `install.sh` if you
    need a different set.

## Contributing

Open an issue or submit a pull request with improvements or suggestions.

## License

This project is licensed under the MIT License.
