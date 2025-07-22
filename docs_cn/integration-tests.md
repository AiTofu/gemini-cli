Loaded cached credentials.
# Integration Tests

# 集成测试

This document provides information about the integration testing framework used in this project.

本文档提供有关本项目中使用的集成测试框架的信息。

## Overview

## 概述

The integration tests are designed to validate the end-to-end functionality of the Gemini CLI. They execute the built binary in a controlled environment and verify that it behaves as expected when interacting with the file system.

集成测试旨在验证 Gemini CLI 的端到端功能。它们在受控环境中执行构建好的二进制文件，并验证其在与文件系统交互时的行为是否符合预期。

These tests are located in the `integration-tests` directory and are run using a custom test runner.

这些测试位于 `integration-tests` 目录中，并使用自定义的测试运行器来执行。

## Running the tests

## 运行测试

The integration tests are not run as part of the default `npm run test` command. They must be run explicitly using the `npm run test:integration:all` script.

集成测试不作为默认 `npm run test` 命令的一部分运行。必须使用 `npm run test:integration:all` 脚本显式运行它们。

The integration tests can also be run using the following shortcut:

集成测试也可以使用以下快捷方式运行：

```bash
npm run test:e2e
```

## Running a specific set of tests

## 运行特定的测试集

To run a subset of test files, you can use `npm run <integration test command> <file_name1> ....` where <integration test command> is either `test:e2e` or `test:integration*` and `<file_name>` is any of the `.test.js` files in the `integration-tests/` directory. For example, the following command runs `list_directory.test.js` and `write_file.test.js`:

要运行测试文件的子集，您可以使用 `npm run <integration test command> <file_name1> ....`，其中 <integration test command> 是 `test:e2e` 或 `test:integration*`，而 `<file_name>` 是 `integration-tests/` 目录中的任何 `.test.js` 文件。例如，以下命令运行 `list_directory.test.js` 和 `write_file.test.js`：

```bash
npm run test:e2e list_directory write_file
```

### Running a single test by name

### 按名称运行单个测试

To run a single test by its name, use the `--test-name-pattern` flag:

要按名称运行单个测试，请使用 `--test-name-pattern` 标志：

```bash
npm run test:e2e -- --test-name-pattern "reads a file"
```

### Running all tests

### 运行所有测试

To run the entire suite of integration tests, use the following command:

要运行整个集成测试套件，请使用以下命令：

```bash
npm run test:integration:all
```

### Sandbox matrix

### 沙盒矩阵

The `all` command will run tests for `no sandboxing`, `docker` and `podman`.

`all` 命令将针对 `no sandboxing`、`docker` 和 `podman` 运行测试。

Each individual type can be run using the following commands:

每种类型都可以使用以下命令单独运行：

```bash
npm run test:integration:sandbox:none
```

```bash
npm run test:integration:sandbox:docker
```

```bash
npm run test:integration:sandbox:podman
```

## Diagnostics

## 诊断

The integration test runner provides several options for diagnostics to help track down test failures.

集成测试运行器提供了多种诊断选项，以帮助追踪测试失败的原因。

### Keeping test output

### 保留测试输出

You can preserve the temporary files created during a test run for inspection. This is useful for debugging issues with file system operations.

您可以保留测试运行期间创建的临时文件以供检查。这对于调试文件系统操作问题非常有用。

To keep the test output, you can either use the `--keep-output` flag or set the `KEEP_OUTPUT` environment variable to `true`.

要保留测试输出，您可以使用 `--keep-output` 标志或将 `KEEP_OUTPUT` 环境变量设置为 `true`。

```bash
# Using the flag
# 使用标志
npm run test:integration:sandbox:none -- --keep-output

# Using the environment variable
# 使用环境变量
KEEP_OUTPUT=true npm run test:integration:sandbox:none
```

When output is kept, the test runner will print the path to the unique directory for the test run.

当保留输出时，测试运行器将打印出该测试运行的唯一目录的路径。

### Verbose output

### 详细输出

For more detailed debugging, the `--verbose` flag streams the real-time output from the `gemini` command to the console.

为了进行更详细的调试，`--verbose` 标志会将 `gemini` 命令的实时输出流式传输到控制台。

```bash
npm run test:integration:sandbox:none -- --verbose
```

When using `--verbose` and `--keep-output` in the same command, the output is streamed to the console and also saved to a log file within the test's temporary directory.

当在同一命令中使用 `--verbose` 和 `--keep-output` 时，输出会流式传输到控制台，并同时保存到测试临时目录中的日志文件中。

The verbose output is formatted to clearly identify the source of the logs:

详细输出的格式经过设计，可以清晰地识别日志来源：

```
--- TEST: <file-name-without-js>:<test-name> ---
... output from the gemini command ...
--- END TEST: <file-name-without-js>:<test-name> ---
```

```
--- TEST: <file-name-without-js>:<test-name> ---
... gemini 命令的输出 ...
--- END TEST: <file-name-without-js>:<test-name> ---
```

## Linting and formatting

## 代码检查与格式化

To ensure code quality and consistency, the integration test files are linted as part of the main build process. You can also manually run the linter and auto-fixer.

为确保代码质量和一致性，集成测试文件会作为主构建过程的一部分进行代码检查。您也可以手动运行代码检查器和自动修复程序。

### Running the linter

### 运行代码检查器

To check for linting errors, run the following command:

要检查代码检查错误，请运行以下命令：

```bash
npm run lint
```

You can include the `--fix` flag in the command to automatically fix any fixable linting errors:

您可以在命令中包含 `--fix` 标志，以自动修复任何可修复的代码检查错误：

```bash
npm run lint --fix
```

## Directory structure

## 目录结构

The integration tests create a unique directory for each test run inside the `.integration-tests` directory. Within this directory, a subdirectory is created for each test file, and within that, a subdirectory is created for each individual test case.

集成测试会在 `.integration-tests` 目录内为每次测试运行创建一个唯一的目录。在此目录中，会为每个测试文件创建一个子目录，然后在该子目录内，又会为每个单独的测试用例创建一个子目录。

This structure makes it easy to locate the artifacts for a specific test run, file, or case.

这种结构使得定位特定测试运行、文件或用例的产物变得容易。

```
.integration-tests/
└── <run-id>/
    └── <test-file-name>.test.js/
        └── <test-case-name>/
            ├── output.log
            └── ...other test artifacts...
```

```
.integration-tests/
└── <run-id>/
    └── <test-file-name>.test.js/
        └── <test-case-name>/
            ├── output.log
            └── ...其他测试产物...
```

## Continuous integration

## 持续集成

To ensure the integration tests are always run, a GitHub Actions workflow is defined in `.github/workflows/e2e.yml`. This workflow automatically runs the integrations tests for pull requests against the `main` branch, or when a pull request is added to a merge queue.

为确保集成测试始终运行，`.github/workflows/e2e.yml` 中定义了一个 GitHub Actions 工作流。该工作流会针对向 `main` 分支发起的拉取请求，或当拉取请求被添加到合并队列时，自动运行集成测试。

The workflow runs the tests in different sandboxing environments to ensure Gemini CLI is tested across each:

该工作流在不同的沙盒环境中运行测试，以确保 Gemini CLI 在每种环境中都得到测试：

- `sandbox:none`: Runs the tests without any sandboxing.
- `sandbox:none`: 在没有任何沙盒的情况下运行测试。

- `sandbox:docker`: Runs the tests in a Docker container.
- `sandbox:docker`: 在 Docker 容器中运行测试。

- `sandbox:podman`: Runs the tests in a Podman container.
- `sandbox:podman`: 在 Podman 容器中运行测试。
