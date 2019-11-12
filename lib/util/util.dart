import 'package:app/dao/system.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

Future routerGo(BuildContext context, Widget router) async {
  return await Navigator.push(context, MaterialPageRoute(
    builder: (context) => router
  ));
}

void saveInfo(String username, String email) async {
  // SharedPreferences.setMockInitialValues({});
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _userinfo = '$username&$email';
  await prefs.setString('userinfo', _userinfo);
}

void removeInfo() async {
  // SharedPreferences.setMockInitialValues({});
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.remove('userinfo');
}

Future<dynamic> getInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var userinfo = prefs.getString('userinfo');

  if (userinfo != null) {
    List<String> _info = prefs.getString('userinfo').split('&');

    return {
      'username': _info[0],
      'email': _info[1]
    };
  } 

  return null;
}

void saveUpdateTime() async {
  // SharedPreferences.setMockInitialValues({});

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String cancelTime = DateTime.now().toString();
  await prefs.setString('updateTime', cancelTime);
}

void removeUpdateTime() async {
  // SharedPreferences.setMockInitialValues({});
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.remove('updateTime');
}
 
Future<dynamic> getTime() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String time = prefs.getString('updateTime');

  if (time != null) {
    return DateTime.parse(time);
  }

  return null;
}

void updateApp(BuildContext context, [bool showToast = false]) async {
  final res = await SystemDao.getaAppInfo();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;

  if(res.version != version) {

    List<Widget> records = [];
    records.add(Text('更新记录：', style: TextStyle(fontWeight: FontWeight.w500)));
    records.add(SizedBox(height: 6.0));
    int i = 1;
    res.details.forEach((d) {
      records.add(Text('${i}、$d'));
      i++;
    });

    showDialog(
      context: context,
      builder: (context) { 
        return new AlertDialog( 
          title: new Text("有新版本 v${res.version}"), 
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: records,
            mainAxisSize: MainAxisSize.min
          ),
          actions: <Widget>[ 
            FlatButton(onPressed: () {
              downloadApp(context, res.version);
              removeUpdateTime();
              Navigator.of(context).pop();
            },
            child: Text("去更新")),
            FlatButton(onPressed: () {
              saveUpdateTime();
              Navigator.of(context).pop(); 
            },
            child: Text("下次再说"))
          ]
        );
      }
    );
  } else if (showToast) {
    Toast.show('当前是最新版本', context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }
}

void downloadApp(BuildContext context, String version) async {
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    print('ios app update');
  } else {
    String url = 'http://www.lsshuai.com/app/v$version/app-release.apk';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
