Loaded cached credentials.
# Gemini CLI Extensions

# Gemini CLI 扩展

Gemini CLI supports extensions that can be used to configure and extend its functionality.

Gemini CLI 支持用于配置和扩展其功能的扩展。

## How it works

## 工作原理

On startup, Gemini CLI looks for extensions in two locations:

启动时，Gemini CLI 会在两个位置查找扩展：

1.  `<workspace>/.gemini/extensions`
2.  `<home>/.gemini/extensions`

1.  `<workspace>/.gemini/extensions`
2.  `<home>/.gemini/extensions`

Gemini CLI loads all extensions from both locations. If an extension with the same name exists in both locations, the extension in the workspace directory takes precedence.

Gemini CLI 会从这两个位置加载所有扩展。如果同名扩展同时存在于两个位置，则工作区目录中的扩展优先。

Within each location, individual extensions exist as a directory that contains a `gemini-extension.json` file. For example:

在每个位置中，单个扩展以目录的形式存在，其中包含一个 `gemini-extension.json` 文件。例如：

`<workspace>/.gemini/extensions/my-extension/gemini-extension.json`

`<workspace>/.gemini/extensions/my-extension/gemini-extension.json`

### `gemini-extension.json`

### `gemini-extension.json`

The `gemini-extension.json` file contains the configuration for the extension. The file has the following structure:

`gemini-extension.json` 文件包含扩展的配置。该文件具有以下结构：

```json
{
  "name": "my-extension",
  "version": "1.0.0",
  "mcpServers": {
    "my-server": {
      "command": "node my-server.js"
    }
  },
  "contextFileName": "GEMINI.md",
  "excludeTools": ["run_shell_command"]
}
```

```json
{
  "name": "my-extension",
  "version": "1.0.0",
  "mcpServers": {
    "my-server": {
      "command": "node my-server.js"
    }
  },
  "contextFileName": "GEMINI.md",
  "excludeTools": ["run_shell_command"]
}
```

- `name`: The name of the extension. This is used to uniquely identify the extension. This should match the name of your extension directory.
- `name`: 扩展的名称。用于唯一标识扩展。此名称应与你的扩展目录名称匹配。

- `version`: The version of the extension.
- `version`: 扩展的版本。

- `mcpServers`: A map of MCP servers to configure. The key is the name of the server, and the value is the server configuration. These servers will be loaded on startup just like MCP servers configured in a [`settings.json` file](./cli/configuration.md). If both an extension and a `settings.json` file configure an MCP server with the same name, the server defined in the `settings.json` file takes precedence.
- `mcpServers`: 用于配置 MCP 服务器的映射。键是服务器的名称，值是服务器的配置。这些服务器将在启动时加载，就像在 [`settings.json` 文件](./cli/configuration.md) 中配置的 MCP 服务器一样。如果扩展和 `settings.json` 文件都配置了同名的 MCP 服务器，则 `settings.json` 文件中定义的服务器优先。

- `contextFileName`: The name of the file that contains the context for the extension. This will be used to load the context from the workspace. If this property is not used but a `GEMINI.md` file is present in your extension directory, then that file will be loaded.
- `contextFileName`: 包含扩展上下文的文件名。该文件将用于从工作区加载上下文。如果未使用此属性，但你的扩展目录中存在 `GEMINI.md` 文件，则将加载该文件。

- `excludeTools`: An array of tool names to exclude from the model. You can also specify command-specific restrictions for tools that support it, like the `run_shell_command` tool. For example, `"excludeTools": ["run_shell_command(rm -rf)"]` will block the `rm -rf` command.
- `excludeTools`: 要从模型中排除的工具名称数组。你还可以为支持它的工具指定特定于命令的限制，例如 `run_shell_command` 工具。例如，`"excludeTools": ["run_shell_command(rm -rf)"]` 将阻止 `rm -rf` 命令。

When Gemini CLI starts, it loads all the extensions and merges their configurations. If there are any conflicts, the workspace configuration takes precedence.

当 Gemini CLI 启动时，它会加载所有扩展并合并它们的配置。如果存在任何冲突，工作区配置优先。
