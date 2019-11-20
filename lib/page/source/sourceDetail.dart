import 'package:webapp/dao/comment.dart';
import 'package:webapp/module/comment.dart';
import 'package:webapp/page/comment.dart';
import 'package:webapp/util/util.dart';
import 'package:webapp/widget/bottom_drawer.dart';
import 'package:webapp/widget/commentList.dart';
import 'package:webapp/widget/commonBackbar.dart';
import 'package:webapp/widget/icon.dart';
import 'package:webapp/widget/page_wrap.dart';
import 'package:flutter_web/material.dart';

class SourceDetailPage extends StatefulWidget {

  final int id;
  SourceDetailPage({
    this.id
  });

  @override
  _SourceDetailPageState createState() => _SourceDetailPageState();
}

class _SourceDetailPageState extends State<SourceDetailPage> {

  bool loading = true;
  int total = 0;
  int page = 1;
  List<CommentItemModule> comments = [];

  void getComments([bool refresh = false]) {
    CommentDao.fetchBySource(widget.id, page).then((res) {
      if (refresh) {
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

  Future<Null> refresh() {
    page = 1;
    getComments(true);

    return null;
  }

  void getMore() {
    page = page + 1;

    getComments();
  }

  @override
  void initState() { 
    super.initState();
    getComments();
  }

  List<Widget> renderContent() {
    List<Widget> list = [];

    // list.add(WebView(
    //   initialUrl: 'http://www.lsshuai.com/h5/movie/${widget.id}',
    //   javascriptMode: JavascriptMode.unrestricted,
    //   onPageFinished: (String value) {
    //     setState(() {
    //       loading = false;
    //     });
    //   }
    // ));

    if (loading) {
      list.add(Center(
        child: CircularProgressIndicator()
      ));
    }

    return list;
  }
   
  @override
  Widget build(BuildContext context) {

    double _height = (MediaQuery.of(context).size.height * 0.8);

    return PageWrap(
      header: CommonBackBar(extra: '返回', color: 'white'),
      body: BottomDragWidget(
        body:Stack(children: renderContent()),
        dragContainer: DragContainer(
          drawer: CommentDrawer(
            host: widget.id,
            total: total,
            comments: comments,
            refresh: refresh,
            getMore: getMore
          ),
          defaultShowHeight: 60.0,
          height: _height
        ),
      ),
      headerColor: 0xff24292c,
      colorValue: 0xff24292c
    );
  }
}

class CommentDrawer extends StatelessWidget {

  final int host; 
  final int total;
  final List<CommentItemModule> comments;
  final Future<Null> Function() refresh;
  final void Function () getMore;

  CommentDrawer({
    this.host,
    this.total = 0,
    this.comments,
    this.refresh,
    this.getMore
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(children: <Widget>[
        Container(
          height: 60.0,
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Color(0xfff3f4f8),
            border: Border.all(width: 1.0, color: Color(0xffeeeeee)),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0)
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  width: 40.0, height: 3.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(1.5)
                  )
                )
              ),
              SizedBox(height: 4.0),
              Row(children: <Widget>[
                Row(children: <Widget>[
                  IconB(code: 0xe635),
                  SizedBox(width: 4.0),
                  Text('$total')
                ]),
                SizedBox(width: 12.0),
                GestureDetector(
                  onTap: () async {
                    final res = await routerGo(context, CommentPage(
                      type: 4,
                      host: host
                    ));

                    if (res != null && res && refresh != null) {
                      refresh();
                    }
                  },
                  child: Row(children: <Widget>[
                    IconB(code: 0xe6ba, size: 16.0),
                    SizedBox(width: 4.0),
                    Text('写评论')
                  ]) 
                )
              ])
            ]
          )
        ),
        Flexible(
          child: Container(
            color: Colors.white,
            child: CommentList(
              data: comments,
              total: total,
              onRefresh: refresh,
              getMore: getMore
            )
          ) 
        )
      ])
    );
  }
}