#!/usr/bin/env python3
"""
Simple repo cloner example.

- Define repos in the `repos` list (each repo is a dict).
- The script clones a repo when repo['clone'] is True.
- Skips if the target folder already exists.
"""

import subprocess
import os
from pathlib import Path

# Where to clone repos by default
BASE_DIR = Path.home() / ".projects"

# Example list (vector) of repos
repos = [
    {"name": "os-setup", "url": "https://github.com/claudiu-morogan/os-setup.git", "clone": True},
    {"name": "Aplicatieweb", "url": "https://github.com/claudiu-morogan/aplicatieweb.git", "clone": True},
    {"name": "domainChecker", "url": "https://github.com/claudiu-morogan/domainChecker.git", "clone": True},
    {"name": "pocket-admin", "url": "https://github.com/claudiu-morogan/pocket-admin.git", "clone": True},
    {"name": "3reiSudEst", "url": "https://github.com/claudiu-morogan/3reiSudEst.git", "clone": True},
    {"name": "retete", "url": "https://github.com/claudiu-morogan/retete.git", "clone": True},
    {"name": "smarty_toolkit", "url": "https://github.com/claudiu-morogan/smarty_toolkit.git", "clone": True},
    {"name": "cv", "url": "https://github.com/claudiu-morogan/cv.git", "clone": True},
    {"name": "ytb", "url": "https://github.com/claudiu-morogan/ytb.git", "clone": True},
    {"name": "licenta", "url": "https://github.com/claudiu-morogan/licenta.git", "clone": True},
    # Add more repos here
]

def clone_repo(repo, base_dir=BASE_DIR):
    target = base_dir / repo["name"]
    if target.exists():
        print(f"Skipping {repo['name']}: target exists at {target}")
        return
    print(f"Cloning {repo['name']} -> {target}")
    base_dir.mkdir(parents=True, exist_ok=True)
    try:
        subprocess.run(["git", "clone", repo["url"], str(target)], check=True)
        print(f"Cloned {repo['name']}")
    except subprocess.CalledProcessError as e:
        print(f"Failed to clone {repo['name']}: {e}")

def main():
    for repo in repos:                    # iterate the vector/list
        if repo.get("clone"):             # condition to execute git clone
            clone_repo(repo)
        else:
            print(f"Not set to clone: {repo['name']}")

if __name__ == "__main__":
    main()