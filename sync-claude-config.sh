#!/bin/bash

# Claude Code 配置同步工具
# 使用方式：
#   ./sync-claude-config.sh backup   # 備份配置到 dotfile
#   ./sync-claude-config.sh restore  # 從 dotfile 還原配置

set -e

DOTFILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CLAUDE_BACKUP_DIR="$DOTFILE_DIR/claude"
CLAUDE_HOME="$HOME/.claude"

# 顏色輸出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

function print_info() {
    echo -e "${BLUE}ℹ${NC}  $1"
}

function print_success() {
    echo -e "${GREEN}✓${NC}  $1"
}

function print_warning() {
    echo -e "${YELLOW}⚠${NC}  $1"
}

function print_error() {
    echo -e "${RED}✗${NC}  $1"
}

function backup_config() {
    print_info "開始備份 Claude 配置..."

    # 創建備份目錄
    mkdir -p "$CLAUDE_BACKUP_DIR"

    # 備份全域 skills
    if [ -d "$CLAUDE_HOME/skills" ]; then
        print_info "備份全域 skills..."
        cp -r "$CLAUDE_HOME/skills" "$CLAUDE_BACKUP_DIR/"
        print_success "全域 skills 備份完成"
    else
        print_warning "找不到全域 skills 目錄"
    fi

    # 備份全域 plugins（僅設定檔，排除 cache/marketplaces 等可重建內容）
    if [ -d "$CLAUDE_HOME/plugins" ]; then
        print_info "備份全域 plugins..."
        mkdir -p "$CLAUDE_BACKUP_DIR/plugins"
        for f in installed_plugins.json known_marketplaces.json; do
            if [ -f "$CLAUDE_HOME/plugins/$f" ]; then
                cp "$CLAUDE_HOME/plugins/$f" "$CLAUDE_BACKUP_DIR/plugins/"
            fi
        done
        print_success "全域 plugins 備份完成"
    else
        print_warning "找不到全域 plugins 目錄"
    fi

    # 備份全域設定
    if [ -f "$CLAUDE_HOME/settings.json" ]; then
        print_info "備份全域設定..."
        cp "$CLAUDE_HOME/settings.json" "$CLAUDE_BACKUP_DIR/"
        print_success "全域設定備份完成"
    else
        print_warning "找不到全域設定檔"
    fi

    # 備份 keybindings（如果存在）
    if [ -f "$CLAUDE_HOME/keybindings.json" ]; then
        print_info "備份 keybindings..."
        cp "$CLAUDE_HOME/keybindings.json" "$CLAUDE_BACKUP_DIR/"
        print_success "keybindings 備份完成"
    fi

    print_success "所有配置備份完成！"
    print_info "備份位置: $CLAUDE_BACKUP_DIR"
    echo ""
    ls -lh "$CLAUDE_BACKUP_DIR"
}

function restore_config() {
    print_info "開始還原 Claude 配置..."

    # 檢查備份目錄是否存在
    if [ ! -d "$CLAUDE_BACKUP_DIR" ]; then
        print_error "找不到備份目錄: $CLAUDE_BACKUP_DIR"
        exit 1
    fi

    # 確認是否要覆蓋現有配置
    print_warning "這將會覆蓋現有的 Claude 配置"
    read -p "確定要繼續嗎? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "已取消還原"
        exit 0
    fi

    # 確保 ~/.claude 目錄存在
    mkdir -p "$CLAUDE_HOME"

    # 還原全域 skills
    if [ -d "$CLAUDE_BACKUP_DIR/skills" ]; then
        print_info "還原全域 skills..."
        rm -rf "$CLAUDE_HOME/skills"
        cp -r "$CLAUDE_BACKUP_DIR/skills" "$CLAUDE_HOME/"
        print_success "全域 skills 還原完成"
    fi

    # 還原全域 plugins（僅還原設定檔，不影響 cache/marketplaces）
    if [ -d "$CLAUDE_BACKUP_DIR/plugins" ]; then
        print_info "還原全域 plugins..."
        mkdir -p "$CLAUDE_HOME/plugins"
        cp "$CLAUDE_BACKUP_DIR/plugins/"*.json "$CLAUDE_HOME/plugins/" 2>/dev/null
        print_success "全域 plugins 還原完成"
    fi

    # 還原全域設定
    if [ -f "$CLAUDE_BACKUP_DIR/settings.json" ]; then
        print_info "還原全域設定..."
        cp "$CLAUDE_BACKUP_DIR/settings.json" "$CLAUDE_HOME/"
        print_success "全域設定還原完成"
    fi

    # 還原 keybindings
    if [ -f "$CLAUDE_BACKUP_DIR/keybindings.json" ]; then
        print_info "還原 keybindings..."
        cp "$CLAUDE_BACKUP_DIR/keybindings.json" "$CLAUDE_HOME/"
        print_success "keybindings 還原完成"
    fi

    print_success "所有配置還原完成！"
}

function show_usage() {
    echo "使用方式:"
    echo "  $0 backup   - 備份 Claude 配置到 dotfile"
    echo "  $0 restore  - 從 dotfile 還原 Claude 配置"
    echo ""
    echo "備份內容:"
    echo "  • ~/.claude/skills/          (全域 skills)"
    echo "  • ~/.claude/plugins/         (全域 plugins)"
    echo "  • ~/.claude/settings.json    (全域設定)"
    echo "  • ~/.claude/keybindings.json (快捷鍵設定)"
}

# 主程式
case "$1" in
    backup)
        backup_config
        ;;
    restore)
        restore_config
        ;;
    *)
        show_usage
        exit 1
        ;;
esac
