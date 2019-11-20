import 'package:webapp/module/comment.dart';
import 'package:webapp/page/comment.dart';
import 'package:webapp/util/util.dart';
// import 'package:webapp/page/comment.dart';
import 'package:webapp/widget/empty.dart';
import 'package:webapp/widget/icon.dart';
import 'package:webapp/widget/load_more.dart';
import 'package:flutter_web/material.dart';

class CommentList extends StatefulWidget {

  final List<CommentItemModule> data;
  final int total;
  final void Function() getMore;
  final Future<Null> Function() onRefresh;
  final bool isBorad;

  CommentList({
    this.data,
    this.total,
    this.getMore,
    this.onRefresh,
    this.isBorad = false
  });

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() { 
    super.initState();
    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (widget.total == widget.data.length) return;
        if (widget.getMore != null) {
          widget.getMore();
        }
      }
    });
  }

  _renderListItem(int index) {
    if (index == widget.data.length) {
      return LoadMore(widget.total != widget.data.length);
    }
    return CommentItem(
      comment: widget.data[index],
      floor: widget.total - index,
      refresh: widget.onRefresh,
      isBoard: widget.isBorad
    );
  }

  Future<Null> handleRefresh() async {
    if (widget.onRefresh != null) {
      widget.onRefresh();
    } else {
      return null;
    }
  }

  Widget renderMain() {
    if (widget.data.length > 0) {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: RefreshIndicator(
          onRefresh: handleRefresh,
          child: ListView.builder(
            itemCount: widget.data.length + 1,
            itemBuilder: (BuildContext context, int index) {
              return _renderListItem(index);
            },
            controller: _scrollController
          )
        )
      );
    }

    return Empty(text: '暂无评论');
  }

  @override
  Widget build(BuildContext context) {
    return renderMain();
  }
}

class CommentItem extends StatelessWidget {

  final CommentItemModule comment;
  final int floor;
  final Future<Null> Function() refresh;
  final bool isBoard;

  CommentItem({
    this.comment,
    this.floor,
    this.refresh,
    this.isBoard = false
  });

  List<Widget> renderContent(BuildContext context) {
    List<Widget> list = [];

    double fontSize = isBoard ? 16.0 : 15.0;

    list.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(children: <Widget>[
          Text(comment.username, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500)),
          SizedBox(width: 6.0),
          Text(comment.pubtime, style: TextStyle(fontSize: 14.0, color: Color(0xffaaaaaa)))
        ]),
        Row(children: <Widget>[
          Text('$floor 楼', style: TextStyle(fontSize: fontSize, color: Color(0xffaaaaaa))),
          SizedBox(width: 10.0),
          PopupMenuButton(
            padding: EdgeInsets.all(0.0),
            child: IconB(code: 0xe61c, size: 26.0),
            onSelected: (value) async {
              if (value == 'quto') {
                final res = await routerGo(context, CommentPage(
                  type: comment.type,
                  host: comment.host,
                  comment: comment
                ));

                if (res != null && res && refresh != null) {
                  refresh();
                }
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem> [
              PopupMenuItem(
                value: 'quto',
                child: Text('引用')
              )
            ]
          )
        ])
      ]
    ));

    list.add(SizedBox(height: 4.0));

    if (comment.replycontent != null
      && comment.replyname != null
      && comment.replyemail != null) {
        list.add(Container(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
          decoration: BoxDecoration(
            border: Border(left: BorderSide(width: 3.0, color: Color(0xffeeeeee))),
            color: Color(0xfff8f8f8)
          ),
          child: Container(
            padding: EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[Text('引用 ${comment.replyname} 的发言', style: TextStyle(fontWeight: FontWeight.w500))]),
                SizedBox(height: 4.0),
                Row(children: <Widget>[Text(comment.replycontent)])
              ]
            )
          )
        ));

      list.add(SizedBox(height: 6.0));
    }

    list.add(Text(comment.content, style: TextStyle(fontSize: 16.0)));

    return list;
  }

  @override
  Widget build(BuildContext context) {

    if (isBoard) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        margin: EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: renderContent(context)
        )
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1.0, color: Color(0xffeeeeee))),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: renderContent(context)
      )
    );
  }
}