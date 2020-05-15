


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_mall/core/models/bussiness_product_products.dart';

class BuyCar {
  String _id; // this Id is equal to the user Id
  List<BusinessProductProducts> _products;
  String _totalAmount;
  String _totalProducts;
  String _tax;
  // ignore: unnecessary_getters_setters
  String get id => _id;
// ignore: unnecessary_getters_setters
  set id(String value) {
    _id = value;
  }
// ignore: unnecessary_getters_setters
  List<BusinessProductProducts> get products => _products;
// ignore: unnecessary_getters_setters
  set products(List<BusinessProductProducts> value) {
    _products = value;
  }
// ignore: unnecessary_getters_setters
  String get totalAmount => _totalAmount;
// ignore: unnecessary_getters_setters
  set totalAmount(String value) {
    _totalAmount = value;
  }
// ignore: unnecessary_getters_setters
  String get totalProducts => _totalProducts;
// ignore: unnecessary_getters_setters
  set totalProducts(String value) {
    _totalProducts = value;
  }
// ignore: unnecessary_getters_setters
  String get tax => _tax;
// ignore: unnecessary_getters_setters
  set tax(String value) {
    _tax = value;
  }
  BuyCar(this._id, this._products, this._totalAmount, this._totalProducts,
      this._tax);


  BuyCar.initial()
      : _id = '',
        _products = List<BusinessProductProducts>(),
        _totalAmount = '',
        _totalProducts = '',
        _tax = '';
  factory BuyCar.fromDocument(DocumentSnapshot document) {
    String tax = document['tax'] != null ? document['tax'] : '';
    String totalAmount =
    document['total_a_pagar'] != null ? document['total_a_pagar'] : '0';
    String totalProducts =
    document['total_productos'] != null ? document['total_productos'] : '0';
    return BuyCar(document.documentID, null, totalAmount, totalProducts, tax);
  }
}