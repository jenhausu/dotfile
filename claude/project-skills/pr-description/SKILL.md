---
name: pr-description
description: 自動生成 Pull Request 描述，包含 Purpose、Behavior Changes、Architecture Changes 和 Risk 評估。當使用者需要建立 PR description 或詢問如何寫 PR 說明時使用此 skill。
---

# PR Description Generator

自動分析當前分支的變更並生成完整的 Pull Request 描述。

## 使用方式

使用者可以透過以下方式調用此 skill：
- `/pr-description`
- "幫我生成 PR description"
- "我需要寫 PR 說明"

## Instructions

當使用者執行此 skill 時，請按照以下步驟操作：

### 1. 檢查當前分支狀態

首先確認當前的工作環境：
- 執行 `git status` 確認當前分支名稱和狀態
- 執行 `git log develop..HEAD --oneline` 查看所有提交（base branch 為 develop）
- 執行 `git diff develop...HEAD --stat` 查看變更統計

### 2. 分析變更內容

深入分析程式碼變更：
- 執行 `git diff develop...HEAD` 查看完整差異
- 識別主要變更的檔案和功能模組
- 理解每個提交的目的和影響範圍
- 關注業務邏輯變更，而非僅僅代碼語法修改

### 3. 生成 PR Description

使用以下格式生成 PR description（使用繁體中文）：

```markdown
## Purpose
[描述此 PR 的目的和要解決的問題。2-4 句話說明為什麼需要這些變更]

## Behavior Changes
[列出使用者可見的行為變更]
- [行為變更 1]
- [行為變更 2]
- [如果沒有行為變更，說明 "無使用者可見的行為變更"]

## Architecture Changes
[描述架構層面的變更]
- [架構變更 1：例如新增的模組、修改的資料流程]
- [架構變更 2：例如資料庫 schema 變更、新增的 API]
- [架構變更 3：例如相依性更新、設計模式改變]
- [如果沒有架構變更，說明 "無架構變更"]

## Risk
[評估此變更的風險等級和潛在影響]
- **風險等級**: [Low / Medium / High]
- **影響範圍**: [描述可能受影響的功能或模組]
- **需要注意的測試項目**:
  - [ ] [關鍵測試項目 1]
  - [ ] [關鍵測試項目 2]
  - [ ] [關鍵測試項目 3]
- **建議的部署策略**: [例如：可以正常部署 / 建議在低峰時段部署 / 需要資料庫遷移]

---
🤖 由 [Claude Code](https://claude.com/claude-code) 自動生成
```

### 4. 輸出結果

- 直接顯示生成的完整 PR description
- 提示使用者可以直接複製使用
- 詢問是否需要調整任何部分

## 注意事項

### Base Branch
- 預設使用 `develop` 作為 base branch（根據專案的 git 配置）
- 如果需要與其他分支比較，請明確告知使用者

### 語言
- 所有 PR description 內容使用**繁體中文**（符合 iCHEF 團隊慣例）
- 技術術語可保留英文

### 風險評估準則
- **Low**: 僅影響局部功能，容易回滾，測試覆蓋完整
- **Medium**: 影響多個模組，需要額外測試，回滾略複雜
- **High**: 影響核心功能、資料結構變更、需要資料遷移、或影響多個子系統

### 測試項目建議
根據變更類型自動建議相關測試：
- UI 變更：檢查畫面顯示、互動流程
- API 變更：測試新舊版本相容性、錯誤處理
- 資料變更：驗證資料遷移、資料完整性
- 硬體整合：測試實體設備（印表機、支付終端機等）
- 離線功能：測試離線模式運作、同步機制

## Examples

### 範例 1：新增支付方式
```
使用者：/pr-description
助手：讓我分析當前分支的變更...

[執行 git 命令分析]

這是為 feat/support_91AppPayment 分支生成的 PR description：

## Purpose
此 PR 新增 91APP 支付方式的完整支援，讓 iCHEF POS 系統能夠整合 91APP 的支付服務。包含登入流程自動建立支付方式、GraphQL API 支援、以及在各個銷售相關功能中正確顯示和處理 91APP 支付。

## Behavior Changes
- 登入時自動檢查並建立 91APP 支付方式（需開啟 DreamCenter 功能開關）
- 小結關帳介面新增 91APP 支付類別顯示
- 發票詳情頁面支援顯示 91APP 支付資訊
- 印單功能支援 91APP 支付方式列印

...
```

### 範例 2：Bug 修復
```
使用者：幫我生成 PR description
助手：好的，讓我分析這個 bug fix PR...

[分析變更]

## Purpose
修正折扣計算在特定情境下的精度錯誤...
```
