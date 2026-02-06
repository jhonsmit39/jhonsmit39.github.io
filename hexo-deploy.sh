#!/bin/bash

# Hexo 博客部署脚本
# 用法: ./hexo-deploy.sh "your commit message"

# 检查是否提供了 commit 信息
if [ -z "$1" ]; then
    echo "错误: 请提供 commit 信息"
    echo "用法: ./hexo-deploy.sh \"your commit message\""
    echo "示例: ./hexo-deploy.sh \"fix: add title to poetry article\""
    exit 1
fi

# 保存 commit 信息
COMMIT_MSG="$1"

echo "=========================================="
echo "开始部署 Hexo 博客"
echo "Commit 信息: $COMMIT_MSG"
echo "=========================================="

# 1. 清理缓存
echo ""
echo "[1/5] 清理 Hexo 缓存..."
hexo clean

if [ $? -ne 0 ]; then
    echo "❌ 清理失败"
    exit 1
fi
echo "✅ 清理完成"

# 2. 生成静态文件
echo ""
echo "[2/5] 生成静态文件..."
hexo generate

if [ $? -ne 0 ]; then
    echo "❌ 生成失败"
    exit 1
fi
echo "✅ 生成完成"

# 3. 添加到 Git
echo ""
echo "[3/5] 添加文件到 Git..."
git add .

if [ $? -ne 0 ]; then
    echo "❌ Git add 失败"
    exit 1
fi
echo "✅ 文件已添加"

# 4. 提交更改
echo ""
echo "[4/5] 提交更改..."
git commit -m "$COMMIT_MSG"

if [ $? -ne 0 ]; then
    echo "⚠️  没有需要提交的更改，或提交失败"
fi

# 5. 推送到远程仓库
echo ""
echo "[5/5] 推送到 GitHub..."
git push

if [ $? -ne 0 ]; then
    echo "❌ 推送失败"
    exit 1
fi
echo "✅ 推送完成"

echo ""
echo "=========================================="
echo "🎉 部署成功！"
echo "=========================================="
echo "您的博客将在几分钟内更新"
echo "访问: https://jhonsmit39.github.io"
echo "=========================================="
