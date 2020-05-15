import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:virtual_mall/core/models/quotation_chat_item.dart';
import 'package:virtual_mall/core/models/quotation_chat_message.dart';
import 'package:virtual_mall/ui/shared/app_colors.dart';

part 'quotation_chat_list_item.g.dart';

// separation of design the data-binding
@widget
Widget quotationListItem(BuildContext context) {
  final quotationItem = Provider.of<QuotationItem>(context);
  if (quotationItem.loggedUserId == quotationItem.quotationMessage.idFrom) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        quotationItem.quotationMessage.type == 0
            ? QuotationCurrentUserTextItem(
                quotationMessage: quotationItem.quotationMessage,
                isLastMessageRight: quotationItem.isLastMessageRight)
            : quotationItem.quotationMessage.type == 1
                ? QuotationCurrentUserImageItem(
                    quotationMessage: quotationItem.quotationMessage,
                    isLastMessageRight: quotationItem.isLastMessageRight,
                    onTap: () {
                      Navigator.pushNamed(context, '/fullPhoto',
                          arguments: quotationItem.quotationMessage.content);
                    })
                : QuotationCurrentUserStickerItem(
                    quotationMessage: quotationItem.quotationMessage,
                    isLastMessageRight: quotationItem.isLastMessageRight)
      ],
    );
  } else {
    return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  quotationItem.isLastMessageLeft
                      ? QuotationBusinessProfileImage(
                          businessImageUrl: quotationItem.businessImageUrl)
                      : Container(width: 35.0),
                  quotationItem.quotationMessage.type == 0
                      ? QuotationBusinessTextItem(
                          quotationMessage: quotationItem.quotationMessage)
                      : quotationItem.quotationMessage.type == 1
                          ? QuotationBusinessImageItem(
                              quotationMessage: quotationItem.quotationMessage,
                              onTap: () {
                                Navigator.pushNamed(context, '/fullPhoto',
                                    arguments:
                                        quotationItem.quotationMessage.content);
                              },
                            )
                          : QuotationBusinessStickerItem(
                              quotationMessage: quotationItem.quotationMessage,
                              isLastMessageRight:
                                  quotationItem.isLastMessageRight)
                ],
              ),
              quotationItem.isLastMessageLeft
                  ? Container(
                      child: Text(
                        "DATE",
                        style: TextStyle(
                            color: greyColor,
                            fontSize: 12.0,
                            fontStyle: FontStyle.italic),
                      ),
                      margin:
                          EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                    )
                  : Container()
            ]));
  }
}

@widget
Widget quotationCurrentUserTextItem(
    {QuotationMessage quotationMessage, bool isLastMessageRight}) {
  return Container(
    child: Text(
      quotationMessage.content,
      style: TextStyle(color: Colors.black),
    ),
    padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
    width: 200.0,
    decoration: BoxDecoration(
        color: greyColor2, borderRadius: BorderRadius.circular(8.0)),
    margin:
        EdgeInsets.only(bottom: isLastMessageRight ? 20.0 : 10.0, right: 10.0),
  );
}

@widget
Widget quotationCurrentUserImageItem(
    {QuotationMessage quotationMessage,
    bool isLastMessageRight,
    VoidCallback onTap}) {
  return Container(
    child: FlatButton(
      child: Material(
        child: quotationMessage.pending
            ? Container(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                ),
                width: 200.0,
                height: 200.0,
                padding: EdgeInsets.all(70.0),
                decoration: BoxDecoration(
                  color: greyColor2,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              )
            : CachedNetworkImage(
                placeholder: (context, url) => Container(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                  ),
                  width: 200.0,
                  height: 200.0,
                  padding: EdgeInsets.all(70.0),
                  decoration: BoxDecoration(
                    color: greyColor2,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Material(
                  child: Image.asset(
                    'images/img_not_available.jpeg',
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                ),
                imageUrl: quotationMessage.content,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        clipBehavior: Clip.hardEdge,
      ),
      onPressed: onTap,
      padding: EdgeInsets.all(0),
    ),
    margin:
        EdgeInsets.only(bottom: isLastMessageRight ? 20.0 : 10.0, right: 10.0),
  );
}

@widget
Widget quotationCurrentUserStickerItem(
    {QuotationMessage quotationMessage, bool isLastMessageRight}) {
  return Container(
    child: new Image.asset(
      'images/${quotationMessage.content}.gif',
      width: 100.0,
      height: 100.0,
      fit: BoxFit.cover,
    ),
    margin:
        EdgeInsets.only(bottom: isLastMessageRight ? 20.0 : 10.0, right: 10.0),
  );
}

@widget
Widget quotationBusinessTextItem({QuotationMessage quotationMessage}) {
  return Container(
    child: Text(
      quotationMessage.content,
      style: TextStyle(color: Colors.white),
    ),
    padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
    width: 200.0,
    decoration: BoxDecoration(
        color: primaryColor, borderRadius: BorderRadius.circular(8.0)),
    margin: EdgeInsets.only(left: 10.0),
  );
}

@widget
Widget quotationBusinessProfileImage({String businessImageUrl}) {
  return Material(
    child: CachedNetworkImage(
      placeholder: (context, url) => Container(
        child: CircularProgressIndicator(
          strokeWidth: 1.0,
          valueColor: AlwaysStoppedAnimation<Color>(themeColor),
        ),
        width: 35.0,
        height: 35.0,
        padding: EdgeInsets.all(10.0),
      ),
      imageUrl: businessImageUrl,
      width: 35.0,
      height: 35.0,
      fit: BoxFit.cover,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(18.0),
    ),
    clipBehavior: Clip.hardEdge,
  );
}

@widget
Widget quotationBusinessImageItem(
    {QuotationMessage quotationMessage, VoidCallback onTap}) {
  return Container(
    child: FlatButton(
      child: Material(
        child: quotationMessage.pending
            ? Container(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                ),
                width: 200.0,
                height: 200.0,
                padding: EdgeInsets.all(70.0),
                decoration: BoxDecoration(
                  color: greyColor2,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              )
            : CachedNetworkImage(
                placeholder: (context, url) => Container(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                  ),
                  width: 200.0,
                  height: 200.0,
                  padding: EdgeInsets.all(70.0),
                  decoration: BoxDecoration(
                    color: greyColor2,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Material(
                  child: Image.asset(
                    'images/img_not_available.jpeg',
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                ),
                imageUrl: quotationMessage.content,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        clipBehavior: Clip.none,
      ),
      onPressed: onTap,
      padding: EdgeInsets.all(0),
    ),
    margin: EdgeInsets.only(left: 10.0),
  );
}

@widget
Widget quotationBusinessStickerItem(
    {QuotationMessage quotationMessage, bool isLastMessageRight}) {
  return Container(
    child: new Image.asset(
      'images/${quotationMessage.content}.gif',
      width: 100.0,
      height: 100.0,
      fit: BoxFit.cover,
    ),
    margin:
        EdgeInsets.only(bottom: isLastMessageRight ? 20.0 : 10.0, right: 10.0),
  );
}
