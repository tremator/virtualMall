import 'package:flutter/material.dart';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/models/user.dart';
import 'package:virtual_mall/core/services/business_quotation/base_business_quotation.dart';
import 'package:virtual_mall/core/services/business_quotation/business_quotation.dart';
import 'package:virtual_mall/core/viewmodels/base_model.dart';

class QuotationModel extends BaseModel {
  String groupChatId;
  ScrollController _listScrollController =  ScrollController();
  get listScrollController => _listScrollController;

  BusinessQuotation _service;
  BusinessQuotation get businessService => _service;
  set businessService(BusinessQuotation service) {
    _service = service;
    notifyListeners();
  }

  User _user;
  User get user => _user;
  set user(User user){
    if(_user != user){
      _user = user;
      notifyListeners();
    }
  }

  Business _business;
  Business get business => _business;
  set business(Business business){
    if(_business != business){
      _business = business;
      setChatReferences();
      notifyListeners();
    }
  }

  bool isShowSticker;
  String imageUrl;

  final FocusNode focusNode = new FocusNode();

  initState() {
    isShowSticker = false;
    focusNode.addListener(onFocusChange);
    imageUrl = '';

  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      isShowSticker = false;
      notifyListeners();
    }
  }

  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    isShowSticker = !isShowSticker;
    notifyListeners();
  }

  void setChatReferences(){
    if (_user.id.hashCode <= _business.id.hashCode) {
      groupChatId = '${_user.id}-${_business.id}';
    } else {
      groupChatId = '${_business.id}-${_user.id}';
    }

    _service.writeWrittenWith(_user.id, _business.id);
  }

}