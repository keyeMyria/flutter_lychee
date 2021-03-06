import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:lychee/widget/base/BaseListState.dart';
import 'package:lychee/widget/base/BaseState.dart';
import 'package:lychee/widget/base/BaseBookListState.dart';
import 'package:lychee/widget/base/BaseBookListWidget.dart';
import 'package:lychee/common/util/CommonUtils.dart';
import 'package:lychee/common/style/Style.dart';
import 'package:lychee/common/model/Book.dart';
import 'package:lychee/common/model/Frame.dart';

class MineCollectionBookPage extends StatefulWidget {
  @override
  _MineCollectionBookPageState createState() => _MineCollectionBookPageState();
}

class _MineCollectionBookPageState extends State<MineCollectionBookPage> with AutomaticKeepAliveClientMixin<MineCollectionBookPage>,BaseState<MineCollectionBookPage>, BaseListState<MineCollectionBookPage>,BaseBookListState<MineCollectionBookPage> {
  @override
  remotePath() {
    return "/collection/search";
  }

  @override
  bool get needLibrary => false;

  @override
  bool get needSlide => true;

  @override
  List<Widget> slideActions(index) {
    return <Widget>[
      IconSlideAction(
        caption: '定位',
        color: Color(YYColors.primary),
        icon: Icons.location_on,
        onTap: () {
          _location(index);
        },
      ),
      IconSlideAction(
        caption: '删除',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () {
          _delete(index);
        },
      ),
    ];
  }

  @override
  String get categoryRemotePath => "/category/findCollection";

  _location(index) async{
    Book book = control.data[index];
    var res = await handleNotAssociatedWithRefreshRequest("/frame/findMyByBid", {"bid":book.id});
    if (res!=null && res.result && res.data!=null) {
      Frame frame = Frame.fromJson(res.data);
      showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('所属书架'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(frame.name,style:TextStyle(color: Color(YYColors.primaryText),fontSize: YYSize.large),overflow: TextOverflow.ellipsis)
                ],
              ),
            ),
            actions: <Widget>[
              InkWell(
                child: Text('确定',style: TextStyle(color: Color(YYColors.secondaryText),fontSize: YYSize.medium),overflow: TextOverflow.ellipsis),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      );
    }
  }

  _delete(index) async{
    Book book = control.data[index];
    var res = await handleNotAssociatedWithRefreshRequest("/collection/delete", {"bid":book.id});
    if (res!=null && res.result) {
      if (isShow) {
        setState(() {
          control.data.removeAt(index);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: new Image.asset(CommonUtils.Local_Icon_prefix+"back.png",width: 18.0,height: 18.0),
          onPressed: () {
            CommonUtils.closePage(context);
          }),
        title:Text("我的藏书"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child:  BaseBookListWidget(
                control:control,
                onRefresh: handleRefresh,
                onLoadMore: onLoadMore,
                refreshKey: refreshIndicatorKey,
                widgetName: widget.runtimeType.toString(),
                itemBuilder: (BuildContext context, int index) => renderListItem(index),
              ),
            ),
            Container(
              height: 47.0,
              color: Color(YYColors.gray),
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                    child: Container(
                      width: 104,
                      height: 47.0,
                      color: Color(YYColors.primary),
                      child: Center( 
                        child: Text("扫描添加",style:TextStyle(color: Colors.white,fontSize: YYSize.tip),overflow: TextOverflow.ellipsis)
                      )
                    ),
                    onTap: () {
                      
                    }
                ),
              )
            )
          ],
        ),
      )
    );
  }
}