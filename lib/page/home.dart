import 'package:flutter_web/material.dart';
import 'package:webapp/dao/article.dart';
import 'package:webapp/dao/channel.dart';
import 'package:webapp/module/article.dart';
import 'package:webapp/module/channel.dart';
import 'package:webapp/page/search.dart';
import 'package:webapp/util/util.dart';
import 'package:webapp/widget/articleBox.dart';
import 'package:webapp/widget/empty.dart';
import 'package:webapp/widget/load_more.dart';
import 'package:webapp/widget/loading.dart';
import 'package:webapp/widget/page_wrap.dart';
import 'package:webapp/widget/icon.dart';
import 'package:webapp/widget/logo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _curGroup = '全部';
  int _curIndex = 0;
  List<ArticleItemModule> list = [];
  List<ChannelModel> channels = [];
  int total = 0;
  int articleTotal = 0;
  int page = 1;
  bool loading = true;

  ScrollController _scrollController = new ScrollController();

  getChannels() {
    ChannelDao.fetchChannels().then((res) {
      int articleCount = 0;
      res.forEach((c) {
        articleCount += c.articlecount;
      });
      setState(() {
        channels = res;
        articleTotal = articleCount;
      });
    });
  }

  getArticles([bool reload = false]) {
    ArticleDao.fetchByAuthor(page).then((res) {
      if (reload) {
        setState(() {
          list = res.list;
          total = res.total;
          loading = false;
        });
      } else {
        setState(() {
          list.addAll(res.list);
          total = res.total;
        });
      }
    });
  }

  @override
  void initState() { 
    super.initState();
    getChannels();
    getArticles(true);

    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (total == list.length) return;
        page = page + 1;
        getArticleByChannel();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  TextStyle _initTextStyle(Color color) {
    return TextStyle(
      fontSize: 15.0,
      color: color,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none
    );
  }

  Widget _selectItem(String title, int index, int total, [bool showLine = true]) {

    List<Widget> _list = [];

    _list.add(Text(title, style: _initTextStyle(Colors.black)));

    if (_curIndex == index) {
      _list.add(IconB(code: 0xe665, size: 28.0, color: Colors.black));
    } else {
      _list.add(Text('($total)', style: _initTextStyle(Colors.black)));
    }

    return GestureDetector(
      onTap: () {
        changeChannel(title, index);
        Navigator.pop(context);
      },
      child: Row(children: <Widget>[
        Expanded(child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
          decoration: BoxDecoration(
            border: showLine ? Border(bottom: BorderSide(width: 1.0, color: Color(0xffeeeeee)))
              : Border(bottom: BorderSide(width: 0.0))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _list
          )
        ))
      ])
    );
  }

  void changeChannel(String title, int index) {
    setState(() {
      _curGroup = title;
      _curIndex = index;
      loading = true;
    });
    page = 1;
    getArticleByChannel(true);
  }

  List _selectItemList() {
    List<Widget> _channels = [];

    for (var i = 0; i < channels.length; i++) {
      _channels.add(_selectItem(channels[i].name, channels[i].id, channels[i].articlecount, i != channels.length - 1));
    }

    return _channels;
  }

  Widget _selectModel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 240.0,
          margin: EdgeInsets.only(top: 40.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _selectItem('全部', 0, articleTotal),
              ..._selectItemList()
            ],
          )
        )
      ]
    );
  }

  Widget _header() {
    return Container(
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Logo(size: 80.0),
              GestureDetector(
                onTap: () {
                  routerGo(context, SearchPage());
                },
                child: IconB(code: 0xe63c, color: Colors.black, size: 24.0),
              )
            ]
          ),
          Center(child: Container(
            margin: EdgeInsets.only(top: 4.0),
            child: GestureDetector(
              onTap: () {
                showDialog<Null>(
                  context: context,
                  builder: (BuildContext context) {
                    return _selectModel();
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text(_curGroup, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0
                )),
                SizedBox(width: 6.0),
                IconB(code: 0xe65c, size: 20.0, color: Colors.black),
              ])
            )
          ))
        ])
      )
    );
  }

  getArticlesByChannel([bool reload = false]) {
    ArticleDao.fetchByChannel(page, _curIndex).then((res) {
      if (reload) {
        setState(() {
          list = res.list;
          total = res.total;
          loading = false;
        });
      } else {
        setState(() {
          list.addAll(res.list);
          total = res.total;
        });
      }
    });
  }

  getArticleByChannel([bool reload = false]) {
    if (_curIndex > 0) {
      getArticlesByChannel(reload);
    } else {
      getArticles(reload);
    }
  }

  Future<Null> handleRefresh() async {
    page = 1;
    getArticleByChannel(true);

    return null;
  }

  Widget _renderListItem(int index) {
    if (index == list.length) {
      return LoadMore(list.length != total);
    }

    return ArticleBox(
      article: list[index],
      channelClick: (title, index) {
        if (index != _curIndex) {
          changeChannel(title, index);
        } 
      }
    );
  }

  Widget renderMain() {
    if (list.length > 0) {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: RefreshIndicator(
          onRefresh: handleRefresh,
          child: ListView.builder(
            itemCount: list.length + 1,
            itemBuilder: (BuildContext context, int index) {
              return _renderListItem(index);
            },
            controller: _scrollController
          )
        )
      );
    } else {
      return Empty(text: '暂时没有相关文章');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      header: _header(),
      body: LoadingContainer(isLoading: loading,
        child: renderMain()
      )
    );
  }
}