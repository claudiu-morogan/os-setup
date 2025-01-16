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

3. Run the script:
    ```bash
    ./install.sh
    ```

## Notes

- Ensure you have `sudo` privileges before running the script.
- The script will prompt you to enter your email address for generating an SSH key.
- Some applications are installed using `snap`, so make sure `snapd` is installed on your system.

## License

This project is licensed under the MIT License.

## Contributing

Feel free to submit issues or pull requests if you have any improvements or suggestions.

## Screenshots

![Setup Script](https://via.placeholder.com/800x400.png?text=Setup+Script+Running)

Enjoy your newly set up PC!