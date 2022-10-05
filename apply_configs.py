#!/usr/bin/env python
"""
Apply the configs in this dotfiles repo.

NOTE: it's assumed that install-pyenv.sh has been run.
"""

import argparse
import logging
import os
import shutil

from git import Repo
from git.exc import InvalidGitRepositoryError, NoSuchPathError


# It's assumed that this script will be run from the top-level repo directory
REPO_DIR = os.getcwd()


def parse_args():
    """Return argparse.Namespace representing parsed command line."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "-c", "--clobber", action="store_true", help="Clobber existing files when creating symlinks or dirs."
    )
    return parser.parse_args()


def create_directories():
    """Create directories to put config files in."""
    dir_paths = [
        os.path.expanduser("~/.config/alacritty"),
        os.path.expanduser("~/.emacs.d/eshell"),
        os.path.expanduser("~/.config/nvim"),
    ]
    for path in dir_paths:
        os.makedirs(path, exist_ok=True)


def clone_repo(repo_url, path, clobber=False):
    """Clone the repo at repo_url to the given path."""
    try:
        repo = Repo(path)
        if list(repo.remotes[0].urls)[0] != repo_url:
            if clobber:
                logging.info(f"Removing the directory that exists at {path}.")
                shutil.rmtree(path)
            else:
                raise Exception(
                    f"Can't clone repo from {repo_url} to {path}. "
                    "A directory already exists there and clobber wasn't specified"
                )
        else:
            logging.info(f"Directory at {path} is already a git repo cloned from {repo_url}")
            return
    except InvalidGitRepositoryError:
        if clobber:
            logging.info(f"Removing the directory that exists at {path}.")
            shutil.rmtree(path)
        else:
            raise Exception(
                f"Can't clone repo from {repo_url} to {path}. "
                "A directory already exists there and clobber wasn't specified"
            )
    except NoSuchPathError:
        # Make parent directories if needed.
        repo_parent_dir = os.path.dirname(path)
        if not os.path.isdir(repo_parent_dir):
            logging.info(f"Creating the directory {repo_parent_dir} in order to clone a repo to {path}")
            os.makedirs(repo_parent_dir)
    logging.info(f"Cloning repo from {repo_url} to {path}")
    Repo.clone_from(repo_url, path)


def clone_repos_if_needed(clobber=False, repos_to_clone=None):
    """Clone certain repos if needed."""
    if not repos_to_clone:
        repos_to_clone = {
            "https://github.com/ohmyzsh/ohmyzsh.git": os.path.expanduser("~/.oh-my-zsh"),
        }
    for repo_url, path in repos_to_clone.items():
        clone_repo(repo_url, path, clobber)


def link_if_needed(target, path, clobber=False):
    """
    Make a link from the path to target if doesn't already exist and there's nothing at path.

    If there's already something at path, don't do it unless clobber is True.
    """
    if os.path.islink(path) and os.readlink(path) == target:
        logging.info(f"Link already exists at {path} pointing to {target}")
        return
    if os.path.exists(path) or os.path.islink(path):
        if clobber:
            logging.info("File already exists at {path}. Removing it in order to make link to {target}.")
            os.remove(path)
        else:
            raise Exception(f"File already exists at {path}. Can't make link to {target}.")
    os.symlink(target, path)


def create_symlinks(clobber=False):
    """Create desired symlinks for config files."""
    symlinks = {
        "vim": "~/.vim",
        "vimrc": "~/.config/nvim/vimrc",
        "init.vim": "~/.config/nvim/init.vim",
        "coc.vim": "~/.config/nvim/coc.vim",
        "zshrc": "~/.zshrc",
        "aliases": "~/.aliases",
        "bashrc": "~/.bashrc",
        "bash_profile": "~/.bash_profile",
        "refined-tilne.zsh-theme": "~/.oh-my-zsh/themes/refined-tilne.zsh-theme",
        "pythonrc": "~/.pythonrc",
        "emacs": "~/.emacs",
        "eshell-profile": "~/.emacs.d/eshell/profile",
        "tmux.conf": "~/.tmux.conf",
        "bin": "~/bin",
        "alacritty.yml": "~/.config/alacritty/alacritty.yml",
        "gitconfig": "~/.gitconfig",
        "gitignore": "~/.gitignore",
        "fish": "~/.config/fish",
    }
    for repo_file, link_path in symlinks.items():
        link_if_needed(os.path.join(REPO_DIR, repo_file), os.path.expanduser(link_path), clobber)


def handle_special_cases(clobber=False):
    """Do stuff that couldn't be batched for whatever reason."""
    # This has to be done after the symlink to the ./vim directory is made.
    clone_repos_if_needed(
        clobber,
        {"https://github.com/VundleVim/Vundle.vim.git": os.path.expanduser("~/.vim/bundle/Vundle.vim")},
    )


def main():
    """Run the script."""
    args = parse_args()
    create_directories()
    clone_repos_if_needed(args.clobber)
    create_symlinks(args.clobber)
    handle_special_cases(args.clobber)


if __name__ == "__main__":
    main()
