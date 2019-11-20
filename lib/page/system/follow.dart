import 'package:webapp/dao/system.dart';
import 'package:webapp/widget/commonBackbar.dart';
import 'package:webapp/widget/editBottom.dart';
import 'package:webapp/widget/infoNotice.dart';
import 'package:webapp/widget/input.dart';
import 'package:webapp/widget/page_wrap.dart';
import 'package:flutter_web/material.dart';
// import 'package:toast/toast.dart';

class FollowPage extends StatelessWidget {

  BoxDecoration commonEditWrapStyle = BoxDecoration(
    border: Border.all(width: 2.0, color: Color(0xffeeeeee)),
    borderRadius: BorderRadius.circular(6.0),
    color: Colors.white
  );

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void clearInfo() {
    nameController.text = '';
    emailController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      header: CommonBackBar(extra: '返回'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(children: <Widget>[
              Input(
                hintText: '昵称',
                controller: nameController
              ),
              Input(
                hintText: '邮箱',
                controller: emailController
              ),
              InfoNotice(text: '订阅成功后有文章更新时会以邮件形式通知，邮箱不会对外公布。')
            ]),
          ),
          EditBottom( 
            cancelText: '重置信息',
            okText: '订阅',
            submit: () {
              String username = nameController.text;
              String email = emailController.text;

              SystemDao.follow(username, email).then((res) {
                if (res.code == 200) {
                  // Toast.show('关注成功', context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                  clearInfo();
                  Navigator.pop(context);
                } else {
                  // Toast.show(res.msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
                }
              });
            },
            clear: clearInfo
          )
        ]
      )
    );
  }
}