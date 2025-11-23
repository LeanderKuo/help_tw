// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'DRIP';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get home => 'Home';

  @override
  String get announcements => 'Announcements';

  @override
  String get tasks => 'Tasks';

  @override
  String get shuttles => 'Shuttles';

  @override
  String get profile => 'Profile';

  @override
  String get map => 'Map';

  @override
  String get resources => 'Resources';

  @override
  String get createTask => 'Create Task';

  @override
  String get join => 'Join';

  @override
  String get leave => 'Leave';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get logout => 'Logout';

  @override
  String get signInSubtitle => 'Sign in to the relief coordination platform';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Enter a valid email address';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get orContinueWith => 'Or continue with';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithLine => 'Continue with LINE';

  @override
  String get noAccountPrompt => 'No account yet?';

  @override
  String get createAccount => 'Create an account';

  @override
  String get registerIntro =>
      'Join the disaster relief platform by filling in the information below.';

  @override
  String get fullName => 'Full name';

  @override
  String get fullNameHint => 'Enter your full name';

  @override
  String get fullNameRequired => 'Full name is required';

  @override
  String get passwordLengthRule => 'Password must be at least 6 characters';

  @override
  String get passwordLengthHint => 'At least 6 characters';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get confirmPasswordHint => 'Re-enter your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get registrationSuccess =>
      'Registration successful. Please verify your email.';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get missionBoardTitle => 'MISSION BOARD\\nTasks';

  @override
  String get useMyLocation => 'Use my location';

  @override
  String get searchTasksHint => 'Search tasks by title or location';

  @override
  String get filterAllCategories => 'All categories';

  @override
  String get filterGeneral => 'General';

  @override
  String get filterUrgent => 'Urgent';

  @override
  String get filterMyDrafts => 'My drafts';

  @override
  String get sortNewest => 'Newest';

  @override
  String get sortNearest => 'Nearest';

  @override
  String get sortPriority => 'Priority';

  @override
  String get tabOpenTasks => 'Open tasks';

  @override
  String get tabMyDrafts => 'My drafts';

  @override
  String get noTasksMatch => 'No active tasks match your filters.';

  @override
  String get noDraftsYet => 'You have not created any drafts.';

  @override
  String get taskEmptyMessage =>
      'Try creating a new task or adjusting the filters.';

  @override
  String get loadFailed => 'Load failed';

  @override
  String get locationNotSet => 'Location not set';

  @override
  String get unknownTime => 'Unknown';

  @override
  String get justNow => 'Just now';

  @override
  String minutesAgo(Object minutes) {
    return '$minutes min ago';
  }

  @override
  String hoursAgo(Object hours) {
    return '$hours h ago';
  }

  @override
  String daysAgo(Object days) {
    return '$days d ago';
  }

  @override
  String get priorityLow => 'Low';

  @override
  String get priorityNormal => 'Normal';

  @override
  String get priorityHigh => 'High';

  @override
  String get priorityEmergency => 'Emergency';

  @override
  String get taskStatusOpen => 'Open';

  @override
  String get taskStatusInProgress => 'In progress';

  @override
  String get taskStatusCompleted => 'Completed';

  @override
  String get taskStatusCancelled => 'Cancelled';

  @override
  String get titleLabel => 'Title';

  @override
  String get priorityLabel => 'Priority';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get typeLabel => 'Type';

  @override
  String get requiredField => 'Required';

  @override
  String get myShuttlesTitle => 'MY SHUTTLES\\nTransport';

  @override
  String get createShuttle => 'Create shuttle';

  @override
  String get searchShuttlesHint => 'Search shuttles by title or location';

  @override
  String get tabHosting => 'Hosting';

  @override
  String get tabJoined => 'Joined';

  @override
  String get tabCompleted => 'Completed';

  @override
  String get noShuttlesHosting => 'No shuttles created yet.';

  @override
  String get noShuttlesJoined => 'No joined shuttles yet.';

  @override
  String get noShuttlesCompleted => 'No completed trips.';

  @override
  String get shuttleEmptyMessage => 'Try creating a shuttle or joining one.';

  @override
  String get navigate => 'Navigate';

  @override
  String get details => 'Details';

  @override
  String get shuttleStatusScheduled => 'Scheduled';

  @override
  String get shuttleStatusEnRoute => 'On the way';

  @override
  String get shuttleStatusArrived => 'Arrived';

  @override
  String get shuttleStatusCancelled => 'Cancelled';

  @override
  String get timeNotSet => 'Time not set';

  @override
  String get communityResourcesTitle =>
      'COMMUNITY RESOURCES\\nResource directory';

  @override
  String get addResource => 'Add resource';

  @override
  String get searchResourcesHint => 'Search resources or locations';

  @override
  String get resourceTypeAll => 'All';

  @override
  String get resourceTypeShelter => 'Shelter';

  @override
  String get resourceTypeWater => 'Water';

  @override
  String get resourceTypeFood => 'Food';

  @override
  String get resourceTypeMedical => 'Medical';

  @override
  String get resourceTypeOther => 'Other';

  @override
  String get noResourcesFound => 'No resources found';

  @override
  String get noResourcesMessage => 'Try adjusting filters or add a resource.';

  @override
  String get activeStatus => 'Active';

  @override
  String get inactiveStatus => 'Inactive';

  @override
  String updatedAt(Object timestamp) {
    return 'Updated $timestamp';
  }

  @override
  String get locationLabel => 'Location';

  @override
  String get createResource => 'Create Resource';

  @override
  String errorWithMessage(Object message) {
    return 'Error: $message';
  }

  @override
  String get taskDetails => 'Task Details';

  @override
  String get taskNotFound => 'Task not found';

  @override
  String get noDescriptionAvailable => 'No description';

  @override
  String errorLoadingChat(Object message) {
    return 'Error loading chat: $message';
  }

  @override
  String get messageHint => 'Type a message...';

  @override
  String get shuttleDetails => 'Shuttle Details';

  @override
  String get shuttleNotFound => 'Shuttle not found';

  @override
  String get startPoint => 'Start';

  @override
  String get endPoint => 'End';

  @override
  String statusWithValue(Object status) {
    return 'Status: $status';
  }

  @override
  String capacityWithValue(Object taken, Object capacity) {
    return 'Capacity: $taken/$capacity';
  }

  @override
  String get joinedShuttleSuccess => 'Joined shuttle!';

  @override
  String get joinShuttle => 'Join Shuttle';

  @override
  String get languageTraditional => 'Traditional Chinese (UI)';

  @override
  String get languageTraditionalSubtitle =>
      'UI labels and errors use Traditional Chinese. Content fields accept any language you type.';

  @override
  String get languageEnglish => 'English (UI only)';

  @override
  String get languageEnglishSubtitle =>
      'Switches interface copy to English. Content fields are language-agnostic with auto-fallback.';

  @override
  String get languageNote =>
      'Interface language is separate from content language. Bilingual fields are optional; display prefers your language and falls back to the other when empty.';

  @override
  String get saveLanguageFailed => 'Failed to save language. Please retry.';

  @override
  String get noEmail => 'No Email';

  @override
  String get roleUser => 'User';

  @override
  String get accountInfo => 'Account Info';

  @override
  String get emailLabel => 'Email';

  @override
  String get userIdLabel => 'User ID';

  @override
  String get appSettingsSection => 'App Settings';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String get notificationSettings => 'Notification Settings';

  @override
  String get privacySettings => 'Privacy Settings';

  @override
  String get aboutSection => 'About';

  @override
  String get helpCenter => 'Help Center';

  @override
  String get aboutApp => 'About Platform';

  @override
  String get terms => 'Terms of Service';

  @override
  String get logoutConfirmTitle => 'Confirm logout';

  @override
  String get logoutConfirmMessage => 'Are you sure you want to log out?';

  @override
  String get cancel => 'Cancel';
}
