import 'package:flutter/material.dart';
import 'package:virtual_mall/translation/app_localizations.dart';
import 'package:virtual_mall/ui/shared/app_colors.dart';
import 'package:virtual_mall/ui/shared/ui_helpers.dart';

class LoginHeader extends StatelessWidget {
  final TextEditingController controller;
  final String validationMessage;

  LoginHeader({@required this.controller, this.validationMessage});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(AppLocalizations.of(context).welcome,
          style: TextStyle(
            color: themeColor,
          fontSize: 24,
          fontWeight: FontWeight.w900
      )),
      UIHelper.verticalSpace(16),
      Container(
        width: 202.0,
        child: Text(
          AppLocalizations.of(context)
              .createLegend,
          textAlign: TextAlign.center,
        ),
      ),
      UIHelper.verticalSpaceMedium(),
      Container(
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
      UIHelper.verticalSpaceMedium(),
      this.validationMessage != null
          ? Text(validationMessage, style: TextStyle(color: Colors.red))
          : Container()
    ]);
  }
}

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;

  LoginTextField(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: TextField(
          decoration: InputDecoration.collapsed(hintText: 'User Id'),
          controller: controller),
    );
  }
}
