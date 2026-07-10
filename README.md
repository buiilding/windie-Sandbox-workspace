# Windie Sandbox Workspace

This repository is a development and source-reference workspace:

```text
windie   -> Windie runtime, API, and inspector UI
bifrost  -> official Maxim Bifrost source for compatibility study
cua      -> CUA source tree for integration study
DesktopCommanderMCP -> Desktop Commander MCP source tree for reference
blender-mcp         -> Blender MCP source tree for reference
```

The repositories stay as submodules so each project keeps its own history and
ownership. They are not included in Windie release packages. Installed Windie
uses the projects' public npm, Python, Docker, or executable interfaces.

## Layout

```text
windie/           Windie runtime repository
bifrost/          Official maximhq/bifrost development branch
cua/              CUA repository
DesktopCommanderMCP/ Desktop Commander MCP repository
blender-mcp/      Blender MCP repository
scripts/          Workspace helpers
```

## First Setup

```bash
git clone --recurse-submodules https://github.com/buiilding/windie-Sandbox-workspace.git
cd windie-Sandbox-workspace
./scripts/bootstrap.sh
```

`bootstrap.sh` does two explicit things:

1. Initializes submodules.
2. Builds the Windie release binary.

It does not install provider keys or silently install CUA system permissions.

## Provider Secrets

Copy `.env.example` to `windie/.env` for provider secrets referenced by your
Bifrost configuration:

```bash
cp .env.example windie/.env
```

Windie passes `windie/.env` to Bifrost gateway startup. Windie does not create
provider rows from these variables. Configure providers through the official
Bifrost UI at `http://localhost:8080` and use `env.KEY_NAME` secret references.

## CUA Driver

Windie's CUA MCP provider calls:

```bash
cua-driver mcp
```

That means `cua-driver` must be installed on your machine and available on `PATH` before CUA tools appear in Windie.

Use CUA's own installation docs from `cua/` for the current platform-specific setup. The workspace does not install CUA automatically because CUA may require OS permissions.

## Running The Stack

In separate terminals:

```bash
./scripts/start-gateway.sh
./scripts/start-api.sh
./scripts/start-inspector.sh
```

Then open the inspector URL printed by the frontend dev server.

## Status Check

```bash
./scripts/status.sh
```

This prints submodule commits and runs `windie doctor` when the binary exists.

## Packaging Boundary

The `bifrost` submodule tracks official `maximhq/bifrost` branch `dev`. CUA,
Desktop Commander, and Blender MCP remain here because their code is useful for
understanding and debugging integrations. `windie/scripts/package-release.sh`
packages only the Windie binary and compiled operator UI.
