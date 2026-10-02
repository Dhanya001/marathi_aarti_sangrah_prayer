import 'package:easy_localization/easy_localization.dart';

class AppString {
  static const String prodCode = "infocontracts";

  // Dashboard / Home Page
  static String get searchDocuments => 'searchDocuments'.tr();
  static String get welcomeUser => 'welcomeUser'.tr(); // Use with .tr(namedArgs: {'name': 'Stacy'})
  static String get expiringSoon => 'expiringSoon'.tr();
  static String get actionPending => 'actionPending'.tr();
  static String get waitingForOther => 'waitingForOther'.tr();
  static String get completed => 'completed'.tr();
  static String get createOrSendDocuments => 'createOrSendDocuments'.tr();
  static String get signDocumentsDescription => 'signDocumentsDescription'.tr();
  static String get startNow => 'startNow'.tr();
  static String get mySignatures => 'mySignatures'.tr();
  static String get manageSignaturesDescription => 'manageSignaturesDescription'.tr();
  static String get createNow => 'createNow'.tr();
  static String get myTemplates => 'myTemplates'.tr();
  static String get manageTemplatesDescription => 'manageTemplatesDescription'.tr();

  // ✅ New strings
  static String get proceed => 'proceed'.tr();
  static String get chooseLanguage => 'chooseLanguage'.tr();

  // Profile Screen
  static String get profile => 'profile'.tr();
  static String get yourPlan => 'yourPlan'.tr();
  static String get freePlan => 'freePlan'.tr();
  static String get managePlan => 'managePlan'.tr();
  static String get upgradeToPro => 'upgradeToPro'.tr();
  static String get profileSettings => 'profileSettings'.tr();
  static String get passwordChange => 'passwordChange'.tr();
  static String get draft => 'draft'.tr();
  static String get contact => 'contact'.tr();
  static String get trash => 'trash'.tr();
  static String get billing => 'billing'.tr();
  static String get darkTheme => 'darkTheme'.tr();
  static String get language => 'language'.tr();
  static String get enhanceExperience => 'enhanceExperience'.tr();
  static String get rateApp => 'rateApp'.tr();
  static String get shareWithFriends => 'shareWithFriends'.tr();
  static String get helpSupport => 'helpSupport'.tr();
  static String get aboutUs => 'aboutUs'.tr();
  static String get privacyPolicy => 'privacyPolicy'.tr();
  static String get termsConditions => 'termsConditions'.tr();
  static String get legalUserAgreement => 'legalUserAgreement'.tr();
  static String get faq => 'faq'.tr();
  static String get contactUs => 'contactUs'.tr();
  static String get communityGuidelines => 'communityGuidelines'.tr();
  static String get accountControl => 'accountControl'.tr();
  static String get deleteAccount => 'deleteAccount'.tr();
  static String get logout => 'logout'.tr();

  // Add Signature Screen
  static String get addSignature => 'addSignature'.tr();
  static String get select => 'select'.tr();
  static String get draw => 'draw'.tr();
  static String get upload => 'upload'.tr();
  static String get signature => 'signature'.tr();
  static String get initials => 'initials'.tr();
  static String get uploadImage => 'uploadImage'.tr();
  static String get createSign => 'createSign'.tr();
  static String get name => 'name'.tr();
  static String get clear => 'clear'.tr();
  static String get createSignAgreement => 'createSignAgreement'.tr();

  // Create First Signature Dialog
  static String get createYourFirstSignature => 'createYourFirstSignature'.tr();
  static String get createSignatureDescription => 'createSignatureDescription'.tr();
  static String get cancel => 'cancel'.tr();
  static String get getStarted => 'getStarted'.tr();

  //inbox
  static String get inbox => 'inbox'.tr();

  // 📅 Date Range
  static String get selectDateRange => 'selectDateRange'.tr();
  static String get allTime => 'allTime'.tr();
  static String get last12Months => 'last12Months'.tr();
  static String get last6Months => 'last6Months'.tr();
  static String get last30Days => 'last30Days'.tr();
  static String get lastWeek => 'lastWeek'.tr();
  static String get last24Hours => 'last24Hours'.tr();

  // 🔍 Filters
  static String get filterDocuments => 'filterDocuments'.tr();
  static String get allDocuments => 'allDocuments'.tr();
  static String get pending => 'pending'.tr();
  static String get cancelled => 'cancelled'.tr();

  // ↕ Sorting
  static String get sortDocuments => 'sortDocuments'.tr();
  static String get newestFirst => 'newestFirst'.tr();
  static String get oldestFirst => 'oldestFirst'.tr();
  static String get aToZ => 'aToZ'.tr();
  static String get zToA => 'zToA'.tr();

  //important tab bar
  static String get important => 'important'.tr();
  static String get template => 'template'.tr();
  static String get received => 'received'.tr();
  static String get sent => 'sent'.tr();
  static String get drafts => 'drafts'.tr();

  static String get partnershipAgreement => 'partnershipAgreement'.tr();
  static String get to => 'to'.tr();
  static String get pendingStatus => 'pendingStatus'.tr();
  static String get completedStatus => 'completedStatus'.tr();
  static String get resend => 'resend'.tr();
  static String get download => 'download'.tr();
  static String get and => 'and'.tr();
  static String get more => 'more'.tr();
  static String get by => 'by'.tr();

  static String get copy => 'copy'.tr();
  static String get saveAsTemplate => 'saveAsTemplate'.tr();
  static String get voidText => 'void'.tr();
  static String get history => 'history'.tr();
  static String get markAsImportant => 'markAsImportant'.tr();
  static String get exportAsCsv => 'exportAsCsv'.tr();
  static String get delete => 'delete'.tr();

  static String get proposalWebsiteRedesign => 'proposalWebsiteRedesign'.tr();
  static String get from => 'from'.tr();
  static String get needToSign => 'needToSign'.tr();
  static String get receiveACopy => 'receiveACopy'.tr();
  static String get needToView => 'needToView'.tr();
  static String get accessCode => 'accessCode'.tr();
  static String get savedDraft => 'savedDraft'.tr();
  static String get sign => 'sign'.tr();
  static String get expiryDate => 'expiryDate'.tr();

  static String get noItemsToSee => 'noItemsToSee'.tr();
  static String get noDraftSaved => 'noDraftSaved'.tr();

  static String get contactDetails => 'contactDetails'.tr();
  static String get about => 'about'.tr();
  static String get saveChanges => 'saveChanges'.tr();
  static String get profileDetails => 'profileDetails'.tr();

  static String get freePlanTitle => 'freePlanTitle'.tr();
  static String get basicPlanTitle => 'basicPlanTitle'.tr();
  static String get proPlanTitle => 'proPlanTitle'.tr();

  static String get pricePerMonth => 'pricePerMonth'.tr();
  static String get popularTag => 'popularTag'.tr();

  static String get startForFree => 'startForFree'.tr();
  static String get contactSale => 'contactSale'.tr();

  static String get freePlanBenefit1 => 'freePlanBenefit1'.tr();
  static String get freePlanBenefit2 => 'freePlanBenefit2'.tr();
  static String get freePlanBenefit3 => 'freePlanBenefit3'.tr();
  static String get freePlanBenefit4 => 'freePlanBenefit4'.tr();

  static String get basicPlanBenefit1 => 'basicPlanBenefit1'.tr();
  static String get basicPlanBenefit2 => 'basicPlanBenefit2'.tr();
  static String get basicPlanBenefit3 => 'basicPlanBenefit3'.tr();
  static String get basicPlanBenefit4 => 'basicPlanBenefit4'.tr();

  static String get proPlanBenefit1 => 'proPlanBenefit1'.tr();
  static String get proPlanBenefit2 => 'proPlanBenefit2'.tr();
  static String get proPlanBenefit3 => 'proPlanBenefit3'.tr();

  static String get subscriptions => 'subscriptions'.tr();
  static String get transparentPricing => 'transparentPricing'.tr();
  static String get passwordChangeTitle => 'passwordChangeTitle'.tr();
  static String get changePassword => 'changePassword'.tr();
  static String get changePasswordDescription => 'changePasswordDescription'.tr();
  static String get enterCurrentPassword => 'enterCurrentPassword'.tr();
  static String get enterNewPassword => 'enterNewPassword'.tr();
  static String get confirmNewPassword => 'confirmNewPassword'.tr();
  static String get save => 'save'.tr();
  static String get continue1 => 'continue'.tr();
  static String get company => 'company'.tr();
  static String get contacts => 'contacts'.tr();
  static String get edit => 'edit'.tr();
  static String get itemsInRecycleBin => 'itemsInRecycleBin'.tr();
  static String get emptyTrash => 'emptyTrash'.tr();
  static String get restore => 'restore'.tr();
  static String get notifications => 'notifications'.tr();
  static String get sendDocumentForSignature => 'sendDocumentForSignature'.tr();
  static String get addDocument => 'addDocument'.tr();
  static String get next => 'next'.tr();
  static String get addRecipients => 'addRecipients'.tr();
  static String get onlySignerTitle => 'onlySignerTitle'.tr();
  static String get onlySignerSubtitle => 'onlySignerSubtitle'.tr();
  static String get addRecipientsTitle => 'addRecipientsTitle'.tr();
  static String get addRecipientsSubtitle => 'addRecipientsSubtitle'.tr();
  static String get templateName => 'templateName'.tr();
  static String get enterName => 'enterName'.tr();
  static String get message => 'message'.tr();
  static String get addMessageForEmail => 'addMessageForEmail'.tr();
  static String get selectFile => 'selectFile'.tr();
  static String get createTemplate => 'createTemplate'.tr();
  static String get addSigningOrder => 'addSigningOrder'.tr();
  static String get addSigningOrderDescription => 'addSigningOrderDescription'.tr();
  static String get emailSubject => 'emailSubject'.tr();
  static String get addEmailSubject => 'addEmailSubject'.tr();
  static String get emailMessage => 'emailMessage'.tr();
  static String get noDataFound => 'noDataFound'.tr();
  static String get tryAdjustingFilters => 'tryAdjustingFilters'.tr();
  static String get refresh => 'refresh'.tr();
  static String get retry => 'retry'.tr();
  static String get noInternetConnection => 'noInternetConnection'.tr();
  static String get pleaseCheckYourConnectionAndTryAgain => 'pleaseCheckYourConnectionAndTryAgain'.tr();
  static String get somethingWentWrong => 'somethingWentWrong'.tr();
  static String get firstName => 'firstName'.tr();
  static String get enterFirstName => 'enterFirstName'.tr();
  static String get middleName => 'middleName'.tr();
  static String get lastName => 'lastName'.tr();
  static String get enterLastName => 'enterLastName'.tr();
  static String get userName => 'userName'.tr();
  static String get enterUserName => 'enterUserName'.tr();
  static String get userNameAlreadyExists => 'userNameAlreadyExists'.tr();
  static String get email => 'email'.tr();
  static String get dateOfBirth => 'dateOfBirth'.tr();
  static String get optional => 'optional'.tr();
  static String get gender => 'gender'.tr();
  static String get selectGender => 'selectGender'.tr();
  static String get spokenLanguage => 'spokenLanguage'.tr();
  static String get selectSpokenLanguage => 'selectSpokenLanguage'.tr();
  static String get phoneNumber => 'phoneNumber'.tr();
  static String get enterPhoneNumber => 'enterPhoneNumber'.tr();
  static String get enterEmail => 'enterEmail'.tr();
  static String get uploadPhoto => 'uploadPhoto'.tr();
  static String get remove => 'remove'.tr();
  static String get selectAll => 'selectAll'.tr();
  static String get downloadDocument => 'downloadDocument'.tr();
  static String get selectFilesOfDownloadDocument => 'selectFilesOfDownloadDocument'.tr();
  static String get viewDocument => 'viewDocument'.tr();
  static String get selectFilesViewDocument => 'selectFilesViewDocument'.tr();
  static String get logoutFromAllDevices => 'logoutFromAllDevices'.tr();
  static String get emptyStamp => 'emptyStamp'.tr();
  static String get setAsDefault => 'setAsDefault'.tr();
  static String get passwordProtectedFile => "passwordProtectedFile".tr();
  static String get viewed => "viewed".tr();
  static String get createdAndSigned => "createdAndSigned".tr();
  static String get stamp => "stamp".tr();
  static String get hintTemplateName => 'hintTemplateName'.tr();
  static String get recipient => 'recipient'.tr();
  static String get saveAndClose => 'saveAndClose'.tr();
}
