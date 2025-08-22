{
  lib,
  pkgs,
  ...
}:
pkgs.buildNpmPackage rec {
  pname = "folder-notes";
  version = "1.8.5-2-beta";

  src = pkgs.fetchFromGitHub {
    owner = "LostPaul";
    repo = "obsidian-folder-notes";
    rev = version;
    sha256 = "sha256-br064JcENELB1kwV+ySR8oHzWNpoMyK6ijqtDM3BGDc=";
    fetchSubmodules = true;
  };

  npmDepsHash = "sha256-DpMuOGS6eolE8/XLN921y2cYGe7QWj9VVJkN9d79z3M=";

  npmBuildScript = "fn-build";

  installPhase =
    # bash
    ''
      mkdir -p $out/
      cp main.js styles.css $out/
      cp manifest-beta.json $out/manifest.json
    '';

  env = {
    ELECTRON_SKIP_BINARY_DOWNLOAD = 1;
  };

  meta = {
    description = "Create notes within folders that can be accessed without collapsing the folder, similar to the functionality offered in Notion.";
    homepage = "https://lostpaul.github.io/obsidian-folder-notes";
    changelog = "https://github.com/LostPaul/obsidian-folder-notes/releases/tag/${version}";
    license = lib.licenses.agpl3Only;
  };
}
