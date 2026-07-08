# Windie Sandbox Workspace

This repository pins the local Windie development stack in one place:

```text
windie   -> Windie runtime, API, and inspector UI
bifrost  -> local gateway used by Windie
cua      -> CUA source tree used by Windie's approved CUA MCP provider
DesktopCommanderMCP -> Desktop Commander MCP source tree for reference
blender-mcp         -> Blender MCP source tree for reference
```

The repositories stay as submodules so each project keeps its own history and ownership.

## Layout

```text
windie/           Windie runtime repository
bifrost/          Windie Bifrost fork
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

`bootstrap.sh` does three explicit things:

1. Initializes submodules.
2. Builds the Windie release binary.

It does not install provider keys or silently install CUA system permissions.

## Provider Keys

Copy `.env.example` to `windie/.env` and fill the provider keys you want Bifrost to use:

```bash
cp .env.example windie/.env
```

Windie passes `windie/.env` to Bifrost gateway startup. This keeps provider keys explicit instead of inherited from the shell.

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

This prints submodule commits and checks whether the Windie binary, local Bifrost binary, and `cua-driver` command are available.

## Bifrost Fork

The `bifrost` submodule points at `buiilding/bifrost` branch `windie-dev`. That branch contains the Bifrost changes Windie expects for local gateway startup and model listing.
