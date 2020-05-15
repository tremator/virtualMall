import 'package:virtual_mall/core/enums/viewstate.dart';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/models/quotation_chat_message.dart';
import 'package:virtual_mall/core/models/user.dart';
import 'package:virtual_mall/core/services/business_quotation/base_business_quotation.dart';
import 'package:virtual_mall/core/services/business_quotation/business_quotation.dart';
import 'package:virtual_mall/core/viewmodels/base_model.dart';

class QuotationMessagesListModel extends BaseModel {
  String groupChatId;


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
      getMessages();
      notifyListeners();
    }
  }

  void setChatReferences(){
    if (_user.id.hashCode <= _business.id.hashCode) {
      groupChatId = '${_user.id}-${_business.id}';
    } else {
      groupChatId = '${_business.id}-${_user.id}';
    }
  }

  Stream<List<QuotationMessage>> _quotationMessages;

  Stream<List<QuotationMessage>> get quotationMessages => _quotationMessages;


  void getMessages() {
    if (state == ViewState.Busy) {
      throw StateError(
          "fetching posts again when the current request haven't finished");
    }
    setState(ViewState.Busy);
    _quotationMessages = _service.getQuotationMessages(groupChatId, _business.id);
    setState(ViewState.Idle);
  }
}