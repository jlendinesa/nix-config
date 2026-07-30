## Home Manager Switching
- **Check Hostname & Config**: Always inspect the machine's hostname (`hostname`) and cross-reference with `homeConfigurations` in `flake.nix` before building or switching configuration.
- **Preferred Commands**:
  - Use `hms` for applying Home Manager configurations (`home-manager switch -b backup --flake ~/.config/home-manager`).
  - Use `hmsupdate` when updating flake inputs and applying changes (`nix flake update` + `hms`).
- **Minimize Build Commands**: Avoid completely using `home-manager build` or manual `nix-build`/`nix build` commands whenever possible. Always prefer switching directly using `hms` or `hmsupdate`.
- Avoid running arbitrary or bare `home-manager switch` commands without proper target verification and backup options.
