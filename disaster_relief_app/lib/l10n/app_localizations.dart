import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'DRIP'**
  String get appTitle;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @announcements.
  ///
  /// In en, this message translates to:
  /// **'Announcements'**
  String get announcements;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @shuttles.
  ///
  /// In en, this message translates to:
  /// **'Shuttles'**
  String get shuttles;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @resources.
  ///
  /// In en, this message translates to:
  /// **'Resources'**
  String get resources;

  /// No description provided for @createTask.
  ///
  /// In en, this message translates to:
  /// **'Create Task'**
  String get createTask;

  /// No description provided for @join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get join;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leave;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to the relief coordination platform'**
  String get signInSubtitle;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get emailInvalid;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithLine.
  ///
  /// In en, this message translates to:
  /// **'Continue with LINE'**
  String get continueWithLine;

  /// No description provided for @noAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'No account yet?'**
  String get noAccountPrompt;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAccount;

  /// No description provided for @registerIntro.
  ///
  /// In en, this message translates to:
  /// **'Join the disaster relief platform by filling in the information below.'**
  String get registerIntro;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullNameHint;

  /// No description provided for @fullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get fullNameRequired;

  /// No description provided for @passwordLengthRule.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordLengthRule;

  /// No description provided for @passwordLengthHint.
  ///
  /// In en, this message translates to:
  /// **'At least 6 characters'**
  String get passwordLengthHint;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get confirmPasswordHint;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @registrationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful. Please verify your email.'**
  String get registrationSuccess;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @missionBoardTitle.
  ///
  /// In en, this message translates to:
  /// **'MISSION BOARD\\nTasks'**
  String get missionBoardTitle;

  /// No description provided for @useMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Use my location'**
  String get useMyLocation;

  /// No description provided for @searchTasksHint.
  ///
  /// In en, this message translates to:
  /// **'Search tasks by title or location'**
  String get searchTasksHint;

  /// No description provided for @filterAllCategories.
  ///
  /// In en, this message translates to:
  /// **'All categories'**
  String get filterAllCategories;

  /// No description provided for @filterGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get filterGeneral;

  /// No description provided for @filterUrgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get filterUrgent;

  /// No description provided for @filterMyDrafts.
  ///
  /// In en, this message translates to:
  /// **'My drafts'**
  String get filterMyDrafts;

  /// No description provided for @sortNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get sortNewest;

  /// No description provided for @sortNearest.
  ///
  /// In en, this message translates to:
  /// **'Nearest'**
  String get sortNearest;

  /// No description provided for @sortPriority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get sortPriority;

  /// No description provided for @tabOpenTasks.
  ///
  /// In en, this message translates to:
  /// **'Open tasks'**
  String get tabOpenTasks;

  /// No description provided for @tabMyDrafts.
  ///
  /// In en, this message translates to:
  /// **'My drafts'**
  String get tabMyDrafts;

  /// No description provided for @noTasksMatch.
  ///
  /// In en, this message translates to:
  /// **'No active tasks match your filters.'**
  String get noTasksMatch;

  /// No description provided for @noDraftsYet.
  ///
  /// In en, this message translates to:
  /// **'You have not created any drafts.'**
  String get noDraftsYet;

  /// No description provided for @taskEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Try creating a new task or adjusting the filters.'**
  String get taskEmptyMessage;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Load failed'**
  String get loadFailed;

  /// No description provided for @locationNotSet.
  ///
  /// In en, this message translates to:
  /// **'Location not set'**
  String get locationNotSet;

  /// No description provided for @unknownTime.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknownTime;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min ago'**
  String minutesAgo(Object minutes);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours} h ago'**
  String hoursAgo(Object hours);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} d ago'**
  String daysAgo(Object days);

  /// No description provided for @priorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get priorityLow;

  /// No description provided for @priorityNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get priorityNormal;

  /// No description provided for @priorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get priorityHigh;

  /// No description provided for @priorityEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get priorityEmergency;

  /// No description provided for @taskStatusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get taskStatusOpen;

  /// No description provided for @taskStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get taskStatusInProgress;

  /// No description provided for @taskStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get taskStatusCompleted;

  /// No description provided for @taskStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get taskStatusCancelled;

  /// No description provided for @titleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleLabel;

  /// No description provided for @priorityLabel.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priorityLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @typeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get typeLabel;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredField;

  /// No description provided for @myShuttlesTitle.
  ///
  /// In en, this message translates to:
  /// **'MY SHUTTLES\\nTransport'**
  String get myShuttlesTitle;

  /// No description provided for @createShuttle.
  ///
  /// In en, this message translates to:
  /// **'Create shuttle'**
  String get createShuttle;

  /// No description provided for @searchShuttlesHint.
  ///
  /// In en, this message translates to:
  /// **'Search shuttles by title or location'**
  String get searchShuttlesHint;

  /// No description provided for @tabHosting.
  ///
  /// In en, this message translates to:
  /// **'Hosting'**
  String get tabHosting;

  /// No description provided for @tabJoined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get tabJoined;

  /// No description provided for @tabCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get tabCompleted;

  /// No description provided for @noShuttlesHosting.
  ///
  /// In en, this message translates to:
  /// **'No shuttles created yet.'**
  String get noShuttlesHosting;

  /// No description provided for @noShuttlesJoined.
  ///
  /// In en, this message translates to:
  /// **'No joined shuttles yet.'**
  String get noShuttlesJoined;

  /// No description provided for @noShuttlesCompleted.
  ///
  /// In en, this message translates to:
  /// **'No completed trips.'**
  String get noShuttlesCompleted;

  /// No description provided for @shuttleEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Try creating a shuttle or joining one.'**
  String get shuttleEmptyMessage;

  /// No description provided for @navigate.
  ///
  /// In en, this message translates to:
  /// **'Navigate'**
  String get navigate;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @shuttleStatusScheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get shuttleStatusScheduled;

  /// No description provided for @shuttleStatusEnRoute.
  ///
  /// In en, this message translates to:
  /// **'On the way'**
  String get shuttleStatusEnRoute;

  /// No description provided for @shuttleStatusArrived.
  ///
  /// In en, this message translates to:
  /// **'Arrived'**
  String get shuttleStatusArrived;

  /// No description provided for @shuttleStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get shuttleStatusCancelled;

  /// No description provided for @timeNotSet.
  ///
  /// In en, this message translates to:
  /// **'Time not set'**
  String get timeNotSet;

  /// No description provided for @communityResourcesTitle.
  ///
  /// In en, this message translates to:
  /// **'COMMUNITY RESOURCES\\nResource directory'**
  String get communityResourcesTitle;

  /// No description provided for @addResource.
  ///
  /// In en, this message translates to:
  /// **'Add resource'**
  String get addResource;

  /// No description provided for @searchResourcesHint.
  ///
  /// In en, this message translates to:
  /// **'Search resources or locations'**
  String get searchResourcesHint;

  /// No description provided for @resourceTypeAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get resourceTypeAll;

  /// No description provided for @resourceTypeShelter.
  ///
  /// In en, this message translates to:
  /// **'Shelter'**
  String get resourceTypeShelter;

  /// No description provided for @resourceTypeWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get resourceTypeWater;

  /// No description provided for @resourceTypeFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get resourceTypeFood;

  /// No description provided for @resourceTypeMedical.
  ///
  /// In en, this message translates to:
  /// **'Medical'**
  String get resourceTypeMedical;

  /// No description provided for @resourceTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get resourceTypeOther;

  /// No description provided for @noResourcesFound.
  ///
  /// In en, this message translates to:
  /// **'No resources found'**
  String get noResourcesFound;

  /// No description provided for @noResourcesMessage.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting filters or add a resource.'**
  String get noResourcesMessage;

  /// No description provided for @activeStatus.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeStatus;

  /// No description provided for @inactiveStatus.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactiveStatus;

  /// No description provided for @updatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated {timestamp}'**
  String updatedAt(Object timestamp);

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationLabel;

  /// No description provided for @createResource.
  ///
  /// In en, this message translates to:
  /// **'Create Resource'**
  String get createResource;

  /// No description provided for @errorWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorWithMessage(Object message);

  /// No description provided for @taskDetails.
  ///
  /// In en, this message translates to:
  /// **'Task Details'**
  String get taskDetails;

  /// No description provided for @taskNotFound.
  ///
  /// In en, this message translates to:
  /// **'Task not found'**
  String get taskNotFound;

  /// No description provided for @noDescriptionAvailable.
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get noDescriptionAvailable;

  /// No description provided for @errorLoadingChat.
  ///
  /// In en, this message translates to:
  /// **'Error loading chat: {message}'**
  String errorLoadingChat(Object message);

  /// No description provided for @messageHint.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get messageHint;

  /// No description provided for @shuttleDetails.
  ///
  /// In en, this message translates to:
  /// **'Shuttle Details'**
  String get shuttleDetails;

  /// No description provided for @shuttleNotFound.
  ///
  /// In en, this message translates to:
  /// **'Shuttle not found'**
  String get shuttleNotFound;

  /// No description provided for @startPoint.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startPoint;

  /// No description provided for @endPoint.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get endPoint;

  /// No description provided for @statusWithValue.
  ///
  /// In en, this message translates to:
  /// **'Status: {status}'**
  String statusWithValue(Object status);

  /// No description provided for @capacityWithValue.
  ///
  /// In en, this message translates to:
  /// **'Capacity: {taken}/{capacity}'**
  String capacityWithValue(Object taken, Object capacity);

  /// No description provided for @joinedShuttleSuccess.
  ///
  /// In en, this message translates to:
  /// **'Joined shuttle!'**
  String get joinedShuttleSuccess;

  /// No description provided for @joinShuttle.
  ///
  /// In en, this message translates to:
  /// **'Join Shuttle'**
  String get joinShuttle;

  /// No description provided for @languageTraditional.
  ///
  /// In en, this message translates to:
  /// **'Traditional Chinese (UI)'**
  String get languageTraditional;

  /// No description provided for @languageTraditionalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'UI labels and errors use Traditional Chinese. Content fields accept any language you type.'**
  String get languageTraditionalSubtitle;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English (UI only)'**
  String get languageEnglish;

  /// No description provided for @languageEnglishSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Switches interface copy to English. Content fields are language-agnostic with auto-fallback.'**
  String get languageEnglishSubtitle;

  /// No description provided for @languageNote.
  ///
  /// In en, this message translates to:
  /// **'Interface language is separate from content language. Bilingual fields are optional; display prefers your language and falls back to the other when empty.'**
  String get languageNote;

  /// No description provided for @saveLanguageFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save language. Please retry.'**
  String get saveLanguageFailed;

  /// No description provided for @noEmail.
  ///
  /// In en, this message translates to:
  /// **'No Email'**
  String get noEmail;

  /// No description provided for @roleUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get roleUser;

  /// No description provided for @accountInfo.
  ///
  /// In en, this message translates to:
  /// **'Account Info'**
  String get accountInfo;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @userIdLabel.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get userIdLabel;

  /// No description provided for @appSettingsSection.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettingsSection;

  /// No description provided for @languageSettings.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettings;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// No description provided for @privacySettings.
  ///
  /// In en, this message translates to:
  /// **'Privacy Settings'**
  String get privacySettings;

  /// No description provided for @aboutSection.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutSection;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About Platform'**
  String get aboutApp;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm logout'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirmMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
