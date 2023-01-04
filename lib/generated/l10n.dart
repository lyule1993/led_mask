// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `First Name`
  String get common_full_name {
    return Intl.message(
      'First Name',
      name: 'common_full_name',
      desc: '',
      args: [],
    );
  }

  /// `E-mail Address`
  String get common_email_address {
    return Intl.message(
      'E-mail Address',
      name: 'common_email_address',
      desc: '',
      args: [],
    );
  }

  /// `Please Check Network`
  String get common_please_check_network {
    return Intl.message(
      'Please Check Network',
      name: 'common_please_check_network',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get common_password {
    return Intl.message(
      'Password',
      name: 'common_password',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get common_sign_up {
    return Intl.message(
      'Sign Up',
      name: 'common_sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get common_take_photo {
    return Intl.message(
      'Take Photo',
      name: 'common_take_photo',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get common_skip {
    return Intl.message(
      'Skip',
      name: 'common_skip',
      desc: '',
      args: [],
    );
  }

  /// `Pause`
  String get common_pause {
    return Intl.message(
      'Pause',
      name: 'common_pause',
      desc: '',
      args: [],
    );
  }

  /// `Stop`
  String get common_stop {
    return Intl.message(
      'Stop',
      name: 'common_stop',
      desc: '',
      args: [],
    );
  }

  /// `Finished`
  String get common_finished {
    return Intl.message(
      'Finished',
      name: 'common_finished',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get common_continue {
    return Intl.message(
      'Continue',
      name: 'common_continue',
      desc: '',
      args: [],
    );
  }

  /// `Red`
  String get common_red {
    return Intl.message(
      'Red',
      name: 'common_red',
      desc: '',
      args: [],
    );
  }

  /// `Blue`
  String get common_blue {
    return Intl.message(
      'Blue',
      name: 'common_blue',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get common_other {
    return Intl.message(
      'Other',
      name: 'common_other',
      desc: '',
      args: [],
    );
  }

  /// `terms of use`
  String get common_term_of_use {
    return Intl.message(
      'terms of use',
      name: 'common_term_of_use',
      desc: '',
      args: [],
    );
  }

  /// `Loading ... `
  String get common_loading {
    return Intl.message(
      'Loading ... ',
      name: 'common_loading',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get common_success {
    return Intl.message(
      'Success',
      name: 'common_success',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get common_sign_in {
    return Intl.message(
      'Sign in',
      name: 'common_sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Min`
  String get common_min {
    return Intl.message(
      'Min',
      name: 'common_min',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get common_time {
    return Intl.message(
      'Time',
      name: 'common_time',
      desc: '',
      args: [],
    );
  }

  /// `FAQS`
  String get common_faqs1 {
    return Intl.message(
      'FAQS',
      name: 'common_faqs1',
      desc: '',
      args: [],
    );
  }

  /// `Light Beauty LED FAQs`
  String get common_faqs_desc1 {
    return Intl.message(
      'Light Beauty LED FAQs',
      name: 'common_faqs_desc1',
      desc: '',
      args: [],
    );
  }

  /// `FAQS`
  String get common_faqs2 {
    return Intl.message(
      'FAQS',
      name: 'common_faqs2',
      desc: '',
      args: [],
    );
  }

  /// `NewKey® ClearSkin  Facewear`
  String get common_faqs_desc2 {
    return Intl.message(
      'NewKey® ClearSkin  Facewear',
      name: 'common_faqs_desc2',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get common_terms_conditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'common_terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy & Agreement`
  String get common_terms_conditions_desc {
    return Intl.message(
      'Privacy Policy & Agreement',
      name: 'common_terms_conditions_desc',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get common_store {
    return Intl.message(
      'Store',
      name: 'common_store',
      desc: '',
      args: [],
    );
  }

  /// `Disconnect`
  String get common_disconnect {
    return Intl.message(
      'Disconnect',
      name: 'common_disconnect',
      desc: '',
      args: [],
    );
  }

  /// `Disconnect Success`
  String get common_disconnect_success {
    return Intl.message(
      'Disconnect Success',
      name: 'common_disconnect_success',
      desc: '',
      args: [],
    );
  }

  /// `Connect Success`
  String get common_connect_success {
    return Intl.message(
      'Connect Success',
      name: 'common_connect_success',
      desc: '',
      args: [],
    );
  }

  /// `Get Yours Now`
  String get common_store_desc {
    return Intl.message(
      'Get Yours Now',
      name: 'common_store_desc',
      desc: '',
      args: [],
    );
  }

  /// `Save it`
  String get common_save_it {
    return Intl.message(
      'Save it',
      name: 'common_save_it',
      desc: '',
      args: [],
    );
  }

  /// `Login...`
  String get common_automatic_login {
    return Intl.message(
      'Login...',
      name: 'common_automatic_login',
      desc: '',
      args: [],
    );
  }

  /// `Deleting User...`
  String get common_deleting_user {
    return Intl.message(
      'Deleting User...',
      name: 'common_deleting_user',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get common_deleting_account {
    return Intl.message(
      'Delete Account',
      name: 'common_deleting_account',
      desc: '',
      args: [],
    );
  }

  /// `This Will Erase Current User Data\nOther Users Data Will Not Affect`
  String get common_deleting_account_desc {
    return Intl.message(
      'This Will Erase Current User Data\nOther Users Data Will Not Affect',
      name: 'common_deleting_account_desc',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get common_confirm {
    return Intl.message(
      'Confirm',
      name: 'common_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get common_cancel {
    return Intl.message(
      'Cancel',
      name: 'common_cancel',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get common_user {
    return Intl.message(
      'User',
      name: 'common_user',
      desc: '',
      args: [],
    );
  }

  /// `LED Mask FAQs`
  String get account_therapy_faq {
    return Intl.message(
      'LED Mask FAQs',
      name: 'account_therapy_faq',
      desc: '',
      args: [],
    );
  }

  /// `Facewear FAQs`
  String get account_facewear_faq {
    return Intl.message(
      'Facewear FAQs',
      name: 'account_facewear_faq',
      desc: '',
      args: [],
    );
  }

  /// `Please type your information below`
  String get sign_up_please_type {
    return Intl.message(
      'Please type your information below',
      name: 'sign_up_please_type',
      desc: '',
      args: [],
    );
  }

  /// `You must agree with our`
  String get sign_up_you_must_agree {
    return Intl.message(
      'You must agree with our',
      name: 'sign_up_you_must_agree',
      desc: '',
      args: [],
    );
  }

  /// `Please Agree Terms of Use`
  String get sign_up_please_agree_terms_of_use {
    return Intl.message(
      'Please Agree Terms of Use',
      name: 'sign_up_please_agree_terms_of_use',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter a Vaild Email`
  String get sign_up_please_enter_a_vaild_email {
    return Intl.message(
      'Please Enter a Vaild Email',
      name: 'sign_up_please_enter_a_vaild_email',
      desc: '',
      args: [],
    );
  }

  /// `The Password Should At Lease 6 Digits`
  String get sign_up_the_password_should_more_than_6_digits {
    return Intl.message(
      'The Password Should At Lease 6 Digits',
      name: 'sign_up_the_password_should_more_than_6_digits',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Full Name`
  String get sign_up_please_enter_full_name {
    return Intl.message(
      'Please Enter Full Name',
      name: 'sign_up_please_enter_full_name',
      desc: '',
      args: [],
    );
  }

  /// `Check your email`
  String get sign_up_check_your_email {
    return Intl.message(
      'Check your email',
      name: 'sign_up_check_your_email',
      desc: '',
      args: [],
    );
  }

  /// `To confirm your email address, tap the button in the email we send to you`
  String get sign_up_to_confirm_your_email_address {
    return Intl.message(
      'To confirm your email address, tap the button in the email we send to you',
      name: 'sign_up_to_confirm_your_email_address',
      desc: '',
      args: [],
    );
  }

  /// `Already had an account?`
  String get sign_up_already_had_an_account {
    return Intl.message(
      'Already had an account?',
      name: 'sign_up_already_had_an_account',
      desc: '',
      args: [],
    );
  }

  /// `To Create an Account?`
  String get sign_up_to_create_an_account {
    return Intl.message(
      'To Create an Account?',
      name: 'sign_up_to_create_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Welcome, {name}`
  String home_welcome_name(Object name) {
    return Intl.message(
      'Welcome, $name',
      name: 'home_welcome_name',
      desc: '',
      args: [name],
    );
  }

  /// `Here's our recommended plan for you`
  String get home_welcome_subtitle {
    return Intl.message(
      'Here\'s our recommended plan for you',
      name: 'home_welcome_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Start Program`
  String get home_start_treatment {
    return Intl.message(
      'Start Program',
      name: 'home_start_treatment',
      desc: '',
      args: [],
    );
  }

  /// `Go To Progress`
  String get home_go_to_progress {
    return Intl.message(
      'Go To Progress',
      name: 'home_go_to_progress',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get tab_home {
    return Intl.message(
      'Home',
      name: 'tab_home',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get tab_chat {
    return Intl.message(
      'Chat',
      name: 'tab_chat',
      desc: '',
      args: [],
    );
  }

  /// `Start Program`
  String get tab_start_treatment {
    return Intl.message(
      'Start Program',
      name: 'tab_start_treatment',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get tab_progress {
    return Intl.message(
      'Progress',
      name: 'tab_progress',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get tab_account {
    return Intl.message(
      'Account',
      name: 'tab_account',
      desc: '',
      args: [],
    );
  }

  /// `No Data`
  String get common_no_data_display {
    return Intl.message(
      'No Data',
      name: 'common_no_data_display',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get drawer_my_profile {
    return Intl.message(
      'My Profile',
      name: 'drawer_my_profile',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get drawer_settings {
    return Intl.message(
      'Settings',
      name: 'drawer_settings',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get drawer_store {
    return Intl.message(
      'Store',
      name: 'drawer_store',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get drawer_terms_conditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'drawer_terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get drawer_privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'drawer_privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `FAQ & Support`
  String get drawer_faq_support {
    return Intl.message(
      'FAQ & Support',
      name: 'drawer_faq_support',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get drawer_log_out {
    return Intl.message(
      'Log out',
      name: 'drawer_log_out',
      desc: '',
      args: [],
    );
  }

  /// `No Device Detected`
  String get no_device_detected {
    return Intl.message(
      'No Device Detected',
      name: 'no_device_detected',
      desc: '',
      args: [],
    );
  }

  /// `To Start your Program, please link your device`
  String get to_start_your_treatment {
    return Intl.message(
      'To Start your Program, please link your device',
      name: 'to_start_your_treatment',
      desc: '',
      args: [],
    );
  }

  /// `Search & Connect`
  String get search_connect {
    return Intl.message(
      'Search & Connect',
      name: 'search_connect',
      desc: '',
      args: [],
    );
  }

  /// `Please Turn On Bluetooth`
  String get please_turn_on_bluetooth {
    return Intl.message(
      'Please Turn On Bluetooth',
      name: 'please_turn_on_bluetooth',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have a device?`
  String get dont_have_a_device {
    return Intl.message(
      'Don’t have a device?',
      name: 'dont_have_a_device',
      desc: '',
      args: [],
    );
  }

  /// `Get yours now`
  String get get_yours_now {
    return Intl.message(
      'Get yours now',
      name: 'get_yours_now',
      desc: '',
      args: [],
    );
  }

  /// `Searching`
  String get treatment_searching {
    return Intl.message(
      'Searching',
      name: 'treatment_searching',
      desc: '',
      args: [],
    );
  }

  /// `Device Detected`
  String get treatment_device_detected {
    return Intl.message(
      'Device Detected',
      name: 'treatment_device_detected',
      desc: '',
      args: [],
    );
  }

  /// `Connecting, please wait a moment`
  String get treatment_connecting_please_wait_a_moment {
    return Intl.message(
      'Connecting, please wait a moment',
      name: 'treatment_connecting_please_wait_a_moment',
      desc: '',
      args: [],
    );
  }

  /// `Need Assistance?`
  String get treatment_need_assistance {
    return Intl.message(
      'Need Assistance?',
      name: 'treatment_need_assistance',
      desc: '',
      args: [],
    );
  }

  /// `Select your Program`
  String get treatment_select_your_treatment {
    return Intl.message(
      'Select your Program',
      name: 'treatment_select_your_treatment',
      desc: '',
      args: [],
    );
  }

  /// `Anti-Aging`
  String get treatment_anti_aging {
    return Intl.message(
      'Anti-Aging',
      name: 'treatment_anti_aging',
      desc: '',
      args: [],
    );
  }

  /// `Anti-Acne`
  String get treatment_anti_acne {
    return Intl.message(
      'Anti-Acne',
      name: 'treatment_anti_acne',
      desc: '',
      args: [],
    );
  }

  /// `Daily Care`
  String get treatment_daily_care {
    return Intl.message(
      'Daily Care',
      name: 'treatment_daily_care',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get treatment_select_time {
    return Intl.message(
      'Time',
      name: 'treatment_select_time',
      desc: '',
      args: [],
    );
  }

  /// `Remain Time`
  String get treatment_remain_time {
    return Intl.message(
      'Remain Time',
      name: 'treatment_remain_time',
      desc: '',
      args: [],
    );
  }

  /// `Start Program`
  String get treatment_start_treatment {
    return Intl.message(
      'Start Program',
      name: 'treatment_start_treatment',
      desc: '',
      args: [],
    );
  }

  /// `Skin care Beauty Mask`
  String get treatment_skin_care_beauty_mask {
    return Intl.message(
      'Skin care Beauty Mask',
      name: 'treatment_skin_care_beauty_mask',
      desc: '',
      args: [],
    );
  }

  /// `SN: {num}`
  String treatment_sn(Object num) {
    return Intl.message(
      'SN: $num',
      name: 'treatment_sn',
      desc: '',
      args: [num],
    );
  }

  /// `Record your progress by taking a selfie`
  String get treatment_record_your_progress {
    return Intl.message(
      'Record your progress by taking a selfie',
      name: 'treatment_record_your_progress',
      desc: '',
      args: [],
    );
  }

  /// `Total Sessions`
  String get progress_total_sessions {
    return Intl.message(
      'Total Sessions',
      name: 'progress_total_sessions',
      desc: '',
      args: [],
    );
  }

  /// `Average Time`
  String get progress_average_time {
    return Intl.message(
      'Average Time',
      name: 'progress_average_time',
      desc: '',
      args: [],
    );
  }

  /// `This Week`
  String get progress_this_week {
    return Intl.message(
      'This Week',
      name: 'progress_this_week',
      desc: '',
      args: [],
    );
  }

  /// `View all`
  String get progress_view_all {
    return Intl.message(
      'View all',
      name: 'progress_view_all',
      desc: '',
      args: [],
    );
  }

  /// `Take Today's Photo`
  String get progress_take_today_photo {
    return Intl.message(
      'Take Today\'s Photo',
      name: 'progress_take_today_photo',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
