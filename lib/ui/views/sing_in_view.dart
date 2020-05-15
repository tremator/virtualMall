import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:provider/provider.dart';
import 'package:virtual_mall/core/enums/viewstate.dart';
import 'package:virtual_mall/core/viewmodels/login_model.dart';
import 'package:virtual_mall/ui/shared/app_colors.dart';
import 'package:virtual_mall/ui/widgets/login_header.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LoginModel>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LoginHeader(
            validationMessage: model.errorMessage,
            controller: _controller,
          ),
          model.state == ViewState.Busy
              ? const CircularProgressIndicator()
              : Container(
                  child: Column(
                  children: <Widget>[
                    ButtonTheme(
                      child: GoogleSignInButton(
                        onPressed: () async {
                          await model.googleSignIn();
                        },
                      ),
                    ),
                    ButtonTheme(
                      child: FacebookSignInButton(
                          onPressed: () async {
                        await model.facebookSignIn();
                      }),
                    )
                  ],
                )),
        ],
      ),
    );
  }
}
