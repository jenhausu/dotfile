#!/usr/bin/env fish

# Claude Code 配置同步工具 (Fish Shell 版本)
# 使用方式：
#   ./sync-claude-config.fish backup   # 備份配置到 dotfile
#   ./sync-claude-config.fish restore  # 從 dotfile 還原配置

set DOTFILE_DIR (dirname (status --current-filename))
set CLAUDE_BACKUP_DIR "$DOTFILE_DIR/claude"
set CLAUDE_HOME "$HOME/.claude"

# 顏色輸出
set GREEN (set_color green)
set BLUE (set_color blue)
set YELLOW (set_color yellow)
set RED (set_color red)
set NC (set_color normal)

function print_info
    echo -e "$BLUE"ℹ"$NC  $argv"
end

function print_success
    echo -e "$GREEN"✓"$NC  $argv"
end

function print_warning
    echo -e "$YELLOW"⚠"$NC  $argv"
end

function print_error
    echo -e "$RED"✗"$NC  $argv"
end

function backup_config
    print_info "開始備份 Claude 配置..."

    # 創建備份目錄
    mkdir -p "$CLAUDE_BACKUP_DIR"

    # 備份全域 skills
    if test -d "$CLAUDE_HOME/skills"
        print_info "備份全域 skills..."
        cp -r "$CLAUDE_HOME/skills" "$CLAUDE_BACKUP_DIR/"
        print_success "全域 skills 備份完成"
    else
        print_warning "找不到全域 skills 目錄"
    end

    # 備份全域 plugins（僅設定檔，排除 cache/marketplaces 等可重建內容）
    if test -d "$CLAUDE_HOME/plugins"
        print_info "備份全域 plugins..."
        mkdir -p "$CLAUDE_BACKUP_DIR/plugins"
        for f in installed_plugins.json known_marketplaces.json
            if test -f "$CLAUDE_HOME/plugins/$f"
                cp "$CLAUDE_HOME/plugins/$f" "$CLAUDE_BACKUP_DIR/plugins/"
            end
        end
        print_success "全域 plugins 備份完成"
    else
        print_warning "找不到全域 plugins 目錄"
    end

    # 備份全域設定
    if test -f "$CLAUDE_HOME/settings.json"
        print_info "備份全域設定..."
        cp "$CLAUDE_HOME/settings.json" "$CLAUDE_BACKUP_DIR/"
        print_success "全域設定備份完成"
    else
        print_warning "找不到全域設定檔"
    end

    # 備份 keybindings（如果存在）
    if test -f "$CLAUDE_HOME/keybindings.json"
        print_info "備份 keybindings..."
        cp "$CLAUDE_HOME/keybindings.json" "$CLAUDE_BACKUP_DIR/"
        print_success "keybindings 備份完成"
    end

    print_success "所有配置備份完成！"
    print_info "備份位置: $CLAUDE_BACKUP_DIR"
    echo ""
    ls -lh "$CLAUDE_BACKUP_DIR"
end

function restore_config
    print_info "開始還原 Claude 配置..."

    # 檢查備份目錄是否存在
    if not test -d "$CLAUDE_BACKUP_DIR"
        print_error "找不到備份目錄: $CLAUDE_BACKUP_DIR"
        return 1
    end

    # 確認是否要覆蓋現有配置
    print_warning "這將會覆蓋現有的 Claude 配置"
    read -P "確定要繼續嗎? (y/N): " -n 1 confirm
    echo

    if not string match -qi "y" $confirm
        print_info "已取消還原"
        return 0
    end

    # 確保 ~/.claude 目錄存在
    mkdir -p "$CLAUDE_HOME"

    # 還原全域 skills
    if test -d "$CLAUDE_BACKUP_DIR/skills"
        print_info "還原全域 skills..."
        rm -rf "$CLAUDE_HOME/skills"
        cp -r "$CLAUDE_BACKUP_DIR/skills" "$CLAUDE_HOME/"
        print_success "全域 skills 還原完成"
    end

    # 還原全域 plugins（僅還原設定檔，不影響 cache/marketplaces）
    if test -d "$CLAUDE_BACKUP_DIR/plugins"
        print_info "還原全域 plugins..."
        mkdir -p "$CLAUDE_HOME/plugins"
        cp "$CLAUDE_BACKUP_DIR/plugins/"*.json "$CLAUDE_HOME/plugins/" 2>/dev/null
        print_success "全域 plugins 還原完成"
    end

    # 還原全域設定
    if test -f "$CLAUDE_BACKUP_DIR/settings.json"
        print_info "還原全域設定..."
        cp "$CLAUDE_BACKUP_DIR/settings.json" "$CLAUDE_HOME/"
        print_success "全域設定還原完成"
    end

    # 還原 keybindings
    if test -f "$CLAUDE_BACKUP_DIR/keybindings.json"
        print_info "還原 keybindings..."
        cp "$CLAUDE_BACKUP_DIR/keybindings.json" "$CLAUDE_HOME/"
        print_success "keybindings 還原完成"
    end

    print_success "所有配置還原完成！"
end

function show_usage
    echo "使用方式:"
    echo "  "(status --current-filename)" backup   - 備份 Claude 配置到 dotfile"
    echo "  "(status --current-filename)" restore  - 從 dotfile 還原 Claude 配置"
    echo ""
    echo "備份內容:"
    echo "  • ~/.claude/skills/          (全域 skills)"
    echo "  • ~/.claude/plugins/         (全域 plugins)"
    echo "  • ~/.claude/settings.json    (全域設定)"
    echo "  • ~/.claude/keybindings.json (快捷鍵設定)"
end

# 主程式
switch "$argv[1]"
    case backup
        backup_config
    case restore
        restore_config
    case '*'
        show_usage
        exit 1
end
