import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:virtual_mall/core/models/bussiness_product_products.dart';
import 'package:virtual_mall/core/models/buy_car.dart';
import 'package:virtual_mall/core/services/buyCar/base_buy_car.dart';

class AppFirebaseBuyCar extends BaseCart {
  @override
  // TODO: implement cartMetadata
  Stream<List<BuyCar>> get cartMetadata => null;
  final Firestore _fireStore = Firestore.instance;
  StreamSubscription<QuerySnapshot> streamSub;
  // ignore: cancel_subscriptions
  StreamSubscription<DocumentSnapshot> cartStreamSub;
  BuyCar _cart = BuyCar.initial();
  StreamController<BuyCar> cartController = new StreamController();
  StreamController<List<BusinessProductProducts>> productInCartController = new StreamController();
  Stream<BuyCar> getCart(String userId) {
    cartController.close();
    cartController = StreamController<BuyCar>.broadcast();
    streamSub?.cancel();
    streamSub = _fireStore
        .collection('user-carts/$userId/products/')
        .snapshots()
        .listen((onData) {
      List<BusinessProductProducts> newList = List();
      onData.documents
          .forEach((document) => newList.add(BusinessProductProducts.fromDocument(document)));
      _cart.products = newList;
      cartController.add(_cart);
    });
    return cartController.stream;
  }
  Future<bool> insertProductInCart(BusinessProductProducts product, String userId) async {
    return await Firestore.instance
        .collection('user-carts')
        .document(userId)
        .collection('products')
        .document(product.id)
        .setData({
      'amount': product.amount.toString(),
      'description': product.description,
      'details': product.details,
      'img': product.img,
      'name': product.name,
      'price': product.price,
      'categories': product.categories,
      'id_business' : product.business.id
    }).then((value) {
      return true;
    }).catchError((error) {
      debugPrint("Something went wrong + $error");
      return false;
    });
  }
  Stream<List<BusinessProductProducts>> getProductsInCart(String idCart) {
    streamSub?.cancel();
    productInCartController?.add([]);
    productInCartController = new StreamController();
    streamSub = _fireStore
        .collection('cart-users/$idCart/products')
        .snapshots()
        .listen((onData) {
      productInCartController.add(onData.documents
          .map((document) => BusinessProductProducts.fromDocument(document))
          .toList());
    });
    return productInCartController.stream;
  }
  Future<bool> deleteProductInCart(String productId, String id) async {
    try {
      await Firestore.instance
          .collection('user-carts')
          .document(id)
          .collection('products')
          .document(productId)
          .delete();
      return true;
    } catch (ex) {
      return false;
    }
  }
  Future<bool> deleteCart(String userId) async{
    try{
      await Firestore.instance
          .collection('user-carts')
          .document(userId)
          .delete();
      return true;
    }catch(e){
      return false;
    }
  }
}