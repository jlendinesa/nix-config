---
trigger: always_on
---

## Package Installation Preference Order
When installing software or adding new applications to the configuration, follow this strict order of preference:
1. **Nix Package in Config**: Direct installation via Nix package in the Home Manager configuration (`pkgs.<package>`).
2. **Flake**: Installation via a Nix Flake input if not available or viable in nixpkgs.
3. **Flatpak**: Installation via Flatpak if Nix package and Flake are not available/working.
4. **AppImage**: Installation via AppImage if Flatpak is not available/working.
5. **Distrobox Container (.deb)**: Installation via a `.deb` package inside a Distrobox container as a last resort.
