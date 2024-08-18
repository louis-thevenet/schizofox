{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
  background ? "1e1e2e",
  foreground ? "cdd6f4",
  ...
}: let
  version = "10.4";
in
  buildNpmPackage {
    pname = "midnight-lizard";
    inherit version;

    src = fetchFromGitHub {
      owner = "Midnight-Lizard";
      repo = "Midnight-Lizard";
      rev = version;
      hash = "";
    };

    npmDepsHash = "";

    patchPhase = ''
      runHook prePatch

    #   substituteInPlace src/defaults.ts --replace "181a1b" ${background}
    #   substituteInPlace src/defaults.ts --replace "e8e6e3" ${foreground}

      runHook postPatch
    '';

    npmBuildFlags = ["--" "--firefox"];

    installPhase = ''
      runHook preInstall
      cp -rv build $out/
      runHook postInstall
    '';

    meta = {
      description = "Custom patched Dark reader for Schizofox";
      maintainers = with lib.maintainers; [notashelf sioodmy];
      license = lib.licenses.mit;
    };
  }
