import 'package:flutter/material.dart';

import 'package:lychee/widget/base/YYBaseScrollSate.dart';
import 'package:lychee/widget/base/YYBaseScrollWidget.dart';
import 'package:lychee/widget/base/YYBaseState.dart';
import 'package:lychee/common/model/YYIndex.dart';
import 'package:lychee/widget/YYSwiperWidget.dart';
import 'package:lychee/common/style/YYStyle.dart';
import 'package:lychee/widget/YYIconTextWidget.dart';
import 'package:lychee/widget/YYLessonItemWidget.dart';
import 'package:lychee/widget/YYCourseItemWidget.dart';
import 'package:lychee/widget/YYBookItemWidget.dart';
import 'package:lychee/common/model/YYBook.dart';
import 'package:lychee/common/util/YYCommonUtils.dart';

class YYHomePage extends StatefulWidget {
  @override
  _YYHomePageState createState() => _YYHomePageState();
}

class _YYHomePageState extends State<YYHomePage> with AutomaticKeepAliveClientMixin<YYHomePage>,YYBaseState<YYHomePage>, YYBaseScrollState<YYHomePage> {

  @override
  bool get needRefreshHeader => true;
  
  @override
  remotePath() {
    return "/home";
  }

  @override
  generateRemoteParams() {
    return {'adCode':'未知'};
  }

  @override
  jsonConvertToModel(Map<String,dynamic> json) {
    return YYIndex.fromJson(json);
  }

  _optionIconText(String assetName,String text, VoidCallback callback) {
    return new FlatButton(
      padding: EdgeInsets.all(0),
      child: new YYIconTextWidget(
        type:2,
        iconAssetName: assetName,
        iconText: text,
        iconWidth: 62.5,
        iconHeight: 62.5,
        textStyle: TextStyle(color: Color(YYColors.primarySection),fontSize: YYSize.medium),
        padding: 2.5,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      onPressed: () {callback?.call();},
    );
  }

  _bannerWidget() {
    if (baseWidgetControl.data==null) return new Container();

    var banners = baseWidgetControl.data.bannerList;

    return (banners==null||banners.length==0)?new Container():new YYSwiperWidget(
      height: 125,
      banners: banners,
      dotActiveColor: Color(YYColors.primary),
      selectItemChanged:(selectIndex) {
       
      },
    );
  } 

  _optionWidget() {
    return new Padding(
      padding:new EdgeInsets.only(left:0,top:21.0,right:0,bottom:10.5),
      child: new Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _optionIconText("book.png","图书",() {
            }),
          ),
          Expanded(
            flex: 1,
            child: _optionIconText("lesson.png","小讲",() {
            }),
          ),
          Expanded(
            flex: 1,
            child: _optionIconText("course.png","短课",() {
            }),
          ),
        ],
      ),
    );
  }

  _chosenBookWidget() {
    if (baseWidgetControl.data == null) return new Container();

    var books =baseWidgetControl.data.chosenBookList;

    return (books==null||books.length==0)?new Container():new Column(
      children: <Widget>[
        new Container(
          height:40.5,
          child: new Padding(
            padding: new EdgeInsets.only(left:10.5),
            child: Align( 
              alignment: Alignment.centerLeft,
              child: Text("精选图书",style: TextStyle(color: Color(YYColors.primarySection),fontSize: YYSize.large))
            ),
          ),
        ),
        new ListView.builder(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            int start = index*YYBookItemWidget.defaultColumn;
            int end = (index+1)*YYBookItemWidget.defaultColumn;
            List<YYBook> itemBooks = new List<YYBook>();
            for (int i=start;i<end&&i<books.length;i++) {
              itemBooks.add(books[i]);
            }
            return new YYBookItemWidget(itemBooks,onPressed: (book){

            });
          },
          itemCount: (books.length%YYBookItemWidget.defaultColumn==0)?(books.length~/YYBookItemWidget.defaultColumn):(books.length~/YYBookItemWidget.defaultColumn+1),
        ),
      ],
    );
  }

  _chosenLessonWidget() {
    if (baseWidgetControl.data == null) return new Container();

    var lessons =baseWidgetControl.data.chosenLessonList;

    return (lessons==null||lessons.length==0)?new Container():new Column(
      children: <Widget>[
        new Container(
          height:40.5,
          child: new Padding(
            padding: new EdgeInsets.only(left:10.5),
            child: Align( 
              alignment: Alignment.centerLeft,
              child: Text("精选小讲",style: TextStyle(color: Color(YYColors.primarySection),fontSize: YYSize.large))
            ),
          ),
        ),
        new ListView.builder(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return new YYLessonItemWidget(lessons[index],onPressed:() {

            });
          },
          itemCount: lessons.length,
        ),
      ],
    );
  }

  _chosenCourseWidget() {
    if (baseWidgetControl.data == null) return new Container();

    var courses =baseWidgetControl.data.chosenCourseList;

    return (courses==null||courses.length==0)?new Container():new Column(
      children: <Widget>[
        new Container(
          height:40.5,
          child: new Padding(
            padding: new EdgeInsets.only(left:10.5),
            child: Align( 
              alignment: Alignment.centerLeft,
              child: Text("精选短课",style: TextStyle(color: Color(YYColors.primarySection),fontSize: YYSize.large))
            ),
          ),
        ),
        new ListView.builder(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return new YYCourseItemWidget(courses[index],onPressed: (){
              
            });
          },
          itemCount: courses.length,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    YYBaseScrollWidgetControl control = baseWidgetControl;

    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"scan.png",width: 24.0,height: 24.0),
          onPressed: () {

          }),
        title:Text("荔枝课堂"),
        actions: <Widget>[
          IconButton(
          icon: new Image.asset(YYCommonUtils.Local_Icon_prefix+"search.png",width: 24.0,height: 24.0),
          onPressed: () {

          })
        ],
      ),
      body: YYBaseScrollWidget(
        control:control,
        onRefresh:handleRefresh,
        refreshKey: refreshIndicatorKey,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _bannerWidget(),
            _optionWidget(),
            _chosenBookWidget(),
            _chosenLessonWidget(),
            _chosenCourseWidget(),
          ]
        ),
      ),
    );
  }
}