---
name: write-tests
description: 根據當前分支的程式碼改動自動生成測試代碼。分析變更檔案、識別需要測試的邏輯，並基於 iCHEF 測試策略生成單元測試和整合測試。測試會被放在對應的模組 Tests 目錄中，只有主專案的程式碼測試才放在 iCHEF2Tests/。
---

# Write Tests from Branch Changes

自動分析當前分支的程式碼變更，識別需要測試的邏輯，並在正確的模組測試目錄中生成相應的測試代碼。

## 使用方式

使用者可以透過以下方式調用此 skill：
- `/write-tests`
- "幫我寫測試"
- "根據改動生成測試代碼"
- "這個 branch 需要什麼測試"

## Instructions

當使用者執行此 skill 時，請按照以下步驟操作：

### 1. 分析當前分支變更

首先了解程式碼變更範圍：
- 執行 `git status` 確認當前分支名稱和未提交的變更
- 執行 `git diff develop...HEAD --name-status` 查看所有變更檔案列表
- 執行 `git diff develop...HEAD` 查看完整程式碼差異
- 識別以下類型的檔案：
  - 新增的 Swift 檔案 (A)
  - 修改的 Swift 檔案 (M)
  - 排除測試檔案本身 (*Tests.swift, *Spec.swift)

#### 識別檔案所屬模組

根據檔案路徑判斷所屬模組：
- **Packages/CHFBusinessLogic/Sources/** → 測試放在 `Packages/CHFBusinessLogic/Tests/CHFBusinessLogicTests/`
- **Packages/CHFDataModel/Sources/** → 測試放在 `Packages/CHFDataModel/Tests/CHFDomainModelsTests/` 或 `CHFYYModelsTests/`
- **Packages/CHFDomain/Sources/** → 測試放在 `Packages/CHFDomain/Tests/CHFDomainTests/`
- **Packages/CHFFeature/Sources/** → 測試放在 `Packages/CHFFeature/Tests/CHFFeatureTests/`
- **Packages/CHFFoundation/Sources/** → 測試放在 `Packages/CHFFoundation/Tests/CHFFoundationTests/`
- **Packages/CHFUIKit/Sources/** → 測試放在 `Packages/CHFUIKit/Tests/CHFUIKitTests/`
- **Packages/CHFUtility/Sources/** → 測試放在 `Packages/CHFUtility/Tests/CHFUtilityTests/`
- **Packages/JamUI/Sources/** → 測試放在 `Packages/JamUI/Tests/JamUITests/`
- **Packages/Peripherals/Sources/** → 測試放在 `Packages/Peripherals/Tests/PeripheralsTests/`
- **iCHEF2/** (主專案) → 測試放在 `iCHEF2Tests/`

**重要**: 每個模組的測試都應該放在該模組的 Tests 目錄中，只有主專案的程式碼測試才放在 iCHEF2Tests/。

### 2. 識別需要測試的代碼

深入分析變更內容，找出需要測試的邏輯：

#### 優先測試項目
1. **新增的業務邏輯**：
   - 新的類別、結構、方法
   - 計算邏輯（例如：折扣計算、金額計算）
   - 資料轉換邏輯
   - 狀態管理邏輯

2. **修改的核心邏輯**：
   - 條件判斷的變更
   - 演算法改動
   - API 呼叫變更
   - 資料處理流程變更

3. **整合點**：
   - ViewModel 與 Model 的互動
   - API 整合（GraphQL mutations/queries）
   - 資料庫操作（Core Data, SQLite）
   - 硬體週邊整合（印表機、支付終端機）

#### 需要特別注意的測試場景
- **離線功能**：離線模式下的行為
- **同步邏輯**：主從設備同步
- **支付流程**：支付閘道整合
- **錯誤處理**：邊界條件、錯誤情境
- **併發處理**：多執行緒、非同步操作

### 3. 確定測試類型

根據變更內容選擇適當的測試類型：

#### 單元測試 (Unit Tests)
適用於：
- 純函數邏輯
- 資料模型轉換
- 計算邏輯
- ViewModel 狀態管理
- Utility 函數

#### 整合測試 (Integration Tests)
適用於：
- API 呼叫與回應處理
- 資料庫操作
- 多模組互動
- ViewModel 與 Service 層互動

#### 手動測試檢查清單
適用於：
- 硬體週邊操作（印表機、支付終端機）
- UI 互動流程
- 離線同步場景
- 多設備協作

### 4. 生成測試代碼

#### 測試檔案命名規範
- 單元測試：`[ClassName]Tests.swift`
- 整合測試：`[ModuleName]IntegrationTests.swift`

#### 測試檔案放置位置規則

**根據被測試程式碼的位置決定測試檔案位置：**

1. **模組程式碼** (Packages/*/Sources/): 測試放在該模組的 Tests 目錄
   - 例：`Packages/CHFBusinessLogic/Sources/CHFBusinessLogic/DiscountCalculator.swift`
   - 測試放在：`Packages/CHFBusinessLogic/Tests/CHFBusinessLogicTests/DiscountCalculatorTests.swift`

2. **主專案程式碼** (iCHEF2/): 測試放在 iCHEF2Tests/
   - 例：`iCHEF2/ViewControllers/CheckoutViewController.swift`
   - 測試放在：`iCHEF2Tests/CheckoutViewControllerTests.swift`

3. **特殊模組**: 某些模組可能有多個測試 target
   - CHFDataModel 有：`CHFDomainModelsTests/`, `CHFYYModelsTests/`, `CHFManagedObjectsTests/`
   - CHFBusinessLogic 有：`CHFBusinessLogicTests/`, `InvoiceLogicTests/`
   - 根據程式碼功能選擇最合適的測試 target

#### 測試代碼結構
使用 XCTest 框架，遵循以下結構：

```swift
import XCTest
@testable import [ModuleName] // 例如 CHFBusinessLogic, CHFDataModel, 或 iCHEF2

final class [ClassName]Tests: XCTestCase {

    // MARK: - Properties
    var sut: [ClassName]!
    // 其他需要的 mock objects 或 dependencies

    // MARK: - Setup & Teardown
    override func setUp() {
        super.setUp()
        // 初始化 system under test (sut)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests
    func test_[methodName]_[scenario]_[expectedResult]() {
        // Given (準備測試數據)

        // When (執行被測試的操作)

        // Then (驗證結果)
    }
}
```

#### 測試命名慣例
使用 `test_[methodName]_[scenario]_[expectedResult]` 格式：
- `test_calculateDiscount_withValidCoupon_returnsDiscountedPrice()`
- `test_syncData_whenOffline_queuesForLaterSync()`
- `test_processPayment_with91AppPayment_updatesOrderStatus()`

#### Mock 和 Stub 建議
- 對外部依賴（API、資料庫）使用 Protocol + Mock 實作
- 使用 Dependency Injection 讓測試更容易
- 對於非同步操作，使用 `XCTestExpectation`

### 5. 生成測試檢查清單

對於無法自動化測試的部分，生成手動測試檢查清單：

```markdown
## 手動測試檢查清單

### 功能測試
- [ ] [測試項目 1：描述具體操作步驟和預期結果]
- [ ] [測試項目 2：...]

### 離線測試
- [ ] 在離線模式下執行功能
- [ ] 確認資料正確儲存到本地
- [ ] 恢復網路後驗證同步

### 硬體整合測試（如適用）
- [ ] [印表機：測試印單格式和內容]
- [ ] [支付終端機：測試支付流程]

### 邊界條件測試
- [ ] [極端數值測試]
- [ ] [空值/nil 處理]
- [ ] [錯誤情境處理]
```

### 6. 輸出測試代碼和說明

- 為每個需要測試的檔案生成對應的測試檔案
- 顯示測試代碼的完整內容
- 說明每個測試的目的和覆蓋的場景
- 提供手動測試檢查清單
- 建議測試執行順序（先單元測試，再整合測試，最後手動測試）

### 7. 使用 Write 工具創建測試檔案

- 詢問使用者是否要直接創建測試檔案
- 如果同意，使用 Write 工具在適當的測試目錄創建測試檔案
- 提示使用者可以執行 `CMD+U` 或 `xcodebuild test` 來運行測試

## 注意事項

### iCHEF 專案特性
- **MVVM 架構**：ViewModel 是主要測試目標
- **離線優先**：確保離線場景的測試覆蓋
- **多設備同步**：測試主從設備同步邏輯
- **協議導向**：善用 Protocol 來建立可測試的介面

### 測試覆蓋重點
1. **業務邏輯**：計算、轉換、狀態管理
2. **錯誤處理**：邊界條件、錯誤情境
3. **非同步操作**：使用 XCTestExpectation
4. **資料一致性**：同步前後的資料狀態

### 不需要測試的部分
- 第三方框架的功能（已有自己的測試）
- 簡單的 getter/setter
- UI 元件的外觀（由 UI Tests 或手動測試負責）
- 硬體週邊的底層通訊（由廠商 SDK 保證）

### 測試資料準備
- 使用 Factory Pattern 或 Builder Pattern 建立測試資料
- 為常見場景準備可重用的 Mock Data
- 考慮使用 JSON fixtures 來模擬 API 回應

### 語言
- 測試代碼使用英文命名（符合 Swift 慣例）
- 註解和說明可使用繁體中文
- 測試檢查清單使用繁體中文

## Examples

### 範例 1：新增支付方式功能

```
使用者：/write-tests
助手：讓我分析當前分支的程式碼變更...

[執行 git diff 分析]

我找到以下需要測試的變更：

1. **新增檔案**：
   - `Packages/CHFDataModel/Sources/CHFDomainModels/PaymentMethod+91App.swift`
   - `Packages/CHFFeature/Sources/CheckBalance/CheckBalanceViewModel+91App.swift`

2. **修改檔案**：
   - `iCHEF2/Login/LoginFlowManager.swift` - 新增登入時建立支付方式邏輯
   - `iCHEF2/Receipt/ReceiptDetailViewModel.swift` - 新增 91APP 支付顯示邏輯

根據檔案位置，我將測試放在對應的位置：

### 測試檔案 1: `Packages/CHFDataModel/Tests/CHFDomainModelsTests/PaymentMethod91AppTests.swift`

```swift
import XCTest
@testable import CHFDomainModels

final class PaymentMethod91AppTests: XCTestCase {
    // [完整測試代碼]
}
```

### 測試檔案 2: `iCHEF2Tests/LoginFlowManagerTests.swift`

```swift
import XCTest
@testable import iCHEF2

final class LoginFlowManagerTests: XCTestCase {
    // [測試代碼，聚焦在新增的邏輯]
}
```

### 手動測試檢查清單

- [ ] 登入時確認 91APP 支付方式正確建立
- [ ] 小結關帳介面顯示 91APP 支付類別
- [ ] 發票詳情頁面正確顯示 91APP 支付資訊
- [ ] 印單包含 91APP 支付方式資訊

是否要我創建這些測試檔案？
```

### 範例 2：折扣計算邏輯修改

```
使用者：幫我寫測試
助手：分析中...

發現您修改了折扣計算邏輯：
- `Packages/CHFBusinessLogic/Sources/CHFBusinessLogic/DiscountCalculator.swift`

這是計算邏輯的核心變更，我會生成詳細的單元測試。

測試檔案將放在：
`Packages/CHFBusinessLogic/Tests/CHFBusinessLogicTests/DiscountCalculatorTests.swift`

### `DiscountCalculatorTests.swift`

```swift
import XCTest
@testable import CHFBusinessLogic

final class DiscountCalculatorTests: XCTestCase {
    var sut: DiscountCalculator!

    override func setUp() {
        super.setUp()
        sut = DiscountCalculator()
    }

    // [完整測試代碼，包含 10+ 個測試 cases]
}
```

我會測試以下場景：
1. ✅ 單一折扣正確計算
2. ✅ 多重折扣優先順序
3. ✅ 折扣上限限制
4. ✅ 邊界條件（0元、負數、超大數值）
5. ✅ 錯誤輸入處理

### 手動測試建議
- [ ] 在實際訂單中驗證折扣計算正確性
- [ ] 測試多種折扣組合情境
- [ ] 驗證發票上的折扣顯示

是否要我創建測試檔案並執行測試？
```

### 範例 3：僅有小修改

```
使用者：/write-tests
助手：分析中...

我檢查了當前分支的變更，發現主要是以下修改：
- 修正了一個 typo
- 調整了 UI 元件的 spacing

這些變更不需要額外的自動化測試。建議進行簡單的手動檢查：
- [ ] 確認文字顯示正確
- [ ] 確認 UI 排版符合設計

無需創建新的測試檔案。
```

## 進階功能

### 測試覆蓋率分析
- 如果使用者要求，可以執行 `xcodebuild test -enableCodeCoverage YES` 來生成覆蓋率報告
- 分析哪些變更的程式碼還沒有被測試覆蓋
- 建議補充測試的優先順序

### 測試執行
- 提供執行測試的命令
- 解讀測試結果
- 協助除錯失敗的測試

### 重構建議
- 如果發現程式碼難以測試，建議重構方向
- 提出引入 Dependency Injection 的建議
- 建議將複雜邏輯拆分成可測試的小單元
