import 'package:webapp/dao/article.dart';
import 'package:webapp/module/article.dart';
import 'package:webapp/widget/articleBox.dart';
import 'package:webapp/widget/empty.dart';
import 'package:webapp/widget/load_more.dart';
import 'package:webapp/widget/loading.dart';
import 'package:webapp/widget/page_wrap.dart';
import 'package:webapp/widget/searchBar.dart';
import 'package:flutter_web/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int page = 1;
  bool loading = false;
  List<ArticleItemModule> articles = [];
  int total = 0;
  bool didSearch = false;
  String key = '';

  ScrollController _scrollController = new ScrollController();

  void search(String key) {
    ArticleDao.fetchByKeyword(page, key).then((res) {
      setState(() {
        loading = false;
        total = res.total;
        articles = res.list;
        didSearch = true;
      });
    });
  }

  @override
  void initState() { 
    super.initState();
    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (total == articles.length) return;
        page = page + 1;
       search(key);
      }
    });
  }

  Widget renderItem(int index) {
    if (index == 0) {
      return Container(
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
        child: Text('共搜索出 $total 篇文章')
      ); 
    }

    if (index == articles.length + 1) {
      return LoadMore(total != articles.length);
    }

    return ArticleBox(article: articles[index - 1]);
  }

  Widget renderContent() {
    if (didSearch) {
      if (articles.length > 0) {
        return MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
            itemCount: articles.length + 2,
            itemBuilder: (BuildContext context, int index) {
              return renderItem(index);
            },
            controller: _scrollController
          ),
        );
      } else {
        return Empty(text: '没有搜到相关文章，换个关键词试试吧~');
      }
    } 
    return Center(
      child: Text('文章搜索')
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      header: Row(children: <Widget>[
        Expanded(
          child: SearchBar(placeholder: '搜索文章', search: (v) {
            if (v == '') {
              setState(() {
                didSearch = false;
              });
            } else {
              setState(() {
                loading = true;
              });
              key = v;
              search(v);
            }
          })
        ),
        SizedBox(width: 16.0),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text('取消', style: TextStyle(fontSize: 16.0))
        )
      ]),
      body: LoadingContainer(isLoading: loading,
        child: renderContent()
      )
    );
  }
}