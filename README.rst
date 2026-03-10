================================================================================
                              Dotfiles Configuration
================================================================================

A curated, cozy configuration for Linux desktop environments, built on top of
`Omarchy <https://github.com/omarchy/omarchy>`_. Managed with
`chezmoi <https://chezmoi.io>`_ for declarative dotfile management.

----------------------------------------------------------------------
Screenshots
----------------------------------------------------------------------

.. image:: screenshots/1.png
   :alt: Desktop screenshot
   :width: 600
   :align: center

.. image:: screenshots/2.png
   :alt: Desktop screenshot
   :width: 600
   :align: center

----------------------------------------------------------------------
Overview
----------------------------------------------------------------------

This repository contains configuration for a Hyprland-based setup with the
Omarchy theming system, including:

- **Window Manager**: Hyprland
- **Status Bar**: Waybar
- **Application Launcher**: Walker
- **Terminals**: Ghostty, Kitty, Alacritty
- **Editor**: Neovim (LazyVim)
- **Notifications**: Mako
- **Media Controls**: SwayOSD
- **System Info**: Fastfetch, Btop

----------------------------------------------------------------------
Installation
----------------------------------------------------------------------

Prerequisites: `chezmoi <https://chezmoi.io/install/>`_

::

    # Install chezmoi and initialize from this repo
    chezmoi init --apply ml3m

    # Or clone first, then apply
    git clone <this-repo-url> ~/.local/share/chezmoi
    chezmoi apply

----------------------------------------------------------------------
Structure
----------------------------------------------------------------------

::

    .
    ├── dot_config/
    │   ├── hypr/          # Hyprland window manager
    │   ├── waybar/        # Status bar
    │   ├── walker/        # Application launcher
    │   ├── ghostty/       # Terminal emulator
    │   ├── nvim/          # Neovim configuration
    │   ├── omarchy/       # Theming system and themes
    │   └── ...
    ├── dot_bin/           # User scripts
    └── screenshots/       # Screenshots for this README

----------------------------------------------------------------------
License
----------------------------------------------------------------------

MIT License — use and adapt as needed.
