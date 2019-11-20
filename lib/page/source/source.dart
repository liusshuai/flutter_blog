import 'package:webapp/dao/source.dart';
import 'package:webapp/module/source.dart';
import 'package:webapp/widget/empty.dart';
import 'package:webapp/widget/loading.dart';
import 'package:webapp/widget/page_wrap.dart';
import 'package:webapp/widget/searchBar.dart';
import 'package:webapp/widget/sourceBox.dart';
import 'package:flutter_web/material.dart';

class SourcePage extends StatefulWidget {
  @override
  _SourcePageState createState() => _SourcePageState();
}

class _SourcePageState extends State<SourcePage> {

  int total = 0;
  int page = 1;
  List<SourceItemModule> sources = [];
  bool loading = true;
  String key = '';

  ScrollController _scrollController = ScrollController();

  void getSources([bool reload = false]) {
    SourceDao.fetchSource(page, key).then((res) {
      setState(() {
        if (reload) {
          setState(() {
            total = res.total;
            sources = res.list;
            loading = false;
          });
        } else {
          setState(() {
            total = res.total;
            sources.addAll(res.list);
          });
        }
      });
    });
  }

  @override
  void initState() { 
    super.initState();
    getSources(true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels
      == _scrollController.position.maxScrollExtent) {

        if (total == sources.length) return;

        page = page + 1;

        getSources();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<Null> handleFresh() async {
    page = 1;

    getSources(true);

    return null;
  }

  Widget renderContent(int index) {
    return SourceBox(source: sources[index]);
  }

  List<Widget> renderSourceList() {
    List<Widget> _sources = [];

    for (var i = 0; i < sources.length; i++) {
      _sources.add(renderContent(i));
    }

    return _sources;
  }

  Widget renderMain() {
    if (sources.length > 0) {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: RefreshIndicator(
          onRefresh: handleFresh,
          child: GridView.count( 
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            children: renderSourceList()
          )
        )
      );
    }

    return Empty(text: '没有相关资源，请联系博主添加');
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      header: SearchBar(placeholder: '搜索你想要的资源', search: (v) {
        key = v;
        handleFresh();
      }),
      body: LoadingContainer(isLoading: loading,
        child: renderMain()
      )
    );
  }
}