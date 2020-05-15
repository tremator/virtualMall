import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/models/user.dart';
import 'package:virtual_mall/core/services/business_quotation/business_quotation.dart';
import 'package:virtual_mall/core/services/business_quotation/firebase_business_quotation.dart';
import 'package:virtual_mall/core/viewmodels/quotation_model.dart';
import 'package:virtual_mall/keys/keys_model.dart';
import 'package:virtual_mall/translation/app_localizations.dart';
import 'package:virtual_mall/ui/widgets/quotation_chat_input.dart';
import 'package:virtual_mall/ui/widgets/quotation_chat_message_list.dart';

part 'quotation_chat_view.g.dart';

@widget
Widget newBusinessQuotationView(BuildContext context) {
  return MultiProvider(
      providers: [
        ProxyProvider<Keys, FirebaseBusinessQuotation>(
          create: (_) => FirebaseBusinessQuotation(),
          update: (_, keys, previous) =>
          (previous ?? FirebaseBusinessQuotation())..keys = keys,
        ),
        ProxyProvider<FirebaseBusinessQuotation, BusinessQuotation>(
          update: (_, api, previous) =>
          (previous ?? BusinessQuotation())..firebaseBusinessQuotation = api,
          dispose: (_, auth) => auth.dispose(),
        ),
        ChangeNotifierProxyProvider3<Business, User, BusinessQuotation,
                QuotationModel>(
            create: (_) => QuotationModel(),
            update: (context, business, user, service, model) => model
              ..businessService = service
              ..user = user
              ..business = business),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).quotationTitle)
        ),
        body: NewQuotationContent(),
      ));
}

@widget
Widget newQuotationContent(BuildContext context) {
  return  Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              const QuotationChatMessageList(),
            const QuotationChatInput()
            ],
          )
        ],
      );
}
