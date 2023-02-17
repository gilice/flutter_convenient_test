{
  inputs = {
    nixpkgs.url = "github:gilice/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
  }:
    flake-utils.lib.eachDefaultSystem
    (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
      libsForPkgs = p:
        with p; [
          openssl.dev
          libvlc
          libdeflate
          gtk3.dev
          glib
          glib.dev
          harfbuzz
          harfbuzz.dev
          cairo
          cairo.dev
          gdk-pixbuf
          gdk-pixbuf.dev
          atk
          atk.dev
          lz4
          libxkbcommon
          zstd
          libffi
          pango
          pango.dev
          libpng
          libgcrypt
          libgpg-error
          libcap
          libcap.lib
          fontconfig.lib
          xorg.libXdmcp
          fribidi
          tracker
          wayland
          xorg.libXrandr
          xorg.libXinerama
          at-spi2-atk
          libthai
          freetype
          icu
          graphite2
          sqlite
          libxml2
          json-glib
          brotli.lib
          pixman
          libjpeg
          libselinux
          pcre2
          pcre
          xorg.libXau
          xorg.libX11.dev
          xorg.libX11
          xorg.xorgproto
          zlib
          zlib.dev
          libepoxy
          libepoxy.dev
        ];
      envName = "convenient-test-env";
      envBase = run:
        pkgs.buildFHSUserEnv {
          name = envName;
          targetPkgs = p:
            (libsForPkgs p)
            ++ (with p; [
              flutter.unwrapped
              cmake
              ninja
              pkg-config
              fish
              which
              git
              (p.stdenv.mkDerivation {
                src = ./.;

                name = "fixVarEmptyLocal";
                buildPhase = ''

                  mkdir -p $out/var/empty/local

                '';
              })
            ]);
          extraInstallCommands = ''
            ls -lahR
          '';
          runScript = run;
        };
      interactiveEnv = envBase "fish";
    in {
      ### use this with `nix run`
      apps.default = {
        type = "app";
        program = "${interactiveEnv}/bin/${envName}";
      };

      packages.default = pkgs.stdenv.mkDerivation {
        name = "convenient_test_manager";
        src = ./.;
        buildPhase = ''
          ${interactiveEnv}/bin/${envName}
          flutter build linux;
          ls -lah
        '';
      };
    });
}
