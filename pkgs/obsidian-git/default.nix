{
  stdenv,
  fetchFromGitHub,
  nodejs,
  pnpmConfigHook,
  pnpm,
  fetchPnpmDeps,
  lib,
}:
stdenv.mkDerivation rec {
  pname = "obsidian-git";
  version = "2.41.1";

  src = fetchFromGitHub {
    owner = "Vinzent03";
    repo = "obsidian-git";
    rev = version;
    sha256 = "sha256-Jdz+EOsifwogOxxilV2cLpYkvIkuDGYgzWA8KMkgkSI=";
  };

  patches = [
    ./supported-architectures.patch
  ];

  nativeBuildInputs = [
    nodejs
    pnpmConfigHook
    pnpm
  ];

  buildPhase =
    # bash
    ''
      runHook preBuild

      pnpm run build

      runHook postBuild
    '';

  installPhase =
    # bash
    ''
      mkdir -p $out/
      cp main.js manifest.json styles.css $out/
    '';

  env = {
    ELECTRON_SKIP_BINARY_DOWNLOAD = 1;
  };

  pnpmDeps = fetchPnpmDeps {
    fetcherVersion = 4;
    inherit pname version src patches;
    hash = "sha256-hIPloDogCy8E5cf5nBBXfC4LFumUJnEM6mpV8r44tIE=";
  };

  meta = {
    description = "Integrate Git version control with automatic backup and other advanced features.";
    homepage = "https://github.com/Vinzent03/obsidian-git";
    changelog = "https://github.com/Vinzent03/obsidian-git/releases/tag/${version}";
    license = lib.licenses.mit;
  };
}
