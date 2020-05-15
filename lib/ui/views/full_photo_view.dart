import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:virtual_mall/translation/app_localizations.dart';

part 'full_photo_view.g.dart';

@widget
Widget fullPhotoView(BuildContext context) {
  final url = Provider.of<String>(context);

  return Scaffold(
    appBar: new AppBar(
        title: Text(AppLocalizations.of(context)
            .photo),
    ),
    body: Container(child: PhotoView(imageProvider: NetworkImage(url))),
  );
}
