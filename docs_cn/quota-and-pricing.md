Loaded cached credentials.
# Gemini CLI: Quotas and Pricing

# Gemini CLI：配额与定价

Your Gemini CLI quotas and pricing depend on the type of account you use to authenticate with Google. Additionally, both quotas and pricing may be calculated differently based on the model version, requests, and tokens used. A summary of model usage is available through the `/stats` command and presented on exit at the end of a session. See [privacy and terms](./tos-privacy.md) for details on Privacy policy and Terms of Service. Note: published prices are list price; additional negotiated commercial discounting may apply.

您的 Gemini CLI 配额和定价取决于您用于向 Google 进行身份验证的账户类型。此外，配额和定价的计算方式也可能因所使用的模型版本、请求和 token 数量而异。模型使用情况的摘要可通过 `/stats` 命令查看，并在会话结束退出时显示。有关隐私政策和服务条款的详细信息，请参阅[隐私与条款](./tos-privacy.md)。请注意：公布的价格为标价；额外协商的商业折扣可能适用。

This article outlines the specific quotas and pricing applicable to the Gemini CLI when using different authentication methods.

本文概述了在使用不同身份验证方法时，适用于 Gemini CLI 的具体配额和定价。

## 1. Log in with Google (Gemini Code Assist Free Tier)

## 1. 使用 Google 账号登录（Gemini Code Assist 免费套餐）

For users who authenticate by using their Google account to access Gemini Code Assist for individuals:

对于使用其 Google 账户进行身份验证以访问个人版 Gemini Code Assist 的用户：

- **Quota:**
  - 60 requests per minute
  - 1000 requests per day
  - Token usage is not applicable
- **Cost:** Free
- **Details:** [Gemini Code Assist Quotas](https://developers.google.com/gemini-code-assist/resources/quotas#quotas-for-agent-mode-gemini-cli)
- **Notes:** A specific quota for different models is not specified; model fallback may occur to preserve shared experience quality.

- **配额：**
  - 每分钟 60 次请求
  - 每天 1000 次请求
  - Token 使用量不适用
- **费用：** 免费
- **详情：** [Gemini Code Assist 配额](https://developers.google.com/gemini-code-assist/resources/quotas#quotas-for-agent-mode-gemini-cli)
- **备注：** 未指定不同模型的具体配额；可能会发生模型回退以保证共享体验的质量。

## 2. Gemini API Key (Unpaid)

## 2. Gemini API 密钥（未付费）

If you are using a Gemini API key for the free tier:

如果您使用的是免费套餐的 Gemini API 密钥：

- **Quota:**
  - Flash model only
  - 10 requests per minute
  - 250 requests per day
- **Cost:** Free
- **Details:** [Gemini API Rate Limits](https://ai.google.dev/gemini-api/docs/rate-limits)

- **配额：**
  - 仅限 Flash 模型
  - 每分钟 10 次请求
  - 每天 250 次请求
- **费用：** 免费
- **详情：** [Gemini API 速率限制](https://ai.google.dev/gemini-api/docs/rate-limits)

## 3. Gemini API Key (Paid)

## 3. Gemini API 密钥（付费）

If you are using a Gemini API key with a paid plan:

如果您使用的是付费计划的 Gemini API 密钥：

- **Quota:** Varies by pricing tier.
- **Cost:** Varies by pricing tier and model/token usage.
- **Details:** [Gemini API Rate Limits](https://ai.google.dev/gemini-api/docs/rate-limits), [Gemini API Pricing](https://ai.google.dev/gemini-api/docs/pricing)

- **配额：** 因定价套餐而异。
- **费用：** 因定价套餐及模型/token 使用量而异。
- **详情：** [Gemini API 速率限制](https://ai.google.dev/gemini-api/docs/rate-limits)，[Gemini API 定价](https://ai.google.dev/gemini-api/docs/pricing)

## 4. Login with Google (for Workspace or Licensed Code Assist users)

## 4. 使用 Google 账号登录（适用于 Workspace 或已获许可的 Code Assist 用户）

For users of Standard or Enterprise editions of Gemini Code Assist, quotas and pricing are based on a fixed price subscription with assigned license seats:

对于标准版或企业版 Gemini Code Assist 的用户，配额和定价基于固定价格的订阅，并分配有许可席位：

- **Standard Tier:**
  - **Quota:** 120 requests per minute, 1500 per day
- **Enterprise Tier:**
  - **Quota:** 120 requests per minute, 2000 per day
- **Cost:** Fixed price included with your Gemini for Google Workspace or Gemini Code Assist subscription.
- **Details:** [Gemini Code Assist Quotas](https://developers.google.com/gemini-code-assist/resources/quotas#quotas-for-agent-mode-gemini-cli), [Gemini Code Assist Pricing](https://cloud.google.com/products/gemini/pricing)
- **Notes:**
  - Specific quota for different models is not specified; model fallback may occur to preserve shared experience quality.
  - Members of the Google Developer Program may have Gemini Code Assist licenses through their membership.

- **标准版：**
  - **配额：** 每分钟 120 次请求，每天 1500 次
- **企业版：**
  - **配额：** 每分钟 120 次请求，每天 2000 次
- **费用：** 固定价格，已包含在您的 Gemini for Google Workspace 或 Gemini Code Assist 订阅中。
- **详情：** [Gemini Code Assist 配额](https://developers.google.com/gemini-code-assist/resources/quotas#quotas-for-agent-mode-gemini-cli)，[Gemini Code Assist 定价](https://cloud.google.com/products/gemini/pricing)
- **备注：**
  - 未指定不同模型的具体配额；可能会发生模型回退以保证共享体验的质量。
  - Google 开发者计划的成员可能通过其会员资格获得 Gemini Code Assist 许可。

## 5. Vertex AI (Express Mode)

## 5. Vertex AI（Express 模式）

If you are using Vertex AI in Express Mode:

如果您在 Express 模式下使用 Vertex AI：

- **Quota:** Quotas are variable and specific to your account. See the source for more details.
- **Cost:** After your Express Mode usage is consumed and you enable billing for your project, cost is based on standard [Vertex AI Pricing](https://cloud.google.com/vertex-ai/pricing).
- **Details:** [Vertex AI Express Mode Quotas](https://cloud.google.com/vertex-ai/generative-ai/docs/start/express-mode/overview#quotas)

- **配额：** 配额是可变的，且特定于您的账户。更多详情请参阅源文档。
- **费用：** 在您的 Express 模式用量消耗完毕并为您的项目启用结算后，费用将基于标准的 [Vertex AI 定价](https://cloud.google.com/vertex-ai/pricing)。
- **详情：** [Vertex AI Express 模式配额](https://cloud.google.com/vertex-ai/generative-ai/docs/start/express-mode/overview#quotas)

## 6. Vertex AI (Regular Mode)

## 6. Vertex AI（常规模式）

If you are using the standard Vertex AI service:

如果您使用的是标准 Vertex AI 服务：

- **Quota:** Governed by a dynamic shared quota system or pre-purchased provisioned throughput.
- **Cost:** Based on model and token usage. See [Vertex AI Pricing](https://cloud.google.com/vertex-ai/pricing).
- **Details:** [Vertex AI Dynamic Shared Quota](https://cloud.google.com/vertex-ai/generative-ai/docs/resources/dynamic-shared-quota)

- **配额：** 受动态共享配额系统或预购的预配吞吐量管理。
- **费用：** 基于模型和 token 使用量。请参阅 [Vertex AI 定价](https://cloud.google.com/vertex-ai/pricing)。
- **详情：** [Vertex AI 动态共享配额](https://cloud.google.com/vertex-ai/generative-ai/docs/resources/dynamic-shared-quota)

## 7. Google One and Ultra plans, Gemini for Workspace plans

## 7. Google One 和 Ultra 套餐，Gemini for Workspace 套餐

These plans currently apply only to the use of Gemini web-based products provided by Google-based experiences (for example, the Gemini web app or the Flow video editor). These plans do not apply to the API usage which powers the Gemini CLI. Supporting these plans is under active consideration for future support.

这些套餐目前仅适用于使用由 Google 提供的基于网页的 Gemini 产品（例如，Gemini 网页应用或 Flow 视频编辑器）。这些套餐不适用于驱动 Gemini CLI 的 API 使用。我们正在积极考虑在未来支持这些套餐。
