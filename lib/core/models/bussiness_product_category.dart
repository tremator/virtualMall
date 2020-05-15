import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessProductCategory {
  final String id;
  final String name;


  const BusinessProductCategory({this.id, this.name});

  const BusinessProductCategory.initial()
      : id = null,
        name = '';

  factory BusinessProductCategory.fromDocument(DocumentSnapshot document) {
    String name = document['name'] != null ? document['name'] : '';


    return BusinessProductCategory(
        id: document.documentID,
        name: name);
  }
}
