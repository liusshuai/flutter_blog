import 'package:app/page/article/articleDetail.dart';
import 'package:app/page/source/source.dart';
import 'package:app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:app/navigator/navigator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jpush/flutter_jpush.dart';
import 'dart:io';

void main() {
  runApp(MyApp());

  if (Platform.isAndroid) { //安卓机上设置顶部状态栏背景为透明
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,  //设置为透明
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LSSHUAI',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: Main()
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  void initJPush() async {
    await FlutterJPush.startup();
    print('极光推送初始化完成');

    var regId = await FlutterJPush.getRegistrationID();
    print('设备号 $regId');

    initNotification();
  }

  void initNotification() async {
    FlutterJPush.addReceiveNotificationListener((JPushNotification notification) {
      print('收到消息推送 $notification');
    });

    FlutterJPush.addReceiveOpenNotificationListener((JPushNotification notification) {
      if (notification.extras != null) {
        if (notification.extras.type == 'article') {
          routerGo(context, ArticleDetailPage(
            id: notification.extras.key,
            title:notification.extras.title,
            comment: 0
          ));
        } else if (notification.extras.type == 'source') {
          routerGo(context, SourcePage());
        }
      }
    });
  }

  showUpdateInfo() async {
    final time = await getTime();
    if (time != null) {
      DateTime now = DateTime.now();
      if(time.add(Duration(days: 1)).compareTo(now) >= 0) {
        updateApp(context);
      }
    } else {
      updateApp(context);
    }
  }

  @override
  void initState() { 
    super.initState();
    showUpdateInfo();
    initJPush();
  }

  @override
  Widget build(BuildContext context) {
    return Base();
  }
}