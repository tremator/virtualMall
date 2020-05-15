import 'package:cloud_firestore/cloud_firestore.dart';

class QuotationMessage {
  final int type;
  final String content;
  final String idFrom;
  final bool pending;

  const QuotationMessage(this.type, this.content, this.idFrom, this.pending);

  factory QuotationMessage.fromDocument(DocumentSnapshot document) {
    int type = document['type'] != null ? document['type'] : 1;
    String content = document['content'] != null
        ? document['content']
        : 'Cant read message';
    String idFrom = document['idFrom'] != null ? document['idFrom'] : '';
    bool pending = document['pending'] != null ? document['pending'] : false;

    return QuotationMessage(type, content, idFrom, pending);
  }
}
