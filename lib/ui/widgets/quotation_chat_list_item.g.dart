// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotation_chat_list_item.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class QuotationListItem extends StatelessWidget {
  const QuotationListItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => quotationListItem(_context);
}

class QuotationCurrentUserTextItem extends StatelessWidget {
  const QuotationCurrentUserTextItem(
      {Key key, this.quotationMessage, this.isLastMessageRight})
      : super(key: key);

  final QuotationMessage quotationMessage;

  final bool isLastMessageRight;

  @override
  Widget build(BuildContext _context) => quotationCurrentUserTextItem(
      quotationMessage: quotationMessage,
      isLastMessageRight: isLastMessageRight);
}

class QuotationCurrentUserImageItem extends StatelessWidget {
  const QuotationCurrentUserImageItem(
      {Key key, this.quotationMessage, this.isLastMessageRight, this.onTap})
      : super(key: key);

  final QuotationMessage quotationMessage;

  final bool isLastMessageRight;

  final dynamic onTap;

  @override
  Widget build(BuildContext _context) => quotationCurrentUserImageItem(
      quotationMessage: quotationMessage,
      isLastMessageRight: isLastMessageRight,
      onTap: onTap);
}

class QuotationCurrentUserStickerItem extends StatelessWidget {
  const QuotationCurrentUserStickerItem(
      {Key key, this.quotationMessage, this.isLastMessageRight})
      : super(key: key);

  final QuotationMessage quotationMessage;

  final bool isLastMessageRight;

  @override
  Widget build(BuildContext _context) => quotationCurrentUserStickerItem(
      quotationMessage: quotationMessage,
      isLastMessageRight: isLastMessageRight);
}

class QuotationBusinessTextItem extends StatelessWidget {
  const QuotationBusinessTextItem({Key key, this.quotationMessage})
      : super(key: key);

  final QuotationMessage quotationMessage;

  @override
  Widget build(BuildContext _context) =>
      quotationBusinessTextItem(quotationMessage: quotationMessage);
}

class QuotationBusinessProfileImage extends StatelessWidget {
  const QuotationBusinessProfileImage({Key key, this.businessImageUrl})
      : super(key: key);

  final String businessImageUrl;

  @override
  Widget build(BuildContext _context) =>
      quotationBusinessProfileImage(businessImageUrl: businessImageUrl);
}

class QuotationBusinessImageItem extends StatelessWidget {
  const QuotationBusinessImageItem({Key key, this.quotationMessage, this.onTap})
      : super(key: key);

  final QuotationMessage quotationMessage;

  final dynamic onTap;

  @override
  Widget build(BuildContext _context) => quotationBusinessImageItem(
      quotationMessage: quotationMessage, onTap: onTap);
}

class QuotationBusinessStickerItem extends StatelessWidget {
  const QuotationBusinessStickerItem(
      {Key key, this.quotationMessage, this.isLastMessageRight})
      : super(key: key);

  final QuotationMessage quotationMessage;

  final bool isLastMessageRight;

  @override
  Widget build(BuildContext _context) => quotationBusinessStickerItem(
      quotationMessage: quotationMessage,
      isLastMessageRight: isLastMessageRight);
}
