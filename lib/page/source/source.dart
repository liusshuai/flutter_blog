import 'package:app/dao/source.dart';
import 'package:app/module/source.dart';
import 'package:app/widget/empty.dart';
import 'package:app/widget/loading.dart';
import 'package:app/widget/page_wrap.dart';
import 'package:app/widget/searchBar.dart';
import 'package:app/widget/sourceBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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

  Widget renderMain() {
    if (sources.length > 0) {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: RefreshIndicator(
          onRefresh: handleFresh,
          child: StaggeredGridView.countBuilder(
            controller: _scrollController,
            crossAxisCount: 4,
            itemCount: sources.length,
            itemBuilder: (BuildContext context, int index) => Center(
              child: renderContent(index)
            ),
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.fit(2),
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
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