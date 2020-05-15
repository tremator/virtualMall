import 'dart:async';

import 'package:virtual_mall/core/enums/viewstate.dart';
import 'package:virtual_mall/core/models/bussiness_product_category.dart';
import 'package:virtual_mall/core/services/business/business_service.dart';

import 'base_model.dart';

class BusinessProductCategoryModel extends BaseModel{
  BusinessService _service;

  BusinessService get businessService => _service;
   String _selectedCategoryId = "";
   String get selectedCategoryId => _selectedCategoryId;

  set selectedCategoryId(String categoryId){
    if(categoryId != selectedCategoryId){
      _selectedCategoryId = categoryId;
      notifyListeners();
    }
  }



  set businessService(BusinessService service) {
    _service = service;
    notifyListeners();
  }


  String _businessId;
  String get businessId => _businessId;
  set businessId(String businessId) {
    if (businessId != _businessId) {
      _businessId = businessId;
      getProductCategories(businessId);
      notifyListeners();
    }
  }

  Stream<List<BusinessProductCategory>> _businessProductCategories;

  Stream<List<BusinessProductCategory>> get businessProductCategories => _businessProductCategories;


  void getProductCategories(String businessId) {
    if (state == ViewState.Busy) {
      throw StateError(
          "fetching posts again when the current request haven't finished");
    }
    setState(ViewState.Busy);
    _businessProductCategories = _service.getBusinessProductCategories(businessId);
    setState(ViewState.Idle);
  }

}
