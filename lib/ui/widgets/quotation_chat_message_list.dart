import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:virtual_mall/core/enums/viewstate.dart';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/models/quotation_chat_item.dart';
import 'package:virtual_mall/core/models/quotation_chat_message.dart';
import 'package:virtual_mall/core/models/user.dart';
import 'package:virtual_mall/core/services/business_quotation/business_quotation.dart';
import 'package:virtual_mall/core/viewmodels/quotation_messages_list_model.dart';
import 'package:virtual_mall/core/viewmodels/quotation_model.dart';
import 'package:virtual_mall/ui/widgets/quotation_chat_list_item.dart';

part 'quotation_chat_message_list.g.dart';

@widget
Widget quotationChatMessageList(BuildContext context) {
  final viewState = Provider.of<QuotationModel>(context);
  return ChangeNotifierProxyProvider3<Business, User, BusinessQuotation,
      QuotationMessagesListModel>(
    create: (_) => QuotationMessagesListModel(),
    update: (context, business, user, service, model) => model
      ..businessService = service
      ..user = user
      ..business = business,
    child: Consumer<QuotationMessagesListModel>(
      builder: (context, model, child) => Flexible(
          child: model.state == ViewState.Busy
          
              ? const Center(child: CircularProgressIndicator())
              : StreamBuilder<List<QuotationMessage>>(
                  stream: model.quotationMessages,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<QuotationMessage>> snapshot) {
                    if (!snapshot.hasData)
                      return const Center(child: CircularProgressIndicator());
                    final int messageCount = snapshot.data.length;
                    return ListView.builder(
                      itemCount: messageCount,
                      reverse: true,
                      controller: viewState.listScrollController,
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) {
                        final QuotationMessage quotationMessage =
                            snapshot.data[index];
                        final isLastMessageLeft = (index > 0 &&
                                snapshot.data[index - 1].idFrom ==
                                    model.user.id) ||
                            index == 0;
                        final isLastMessageRight = (index > 0 &&
                                snapshot.data[index - 1].idFrom !=
                                    model.user.id) ||
                            index == 0;
                        return Provider.value(
                          value: QuotationItem(
                              model.user.id,
                              model.business.image,
                              quotationMessage,
                              isLastMessageRight,
                              isLastMessageLeft),
                          child: const QuotationListItem(),
                        );
                      },
                    );
                  },
                )),
    ),
  );
}
