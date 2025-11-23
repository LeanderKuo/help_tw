// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '災難資源整合平台';

  @override
  String get login => '登入';

  @override
  String get register => '註冊';

  @override
  String get email => '電子郵件';

  @override
  String get password => '密碼';

  @override
  String get home => '首頁';

  @override
  String get announcements => '公告';

  @override
  String get tasks => '任務';

  @override
  String get shuttles => '接駁';

  @override
  String get profile => '個人';

  @override
  String get map => '地圖';

  @override
  String get resources => '資源';

  @override
  String get createTask => '建立任務';

  @override
  String get join => '加入';

  @override
  String get leave => '離開';

  @override
  String get settings => '設定';

  @override
  String get language => '語言';

  @override
  String get darkMode => '深色模式';

  @override
  String get logout => '登出';

  @override
  String get signInSubtitle => '登入救災協作平台';

  @override
  String get emailHint => '請輸入電子郵件';

  @override
  String get emailRequired => '請輸入電子郵件';

  @override
  String get emailInvalid => '請輸入有效的電子郵件';

  @override
  String get passwordHint => '請輸入密碼';

  @override
  String get passwordRequired => '請輸入密碼';

  @override
  String get forgotPassword => '忘記密碼？';

  @override
  String get orContinueWith => '或繼續使用';

  @override
  String get continueWithGoogle => '使用 Google 繼續';

  @override
  String get continueWithLine => '使用 LINE 繼續';

  @override
  String get noAccountPrompt => '還沒有帳號？';

  @override
  String get createAccount => '建立帳號';

  @override
  String get registerIntro => '填寫下列資訊加入救災協作平台。';

  @override
  String get fullName => '姓名';

  @override
  String get fullNameHint => '請輸入姓名';

  @override
  String get fullNameRequired => '請輸入姓名';

  @override
  String get passwordLengthRule => '密碼長度至少 6 碼';

  @override
  String get passwordLengthHint => '至少 6 碼';

  @override
  String get confirmPassword => '確認密碼';

  @override
  String get confirmPasswordHint => '請再次輸入密碼';

  @override
  String get passwordsDoNotMatch => '兩次密碼不一致';

  @override
  String get registrationSuccess => '註冊成功，請前往信箱驗證。';

  @override
  String get alreadyHaveAccount => '已經有帳號？';

  @override
  String get missionBoardTitle => '任務看板\\nTasks';

  @override
  String get useMyLocation => '使用我的位置';

  @override
  String get searchTasksHint => '以標題或地點搜尋任務';

  @override
  String get filterAllCategories => '所有分類';

  @override
  String get filterGeneral => '一般';

  @override
  String get filterUrgent => '緊急';

  @override
  String get filterMyDrafts => '我的草稿';

  @override
  String get sortNewest => '最新';

  @override
  String get sortNearest => '最近';

  @override
  String get sortPriority => '優先順序';

  @override
  String get tabOpenTasks => '開放任務';

  @override
  String get tabMyDrafts => '我的草稿';

  @override
  String get noTasksMatch => '沒有符合篩選條件的任務。';

  @override
  String get noDraftsYet => '你尚未建立任何草稿。';

  @override
  String get taskEmptyMessage => '試著建立新任務或調整篩選條件。';

  @override
  String get loadFailed => '載入失敗';

  @override
  String get locationNotSet => '尚未設定地點';

  @override
  String get unknownTime => '未知';

  @override
  String get justNow => '剛剛';

  @override
  String minutesAgo(Object minutes) {
    return '$minutes 分鐘前';
  }

  @override
  String hoursAgo(Object hours) {
    return '$hours 小時前';
  }

  @override
  String daysAgo(Object days) {
    return '$days 天前';
  }

  @override
  String get priorityLow => '低';

  @override
  String get priorityNormal => '一般';

  @override
  String get priorityHigh => '高';

  @override
  String get priorityEmergency => '緊急';

  @override
  String get taskStatusOpen => '開放中';

  @override
  String get taskStatusInProgress => '進行中';

  @override
  String get taskStatusCompleted => '已完成';

  @override
  String get taskStatusCancelled => '已取消';

  @override
  String get titleLabel => '標題';

  @override
  String get priorityLabel => '優先順序';

  @override
  String get descriptionLabel => '描述';

  @override
  String get typeLabel => '類型';

  @override
  String get requiredField => '必填';

  @override
  String get myShuttlesTitle => '我的接駁\\n運輸';

  @override
  String get createShuttle => '建立接駁';

  @override
  String get searchShuttlesHint => '以標題或地點搜尋接駁';

  @override
  String get tabHosting => '主持中';

  @override
  String get tabJoined => '已加入';

  @override
  String get tabCompleted => '已完成';

  @override
  String get noShuttlesHosting => '尚未建立任何接駁。';

  @override
  String get noShuttlesJoined => '尚未加入任何接駁。';

  @override
  String get noShuttlesCompleted => '尚未有完成的行程。';

  @override
  String get shuttleEmptyMessage => '試著建立或加入接駁。';

  @override
  String get navigate => '導航';

  @override
  String get details => '詳情';

  @override
  String get shuttleStatusScheduled => '已排程';

  @override
  String get shuttleStatusEnRoute => '前往中';

  @override
  String get shuttleStatusArrived => '已抵達';

  @override
  String get shuttleStatusCancelled => '已取消';

  @override
  String get timeNotSet => '尚未設定時間';

  @override
  String get communityResourcesTitle => '社區資源\\n資源目錄';

  @override
  String get addResource => '新增資源';

  @override
  String get searchResourcesHint => '搜尋資源或地點';

  @override
  String get resourceTypeAll => '全部';

  @override
  String get resourceTypeShelter => '收容';

  @override
  String get resourceTypeWater => '飲用水';

  @override
  String get resourceTypeFood => '食物';

  @override
  String get resourceTypeMedical => '醫療';

  @override
  String get resourceTypeOther => '其他';

  @override
  String get noResourcesFound => '沒有找到資源';

  @override
  String get noResourcesMessage => '試著調整篩選或新增資源。';

  @override
  String get activeStatus => '啟用';

  @override
  String get inactiveStatus => '停用';

  @override
  String updatedAt(Object timestamp) {
    return '更新於 $timestamp';
  }

  @override
  String get locationLabel => '位置';

  @override
  String get createResource => '建立資源';

  @override
  String errorWithMessage(Object message) {
    return '錯誤：$message';
  }

  @override
  String get taskDetails => '任務詳情';

  @override
  String get taskNotFound => '找不到任務';

  @override
  String get noDescriptionAvailable => '沒有描述';

  @override
  String errorLoadingChat(Object message) {
    return '聊天載入錯誤：$message';
  }

  @override
  String get messageHint => '輸入訊息...';

  @override
  String get shuttleDetails => '接駁詳情';

  @override
  String get shuttleNotFound => '找不到接駁';

  @override
  String get startPoint => '起點';

  @override
  String get endPoint => '終點';

  @override
  String statusWithValue(Object status) {
    return '狀態：$status';
  }

  @override
  String capacityWithValue(Object taken, Object capacity) {
    return '座位：$taken/$capacity';
  }

  @override
  String get joinedShuttleSuccess => '已加入接駁！';

  @override
  String get joinShuttle => '加入接駁';

  @override
  String get languageTraditional => '繁體中文（介面）';

  @override
  String get languageTraditionalSubtitle => '介面與錯誤訊息使用繁體中文，內容欄位可自由輸入任何語言。';

  @override
  String get languageEnglish => 'English（介面）';

  @override
  String get languageEnglishSubtitle => '將介面文案切換為英文，內容欄位保留雙語彈性。';

  @override
  String get languageNote => '介面語言與內容語言分開設定。支援雙語欄位會優先顯示你的語言，若空白則顯示另一語言。';

  @override
  String get saveLanguageFailed => '語言儲存失敗，請再試一次。';

  @override
  String get noEmail => '尚未填寫 Email';

  @override
  String get roleUser => '使用者';

  @override
  String get accountInfo => '帳號資訊';

  @override
  String get emailLabel => '電子郵件';

  @override
  String get userIdLabel => '使用者 ID';

  @override
  String get appSettingsSection => '應用設定';

  @override
  String get languageSettings => '語言設定';

  @override
  String get notificationSettings => '通知設定';

  @override
  String get privacySettings => '隱私設定';

  @override
  String get aboutSection => '關於';

  @override
  String get helpCenter => '幫助中心';

  @override
  String get aboutApp => '關於平台';

  @override
  String get terms => '服務條款';

  @override
  String get logoutConfirmTitle => '確認登出';

  @override
  String get logoutConfirmMessage => '確定要登出嗎？';

  @override
  String get cancel => '取消';
}
