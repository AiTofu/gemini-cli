Loaded cached credentials.
# Uninstalling the CLI

# 卸载 CLI

Your uninstall method depends on how you ran the CLI. Follow the instructions for either npx or a global npm installation.

你的卸载方法取决于你如何运行 CLI。请根据 npx 或全局 npm 安装方式，按照相应的说明进行操作。

## Method 1: Using npx

## 方法一：使用 npx

npx runs packages from a temporary cache without a permanent installation. To "uninstall" the CLI, you must clear this cache, which will remove gemini-cli and any other packages previously executed with npx.

npx 会从临时缓存中运行软件包，而不会进行永久性安装。要“卸载” CLI，你必须清除此缓存，这会移除 gemini-cli 以及之前通过 npx 执行过的任何其他软件包。

The npx cache is a directory named `_npx` inside your main npm cache folder. You can find your npm cache path by running `npm config get cache`.

npx 缓存是主 npm 缓存文件夹中一个名为 `_npx` 的目录。你可以通过运行 `npm config get cache` 来查找你的 npm 缓存路径。

**For macOS / Linux**

**适用于 macOS / Linux**

```bash
# The path is typically ~/.npm/_npx
# 路径通常是 ~/.npm/_npx
rm -rf "$(npm config get cache)/_npx"
```

**For Windows**

**适用于 Windows**

_Command Prompt_

_命令提示符_

```cmd
:: The path is typically %LocalAppData%\npm-cache\_npx
:: 路径通常是 %LocalAppData%\npm-cache\_npx
rmdir /s /q "%LocalAppData%\npm-cache\_npx"
```

_PowerShell_

_PowerShell_

```powershell
# The path is typically $env:LocalAppData\npm-cache\_npx
# 路径通常是 $env:LocalAppData\npm-cache\_npx
Remove-Item -Path (Join-Path $env:LocalAppData "npm-cache\_npx") -Recurse -Force
```

## Method 2: Using npm (Global Install)

## 方法二：使用 npm (全局安装)

If you installed the CLI globally (e.g., `npm install -g @google/gemini-cli`), use the `npm uninstall` command with the `-g` flag to remove it.

如果你是全局安装的 CLI（例如，`npm install -g @google/gemini-cli`），请使用带有 `-g` 标志的 `npm uninstall` 命令来移除它。

```bash
npm uninstall -g @google/gemini-cli
```

This command completely removes the package from your system.

此命令会从你的系统中完全移除该软件包。
