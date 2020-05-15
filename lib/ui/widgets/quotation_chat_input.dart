import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:virtual_mall/core/enums/viewstate.dart';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/models/user.dart';
import 'package:virtual_mall/core/services/business_quotation/business_quotation.dart';
import 'package:virtual_mall/core/viewmodels/quotation_chat_input_model.dart';
import 'package:virtual_mall/core/viewmodels/quotation_model.dart';
import 'package:virtual_mall/ui/shared/app_colors.dart';

part 'quotation_chat_input.g.dart';

@widget
Widget quotationChatInput(BuildContext context) {
  final viewState = Provider.of<QuotationModel>(context);
  return ChangeNotifierProxyProvider3<Business, User, BusinessQuotation,
      QuotationChatInputModel>(
    create: (_) => QuotationChatInputModel(),
    update: (context, business, user, service, model) => model
      ..scrollController = viewState.listScrollController
      ..businessService = service
      ..user = user
      ..business = business,
    child: Consumer<QuotationChatInputModel>(
      builder: (context, model, child) => model.state == ViewState.Busy
          ? const Center(child: CircularProgressIndicator())
          : Container(
            width: double.infinity,
              height: 50.0,
              decoration: new BoxDecoration(
                  border: new Border(
                      top: new BorderSide(color: greyColor2, width: 0.5)),
                  color: Colors.white),
              child: Row(
                children: <Widget>[
                  // Button send image
                  Material(
                    child: new Container(
                      margin: new EdgeInsets.symmetric(horizontal: 1.0),
                      child: new IconButton(
                        icon: new Icon(Icons.image),
                        onPressed: model.getImage,
                        color: themeColor,
                      ),
                    ),
                    color: Colors.white,
                  ),

                  // Edit text
                  Flexible(
                    child: Container(
                      child: TextField(
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                        controller: model.textEditingController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(color: greyColor),
                        ),
                        focusNode: viewState.focusNode,
                      ),
                    ),
                  ),

                  // Button send message
                  Material(
                    child: new Container(
                      margin: new EdgeInsets.symmetric(horizontal: 8.0),
                      child: new IconButton(
                        icon: new Icon(Icons.send),
                        onPressed: () => model.onSendMessage(
                            model.textEditingController.text, 0),
                        color: themeColor,
                      ),
                    ),
                    color: Colors.white,
                  ),
                ],
              ),
              
            ),
    ),
  );
}
