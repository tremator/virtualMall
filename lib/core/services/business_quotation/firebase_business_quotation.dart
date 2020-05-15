import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:virtual_mall/core/models/quotation_chat_message.dart';
import 'package:virtual_mall/core/models/upload_image_response.dart';
import 'package:virtual_mall/core/services/business_quotation/base_business_quotation.dart';
import 'package:virtual_mall/keys/keys_model.dart';

class FirebaseBusinessQuotation implements BaseNewBusinessQuotation{
  final Firestore _firebaseStore = Firestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  void writeWrittenWith(String id, String peerId) {
    Firestore.instance.collection('users').document(id).updateData({'chattingWith': peerId});
  }

  @override
  Stream<List<QuotationMessage>> getQuotationMessages(String groupChatId, String businessId) {
    return _firebaseStore
        .collection('app/${keys.appKey}/business/$businessId/messages')
        .document(groupChatId)
        .collection(groupChatId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snaspshot) => snaspshot.documents
        .map((document) => QuotationMessage.fromDocument(document))
        .toList());
  }

  Future<UploadImageResponse> uploadFile(File imageFile) async{
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      StorageReference reference = _firebaseStorage.ref().child(fileName);
      StorageUploadTask uploadTask = reference.putFile(imageFile);
      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      String downLoadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      if(downLoadUrl == null)
          return UploadImageResponse(false, "");

      return UploadImageResponse(true, downLoadUrl);
  }

  @override
  Future<String> writeMessage(String content, int type, String groupChatId, String fromId, String toId, [bool pending = false]) async {
    if (content.trim() != '') {
      var documentReference = _firebaseStore
          .collection("app/${keys.appKey}/business/$toId/messages")
          .document(groupChatId)
          .collection(groupChatId)
          .document(DateTime
          .now()
          .millisecondsSinceEpoch
          .toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom': fromId,
            'idTo': toId,
            'timestamp': DateTime
                .now()
                .millisecondsSinceEpoch,
            'pending': pending,
            'content': content,
            'type': type
          },
        );
      });

      return documentReference.documentID;
    }

    return null;
  }

  @override
  Future<String> updateMessage(String content, int type, String groupChatId, String fromId, String toId, String documentID, [bool pending = false]) async {
    if (content.trim() != '') {
      var documentReference = _firebaseStore
          .collection("app/${keys.appKey}/business/$toId/messages")
          .document(groupChatId)
          .collection(groupChatId)
          .document(documentID);

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom': fromId,
            'idTo': toId,
            'timestamp': DateTime
                .now()
                .millisecondsSinceEpoch,
            'pending': pending,
            'content': content,
            'type': type
          },
        );
      });

      return documentReference.documentID;
    }

    return null;
  }

  @override
  void removeMessage(String groupChatId, String toId, String documentID) async {
      var documentReference = _firebaseStore
          .collection("app/${keys.appKey}/business/$toId/messages")
          .document(groupChatId)
          .collection(groupChatId)
          .document(documentID);
      documentReference.delete();
  }


  @override
  Keys keys;
}