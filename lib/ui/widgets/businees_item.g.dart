// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'businees_item.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class BusinessListItem extends StatelessWidget {
  const BusinessListItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => businessListItem(_context);
}

class LocalBusinessListItem extends StatelessWidget {
  const LocalBusinessListItem(
      {Key key, this.title, this.body, this.onTap, this.image})
      : super(key: key);

  final Widget title;

  final Widget body;

  final dynamic onTap;

  final Widget image;

  @override
  Widget build(BuildContext _context) => localBusinessListItem(
      title: title, body: body, onTap: onTap, image: image);
}
