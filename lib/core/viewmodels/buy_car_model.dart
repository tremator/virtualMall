



import 'dart:async';

import 'package:virtual_mall/core/models/bussiness_product_products.dart';
import 'package:virtual_mall/core/models/buy_car.dart';
import 'package:virtual_mall/core/models/user.dart';
import 'package:virtual_mall/core/services/buyCar/buy_car_service.dart';
import 'package:virtual_mall/core/viewmodels/base_model.dart';

class BuyCarModel extends BaseModel{
  BuyCarService _service;
  User _user;
  BuyCar _car = BuyCar.initial();

  User get user => _user;

  set user(User user){
    _user = user;
    car.id = user.id;
    getUserCart();
    notifyListeners();
  }
  
  BuyCarService get service => _service;

  set service(BuyCarService service){
    _service = service;
    notifyListeners();
  }

  BuyCar get car =>_car;

  set car (BuyCar car){
    _car = car;
    notifyListeners();
  }

  void addItem(BusinessProductProducts product){
    bool validacion = false;
    if(car.products == null){
      List<BusinessProductProducts> listTemp = new List();
      listTemp.add(product);
      car.products = listTemp;
      getTotalPrice();
      notifyListeners();
    }else{
      for(int i=0; i<_car.products.length;i++){
        if(product.id == _car.products[i].id){
          _car.products[i] = product;
          validacion = true;
          getTotalPrice();
          notifyListeners();
          break;
        }
      }

      if(!validacion){
        _car.products.add(product);
        notifyListeners();
      }
    }

  } 

  
  double getTotalPrice(){
    double price  = 0;
    if(_car.products.isNotEmpty){
      _car.products.forEach((product){
        price += double.parse(product.price) * product.amount; 
      });
      _car.totalAmount = price.toString();
      notifyListeners();
    }
    return price;
  }

  
  int getTotalItems(){
    int amount  = 0;

    if(_car.products.isEmpty){
      return 0;
    }else{
      _car.products.forEach((product){
        amount+= product.amount;
      });
      return amount;
    }
  }
  void deleteItem(BusinessProductProducts product){

    service.deleteProductInCart(product.id, user.id);
    notifyListeners();
    
  }
  void getCartProducts(){
    service.getProductsInCart(car.id).listen((data){
      car.products.clear();
      car.products.addAll(data);
    });
  }
  void getUserCart(){
    service.loadCart(user.id);
    service.cartController.stream.listen((data){
      car = data;
    });
  }
}