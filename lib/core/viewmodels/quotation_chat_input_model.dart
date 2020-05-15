import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/models/upload_image_response.dart';
import 'package:virtual_mall/core/models/user.dart';
import 'package:virtual_mall/core/services/business_quotation/business_quotation.dart';
import 'package:virtual_mall/core/viewmodels/base_model.dart';

class QuotationChatInputModel extends BaseModel {
  String groupChatId;
  final TextEditingController textEditingController =
      new TextEditingController();
  ScrollController _scrollController;
  set scrollController(ScrollController scrollController){
    _scrollController = scrollController;
  }

  BusinessQuotation _service;
  BusinessQuotation get businessService => _service;
  set businessService(BusinessQuotation service) {
    _service = service;
    notifyListeners();
  }

  User _user;
  User get user => _user;
  set user(User user) {
    if (_user != user) {
      _user = user;
      notifyListeners();
    }
  }

  Business _business;
  Business get business => _business;
  set business(Business business) {
    if (_business != business) {
      _business = business;
      setChatReferences();
      notifyListeners();
    }
  }

  void setChatReferences() {
    if (_user.id.hashCode <= _business.id.hashCode) {
      groupChatId = '${_user.id}-${_business.id}';
    } else {
      groupChatId = '${_business.id}-${_user.id}';
    }
  }

  Future getImage() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    if(imageFile == null)
      return;

    File newImage = await testCompressAndGetFile(imageFile);
    if (imageFile != null && newImage != null) {
      String documentID = await _service.onSendPendingImage("pending", 1, groupChatId, _user.id, _business.id, true);
      UploadImageResponse uploadImageResponse = await _service.uploadFile(
          newImage);
      if (uploadImageResponse.success)
        _service.updatePendingImage(uploadImageResponse.downloadUrl, 1, groupChatId, _user.id, _business.id, documentID);
      else {
        _service.removeMessage(groupChatId, _business.id, documentID);
        Fluttertoast.showToast(msg: 'Error uploading image');
      }
    } else {
      Fluttertoast.showToast(msg: 'Error uploading image');
    }

    _scrollList();
  }

  Future<File> testCompressAndGetFile(File file) async {
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = dir.absolute.path + "/temp.png";
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        format: CompressFormat.png,
        quality: 94, minHeight: 300, minWidth: 300);

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  void onSendMessage(String text, int type) async {
    if (text.trim() != '') {
      textEditingController.clear();
      _service.onSendMessage(text, type, groupChatId, _user.id, _business.id);
     _scrollList();
    }
  }

  void _scrollList(){
    if(_scrollController != null)
      _scrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }
}
