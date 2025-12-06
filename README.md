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

## Helper scripts

# OS Setup Script

A small installer that automates common system configuration and developer tooling setup on a
Debian/Ubuntu-based system. The repository contains a primary installer script: `install.sh`.

Read the script before running it to understand and customize the exact steps it will perform.

**Script:** `install.sh`

## What this script does (summary)

- Updates the system package lists and upgrades installed packages.
- Installs base terminal and development utilities via APT (curl, wget, git, unzip, zip, ca-certificates,
  gnupg, lsb-release, build-essential, software-properties-common, htop, tree, jq, mc, xclip,
  python3, python3-pip).
- Installs the Fira Code font (`fonts-firacode`).
- Installs Visual Studio Code via the Microsoft APT repository.
- Installs Docker Engine from Docker's official repository and related packages, enables the service
  and attempts to add the current user to the `docker` group.
- Adds the Papirus icon theme PPA if not present.
- Installs VLC and related packages.
- Configures Git global settings (name, email, default branch `main`, core editor `code --wait`).
- Adds a small alias to `~/.bashrc` and generates an ed25519 SSH keypair at `~/.ssh/id_ed25519` if
  one does not already exist.

## Prerequisites

- Debian/Ubuntu-based distribution (the script uses `apt` and assumes standard Ubuntu/Debian fields).
- A user with `sudo` privileges.

## Usage

1. Clone the repository and change into it:

```bash
git clone <repository-url>
cd os-setup
```

2. Make the installer executable (optional):

```bash
chmod +x install.sh
```

3. Inspect `install.sh` and edit any steps you want to change.

4. Run the installer and then run the helper `git.py` that clones repositories.

One-line (with leading exclamation mark as requested):

```bash
!./install.sh && python3 git.py
```

Or run step-by-step:

```bash
./install.sh
python3 git.py
```

Notes:
- `git.py` will clone repositories into `~/.projects` (the installer now ensures this directory exists).
- The installer prompts for your Git name and email, and will request `sudo` when needed.

## Helper scripts

This repository also contains small helper scripts (see files in the repo). For example the
`add_inputrc_ignorecase.sh` helper ensures `~/.inputrc` contains `set completion-ignore-case on`.

## Troubleshooting

- If Docker commands still require `sudo` after running the script, log out and log back in (or reboot)
  to refresh group membership.

## Contributing

Open an issue or submit a pull request with improvements or suggestions.

## License

This project is licensed under the MIT License.
