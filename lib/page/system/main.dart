import 'package:app/page/system/about.dart';
import 'package:app/page/system/follow.dart';
import 'package:app/util/util.dart';
import 'package:app/widget/avatar.dart';
import 'package:app/widget/icon.dart';
import 'package:app/widget/logo.dart';
import 'package:app/widget/page_wrap.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class SystemPage extends StatefulWidget {
  @override
  _SystemPageState createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> {

  String version = '1.0.0';

  Future<Null> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });

    return null;
  }

  @override
  void initState() { 
    super.initState();
    getVersion();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Logo(size: 80.0)
        ]
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          SystemItem(
            base: Avatar(url: 'http://www.lsshuai.com/static/images/avatar.jpg'),
            haveLine: false,
            extra: '关于',
            router: AboutPage()
          ),
          SizedBox(height: 6.0),
          SystemItem(
            base: Text('订阅我'),
            router: FollowPage()
          ),
          SystemItem(
            base: Text('版本信息'),
            haveLine: false,
            extra: 'v$version',
            action: () async {
              updateApp(context, true);
            }
          )
        ]
      )
    );
  }
}

class SystemItem extends StatefulWidget {
  final Widget base;
  final bool haveLine;
  final String extra;
  final Widget router;
  final void Function () action;

  SystemItem({
    @required this.base,
    this.haveLine = true,
    this.extra,
    this.router,
    this.action
  });

  @override
  _SystemItemState createState() => _SystemItemState();
}

class _SystemItemState extends State<SystemItem> {
  bool isActive = false;

  Widget renderLeft() {
    List<Widget> list = [];

    if (widget.extra != null) {
      list.add(Text(widget.extra, style: TextStyle(color: Colors.grey)));
      list.add(SizedBox(width: 8.0));
    }

    list.add(IconB(code: 0xe65a));

    return Row(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.router != null) {
          routerGo(context, widget.router);
        } else if (widget.action != null) {
          widget.action();
        }
      },
      onTapDown: (d) {
        setState(() {
          isActive = true;
        });
      },
      onTapUp: (d) {
        setState(() {
          isActive = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? Color(0xffeeeeee) : Colors.white,
          border: widget.haveLine ? 
            Border(bottom: BorderSide(width: 1.0, color: Color(0xffeeeeee)))
              : Border(bottom: BorderSide(width: 0.0, color: Colors.transparent))
        ),
        padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            widget.base,
            renderLeft()
          ]
        )
      )
    );
  }
}
