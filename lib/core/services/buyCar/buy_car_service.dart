import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/models/bussiness_product_products.dart';
import 'package:virtual_mall/core/models/buy_car.dart';

import 'firebase_buy_car.dart';



class BuyCarService {
  AppFirebaseBuyCar _api;
  StreamController<BuyCar> cartController = BehaviorSubject();
  StreamSubscription streamSubscription;
  String _lastUserId;
  set api(AppFirebaseBuyCar value) {
    _api = value;
  }
  loadCart(String userId, Business business, {bool force = false}) async {
    if (userId != _lastUserId || force) {
      _lastUserId = userId;
      streamSubscription?.cancel();
      streamSubscription = _api.getCart(userId,business).listen((onData) => cartController.add(onData));
    }
  }
  Stream<BuyCar> get cart => cartController.stream;
  Future<bool> insertProductInCart(BusinessProductProducts product, String userId) async {
    return _api.insertProductInCart(product, userId);
  }
  Stream<List<BusinessProductProducts>> getProductsInCart(String idCart, Business business) {
    return _api.getAllProductsInCart(idCart, business);
  }
  Future<bool> deleteProductInCart(String product, String idCart) {
    return _api.deleteProductInCart(product, idCart);
  }
  Future<bool> deleteCart(String userId)async {
    return await _api.deleteCart(userId);
  }
}