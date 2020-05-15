import 'package:virtual_mall/core/models/quotation_chat_message.dart';

class QuotationItem {
  final String loggedUserId;
  final businessImageUrl;
  final QuotationMessage quotationMessage;
  final bool isLastMessageRight;
  final bool isLastMessageLeft;

  QuotationItem(this.loggedUserId, this.businessImageUrl, this.quotationMessage, this.isLastMessageRight, this.isLastMessageLeft);
}