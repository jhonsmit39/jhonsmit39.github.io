#!/bin/bash

# 快速修复脚本 - 解决当前的推送失败问题

echo "=========================================="
echo "修复 Git 推送问题"
echo "=========================================="

# 1. 获取当前分支
CURRENT_BRANCH=$(git branch --show-current)
echo ""
echo "当前分支: $CURRENT_BRANCH"

# 2. 检查远程仓库
echo ""
echo "[1/3] 检查远程仓库配置..."
REMOTE_URL=$(git remote get-url origin 2>/dev/null)

if [ -z "$REMOTE_URL" ]; then
    echo "❌ 未配置远程仓库"
    echo "请先运行: git remote add origin <你的仓库地址>"
    echo "例如: git remote add origin https://github.com/jhonsmit39/jhonsmit39.github.io.git"
    exit 1
fi

echo "✅ 远程仓库: $REMOTE_URL"

# 3. 处理嵌套的 Git 仓库警告
echo ""
echo "[2/3] 处理嵌套的 Git 仓库..."
if [ -d "themes/next/.git" ]; then
    echo "检测到 themes/next 是嵌套的 Git 仓库"
    echo "建议操作："
    echo "  选项 1: 删除主题的 .git 目录（简单但失去主题更新能力）"
    echo "  选项 2: 使用 Git Submodule（推荐但稍复杂）"
    echo ""
    read -p "选择操作 [1/2/跳过(s)]: " choice
    
    case $choice in
        1)
            echo "删除 themes/next/.git..."
            rm -rf themes/next/.git
            git add themes/next
            git commit -m "chore: remove nested git repo in themes/next"
            echo "✅ 已删除嵌套仓库"
            ;;
        2)
            echo "转换为 Submodule..."
            git rm --cached themes/next
            rm -rf themes/next
            git submodule add https://github.com/next-theme/hexo-theme-next themes/next
            git commit -m "chore: convert theme to submodule"
            echo "✅ 已转换为 Submodule"
            ;;
        *)
            echo "⚠️  跳过处理"
            ;;
    esac
else
    echo "✅ 无嵌套仓库问题"
fi

# 4. 设置上游分支并推送
echo ""
echo "[3/3] 推送到 GitHub..."
echo "执行: git push --set-upstream origin $CURRENT_BRANCH"

git push --set-upstream origin $CURRENT_BRANCH

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "🎉 推送成功！"
    echo "=========================================="
    echo "您的博客将在几分钟内更新"
    echo "访问: https://jhonsmit39.github.io"
else
    echo ""
    echo "=========================================="
    echo "❌ 推送失败"
    echo "=========================================="
    echo "可能的原因："
    echo "1. GitHub 身份验证失败"
    echo "   解决: 配置 SSH 密钥或使用 Personal Access Token"
    echo ""
    echo "2. 网络连接问题"
    echo "   解决: 检查网络连接"
    echo ""
    echo "3. 远程仓库地址错误"
    echo "   当前远程: $REMOTE_URL"
    echo "   修改: git remote set-url origin <正确的地址>"
fi
