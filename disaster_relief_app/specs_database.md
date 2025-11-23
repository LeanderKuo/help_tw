這份資料庫結構規格書直接針對您的需求設計，整合了 **多選標籤**、**欄位優化** 以及 **補完不合理的邏輯**（如：地理位置索引、狀態追蹤、以及關鍵變更通知）。

我將欄位分為 **資料庫欄位名稱 (Field)**、**類型 (Type)** 與 **設計邏輯/備註 (Logic)**。

---

### 1\. 通用標準與基礎結構 (Global Standards)

所有模組共用的設計邏輯，避免重複定義。

- **多語言內容 (`JSONB`)**：標題與內文不分欄位，存成 `{ "zh-TW": "...", "en-US": "..." }`，前端依語系讀取。
- **地理資訊 (`JSONB` + `PostGIS`)**：**修正建議** — 不要只存地址，必須存座標與 Geohash 以便做「附近救援」的查詢。
  - 結構：`{ "lat": 25.03, "lng": 121.56, "address": "...", "geohash": "wsqq..." }`
- **圖片/附件**：建議統一存為 URL 陣列 (`text[]`)。

---

### 2\. 救援任務 (Missions / Tasks)

**修正邏輯**：將「人力需求」結構化，以便計算進度條。新增 `last_critical_update` 用於通知。

| 欄位名稱 (Field)       | 類型 (Type)        | 邏輯與備註 (Logic)                                                                                                                                              |
| :--------------------- | :----------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `id`                   | UUID               | 主鍵                                                                                                                                                            |
| `creator_id`           | UUID               | 關聯到使用者 (Profile)                                                                                                                                          |
| `title`                | JSONB              | 任務標題 (多語言)                                                                                                                                               |
| `description`          | JSONB              | 任務詳情。**若類型選「其他」，細節寫在此處。**                                                                                                                  |
| `types`                | **text[] (Array)** | **多選標籤**。例如：`['rescue', 'medical', 'other']`。                                                                                                          |
| `status`               | Enum               | `open` (招募中), `in_progress` (進行中), `done` (完成), `canceled` (取消)                                                                                       |
| `priority`             | Boolean            | 僅 Leader/Admin 可設為 `true` (置頂或高亮)。                                                                                                                    |
| `location`             | JSONB              | 任務地點 (含座標、地址)。                                                                                                                                       |
| `requirements`         | JSONB              | **結構化需求**。包含：<br>1. `materials` (物資清單 array)<br>2. `manpower_needed` (需求人數 int)<br>3. `manpower_current` (目前人數 int, 透過 Trigger 自動計算) |
| `interaction`          | JSONB              | 包含 `chat_room_id` (聊天室 ID) 與 `contact_phone_visible` (是否公開電話)。                                                                                     |
| `last_critical_update` | Timestamp          | **補完設計**：若在 `in_progress` 狀態修改地點/時間，更新此欄位以觸發通知。                                                                                      |
| `created_at`           | Timestamp          | 建立時間                                                                                                                                                        |

---

### 3\. 班車共乘 (Shuttles)

**修正邏輯**：區分「車輛本身」與「班車用途」。費用拆分為類型與金額結構。

| 欄位名稱 (Field)       | 類型 (Type)        | 邏輯與備註 (Logic)                                                                                       |
| :--------------------- | :----------------- | :------------------------------------------------------------------------------------------------------- | ----------- | -------------------------------------------------- |
| `id`                   | UUID               | 主鍵                                                                                                     |
| `creator_id`           | UUID               | 駕駛或發起人                                                                                             |
| `vehicle_info`         | JSONB              | **車輛硬體資訊** (單選概念)。<br>`{ "type": "bus"                                                        | "van"       | "car", "plate": "車牌(非公開)", "color": "..." }`  |
| `purposes`             | **text[] (Array)** | **用途/類型 (多選)**。例如：`['evacuation', 'medical_transport']`。                                      |
| `description`          | JSONB              | 補充說明 (路線細節、行李限制等)。                                                                        |
| `route`                | JSONB              | **路線結構**。<br>`{ "origin": {Location}, "destination": {Location}, "stops": [Location list] }`        |
| `schedule`             | JSONB              | **時間結構**。<br>`{ "depart_at": Timestamp, "arrive_at_est": Timestamp }`                               |
| `capacity`             | JSONB              | **座位管理**。<br>`{ "total": 4, "taken": 0, "remaining": 4 }` (資料庫 constraint 確保 `taken <= total`) |
| `cost_info`            | JSONB              | **費用結構**。<br>`{ "type": "free"                                                                      | "share_gas" | "fixed", "total_price": 1000, "per_person": 334 }` |
| `status`               | Enum               | `open`, `in_progress` (發車中), `done`, `canceled`。**手動切換，不綁定滿員。**                           |
| `last_critical_update` | Timestamp          | 若發車時間或地點變更，更新此欄位觸發通知。                                                               |

---

### 4\. 資源點 (Resource Points)

**修正邏輯**：增加 `inventory` (庫存) 的結構化欄位，而不僅僅是文字描述，方便未來做「缺水」、「缺電」的快速篩選。

| 欄位名稱 (Field) | 類型 (Type)        | 邏輯與備註 (Logic)                                                                                                                |
| :--------------- | :----------------- | :-------------------------------------------------------------------------------------------------------------------------------- |
| `id`             | UUID               | 主鍵                                                                                                                              |
| `categories`     | **text[] (Array)** | **資源類型 (多選)**。例如：`['food', 'water', 'charging', 'medical', 'shelter', 'other']`。                                       |
| `title`          | JSONB              | 據點名稱 (如：光復車站前補給站)(含座標、地址)                                                                                     |
| `description`    | JSONB              | 詳細說明 (領取規則等)。                                                                                                           |
| `inventory`      | JSONB              | **補完設計：庫存清單**。<br>例如：`[{ "item": "肉包", "qty": "300個", "status": "available" }, { "item": "水", "qty": "300瓶" }]` |
| `location`       | JSONB              | 據點位置 (PostGIS Point)。                                                                                                        |
| `status`         | Enum               | `active` (啟用), `shortage` (物資短缺), `closed` (關閉/撤收)                                                                      |
| `expiry_date`    | Timestamp          | **自動下架時間**。臨時據點預設 3 天或 30 天，到期自動轉 closed 或隱藏。                                                           |

---

### 5\. 關聯表與補充邏輯 (Relational & Logic)

為了支援「參與」、「聊天」與「通知」，需要這兩張輔助表：

#### A. 參與名單 (Participants)

_用於記錄誰加入了哪個任務或班車。_

- `entity_id`: UUID (任務 ID 或 班車 ID)
- `entity_type`: Enum (`mission` | `shuttle`)
- `user_id`: UUID
- `role`: Enum (`driver`, `passenger`, `helper`, `commander`)
- `status`: Enum (`joined`, `waitlist`, `approved`) — **補完設計**：若滿員可進入候補或需審核。
- `is_contact_visible`: Boolean (使用者加入時勾選，是否同意公開電話給同組人)。

#### B. 聊天室 (Chat Rooms)

- 系統在建立任務/班車時，**自動建立**一筆 Chat Room 資料。
- 訊息表 (`chat_messages`) 關聯此 Room ID。
- **補完設計**：不需要手動拉群，邏輯是「只要在 `Participants` 表內且 status=joined 的人，就有權限讀取該 Room ID 的訊息」。

#### C. 編輯與通知邏輯 (Critical Update Logic)

- **權限**：只有 `creator_id` 本人、`role` 為 `leader/admin` 的人可以 Update。
- **觸發條件**：當 `status` = `in_progress` **且** 變更了 `schedule` 或 `location` 欄位時：
  1.  後端紀錄變更日誌。
  2.  系統自動發送推播/App 內通知給該 `entity_id` 下的所有 `Participants`：「[緊急變更] 您參與的任務地點/時間已更新，請確認。」
