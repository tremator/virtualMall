import 'dart:async';
import 'package:virtual_mall/core/enums/viewstate.dart';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/models/bussiness_product_products.dart';
import 'package:virtual_mall/core/services/business/business_service.dart';
import 'package:virtual_mall/core/viewmodels/base_model.dart';

class BusinessProductProductsModel extends BaseModel {
  BusinessService _service;

  Business business;

  String _selectedProductId = "";

  String get selectedProductId => _selectedProductId;
  String _selectedCategoryId = "";

  String get selectedCategoryId => _selectedCategoryId;
  List<BusinessProductProducts> _filteredProductList = new List();

  List<BusinessProductProducts> get filteredProductList => _filteredProductList;
  List<BusinessProductProducts> temporal = List();

  set selectedCategoryId(String categoryId) {
    _selectedCategoryId = categoryId;
    setCategoryProducts(_selectedCategoryId);
  }

  void setCategoryProducts(String categoryId) {
    loadCategoryProducts(categoryId);
    notifyListeners();
  }

  set selectedProductId(String productId) {
    if (productId != selectedProductId) {
      _selectedProductId = productId;
      notifyListeners();
    }
  }

  set businessService(BusinessService service) {
    _service = service;
    notifyListeners();
  }

  String _businessId;
  String _categoryId;

  String get categoryId => _categoryId;

  String get businessId => _businessId;

  set businessId(String businessId) {
    if (businessId != _businessId) {
      _businessId = businessId;
      getProductProducts(businessId);
      notifyListeners();
    }
  }

  Stream<List<BusinessProductProducts>> _businessProductProducts;

  Stream<List<BusinessProductProducts>> get businessProductProducts =>
      _businessProductProducts;

  void getProductProducts(String businessId) {
    if (state == ViewState.Busy) {
      throw StateError(
          "fetching posts again when the current request haven't finished");
    }
    setState(ViewState.Busy);
    _businessProductProducts = _service.getBusinessProductProducts(businessId);
    _businessProductProducts.listen((data) {
      temporal.clear();
      temporal.addAll(data);
      loadCategoryProducts(_selectedCategoryId);
    });

    setState(ViewState.Idle);
  }

  void loadCategoryProducts(String categoryId) async {
    setState(ViewState.Busy);
    _filteredProductList.clear();

    if (categoryId == "local" || categoryId == "") {
      _filteredProductList.addAll(temporal);
    } else {
      for (BusinessProductProducts product in temporal) {
        for (String category in product.categories) {
          if (category.contains(categoryId)) {
            _filteredProductList.add(product);
          }
        }
      }
    }

    notifyListeners();
    setState(ViewState.Idle);
  }
  
}
