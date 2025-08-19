# Pucodev dotfiles

[Read in Spanish 🇪🇸](./README.es.md)

This repository contains my personal configuration files (dotfiles) for Linux.

## Installation

To install any configuration, use [GNU Stow](https://www.gnu.org/software/stow/) to create symbolic links in your home directory (`~`).

Example:

```sh
stow -t ~ {FOLDER_NAME}
```

Where `{FOLDER_NAME}` is the folder you want to install, for example: `nvim`, `tmux`, etc.

## Structure

- `nvim/` — Neovim configuration, plugins, and utilities
- `tmux/` — tmux configuration
- `kitty/` — kitty configuration

```sh
stow -t ~ nvim
stow -t ~ tmux
stow -t ~ kitty
```