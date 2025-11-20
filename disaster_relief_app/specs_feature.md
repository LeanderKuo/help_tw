# 救災資源整合平台 — 系統技術與權限規格（spec.md）

_version: 2025-10-10 • locale: Asia/Taipei • status: Extended/Final_

> **目的**：作為本系統的「單一權威規格」（SSoT）。本檔彙整**架構**、**RBAC 權限矩陣**、**資料模型**、**API 契約**、**MVVC 分層實作要點**、**安全規則**、**效能與備援**、**通知與排程**、**測試與驗收**。  
> **來源**：整合先前文件（架構與重構指南、UI/UX、資安、spec_v 等）與本次新增 **Shuttle（班車）模組**與更新後之**權限矩陣**。  
> **注意**：本檔案不刪除既有規格，僅擴充、明確化、補充新模組與索引，中英雙語，同時用 utf-8 編碼

---

---

## 1. 角色與權限矩陣（RBAC）— **含班車 Shuttle 欄**

> MFA：Leader / Admin / Superadmin 建議啟用（至少 SMS 或 Authenticator）。  
> Rate Limit：**一般使用者**建立任務「每小時 1 次」；**Leader/Admin 豁免**；Superadmin 亦豁免。

| 角色       | 公告            | 資源點           | 任務                     | 班車                 | 管理權限                                                      |
| ---------- | --------------- | ---------------- | ------------------------ | -------------------- | ------------------------------------------------------------- |
| Root       | -               | -                | -                        | 僅後端操作，含硬刪除 | 後端/維運最高權限（前端無入口）                               |
| Superadmin | 新/編/刪/設緊急 | 新/編/刪         | 新/編/刪/完成/設優先     | 建立/編/刪（本人）   | 終審 leader→admin、任命 user→superuser、任命 superuser→leader |
| Admin      | 新/編/刪/設緊急 | 新/編/刪         | 新/編/刪/完成/設優先     | 建立/編/刪（本人）   | 推薦碼管理、任命 user→superuser、任命 superuser→leader        |
| Leader     | 新/編/刪        | 新/編/刪         | 新/編/刪/完成/設優先     | 建立/編/刪（本人）   | 可輸入推薦碼申請 Admin、任命 user→superuser                   |
| Superuser  | 檢視            | 新/編/刪（本人） | 建立/完成（本人）/設優先 | 建立/編/刪（本人）   | 可申請 Leader                                                 |
| User       | 檢視            | 檢視             | 建立/編/刪（本人）       | 建立/編/刪（本人）   | 可申請 Superuser                                              |
| Visitor    | 檢視公開        | 檢視公開         | 檢視公開                 | -                    | -                                                             |

**補充**

- 「設優先」：任務/班車卡片可標示優先度（列表排序/醒目顯示）。
- 緊急公告唯一性：目前以流程仲裁（即時衝突時採角色優先），**自動降級列為後續**（不優先）。

---

## 2. 核心業務邏輯（Business Logic）

### 2.1 認證、申請與晉升

- Auth：Email/密碼、Google、電話 OTP；App Check 啟用。
- 晉升路徑：User → Superuser（需電話） → Leader（單位/事由審核） → Admin（**推薦碼 + Superadmin 終審**）。
- 推薦碼：每位 Admin 同時 **最多 1 組 Active**；TTL 1h；冪等。

### 2.2 公告（Announcements）

- 類型：General / Emergency；任何時刻僅 1 條 Emergency（流程仲裁維持唯一）。
- 顯示：緊急公告置底跑馬燈（全站），置頂卡片。CAP 來源可自動生成草稿。

### 2.3 資源點（Resource Points）

- 類型：Permanent / Temporary（30 天到期自動隱藏）。
- Geohash 去重：提交時以 geohash-6 檢查相同座標，提示合併或跳轉既有點。
- 電話為敏資：未登入不可見；登入顯示遮罩。

### 2.4 任務（Tasks）

- 需求：人力與物資（可並列）；參與者 `participants` 與 `participantCount/Ids` 一致（Transaction 維護）。
- 聊天：子集合 `messages`；**保存 30 天**；到期清理。
- 隱私：參與時可選 `is_visible`，僅參與者互見資訊與聊天室。
- Rate Limit：**User/Superuser** 每小時至多 1 次建立；**Leader/Admin/Superadmin 豁免**。

### 2.5 班車（Shuttles）— **新模組**

**用途**：在災時調度交通工具（接駁/運送物資/撤離），與任務並列為一級實體。

**資料結構（摘要）**

```
shuttles/{shuttleId} {
  displayId: string,                 // 顯示用 ID，如 S-00123
  title: string,                     // 標題，如「A 區 → 集中站 08:30 接駁」
  description: string,               // 說明
  status: 'open'|'in_progress'|'done'|'canceled',
  route: { from: {lat,lng,geohash,address?}, to: {lat,lng,geohash,address?} },
  schedule: { departAt: Timestamp, arriveAt?: Timestamp },
  capacity: { seats: number, reserved: number, remaining: number },
  priority: boolean,                 // 設優先（影響排序與醒目顯示）
  vehicle: { type?: 'van'|'bus'|'truck'|'other', plate?: string },
  contact: { name?: string, phoneMasked?: string }, // 公開投影（遮罩）
  createdBy: string,                 // userId
  participants: string[],            // 快照陣列（僅 ID）
  participantCount: number,
  createdAt: Timestamp, updatedAt: Timestamp
}

shuttles/{id}/participants/{userId} {
  joinedAt: Timestamp,
  is_visible: boolean,               // 參與者願意公開聯絡方式
  role?: 'driver'|'staff'|'passenger'
}

shuttles/{id}/messages/{messageId} {
  authorId: string,
  text: string,
  createdAt: Timestamp
}
```

**行為**

- 建立/編輯/刪除（本人）：Superuser 以上（依表格）；User 可建立 **個人**班車（如政策允許）。
- 報名/退出：登入者可加入，容量不足時返回 409；`participants` 與 `participantCount` 以 Transaction 維護一致。
- 狀態流轉：`open` → `in_progress` → `done`（或 `canceled`）。完成後 7 天封存。
- 聊天：與任務一致，**保存 30 天**；僅參與者可見可寫。
- 排序：`priority DESC, schedule.departAt ASC, createdAt DESC`。

**索引**

- `status ASC, schedule.departAt ASC`
- `priority DESC, schedule.departAt ASC`
- 地理：`route.from.geohash` / `route.to.geohash` 前綴查詢 + 客端 Haversine。

**UI（與任務對齊）**

- 列表卡（ShuttleCard）：顯示起訖地、出發時間、剩餘座位、[導航]、[加入/退出]。
- 詳情（ShuttleDetail）：參與者/聊天室/行程資訊與車輛資訊。
- 我的班車（ShuttleTabs）：我建立 / 進行中 / 歷史。

---

---

---

## 8. 前端工程要點（Appendix B）

- PWA：Workbox `stale-while-revalidate`（清單/公告/班車/任務），`CacheFirst` 靜態資產；IndexedDB 快取，不將敏資放 localStorage。
- UI：緊急公告跑馬燈固定底部；卡片皆含 **[導航]** 深連結（Google Maps）；電話遮罩依登入與偏好顯示。
- Zod：所有資料入口驗證；字串長度/格式/必填與可選。

---

#

---

# 救災資源整合平台 — 資安與隱私合規規格（security_spec.md）

_version: 2025-10-10 • Extended/Final_

> 目的：明確資料分類、最小權限控管、遮罩策略、審計與備援、威脅模型、CI/CD 安全與作業程序；涵蓋 **Shuttles** 與 **Tasks** 一致的聊天/參與邏輯與留存策略。

---

## 1. 法規與資料主權

- 遵循 **GDPR** 與本地個資法；使用者享 **刪除權** 與 **資料可攜權**。
- 資料區域：Primary `asia-east1`；跨區備份 `asia-northeast1` / `us-central1`（加密、權限控管一致）。

## 2. 資料分類與保護

- 公開：公告（非敏資）、部分資源點、匿名化統計。
- 內部：系統設定、一般操作日誌。
- **敏感/PII**：姓名、電話、Email、任務/班車聯絡資訊、審核資訊。

### 2.1 加密與金鑰

- in-transit：TLS 1.2+；at-rest：AES-256。
- 金鑰：GCP KMS/Secret Manager；嚴禁硬編入庫；CI 僅最小權限 token。

### 2.2 遮罩與最小可見

- 電話：台灣在地化遮罩（保留國碼/前幾碼/末三碼）；未登入不顯示電話與撥打按鈕。
- Email：雜湊儲存（如需），公開投影以遮罩字串顯示。
- 可見性偏好 `privacyPrefs` 由觸發器同步至 `usersPublic`。

## 3. 身分鑑別與授權

- Firebase Auth（Email/SMS/社群），App Check 強制。
- Custom Claims：`role`；Rules 以 `usersServer/{uid}.role` 或 claims 校對。
- MFA：Leader/Admin/Superadmin 建議強制。

## 4. 存取控制（Rules 範疇）

- `usersPublic/*`：只讀；嚴禁 client 寫入。
- `usersPrivate/*`、`privacyPrefs/*`：本人可讀寫；delete 限制（改封存）。
- `usersServer/*`：Admin+/Root 可讀；僅後端/觸發器寫。
- `tasks/*/messages/*`、`shuttles/*/messages/*`：僅參與者可讀寫。

## 5. 稽核與偵測

- **auditLogs**：所有敏感/高權限操作追加寫入，不可改刪；保留 ≥ 1 年（稽核合規）。
- 事件覆蓋：角色變更、推薦碼產生/兌換、建立/刪除任務/班車、容量變更、踢出/退出、緊急公告仲裁結果、Rules 拒絕異常。
- 監控：Crashlytics + GA4 + Cloud Monitoring；對暴力請求/異常登入/拒絕率激增設告警。

## 6. 資料保存與刪除

- 聊天訊息（任務/班車）：**30 天**保留後自動清除（Scheduler/Functions）。
- 任務/班車歷史：1 年封存或匿名化。
- 稽核日誌：至少 1 年。

---

## 2. 頁面規格清單（最終版）

| 頁面代號 | 名稱     | 主要元件                       | 動作事件                       | 角色可見性 |
| -------- | -------- | ------------------------------ | ------------------------------ | ---------- |
| `P01`    | 首頁     | HeroCard, CTAGroup             | 登入 / 註冊                    | 所有人     |
| `P02`    | 登入     | AuthForm                       | 登入成功 → 導向 `/tasks`       | 所有人     |
| `P03`    | 註冊     | RegisterForm                   | 完成註冊 → 自動登入            | 所有人     |
| `P04`    | 公告列表 | AnnouncementCard               | 點擊卡片 → 詳情頁              | 所有人     |
| `P05`    | 班車列表 | ShuttleCard, FilterBar         | **加入班車** → 顯示 Join Modal | 登入者     |
| `P06`    | 班車詳情 | ShuttleDetail                  | 加入 / 退出；導航；聊天室      | 登入者     |
| `P07`    | 我的班車 | ShuttleTabs, ShuttleCard       | Tab 切換 / 完成班車            | 登入者     |
| `P08`    | 任務列表 | TaskCard, FilterBar            | **加入任務** → 顯示 Join Modal | 登入者     |
| `P09`    | 任務詳情 | TaskDetail, ChatBox            | 送出訊息 / 加入 / 退出         | 登入者     |
| `P10`    | 我的任務 | TaskTabs, TaskCard             | Tab 切換 / 完成任務            | 登入者     |
| `P11`    | 地圖檢視 | MapContainer, Pin, BottomSheet | 點擊 Pin → 顯示詳情卡          | 所有人     |
| `P12`    | 管理中心 | UserList, ReviewPanel          | 審核 / 推薦碼                  | Admin+     |
| `P13`    | 帳號中心 | UserProfileCard, RoleBadge     | 編輯資料 / 申請升級            | 登入者     |
| `P14`    | 錯誤頁   | EmptyState                     | 返回首頁                       | 所有人     |

> 備註：**Shuttles 全流程**（列表 → 詳情 → 我的班車）整體互動與 Tasks 對齊（參與、聊天室、完成流）。

---

## 3. 全域元件與行為

- **Top Navbar**：固定頂部；行動漢堡選單；顯示 Logo / 地區+天氣 / 通知 / 頭像。
- **Bottom Marquee**：緊急公告紅底白字跑馬燈固定底部；不覆蓋頁面內容（推高佈局）。
- **FloatingActionButton（FAB）**：
  - 任務：User+ 可見；Leader/Admin 可設優先。
  - 班車：User+ 可見（政策可升至 Superuser+）；Leader/Admin 可設優先。
- **Toast/Modal**：跨頁一致；加入/退出/刪除需二次確認。

---

## 4. Shuttle（班車）畫面與元件

### 4.1 `P05` 班車列表（ShuttleList）

- **ShuttleCard** 欄位：標題、起點/終點、出發時間、剩餘座位、優先徽章、[導航]、[加入/退出]。
- **FilterBar**：`出發地/目的地`（地理選擇器）、`時間`（今天/明天/自訂）、`優先`、`狀態`。
- 空狀態：提示建立班車（依權限）；提供快速建立模板。

### 4.2 `P06` 班車詳情（ShuttleDetail）

- 行程摘要：時間軸（出發/抵達），地圖路徑（可選），車輛資訊（type/plate）。
- 參與者清單：頭像列與詳細清單；`driver/staff/passenger` 標記。
- 聊天室：只對參與者顯示；訊息輸入區固定底部。
- 行動按鈕：加入/退出、導航、完成（建立者/Leader+）。

### 4.3 `P07` 我的班車（ShuttleTabs）

- Tab：我建立 / 進行中 / 歷史。
- 卡片操作：編輯（本人）、完成（建立者/Leader+）、刪除（本人，二次確認）。

---

## 5. 任務（Tasks）畫面與元件（對齊項，供設計稽核）

- 列表、詳情、我的任務與聊天室邏輯同上；「加入任務」彈窗包含 **公開聯絡資訊** 的勾選（`is_visible`）。
- `優先` 標籤與排序規則與 Shuttle 一致。

---

## 6. 導航與深連結

- **Google Maps**：`https://www.google.com/maps/dir/?api=1&destination=<lat>,<lng>`；無座標時使用地址編碼。
- 列表卡 / 詳情頁 / 地圖 Pin 皆提供 [導航] 按鈕，開 App 或瀏覽器。

---

## 7. 隱私與遮罩（UI 規範）

- 未登入：不顯示電話與撥打按鈕（顯示登入 CTA）。
- 登入：依 `privacyPrefs` 顯示遮罩電話（TW 規則）。
- 參與者 `is_visible=false`：在聊天室與清單對其他人隱藏電話欄。

---

## 8. 響應式與 A11y

- Mobile（360+）：單欄；FAB 右下；Marquee 推高佈局。
- Tablet：雙欄（列表/詳情）；地圖右側停靠卡。
- Desktop：左側導航 / 右側內容；支援鍵盤導覽；對比度 ≥ 4.5:1；最小點擊區 44x44px。

---

## 9. 事件追蹤（建議 GA4/CJ 標準事件）

- `shuttle_join`, `shuttle_leave`, `shuttle_full`, `shuttle_complete`
- `task_join`, `task_leave`, `task_complete`
- `emergency_announcement_view`, `map_navigation_click`

> **End of uiux.md**
