# nix-lightpanda

Nix flake for [Lightpanda](https://github.com/lightpanda-io/browser) - a headless browser designed for AI agents and automation.

## Features

- 60x faster than Chrome/Playwright for web scraping
- 9x less RAM, 12x less CPU usage
- JavaScript execution and dynamic content
- Chrome DevTools Protocol (CDP) support
- WebSocket connectivity

## Usage

### Run directly

```bash
nix run github:deepwatrcreatur/nix-lightpanda
```

### Add to flake inputs

```nix
{
  inputs.nix-lightpanda = {
    url = "github:deepwatrcreatur/nix-lightpanda";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

### Add to system packages via overlay

```nix
nixpkgs.overlays = [ inputs.nix-lightpanda.overlays.default ];
environment.systemPackages = [ pkgs.lightpanda ];
```

## Supported platforms

- x86_64-linux
- aarch64-linux
