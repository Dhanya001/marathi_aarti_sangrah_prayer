import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:infocontract/core/di/locator.dart';
import 'package:infocontract/core/services/shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationsService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final SharedPref sharedPref = locator<SharedPref>();
  static String _lastMessageIdForNotification = '';
  static const String _lastMessageIdForNavigation = '';

  NotificationsService._();

  static Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // Unique ID for Android devices
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor; // Unique ID for iOS devices
    }
    return null;
  }

  static String? deviceToken;
  static String? deviceId;

  static Future<void> _initDeviceIdAndToken() async {
    deviceId = await _getId();
    deviceId ??= 'unknown_device';
    print("device id ; ${deviceId}");
    sharedPref.setDeviceId(deviceId!);

    deviceToken = await _firebaseMessaging.getToken();
    print("fcm token firebase  by get Token method; ${deviceToken}");
    deviceToken ??= 'unknown_token';
    _onTokenRefresh(deviceToken);
  }

  static Future<void> _configureForegroundMessageHandler() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> _configureFirebaseMessageStream() async {
    _firebaseMessaging.onTokenRefresh.listen(_onTokenRefresh);
    _firebaseMessaging.getInitialMessage().then(_onInitialMessage);
    FirebaseMessaging.onMessage.listen(onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenedAppHandler);
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessageHandler);
    await _initDeviceIdAndToken();
  }

  static Future<void> _onInitialMessage(RemoteMessage? message) async {
    if (message != null) {
      navigationHandler(message);
    }
  }

  static void _onTokenRefresh(String? token) async {
    if (token == null) return;

    deviceToken = token;
    sharedPref.setDeviceToken(token);

    print('FCM token refreshed & sent: $token');
  }
  // static void _onTokenRefresh(String? token) {
  //   deviceToken = token;
  //   sharedPref.setDeviceToken(deviceToken!);
  //   print('Device token refreshed: $deviceToken');
  // }

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> _configureFlutterLocalNotifications() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
          defaultPresentAlert: true,
          defaultPresentBadge: true,
          defaultPresentSound: true,
        );
    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );
    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      "default_channel",
      "Default",
      description: "InfoProfileDescription",
      importance: Importance.max,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  static void onDidReceiveNotificationResponse(NotificationResponse message) {
    navigationHandler(RemoteMessage(data: jsonDecode(message.payload!)));
  }

  static void onDidReceiveBackgroundNotificationResponse(
    NotificationResponse message,
  ) {
    navigationHandler(RemoteMessage(data: jsonDecode(message.payload!)));
  }

  static Future<void> onMessageOpenedAppHandler(RemoteMessage message) async {
    return navigationHandler(message);
  }

  static Future<void> onMessageHandler(RemoteMessage message) async {
    return showNotificationCustomSound(message);
  }

  @pragma('vm:entry-point')
  static Future<void> onBackgroundMessageHandler(RemoteMessage message) async {
    return showNotificationCustomSound(message);
  }

  static Future<void> showNotificationCustomSound(RemoteMessage message) async {
    if (_lastMessageIdForNotification.isNotEmpty &&
        _lastMessageIdForNotification == message.messageId) {
      return;
    }
    _lastMessageIdForNotification = message.messageId ?? '';
    // get Title and Body correctly first
    final String title = message.notification?.title ?? message.data['title'] ?? 'No Title';
    final String body = message.notification?.body ?? message.data['body'] ?? 'No Message';
    AndroidBitmap<Object>? androidBitmap;
    //  Initialize BigTextStyle with the extracted body
    final BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body, 
      htmlFormatBigText: true,
      contentTitle: title, 
      htmlFormatContentTitle: true,
      summaryText: 'New Notification', 
      htmlFormatSummaryText: true,
    );
    DarwinNotificationDetails iOSChannelSpecifics =
        const DarwinNotificationDetails(
          presentSound: true,
          presentAlert: true,
          presentBadge: true,
          /* attachments: <DarwinNotificationAttachment>[
        DarwinNotificationAttachment(" bigPicturePath!,")
      ], */
        );

    // if (Platform.isAndroid &&
    //     message.data['image'] != null &&
    //     message.data['image'].isNotEmpty) {
    //   var bodyBytes = await Helpers.getImageBytes(message.data['image']);
    //   androidBitmap = ByteArrayAndroidBitmap.fromBase64String(
    //     base64.encode(bodyBytes),
    //   );
    // } else if (Platform.isAndroid &&
    //     message.notification?.android?.imageUrl != null &&
    //     (message.notification?.android?.imageUrl?.isNotEmpty != null)) {
    //   message.data['image'] = message.notification?.android?.imageUrl;
    //   var bodyBytes = await Helpers.getImageBytes(message.data['image']);
    //   androidBitmap = ByteArrayAndroidBitmap.fromBase64String(
    //     base64.encode(bodyBytes),
    //   );
    // }

    
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          "default_channel",
          "Default",
          autoCancel: true,
          playSound: true,
          enableVibration: true,
          importance: Importance.max,
          priority: Priority.high,
          enableLights: true,
          styleInformation: bigTextStyleInformation ,
          largeIcon: message.data['image'] != null ? androidBitmap : null,
          showWhen: true,
          vibrationPattern: Int64List.fromList([0, 1000, 5000, 2000]),
        );
    if (Platform.isIOS && message.data['image'] != null) {
      // final String bigPicturePath = await Helpers.downloadAndSaveFile(
      //   message.data['image'],
      //   'bigPicture.jpg',
      // );
      // iOSChannelSpecifics = DarwinNotificationDetails(
      //   presentSound: true,
      //   presentAlert: true,
      //   presentBadge: true,
      //   attachments: <DarwinNotificationAttachment>[
      //     DarwinNotificationAttachment(bigPicturePath),
      //   ],
      // );
    }

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSChannelSpecifics,
    );
    if (message.notification?.title != null) {
      await flutterLocalNotificationsPlugin.show(
        id: 0,
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        notificationDetails: platformChannelSpecifics,
        payload: json.encode(message.data),
      );
    }
  }

  static Future<NotificationSettings> requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    return settings;
  }

  static Future<void> navigationHandler(RemoteMessage message) async {
    if (_lastMessageIdForNavigation.isNotEmpty &&
        _lastMessageIdForNavigation == message.messageId) {
      return;
    }
  }

  static Future<void> init({bool shouldRequestPermission = false}) async {
    try {
      final notificationGranted = await Permission.notification.request();
      if (!notificationGranted.isGranted) {}
      await _initDeviceIdAndToken();
      print(" FCM TOKEN FOR BACKEND: $deviceToken");

      final settings = await requestPermission();
      switch (settings.authorizationStatus) {
        case AuthorizationStatus.authorized:
          await _configureForegroundMessageHandler();
          await _configureFirebaseMessageStream();
          await _configureFlutterLocalNotifications();
      
          print("✅ Subscribed to topics: All, All_User");
       
          break;
        case AuthorizationStatus.provisional:
          // await _initDeviceIdAndToken();
          break;
        case AuthorizationStatus.denied:
        case AuthorizationStatus.notDetermined:
      
          return;
      }
    } catch (e) {

      return;
    }
  }
}
