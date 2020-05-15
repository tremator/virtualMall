import 'dart:async';
import 'dart:io';

import 'package:virtual_mall/core/models/quotation_chat_message.dart';
import 'package:virtual_mall/core/models/upload_image_response.dart';

import 'firebase_business_quotation.dart';

class BusinessQuotation {
  FirebaseBusinessQuotation _firebaseBusinessQuotation;
  set firebaseBusinessQuotation(FirebaseBusinessQuotation service) {
    _firebaseBusinessQuotation = service;
  }
  Stream<List<QuotationMessage>> _business;
  Stream<List<QuotationMessage>> get business => _business;
  StreamController<List<QuotationMessage>> _userController = StreamController<List<QuotationMessage>>();

  Stream<List<QuotationMessage>> getQuotationMessages(String groupChatId, String businessId) {
    return _firebaseBusinessQuotation.getQuotationMessages(groupChatId, businessId);
  }

  dispose() {
    _userController.close();
  }

  Future writeWrittenWith(String id, String peerId) async {
    return _firebaseBusinessQuotation.writeWrittenWith(id, peerId);
  }

  Future<UploadImageResponse> uploadFile(File imageFile) {
     return _firebaseBusinessQuotation.uploadFile(imageFile);
  }

  void onSendMessage(String text, int type, groupChatId, fromId, toId) async {
    await _firebaseBusinessQuotation.writeMessage(text, type, groupChatId, fromId, toId);
  }

  Future<String> onSendPendingImage(String text, int type, groupChatId, fromId, toId, bool pending) async {
    return await _firebaseBusinessQuotation.writeMessage(text, type, groupChatId, fromId, toId, pending);
  }

  void updatePendingImage(String downloadUrl, int type, String groupChatId, String fromId, String toId, String documentID) {
    _firebaseBusinessQuotation.updateMessage(downloadUrl, type, groupChatId, fromId, toId, documentID, false);
  }

  void removeMessage(String groupChatId, String toId, String documentID) {
    _firebaseBusinessQuotation.removeMessage(groupChatId, toId, documentID);
  }
}