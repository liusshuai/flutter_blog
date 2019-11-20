import 'package:webapp/module/bibi.dart';
import 'package:webapp/page/bibiDetail.dart';
import 'package:webapp/util/util.dart';
import 'package:webapp/widget/icon.dart';
import 'package:webapp/widget/imageViewer.dart';
import 'package:flutter_web/material.dart';
import 'package:webapp/constant.dart';
import 'dart:convert';

class BibiBox extends StatelessWidget {

  final BibiItemModule data;
  final bool isDetail;
  
  BibiBox({
    this.data,
    this.isDetail = false
  });

  @override
  Widget build(BuildContext context) {

      List<Widget> renderContent() {
      List<Widget> list = [];
      list.add(Text('${data.pubtime} 发布', style: TextStyle(fontWeight: FontWeight.w500)));

      list.add(Container(
        margin: EdgeInsets.symmetric(vertical: 12.0),
        child: Text('${data.content}')
      ));

      if (data.fromw != null) {
        var tags = json.decode(data.fromw);
        if (tags.length > 0) {
          list.add(Tags(tags: tags));
          list.add(SizedBox(height: 10.0));
        }
      }

      if (data.imgs != null && data.imgs.length > 0) {
        list.add(InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => ImageViwer(
                src: '$base_url${data.imgs[0].src}'
              )
            ));
          },
          child: Container(
            height: 230.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage('$base_url${data.imgs[0].src}'),
                fit: BoxFit.cover
              )
            )
          ))
        );
      }

      list.add(Container(
        margin: EdgeInsetsDirectional.only(top: 10.0),
        padding: EdgeInsetsDirectional.only(top: 6.0),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 1.0, color: Color(0xffeeeeee)))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(children: <Widget>[
              IconB(code: 0xe8ca, color: data.likenum >= 100 ? Colors.red : Colors.grey),
              SizedBox(width: 4.0),
              Text('${data.likenum}')
            ]),
            Text('|', style: TextStyle(
              color: Color(0xffeeeeee)
            )),
            Row(children: <Widget>[
              IconB(code: 0xe635),
              SizedBox(width: 4.0),
              Text('${data.comments}')
            ])
          ],
        )
      ));

      return list;
    }

    if (!isDetail) {
      return GestureDetector(
        onTap: () {
          routerGo(context, BibiDetailPage(bibi: data));
        },
        child: Container(
          margin: EdgeInsetsDirectional.only(top: 10.0),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: renderContent()
          )
        )
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: renderContent()
      )
    );
  }
}

class Tags extends StatelessWidget {

  final List tags;

  Tags({ this.tags });

  List<Widget> renderTags() {
    List<Widget> list = [];

    tags.forEach((tag) {
      list.add(Text('#$tag#', style: TextStyle(color: Color(0xffaaaaaa))));
      list.add(SizedBox(width: 10.0));
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: renderTags());
  }
}
