import 'package:webapp/widget/commonBackbar.dart';
import 'package:webapp/widget/page_wrap.dart';
import 'package:flutter_web/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  bool pageLoading = true;

  List<Widget> renderContent() {
    List<Widget> list = [];

    // list.add(WebView(
    //   initialUrl: 'http://www.lsshuai.com/h5/about',
    //   javascriptMode: JavascriptMode.unrestricted,
    //   onPageFinished: (String value) {
    //     setState(() {
    //       pageLoading = false;
    //     });
    //   }
    // ));

    if (pageLoading) {
      list.add(Center(
        child: CircularProgressIndicator()
      ));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      header: CommonBackBar(extra: '返回'),
      body: Stack(children: renderContent())
    );
  }
}
