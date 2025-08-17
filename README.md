# Pucodev dotfiles

Este repositorio contiene mis archivos de configuración personal (dotfiles) para Linux.

## Instalación

Para instalar cualquier configuración, usa [GNU Stow](https://www.gnu.org/software/stow/) para crear enlaces simbólicos en tu directorio home (`~`).

Ejemplo:

```sh
stow -t ~ {FOLDER_NAME}
```

Donde `{FOLDER_NAME}` es la carpeta que quieres instalar, por ejemplo: `nvim`, `tmux`, etc.

## Estructura

- `nvim/` — Configuración de Neovim, plugins y utilidades
- `tmux/` — Configuración de tmux
- `kitty/` — Configuración de kitty

```sh
stow -t ~ nvim
stow -t ~ tmux
stow -t ~ kitty
```