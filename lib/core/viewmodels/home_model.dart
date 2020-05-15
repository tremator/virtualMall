import 'dart:async';
import 'package:virtual_mall/core/enums/viewstate.dart';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/services/business/business_service.dart';
import 'package:virtual_mall/core/viewmodels/base_model.dart';


class HomeModel extends BaseModel {
  BusinessService _service;

  BusinessService get businessService => _service;

  initState() {
    Future.microtask(() =>
        getPosts()
    );
  }

  set businessService(BusinessService service) {
    _service = service;
    notifyListeners();
  }

  Stream<List<Business>> _appBusiness;

  Stream<List<Business>> get appBusiness => _appBusiness;


  void getPosts() {
    if (state == ViewState.Busy) {
      throw StateError(
          "fetching posts again when the current request haven't finished");
    }
    setState(ViewState.Busy);
    _appBusiness = _service.getAppBusiness();
    setState(ViewState.Idle);
  }
}
