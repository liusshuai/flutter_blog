import 'package:app/dao/comment.dart';
import 'package:app/module/comment.dart';
import 'package:app/page/comment.dart';
import 'package:app/util/util.dart';
import 'package:app/widget/commentList.dart';
import 'package:app/widget/icon.dart';
import 'package:app/widget/loading.dart';
import 'package:app/widget/page_wrap.dart';
import 'package:flutter/material.dart';

class BoardPage extends StatefulWidget {
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {

  int page = 1;
  int total = 0;
  List<CommentItemModule> comments = [];
  bool loading = true;

  getdata([bool reload = false]) {
    CommentDao.fetchBoards(page).then((res) {
      if (reload) {
        setState(() {
          total = res.total;
          comments = res.list;
          loading = false;
        });
      } else {
        setState(() {
          total = res.total;
          comments.addAll(res.list);
        });
      }
    });
  }

  @override
  void initState() { 
    super.initState();
    getdata(true);
  }

  Future<Null> refresh() async {
    page = 1;
    getdata(true);

    return null;
  }

  void getMore() {
    page = page + 1;

    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      header: Row(children: <Widget>[
        Text('留言板($total)', style: TextStyle(fontSize: 20.0))
      ]),
      body: LoadingContainer(isLoading: loading,
        child: CommentList(
          data: comments,
          total: total,
          onRefresh: refresh,
          getMore: getMore,
          isBorad: true
        )
      ),
      button: FloatingActionButton(
        onPressed: () async {
          final res = await routerGo(context, CommentPage(
            type: 3,
            host: 0
          ));

          if (res != null && res) {
            refresh();
          }
        },
        backgroundColor: Colors.black,
        tooltip: '新增留言',
        child: IconB(code: 0xe8cb, color: Colors.white, size: 22.0)
      ) 
    );
  }
}