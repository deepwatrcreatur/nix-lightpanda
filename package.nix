{ lib
, stdenvNoCC
, fetchurl
, autoPatchelfHook
}:

let
  version = "0.2.7";

  sources = {
    x86_64-linux = {
      url = "https://github.com/lightpanda-io/browser/releases/download/${version}/lightpanda-x86_64-linux";
      hash = "sha256-cGrMzVDnChi4IG/Js8Fvy4V0uYS21prgWppCYv7KvxI=";
    };
    aarch64-linux = {
      url = "https://github.com/lightpanda-io/browser/releases/download/${version}/lightpanda-aarch64-linux";
      hash = "sha256-C0LCBkVxnjzfYCKUrIH7zcEMi7NhBL4IbPMoTax4gAs=";
    };
  };

  platform = stdenvNoCC.hostPlatform.system;
  source = sources.${platform} or (throw "Unsupported platform: ${platform}");

in stdenvNoCC.mkDerivation {
  pname = "lightpanda";
  inherit version;

  src = fetchurl {
    inherit (source) url hash;
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -m755 $src $out/bin/lightpanda
    runHook postInstall
  '';

  meta = with lib; {
    description = "Headless browser designed for AI agents and automation";
    longDescription = ''
      Lightpanda is a headless browser optimized for AI agents, testing, and
      web scraping at scale. It's up to 60x faster than Chrome/Playwright,
      uses 9x less RAM and 12x less CPU.

      Features:
      - JavaScript execution and dynamic content handling
      - Chrome DevTools Protocol (CDP) support via HTTP API
      - WebSocket connectivity for automation
    '';
    homepage = "https://github.com/lightpanda-io/browser";
    license = licenses.agpl3Only;
    platforms = [ "x86_64-linux" "aarch64-linux" ];
    mainProgram = "lightpanda";
  };
}
