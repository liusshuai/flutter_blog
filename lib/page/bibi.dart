import 'package:webapp/dao/bibi.dart';
import 'package:webapp/module/bibi.dart';
import 'package:webapp/widget/bibiBox.dart';
import 'package:webapp/widget/load_more.dart';
import 'package:webapp/widget/loading.dart';
import 'package:webapp/widget/page_wrap.dart';
import 'package:flutter_web/material.dart';

class BibiPage extends StatefulWidget {
  @override
  _BibiPageState createState() => _BibiPageState();
}

class _BibiPageState extends State<BibiPage> {

  ScrollController _scrollController = new ScrollController();

  int page = 1;
  int total = 0;
  List<BibiItemModule> bibis = [];
  bool loading = true;

  getData([bool reload = false]) {
    BibiDao.fetchBibi(page).then((res) {
      if (reload) {
        setState(() {
          total = res.total;
          bibis = res.data;
          loading = false;
        });
      } else {
        setState(() {
          total = res.total;
          bibis.addAll(res.data);
        });
      }
    });
  }

  @override
  void initState() { 
    super.initState();
    getData(true);
    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (total == bibis.length) return;
        page = page + 1;
        getData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Widget _renderListItem(int index) {
    if (index == 0) {
      return ImageHeader();
    }

    if (index == bibis.length + 1) {
      return LoadMore(bibis.length != total);
    }

    return BibiBox(data: bibis[index - 1]);
  }

  @override
  Widget build(BuildContext context) {
    return PageWrap(
      body: LoadingContainer(isLoading: loading,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
            itemCount: bibis.length + 2,
            itemBuilder: (BuildContext context, int index) {
              return _renderListItem(index);
            },
            controller: _scrollController
          )
        )
      )
    );
  }
}

class ImageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bibibg.jpg'),
          fit: BoxFit.cover
        ),
      ),
      child: Column(children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 120.0, 0, 16.0),
          child: Text('一个人过', style: TextStyle(color: Colors.white, fontSize: 26.0))
        ),
        Text('其实你认识的大部分人，你们已经', style: TextStyle(color: Colors.white, fontSize: 16.0)),
        Text('见过最后一面了', style: TextStyle(color: Colors.white, fontSize: 16.0))
      ])
    );
  }
}