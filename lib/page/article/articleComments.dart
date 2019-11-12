import 'package:app/dao/comment.dart';
import 'package:app/module/comment.dart';
import 'package:app/page/comment.dart';
import 'package:app/util/util.dart';
import 'package:app/widget/commentList.dart';
import 'package:app/widget/commonBackbar.dart';
import 'package:app/widget/icon.dart';
import 'package:app/widget/page_wrap.dart';
import 'package:flutter/material.dart';

class ArticleCommentPage extends StatefulWidget {

  final int id;

  ArticleCommentPage({
    this.id
  });

  @override
  _ArticleCommentPageState createState() => _ArticleCommentPageState();
}

class _ArticleCommentPageState extends State<ArticleCommentPage> {

  int page = 1;
  int total = 0;
  List<CommentItemModule> comments = [];

  getdata([bool reload = false]) {
    CommentDao.fetchByArticle(widget.id, page).then((res) {
      if (reload) {
        setState(() {
          total = res.total;
          comments = res.list;
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

  void getMore() {
    page = page + 1;

    getdata();
  }

  Future<Null> refresh() {
    page = 1;

    getdata(true);

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      header: CommonBackBar(extra: '评论($total)'),
      body: CommentList(
        data: comments,
        total: total,
        onRefresh: refresh,
        getMore: getMore,
      ),
      button: FloatingActionButton(
        onPressed: () async {
          final res = await routerGo(context, CommentPage(
            type: 1,
            host: widget.id
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