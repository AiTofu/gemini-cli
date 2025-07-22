Loaded cached credentials.
# Memory Import Processor

# Memory Import Processor

The Memory Import Processor is a feature that allows you to modularize your GEMINI.md files by importing content from other markdown files using the `@file.md` syntax.

Memory Import Processor 是一项新功能，它允许你通过 `@file.md` 语法从其他 Markdown 文件中导入内容，从而实现 GEMINI.md 文件的模块化。

## Overview

## 概述

This feature enables you to break down large GEMINI.md files into smaller, more manageable components that can be reused across different contexts. The import processor supports both relative and absolute paths, with built-in safety features to prevent circular imports and ensure file access security.

该功能使你能够将大型 GEMINI.md 文件分解为更小、更易于管理的组件，这些组件可以在不同上下文中重复使用。导入处理器支持相对路径和绝对路径，并内置了安全功能以防止循环导入并确保文件访问安全。

## Important Limitations

## 重要限制

**This feature only supports `.md` (markdown) files.** Attempting to import files with other extensions (like `.txt`, `.json`, etc.) will result in a warning and the import will fail.

**此功能仅支持 `.md` (Markdown) 文件。** 尝试导入其他扩展名的文件（如 `.txt`、`.json` 等）将导致警告并且导入会失败。

## Syntax

## 语法

Use the `@` symbol followed by the path to the markdown file you want to import:

使用 `@` 符号后跟你想要导入的 Markdown 文件的路径：

```markdown
# Main GEMINI.md file

This is the main content.

@./components/instructions.md

More content here.

@./shared/configuration.md
```

```markdown
# 主 GEMINI.md 文件

这是主要内容。

@./components/instructions.md

更多内容在这里。

@./shared/configuration.md
```

## Supported Path Formats

## 支持的路径格式

### Relative Paths

### 相对路径

- `@./file.md` - Import from the same directory
- `@../file.md` - Import from parent directory
- `@./components/file.md` - Import from subdirectory

- `@./file.md` - 从同一目录导入
- `@../file.md` - 从父目录导入
- `@./components/file.md` - 从子目录导入

### Absolute Paths

### 绝对路径

- `@/absolute/path/to/file.md` - Import using absolute path

- `@/absolute/path/to/file.md` - 使用绝对路径导入

## Examples

## 示例

### Basic Import

### 基本导入

```markdown
# My GEMINI.md

Welcome to my project!

@./getting-started.md

## Features

@./features/overview.md
```

```markdown
# 我的 GEMINI.md

欢迎来到我的项目！

@./getting-started.md

## 功能

@./features/overview.md
```

### Nested Imports

### 嵌套导入

The imported files can themselves contain imports, creating a nested structure:

被导入的文件本身也可以包含导入，从而形成嵌套结构：

```markdown
# main.md

@./header.md
@./content.md
@./footer.md
```

```markdown
# main.md

@./header.md
@./content.md
@./footer.md
```

```markdown
# header.md

# Project Header

@./shared/title.md
```

```markdown
# header.md

# 项目标题

@./shared/title.md
```

## Safety Features

## 安全功能

### Circular Import Detection

### 循环导入检测

The processor automatically detects and prevents circular imports:

处理器会自动检测并阻止循环导入：

```markdown
# file-a.md

@./file-b.md

# file-b.md

@./file-a.md <!-- This will be detected and prevented -->
```

```markdown
# file-a.md

@./file-b.md

# file-b.md

@./file-a.md <!-- 这将被检测到并被阻止 -->
```

### File Access Security

### 文件访问安全

The `validateImportPath` function ensures that imports are only allowed from specified directories, preventing access to sensitive files outside the allowed scope.

`validateImportPath` 函数确保只允许从指定的目录进行导入，防止访问允许范围之外的敏感文件。

### Maximum Import Depth

### 最大导入深度

To prevent infinite recursion, there's a configurable maximum import depth (default: 10 levels).

为防止无限递归，有一个可配置的最大导入深度（默认为 10 层）。

## Error Handling

## 错误处理

### Non-MD File Attempts

### 尝试导入非 MD 文件

If you try to import a non-markdown file, you'll see a warning:

如果你尝试导入一个非 Markdown 文件，你会看到一个警告：

```markdown
@./instructions.txt <!-- This will show a warning and fail -->
```

```markdown
@./instructions.txt <!-- 这将显示警告并失败 -->
```

Console output:

控制台输出：

```
[WARN] [ImportProcessor] Import processor only supports .md files. Attempting to import non-md file: ./instructions.txt. This will fail.
```

```
[WARN] [ImportProcessor] Import processor only supports .md files. Attempting to import non-md file: ./instructions.txt. This will fail.
```

### Missing Files

### 文件缺失

If a referenced file doesn't exist, the import will fail gracefully with an error comment in the output.

如果引用的文件不存在，导入将平稳失败，并在输出中显示错误注释。

### File Access Errors

### 文件访问错误

Permission issues or other file system errors are handled gracefully with appropriate error messages.

权限问题或其他文件系统错误会通过适当的错误消息得到平稳处理。

## API Reference

## API 参考

### `processImports(content, basePath, debugMode?, importState?)`

### `processImports(content, basePath, debugMode?, importState?)`

Processes import statements in GEMINI.md content.

处理 GEMINI.md 内容中的导入语句。

**Parameters:**

**参数:**

- `content` (string): The content to process for imports
- `basePath` (string): The directory path where the current file is located
- `debugMode` (boolean, optional): Whether to enable debug logging (default: false)
- `importState` (ImportState, optional): State tracking for circular import prevention

- `content` (string): 要处理导入的内容
- `basePath` (string): 当前文件所在的目录路径
- `debugMode` (boolean, 可选): 是否启用调试日志（默认为 false）
- `importState` (ImportState, 可选): 用于防止循环导入的状态跟踪

**Returns:** Promise<string> - Processed content with imports resolved

**返回:** Promise<string> - 已解析导入的处理后内容

### `validateImportPath(importPath, basePath, allowedDirectories)`

### `validateImportPath(importPath, basePath, allowedDirectories)`

Validates import paths to ensure they are safe and within allowed directories.

验证导入路径以确保其安全且在允许的目录内。

**Parameters:**

**参数:**

- `importPath` (string): The import path to validate
- `basePath` (string): The base directory for resolving relative paths
- `allowedDirectories` (string[]): Array of allowed directory paths

- `importPath` (string): 要验证的导入路径
- `basePath` (string): 用于解析相对路径的基本目录
- `allowedDirectories` (string[]): 允许的目录路径数组

**Returns:** boolean - Whether the import path is valid

**返回:** boolean - 导入路径是否有效

## Best Practices

## 最佳实践

1. **Use descriptive file names** for imported components
2. **Keep imports shallow** - avoid deeply nested import chains
3. **Document your structure** - maintain a clear hierarchy of imported files
4. **Test your imports** - ensure all referenced files exist and are accessible
5. **Use relative paths** when possible for better portability

1. **为导入的组件使用描述性的文件名**
2. **保持导入层级较浅** - 避免深度嵌套的导入链
3. **为你的结构编写文档** - 维护一个清晰的导入文件层次结构
4. **测试你的导入** - 确保所有引用的文件都存在且可访问
5. **尽可能使用相对路径** 以获得更好的可移植性

## Troubleshooting

## 问题排查

### Common Issues

### 常见问题

1. **Import not working**: Check that the file exists and has a `.md` extension
2. **Circular import warnings**: Review your import structure for circular references
3. **Permission errors**: Ensure the files are readable and within allowed directories
4. **Path resolution issues**: Use absolute paths if relative paths aren't resolving correctly

1. **导入不工作**：检查文件是否存在并且扩展名为 `.md`
2. **循环导入警告**：检查你的导入结构是否存在循环引用
3. **权限错误**：确保文件可读且在允许的目录内
4. **路径解析问题**：如果相对路径无法正确解析，请使用绝对路径

### Debug Mode

### 调试模式

Enable debug mode to see detailed logging of the import process:

启用调试模式以查看导入过程的详细日志：

```typescript
// Enable debug mode to see detailed logging
const result = await processImports(content, basePath, true);
```

```typescript
// 启用调试模式以查看详细日志
const result = await processImports(content, basePath, true);
```
