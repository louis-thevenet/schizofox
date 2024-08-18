{
  perSystem = {pkgs, ...}: {
    packages = {
      # Extensions
      midnight-lizard = pkgs.callPackage ./midnight-lizard.nix {};

      # Simplefox
      userChrome = pkgs.callPackage ./simplefox/userChrome.nix {};
      userContent = pkgs.callPackage ./simplefox/userContent.nix {};
    };
  };
}
