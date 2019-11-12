import 'package:app/constant.dart';
import 'package:app/module/article.dart';
import 'package:app/page/article/articleDetail.dart';
import 'package:app/util/util.dart';
import 'package:app/widget/avatar.dart';
import 'package:app/widget/icon.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ArticleBox extends StatelessWidget {

  final ArticleItemModule article;
  final void Function (String title, int index) channelClick;

  ArticleBox({
    this.article,
    this.channelClick
  });

  Color commonBaseColor = Color(0xffaaaaaa);

  List tags() {
    List<Widget> tags = [];

    if (article.tags != null) {
      var _tags = json.decode(article.tags);

      _tags.forEach((tag) {
        tags.add(TagItem(text: tag));
        tags.add(SizedBox(width: 10.0));
      });
    }
      
    return tags;
  }

  List<Widget> renderMain() {
    List<Widget> content = [];

    if (article.cover != null && article.cover != '') {
      content.add(Container(
        height: 200.0,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(10.0),
          //   topRight: Radius.circular(10.0)
          // ),
          image: DecorationImage(
            image: NetworkImage(article.cover),
            fit: BoxFit.cover
          )
        )
      ));
    }

    content.add(Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(article.title, style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500
          )),
          SizedBox(height: 10.0),
          Row(children: <Widget>[
            IconB(code: 0xe638, size: 16.0),
            SizedBox(width: 8.0),
            Text(article.pubtime, style: TextStyle(
              fontSize: 14.0, color: commonBaseColor
            ))
          ]),
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(article.desc)
          ),
          Row(children: tags()),
          Container(
            margin: EdgeInsetsDirectional.only(top: 10.0),
            padding: EdgeInsetsDirectional.only(top: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ChannelWrap(
                  name: article.channel.name,
                  cover: article.channel.cover,
                  onClick: () {
                    if (channelClick != null) {
                      channelClick(article.channel.name, article.channel.id);
                    }
                  }
                ), 
                Row(children: <Widget>[
                  DataIcon(code: 0xe645, count: article.views),
                  CutLine(),
                  DataIcon(code: 0xe635, count: article.comments),
                  CutLine(),
                  DataIcon(code: 0xe657, count: article.likes)
                ])
              ]
            )
          ),
        ]
      )
    ));

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        routerGo(context, ArticleDetailPage(
          id: article.id,
          title: article.title,
          comment: article.comments
        ));
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0.0, 2.0),
              color: Color.fromRGBO(0, 0, 0, 0.6),
              blurRadius: 10.0,
              spreadRadius: -9.0
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: renderMain()
        )
      )
    );
  }
}

class ChannelWrap extends StatelessWidget {

  final String name;
  final String cover;
  final void Function () onClick;

  ChannelWrap({
    this.name,
    this.cover,
    this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(onClick != null) {
          onClick();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Avatar(
            url: '$base_url$cover',
            size: 30.0,
            border: false
          ),
          SizedBox(width: 4.0),
          Text(name, style: TextStyle(color: Color(0xffaaaaaa)))
        ]
      )
    ); 
  }
}

class TagItem extends StatelessWidget {

  final String text;

  TagItem({
    this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      padding: EdgeInsets.fromLTRB(6.0, 0, 8.0, 0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 1.0, color: Color(0xff4c4c4e)),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Center(child: Row(children: <Widget>[
        Container(
          width: 6.0,
          height: 6.0,
          margin: EdgeInsets.only(right: 4.0),
          decoration: BoxDecoration(
            color: Color(0xff4c4c4e),
            borderRadius: BorderRadius.circular(6.0)
          ),
        ),
        Text(
          text, style: TextStyle(
            fontSize: 12.0,
            color: Color(0xff4c4c4e)
          )
        )
      ]))
    );
  }

}

class CutLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Text('|', style: TextStyle(
        color: Color(0xffeeeeee)
      ))
    );
  }
}

class DataIcon extends StatelessWidget {

  final int code;
  final int count;

  DataIcon({
    this.code,
    this.count = 0
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconB(code: code, color: Color(0xffaaaaaa)),
        SizedBox(width: 4.0),
        Text('$count', style: TextStyle(color: Color(0xffaaaaaa)))
      ]
    );
  }
}