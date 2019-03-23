import 'package:flutter/material.dart';
import 'package:lychee/common/model/YYCategory.dart';
import 'package:lychee/common/style/YYStyle.dart';

class YYCategoryLeftItemWidget extends StatefulWidget {
  final YYCategory category;
  final bool highlight;
  final VoidCallback onPress;

  YYCategoryLeftItemWidget({this.category,this.highlight,this.onPress});

  @override
  _YYCategoryLeftItemWidgetState createState() => _YYCategoryLeftItemWidgetState();
}

class _YYCategoryLeftItemWidgetState extends State<YYCategoryLeftItemWidget> {
  @override
  Widget build(BuildContext context) {

    return  FlatButton(
      padding: EdgeInsets.all(0),
      onPressed:() {widget.onPress?.call();},
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 44,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 3,
              height: 36.5,
              color: widget.highlight?Color(YYColors.primary):Colors.transparent
            ),
            Expanded(
              child:Center(
                child: Text(widget.category.name,style: TextStyle(color: widget.highlight?Color(YYColors.primary):Color(YYColors.primaryText),fontSize: YYSize.large), overflow: TextOverflow.ellipsis)
              )
            )
          ],
        ),
      )
    );
  }
}