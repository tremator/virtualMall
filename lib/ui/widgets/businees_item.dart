import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/ui/shared/app_colors.dart';
import 'package:virtual_mall/ui/shared/ui_helpers.dart';

part 'businees_item.g.dart';

// separation of design the data-binding
@widget
Widget businessListItem(BuildContext context) {
  final post = Provider.of<Business>(context);
  return LocalBusinessListItem(
    onTap: () {
      Navigator.pushNamed(context, '/business', arguments: post);
    },
    
    title: Text(post.name),
    body: Text(post.email),
    image: Image.network(post.image, fit: BoxFit.cover, height: 130, width: double.infinity,)
  );
}

@widget
Widget localBusinessListItem({Widget title, Widget body, VoidCallback onTap, Widget image}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
          color: homeRowBackgroundColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
                blurRadius: 3.0,
                offset: Offset(0.0, 2.0),
                color: Color.fromARGB(80, 0, 0, 0))
          ]),
      child: Column(  
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: new BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
              child: Container(
                color: Colors.grey,
                child: image,
              ),
            ),
          ),
          UIHelper.verticalSpace(10.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: DefaultTextStyle.merge(
                  textAlign: TextAlign.center,
                  child: title ,
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0, color: Colors.white,),
                ),
              ),
            ],
          ),
          
          UIHelper.verticalSpace(10.0),
        ],
      ),
    ),
  );
}