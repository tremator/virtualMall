import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_mall/core/models/business.dart';

class BusinessProductProducts {
  final String id;
  final String name;
  final List<String> categories;
  final String img;
  final String details;
  final String description;
  final String price;
  Business business;
  int amount;


  
  BusinessProductProducts(
      {this.id, this.name, this.categories, this.img, this.details, this.description, this.price, this.amount});

  BusinessProductProducts.initial()
      : id = null,
        name = '',
        categories = null,
        img = '',
        details = '',
        description = '',
        price = '',
        amount = 0;
        

        
        

  factory BusinessProductProducts.fromDocument(DocumentSnapshot document) {
    String name = document['name'] != null ? document['name'] : '';
    List<String> categories = document['categories'] != null
        ? List.from(document['categories'])
        : <String>[""];
    String img = document['img'] != null ? document['img'] : '';
    String details = document['details'] != null ? document['details'] : '';
    String description  = document['description'] !=null ? document['description'] : '';
    String price = document['price'] !=null ? document['price'] : '';
    int amount = document['amount'] !=null ? int.parse(document['amount']) : 0;

    return BusinessProductProducts(
      id: document.documentID,
      name: name,
      categories: categories,
      img: img,
      details: details,
      description: description,
      price: price,
      amount: amount,
    );

  }
}
