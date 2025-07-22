#!/bin/zsh

# --- 配置 ---
SOURCE_DIR="/Users/me9528/BestWork/AIProjects/gemini-cli/docs"
TARGET_DIR="/Users/me9528/BestWork/AIProjects/gemini-cli/docs_cn"
LOG_FILE="/Users/me9528/BestWork/AIProjects/gemini-cli/logs/translate-docs.log"

# --- 初始化 ---
mkdir -p "$TARGET_DIR"
# 初始化日志文件
echo "--- Translation log started on $(date) ---" > "$LOG_FILE"

# --- 第一步：拷贝非 Markdown 文件 ---
echo "开始拷贝非 Markdown 文件..."
find "$SOURCE_DIR" -type f ! -name "*.md" | while read -r source_file; do
  # 计算相对路径和目标文件路径
  rel_path="${source_file#$SOURCE_DIR/}"
  target_file="$TARGET_DIR/$rel_path"
  target_dir=$(dirname "$target_file")
  
  # 确保目标文件的目录存在
  mkdir -p "$target_dir"
  
  # 检查目标文件是否已存在，如果存在则跳过
  if [ -f "$target_file" ]; then
    echo "跳过已存在的文件: $target_file"
    continue
  fi
  
  echo "正在拷贝: $source_file -> $target_file"
  
  # 拷贝文件
  if cp "$source_file" "$target_file"; then
    echo "拷贝成功: $target_file"
    echo "Copied $source_file -> $target_file" >> "$LOG_FILE"
  else
    echo "拷贝失败: $source_file"
    echo "Copy failed: $source_file -> $target_file" >> "$LOG_FILE"
  fi
done

echo "非 Markdown 文件拷贝完成！"
echo ""

# --- 第二步：翻译 Markdown 文件 ---
echo "开始翻译 Markdown 文件..."
find "$SOURCE_DIR" -name "*.md" -type f | while read -r source_file; do
  # 计算相对路径和目标文件路径
  rel_path="${source_file#$SOURCE_DIR/}"
  target_file="$TARGET_DIR/$rel_path"
  target_dir=$(dirname "$target_file")
  
  # 确保目标文件的目录存在
  mkdir -p "$target_dir"
  
  # 检查目标文件是否已存在，如果存在则跳过
  if [ -f "$target_file" ]; then
    echo "跳过已存在的文件: $target_file"
    continue
  fi
  
  echo "正在翻译: $source_file"
  
  # 【修正第一处】: 读取源文件的内容到变量中
  source_content=$(cat "$source_file")

  # 记录操作到日志文件，但不包含巨大的文件内容
  echo "Translating $source_file -> $target_file" >> "$LOG_FILE"

  # 【修正第二处】: 重新设计管道和提示词
  # 1. 将源文件内容通过 here-document 喂给 Gemini
  # 2. Gemini 的输出结果通过管道 | 传递给 tee
  # 3. tee 将结果同时写入目标文件 "$target_file" 和终端 "/dev/tty"
    # 【关键修正】: 将 <<EOF 修改为 <<-EOF 以支持缩进
  gemini --silent <<-EOF | tee "$target_file"
	请将下面的 Markdown 文本翻译成中英文段落双语对照内容。
	你的回答应该是且仅是翻译后的 Markdown 内容本身，不要包含任何额外的解释，例如“好的，这是翻译结果：”。

	翻译请遵循以下要求：
	1. 一段英文原文，紧接着一段简体中文翻译，以此格式交替。注意顺序永远是英文原文在前，中文翻译在后。
	2. 在每一对“英文-中文”段落后，增加一个空行以提高可读性。
	3. 翻译需准确流畅，并保留原文的 Markdown 格式（如标题、列表、粗体等）。
	4. 对于常见的英文技术术语（如 "CLI", "API", "Docker", "Git" 等），请保留英文原文不作翻译。
	5. 代码块（\`\`\`）中的代码不需翻译，但代码块中的注释需要翻译成中文。

	--- 以下是需要翻译的 Markdown 文本 ---

	$source_content
	EOF

  # 检查上一个命令（gemini | tee）是否成功执行
  if [ $? -eq 0 ]; then
    echo "翻译成功: $target_file"
  else
    echo "翻译失败: $source_file" >> "$LOG_FILE"
    echo "翻译失败: $source_file"
  fi
  
  # 避免API限制，添加延迟
  sleep 3
done

echo "Markdown 文件翻译完成！"
echo "所有文件处理完成！"

