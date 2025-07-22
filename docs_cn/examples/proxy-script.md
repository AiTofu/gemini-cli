Loaded cached credentials.
# Example Proxy Script

# 代理脚本示例

The following is an example of a proxy script that can be used with the `GEMINI_SANDBOX_PROXY_COMMAND` environment variable. This script only allows `HTTPS` connections to `example.com:443` and declines all other requests.

以下是一个代理脚本示例，可与 `GEMINI_SANDBOX_PROXY_COMMAND` 环境变量一同使用。该脚本仅允许到 `example.com:443` 的 `HTTPS` 连接，并拒绝所有其他请求。

```javascript
#!/usr/bin/env node

/**
 * @license
 * Copyright 2025 Google LLC
 * SPDX-License-Identifier: Apache-2.0
 */

// 监听 :::8877 端口的代理服务器示例，仅允许到 example.com 的 HTTPS 连接。
// Example proxy server that listens on :::8877 and only allows HTTPS connections to example.com.
// 设置 `GEMINI_SANDBOX_PROXY_COMMAND=scripts/example-proxy.js` 以便在沙箱环境旁运行代理
// Set `GEMINI_SANDBOX_PROXY_COMMAND=scripts/example-proxy.js` to run proxy alongside sandbox
// 通过在沙箱内（shell 模式或通过 shell 工具）运行 `curl https://example.com` 进行测试
// Test via `curl https://example.com` inside sandbox (in shell mode or via shell tool)

import http from 'http';
import net from 'net';
import { URL } from 'url';
import console from 'console';

const PROXY_PORT = 8877;
const ALLOWED_DOMAINS = ['example.com', 'googleapis.com'];
const ALLOWED_PORT = '443';

const server = http.createServer((req, res) => {
  // 拒绝除 HTTPS 的 CONNECT 之外的所有请求
  // Deny all requests other than CONNECT for HTTPS
  console.log(
    `[PROXY] Denying non-CONNECT request for: ${req.method} ${req.url}`,
  );
  res.writeHead(405, { 'Content-Type': 'text/plain' });
  res.end('Method Not Allowed');
});

server.on('connect', (req, clientSocket, head) => {
  // 对于 CONNECT 请求，req.url 的格式为 "hostname:port"。
  // req.url will be in the format "hostname:port" for a CONNECT request.
  const { port, hostname } = new URL(`http://${req.url}`);

  console.log(`[PROXY] Intercepted CONNECT request for: ${hostname}:${port}`);

  if (
    ALLOWED_DOMAINS.some(
      (domain) => hostname == domain || hostname.endsWith(`.${domain}`),
    ) &&
    port === ALLOWED_PORT
  ) {
    console.log(`[PROXY] Allowing connection to ${hostname}:${port}`);

    // 建立到原始目标的 TCP 连接。
    // Establish a TCP connection to the original destination.
    const serverSocket = net.connect(port, hostname, () => {
      clientSocket.write('HTTP/1.1 200 Connection Established\r\n\r\n');
      // 通过在客户端和目标服务器之间建立管道来创建隧道。
      // Create a tunnel by piping data between the client and the destination server.
      serverSocket.write(head);
      serverSocket.pipe(clientSocket);
      clientSocket.pipe(serverSocket);
    });

    serverSocket.on('error', (err) => {
      console.error(`[PROXY] Error connecting to destination: ${err.message}`);
      clientSocket.end(`HTTP/1.1 502 Bad Gateway\r\n\r\n`);
    });
  } else {
    console.log(`[PROXY] Denying connection to ${hostname}:${port}`);
    clientSocket.end('HTTP/1.1 403 Forbidden\r\n\r\n');
  }

  clientSocket.on('error', (err) => {
    // 如果客户端挂断，可能会发生这种情况。
    // This can happen if the client hangs up.
    console.error(`[PROXY] Client socket error: ${err.message}`);
  });
});

server.listen(PROXY_PORT, () => {
  const address = server.address();
  console.log(`[PROXY] Proxy listening on ${address.address}:${address.port}`);
  console.log(
    `[PROXY] Allowing HTTPS connections to domains: ${ALLOWED_DOMAINS.join(', ')}`,
  );
});
```
