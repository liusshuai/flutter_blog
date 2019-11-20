import 'package:webapp/page/article/articleComments.dart';
import 'package:webapp/util/util.dart';
import 'package:webapp/widget/icon.dart';
import 'package:webapp/widget/page_wrap.dart';
import 'package:flutter_web/material.dart';

class ArticleDetailPage extends StatefulWidget {

  final int id;
  final String title;
  final int comment;

  ArticleDetailPage({
    this.id,
    this.title,
    this.comment
  });

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {

  bool loading = true;

  List<Widget> renderContent() {
    List<Widget> list = [];

    list.add(Center(child: Text(
      '${widget.title} 详情'
    )));

    if (loading) {
      list.add(Center(
        child: CircularProgressIndicator()
      ));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: IconB(code: 0xe659, size: 26.0, color: Colors.black)
          ),
          Expanded(
            child: Text(widget.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500
            ))
          ),
          GestureDetector(
            onTap: () {
              routerGo(context, ArticleCommentPage(id: widget.id));
            },
            child: Row(children: <Widget>[
              IconB(code: 0xe635, color: Colors.black, size: 24.0),
              SizedBox(width: 4.0),
              Text('${widget.comment}')
            ])
          )
        ]
      ),
      body: Stack(children: renderContent())
    );
  }
}
