Loaded cached credentials.
# Authentication Setup

# 身份验证设置

The Gemini CLI requires you to authenticate with Google's AI services. On initial startup you'll need to configure **one** of the following authentication methods:

Gemini CLI 要求您向 Google 的 AI 服务进行身份验证。在首次启动时，您需要配置以下**一种**身份验证方法：

1.  **Login with Google (Gemini Code Assist):**
    - Use this option to log in with your google account.
    - During initial startup, Gemini CLI will direct you to a webpage for authentication. Once authenticated, your credentials will be cached locally so the web login can be skipped on subsequent runs.
    - Note that the web login must be done in a browser that can communicate with the machine Gemini CLI is being run from. (Specifically, the browser will be redirected to a localhost url that Gemini CLI will be listening on).
    - <a id="workspace-gca">Users may have to specify a GOOGLE_CLOUD_PROJECT if:</a>
      1. You have a Google Workspace account. Google Workspace is a paid service for businesses and organizations that provides a suite of productivity tools, including a custom email domain (e.g. your-name@your-company.com), enhanced security features, and administrative controls. These accounts are often managed by an employer or school.
      2. You have received a Gemini Code Assist license through the [Google Developer Program](https://developers.google.com/program/plans-and-pricing) (including qualified Google Developer Experts)
      3. You have been assigned a license to a current Gemini Code Assist standard or enterprise subscription.
      4. You are using the product outside the [supported regions](https://developers.google.com/gemini-code-assist/resources/available-locations) for free individual usage.
      5. You are a Google account holder under the age of 18
      - If you fall into one of these categories, you must first configure a Google Cloud Project Id to use, [enable the Gemini for Cloud API](https://cloud.google.com/gemini/docs/discover/set-up-gemini#enable-api) and [configure access permissions](https://cloud.google.com/gemini/docs/discover/set-up-gemini#grant-iam).

      You can temporarily set the environment variable in your current shell session using the following command:

      ```bash
      export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"
      ```
      - For repeated use, you can add the environment variable to your [.env file](#persisting-environment-variables-with-env-files) or your shell's configuration file (like `~/.bashrc`, `~/.zshrc`, or `~/.profile`). For example, the following command adds the environment variable to a `~/.bashrc` file:

      ```bash
      echo 'export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"' >> ~/.bashrc
      source ~/.bashrc
      ```

1.  **使用 Google 登录 (Gemini Code Assist):**
    - 使用此选项通过您的 Google 帐户登录。
    - 在首次启动时，Gemini CLI 会将您引导至一个网页进行身份验证。一旦验证成功，您的凭据将被缓存在本地，以便在后续运行时可以跳过网页登录。
    - 请注意，网页登录必须在能够与运行 Gemini CLI 的机器通信的浏览器中完成。（具体来说，浏览器将被重定向到 Gemini CLI 正在监听的一个 localhost URL）。
    - <a id="workspace-gca">在以下情况下，用户可能需要指定一个 GOOGLE_CLOUD_PROJECT：</a>
      1. 您拥有 Google Workspace 帐户。Google Workspace 是一项面向企业和组织的付费服务，提供一套生产力工具，包括自定义电子邮件域名（例如 your-name@your-company.com）、增强的安全功能和管理控制。这些帐户通常由雇主或学校管理。
      2. 您通过 [Google 开发者计划](https://developers.google.com/program/plans-and-pricing)（包括符合条件的 Google 开发者专家）获得了 Gemini Code Assist 许可证。
      3. 您已被分配到当前 Gemini Code Assist 标准版或企业版订阅的许可证。
      4. 您在免费个人使用的[支持区域](https://developers.google.com/gemini-code-assist/resources/available-locations)之外使用该产品。
      5. 您是未满 18 周岁的 Google 帐户持有者。
      - 如果您属于这些类别之一，您必须首先配置一个要使用的 Google Cloud Project Id，[启用 Gemini for Cloud API](https://cloud.google.com/gemini/docs/discover/set-up-gemini#enable-api) 并 [配置访问权限](https://cloud.google.com/gemini/docs/discover/set-up-gemini#grant-iam)。

      您可以使用以下命令在当前的 shell 会话中临时设置环境变量：

      ```bash
      export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"
      ```
      - 为了重复使用，您可以将环境变量添加到您的 [.env 文件](#persisting-environment-variables-with-env-files) 或 shell 的配置文件（如 `~/.bashrc`、`~/.zshrc` 或 `~/.profile`）中。例如，以下命令将环境变量添加到 `~/.bashrc` 文件中：

      ```bash
      echo 'export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"' >> ~/.bashrc
      source ~/.bashrc
      ```

2.  **<a id="gemini-api-key"></a>Gemini API key:**
    - Obtain your API key from Google AI Studio: [https://aistudio.google.com/app/apikey](https://aistudio.google.com/app/apikey)
    - Set the `GEMINI_API_KEY` environment variable. In the following methods, replace `YOUR_GEMINI_API_KEY` with the API key you obtained from Google AI Studio:
      - You can temporarily set the environment variable in your current shell session using the following command:
        ```bash
        export GEMINI_API_KEY="YOUR_GEMINI_API_KEY"
        ```
      - For repeated use, you can add the environment variable to your [.env file](#persisting-environment-variables-with-env-files) or your shell's configuration file (like `~/.bashrc`, `~/.zshrc`, or `~/.profile`). For example, the following command adds the environment variable to a `~/.bashrc` file:
        ```bash
        echo 'export GEMINI_API_KEY="YOUR_GEMINI_API_KEY"' >> ~/.bashrc
        source ~/.bashrc
        ```

2.  **<a id="gemini-api-key"></a>Gemini API 密钥：**
    - 从 Google AI Studio 获取您的 API 密钥：[https://aistudio.google.com/app/apikey](https://aistudio.google.com/app/apikey)
    - 设置 `GEMINI_API_KEY` 环境变量。在以下方法中，将 `YOUR_GEMINI_API_KEY` 替换为您从 Google AI Studio 获取的 API 密钥：
      - 您可以使用以下命令在当前的 shell 会话中临时设置环境变量：
        ```bash
        export GEMINI_API_KEY="YOUR_GEMINI_API_KEY"
        ```
      - 为了重复使用，您可以将环境变量添加到您的 [.env 文件](#persisting-environment-variables-with-env-files) 或 shell 的配置文件（如 `~/.bashrc`、`~/.zshrc` 或 `~/.profile`）中。例如，以下命令将环境变量添加到 `~/.bashrc` 文件中：
        ```bash
        echo 'export GEMINI_API_KEY="YOUR_GEMINI_API_KEY"' >> ~/.bashrc
        source ~/.bashrc
        ```

3.  **Vertex AI:**
    - Obtain your Google Cloud API key: [Get an API Key](https://cloud.google.com/vertex-ai/generative-ai/docs/start/api-keys?usertype=newuser)
      - Set the `GOOGLE_API_KEY` environment variable. In the following methods, replace `YOUR_GOOGLE_API_KEY` with your Vertex AI API key:
        - You can temporarily set these environment variables in your current shell session using the following commands:
          ```bash
          export GOOGLE_API_KEY="YOUR_GOOGLE_API_KEY"
          ```
        - For repeated use, you can add the environment variables to your [.env file](#persisting-environment-variables-with-env-files) or your shell's configuration file (like `~/.bashrc`, `~/.zshrc`, or `~/.profile`). For example, the following commands add the environment variables to a `~/.bashrc` file:
          ```bash
          echo 'export GOOGLE_API_KEY="YOUR_GOOGLE_API_KEY"' >> ~/.bashrc
          source ~/.bashrc
          ```
    - To use Application Default Credentials (ADC), use the following command:
      - Ensure you have a Google Cloud project and have enabled the Vertex AI API.
        ```bash
        gcloud auth application-default login
        ```
        For more information, see [Set up Application Default Credentials for Google Cloud](https://cloud.google.com/docs/authentication/provide-credentials-adc).
      - Set the `GOOGLE_CLOUD_PROJECT` and `GOOGLE_CLOUD_LOCATION` environment variables. In the following methods, replace `YOUR_PROJECT_ID` and `YOUR_PROJECT_LOCATION` with the relevant values for your project:
        - You can temporarily set these environment variables in your current shell session using the following commands:
          ```bash
          export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"
          export GOOGLE_CLOUD_LOCATION="YOUR_PROJECT_LOCATION" # e.g., us-central1
          ```
        - For repeated use, you can add the environment variables to your [.env file](#persisting-environment-variables-with-env-files) or your shell's configuration file (like `~/.bashrc`, `~/.zshrc`, or `~/.profile`). For example, the following commands add the environment variables to a `~/.bashrc` file:
          ```bash
          echo 'export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"' >> ~/.bashrc
          echo 'export GOOGLE_CLOUD_LOCATION="YOUR_PROJECT_LOCATION"' >> ~/.bashrc
          source ~/.bashrc
          ```

3.  **Vertex AI：**
    - 获取您的 Google Cloud API 密钥：[获取 API 密钥](https://cloud.google.com/vertex-ai/generative-ai/docs/start/api-keys?usertype=newuser)
      - 设置 `GOOGLE_API_KEY` 环境变量。在以下方法中，将 `YOUR_GOOGLE_API_KEY` 替换为您的 Vertex AI API 密钥：
        - 您可以使用以下命令在当前的 shell 会话中临时设置这些环境变量：
          ```bash
          export GOOGLE_API_KEY="YOUR_GOOGLE_API_KEY"
          ```
        - 为了重复使用，您可以将环境变量添加到您的 [.env 文件](#persisting-environment-variables-with-env-files) 或 shell 的配置文件（如 `~/.bashrc`、`~/.zshrc` 或 `~/.profile`）中。例如，以下命令将环境变量添加到 `~/.bashrc` 文件中：
          ```bash
          echo 'export GOOGLE_API_KEY="YOUR_GOOGLE_API_KEY"' >> ~/.bashrc
          source ~/.bashrc
          ```
    - 要使用 Application Default Credentials (ADC)，请使用以下命令：
      - 确保您有一个 Google Cloud 项目并已启用 Vertex AI API。
        ```bash
        gcloud auth application-default login
        ```
        更多信息，请参阅 [为 Google Cloud 设置 Application Default Credentials](https://cloud.google.com/docs/authentication/provide-credentials-adc)。
      - 设置 `GOOGLE_CLOUD_PROJECT` 和 `GOOGLE_CLOUD_LOCATION` 环境变量。在以下方法中，将 `YOUR_PROJECT_ID` 和 `YOUR_PROJECT_LOCATION` 替换为您的项目的相关值：
        - 您可以使用以下命令在当前的 shell 会话中临时设置这些环境变量：
          ```bash
          export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"
          export GOOGLE_CLOUD_LOCATION="YOUR_PROJECT_LOCATION" # 例如，us-central1
          ```
        - 为了重复使用，您可以将环境变量添加到您的 [.env 文件](#persisting-environment-variables-with-env-files) 或 shell 的配置文件（如 `~/.bashrc`、`~/.zshrc` 或 `~/.profile`）中。例如，以下命令将环境变量添加到 `~/.bashrc` 文件中：
          ```bash
          echo 'export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"' >> ~/.bashrc
          echo 'export GOOGLE_CLOUD_LOCATION="YOUR_PROJECT_LOCATION"' >> ~/.bashrc
          source ~/.bashrc
          ```

4.  **Cloud Shell:**
    - This option is only available when running in a Google Cloud Shell environment.
    - It automatically uses the credentials of the logged-in user in the Cloud Shell environment.
    - This is the default authentication method when running in Cloud Shell and no other method is configured.

4.  **Cloud Shell：**
    - 此选项仅在 Google Cloud Shell 环境中运行时可用。
    - 它会自动使用 Cloud Shell 环境中已登录用户的凭据。
    - 这是在 Cloud Shell 中运行且未配置其他方法时的默认身份验证方法。

### Persisting Environment Variables with `.env` Files

### 使用 .env 文件持久化环境变量

You can create a **`.gemini/.env`** file in your project directory or in your home directory. Creating a plain **`.env`** file also works, but `.gemini/.env` is recommended to keep Gemini variables isolated from other tools.

您可以在您的项目目录或主目录中创建一个 **`.gemini/.env`** 文件。创建一个普通的 **`.env`** 文件也可以，但推荐使用 `.gemini/.env` 以便将 Gemini 的变量与其他工具隔离开来。

Gemini CLI automatically loads environment variables from the **first** `.env` file it finds, using the following search order:

Gemini CLI 会按照以下搜索顺序，从它找到的**第一个** `.env` 文件中自动加载环境变量：

1. Starting in the **current directory** and moving upward toward `/`, for each directory it checks:
   1. `.gemini/.env`
   2. `.env`
2. If no file is found, it falls back to your **home directory**:
   - `~/.gemini/.env`
   - `~/.env`

1. 从**当前目录**开始，向上移动至 `/`，对每个目录进行检查：
   1. `.gemini/.env`
   2. `.env`
2. 如果没有找到文件，它会回退到您的**主目录**：
   - `~/.gemini/.env`
   - `~/.env`

> **Important:** The search stops at the **first** file encountered—variables are **not merged** across multiple files.

> **重要提示：** 搜索在遇到**第一个**文件时停止——变量**不会**在多个文件之间合并。

#### Examples

#### 示例

**Project-specific overrides** (take precedence when you are inside the project):

**项目特定覆盖**（当您在项目内部时具有优先权）：

```bash
mkdir -p .gemini
echo 'GOOGLE_CLOUD_PROJECT="your-project-id"' >> .gemini/.env
```

**User-wide settings** (available in every directory):

**用户范围设置**（在每个目录中都可用）：

```bash
mkdir -p ~/.gemini
cat >> ~/.gemini/.env <<'EOF'
GOOGLE_CLOUD_PROJECT="your-project-id"
GEMINI_API_KEY="your-gemini-api-key"
EOF
```
