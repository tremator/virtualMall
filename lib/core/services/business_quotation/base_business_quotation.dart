import 'dart:io';

import 'package:virtual_mall/core/models/quotation_chat_message.dart';
import 'package:virtual_mall/core/models/upload_image_response.dart';
import 'package:virtual_mall/keys/keys_model.dart';

abstract class BaseNewBusinessQuotation {
  Keys keys;
  void writeWrittenWith(String id, String peerId);
  Future<UploadImageResponse> uploadFile(File imageFile);
  Stream<List<QuotationMessage>> getQuotationMessages(String groupChatId, String businessId);
  Future<String> writeMessage(String content, int type, String groupChatId, String fromId, String toId, [bool pending = false]);
  void removeMessage(String groupChatId, String toId, String documentID);
  Future<String> updateMessage(String content, int type, String groupChatId, String fromId, String toId, String documentID, [bool pending = false]);
}