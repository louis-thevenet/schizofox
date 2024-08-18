{
  self,
  pkgs,
  lib,
  cfg,
  ...
}: let
  inherit (lib.attrsets) mapAttrs optionalAttrs filterAttrs;
  inherit (self.packages.${pkgs.stdenv.hostPlatform.system}) midnight-lizard;

  reader = midnight-lizard.override {
    inherit (cfg.theme.colors) background foreground;
  };

  ext = cfg.extensions;

  # TODO: move these functions to a local library output defined by the flake.
  # Ideally we would do something like self.lib.mkForceInstalled.
  removeNullAttrs = filterAttrs (_: value: value != null);
  mkForceInstalled = mapAttrs (_: cfg: {installation_mode = "force_installed";} // cfg);

  # HACK: Convert this to use mkMerge once the whole project uses the module system.
  addons =
    optionalAttrs ext.enableDefaultExtensions ext.defaultExtensions
    // optionalAttrs ext.enableExtraExtensions ext.extraExtensions
    // optionalAttrs ext.midnight-lizard.enable {"{    {8fbc7259-8015-4172-9af1-20e1edfbbd3a}}".install_url = "file://${reader}/release/{8fbc7259-8015-4172-9af1-20e1edfbbd3a}.xpi";};
in
  mkForceInstalled (removeNullAttrs addons)
