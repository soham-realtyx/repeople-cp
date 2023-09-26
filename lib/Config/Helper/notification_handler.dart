
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repeoplecp/Config/Helper/notification_list_manager.dart';
import 'package:repeoplecp/Config/Helper/shared_prefrence.dart';
import 'package:repeoplecp/Config/Utils/constant.dart';
import 'package:repeoplecp/View/NotificationPage/notification_page.dart';

RxList<String> lst=RxList([]);
RxString exception="".obs;


class NotificationHandler {

  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel androidNotificationChannel = const AndroidNotificationChannel(
      'default', 'My repeople App NoticeBoard',
      description: "This is notification channel", importance: Importance.max);

  NotificationHandler() {
    createChannelOnDevice();
    requestPermission();
    // this._initNotification();
    // initNotification();
     _initNotification();
    //lst.clear();
    lst.add("notification handler call");
   print("notification handler call");
    // showActionButtonNotification();
  }

  NotificationHandler.instance();

  createChannelOnDevice()async{
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("---notification permission granted-----");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("----notification permission provisional----");
    } else {
      print("----notification permission denied----");
    }
  }

  onMessageOpenApp(RemoteMessage message)async {
    // showNotification("Second", message.notification!.body!, message.data);
    print(
        "-----------------------------------onMessageOpenApp--------------------------------------");
    print(message.data);
    getRemoveAnyParticularNotification(message.data['n_id'] ?? "");
    // ReadNotificationApiCall(notificationid: message.data['n_id'] ?? "");
    onNotificationClickListener(message.data,false);

  }

  onMessage(RemoteMessage message)async {

    print("-----------------------------------onMessage--------------------------------------");

    int count = await getNotificationCount();
    setNotificationCount(count + 1);
    // NotificationCountHandler(message.data['n_id'] ?? "");
    isBadgeShow.value=true;
    isBadgeShow.refresh();

    Map<String , dynamic> data = message.data;

    if (Platform.isIOS) {
      if (message.notification?.apple?.imageUrl != null &&
          message.notification?.apple?.imageUrl != "") {
        String? url = message.notification?.apple?.imageUrl!;
        showBigNotification(message.notification!, data, url!);
      } else {
        showNotification(message.notification!, data);
      }
    }
    else if (Platform.isAndroid) {
      lst.add("on message android");
      if (message.notification?.android?.imageUrl != null &&
          message.notification?.android?.imageUrl != "") {
        String? url = message.notification?.android?.imageUrl!;
        //showBigNotification_Awosome(message.notification!, data, url!);
        showBigNotification(message.notification!, data, url!);
      } else {
       // showNotification_Awosome(message.notification!, data);
        showNotification(message.notification!, data);
      }
    }

  }

  _initNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
    const AndroidInitializationSettings('app_icon');
    //IOSInitializationSettings iosInitializationSettings = const IOSInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,/* iOS: iosInitializationSettings*/);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
       onDidReceiveNotificationResponse: (details) {
           onSelectNotification: (String? playLoad) {
            Map<String, dynamic> data = jsonDecode(playLoad!);

            onNotificationClickListener(data,false);
         };
        },

    );

    messaging.requestPermission();

    await messaging.getToken(vapidKey: "").then((value) {
      //deviceID = value!;
      print('deviceId = $value');
    });

    messaging.onTokenRefresh.listen((event) {
      print('Token: $event');
    });
  }

  showNotification(RemoteNotification notification ,Map<String,dynamic> playload) async {

    AndroidNotificationDetails androidNotificationDetails =  const AndroidNotificationDetails(
        "default",
        "My Totality App NoticeBoard",
        importance: Importance.max,
        priority: Priority.high,
        icon: "app_icon",
    );

    //IOSNotificationDetails iosNotificationDetails = const IOSNotificationDetails();
    NotificationDetails notificationDetails =
    NotificationDetails(/*iOS: iosNotificationDetails,*/ android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(notification.hashCode, notification.title, notification.body, notificationDetails,
        payload: jsonEncode(playload),);
  }

  showBigNotification(RemoteNotification notification,Map<String,dynamic> playLoad,String url)async{

    ByteArrayAndroidBitmap  bigPicture = ByteArrayAndroidBitmap(await _getByteArrayFromUrl(url));
    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(bigPicture,contentTitle: notification.title,summaryText: notification.body);

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        "default",
        "My Totality App NoticeBoard",
        importance: Importance.max,
        priority: Priority.high,
        icon: "app_icon",
        styleInformation: bigPictureStyleInformation
    );

   // IOSNotificationDetails iosNotificationDetails = const IOSNotificationDetails();

    if (url != "") {
      final String bigPicturePath = await downloadFile(url);
      // iosNotificationDetails = IOSNotificationDetails(
      //     attachments: <IOSNotificationAttachment>[IOSNotificationAttachment(bigPicturePath)]);
    }

    NotificationDetails notificationDetails =
    NotificationDetails(/*iOS: iosNotificationDetails,*/ android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(notification.hashCode, notification.title, notification.body, notificationDetails,
        payload: jsonEncode(playLoad));

  }
  Future<Uint8List> _getByteArrayFromUrl(String url) async {

    dio.Options options = dio.Options(responseType: dio.ResponseType.bytes);
    dio.Dio d = dio.Dio();
    dio.Response response = await d.getUri(Uri.parse(url),options: options);
    return response.data;
  }

  Future<String> downloadFile(String printUrl) async {
    Dio dio = Dio();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final name = p.basename(printUrl);
    var response = await dio.download(printUrl, '$appDocPath/$name');
    if (response.statusCode == 200) {
      return '$appDocPath/$name';
    }
    return "";
  }
  onNotificationClickListener(Map<String, dynamic> data, [bool isFormNotification = false]) async {
    int count = await getNotificationCount();
    setNotificationCount(0);

    if (data.containsKey("flag") && data['flag'].toString().isNotEmpty) {
        // ClickHandler(data['flag'], 0,id: data.containsKey("id") ? data['id'] : "");
    }
      //}
      // pageNo = data['flag'];
     else {
      gotoNotificationPage();
    }
  }

  gotoNotificationPage()async{
    Get.to(const NotificationPage());
  }

}
