


import 'package:virtual_mall/core/models/bussiness_product_products.dart';
import 'package:virtual_mall/core/viewmodels/base_model.dart';

class ProductModel extends BaseModel{

  BusinessProductProducts _product;

  ProductModel (BusinessProductProducts products){
    _product = products;
  }

  set product( BusinessProductProducts product){
    product = product;
    notifyListeners();
  }
  BusinessProductProducts get product => _product;

  void add (int cantidad){
    _product.amount = _product.amount+cantidad;
    notifyListeners();
  }
  void rest (int cantidad){
    _product.amount = _product.amount-cantidad;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

}