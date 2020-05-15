import 'package:virtual_mall/core/enums/viewstate.dart';
import 'package:virtual_mall/core/services/auth/authentication_service.dart';

import 'base_model.dart';

class LoginModel extends BaseModel {
  AuthenticationService _authenticationService;

  AuthenticationService get authenticationService => _authenticationService;

  set authenticationService(AuthenticationService authenticationService) {
    _authenticationService = authenticationService;
    notifyListeners();
  }

  String errorMessage;

  Future<bool> googleSignIn() async {
    setState(ViewState.Busy);
    var success = await _authenticationService.googleSignIn();

    // Handle potential error here too.
    if (!success) errorMessage = "Sign In Fail or Cancelled";

    setState(ViewState.Idle);
    return success;
  }

  Future<bool> facebookSignIn() async {
    setState(ViewState.Busy);
    var success = await _authenticationService.facebookSignIn();

    // Handle potential error here too.
    if (!success) errorMessage = "Sign In Fail or Cancelled";

    setState(ViewState.Idle);
    return success;
  }
}
