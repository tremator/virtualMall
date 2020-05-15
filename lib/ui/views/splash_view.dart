import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:virtual_mall/ui/shared/app_colors.dart';

part 'splash_view.g.dart';

@widget
Widget splashView(BuildContext context) {
  return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Text(''))
          ]
      )
  );
}
