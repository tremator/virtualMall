import 'dart:async';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/models/bussiness_product_category.dart';
import 'package:virtual_mall/core/models/bussiness_product_products.dart';
import 'package:virtual_mall/core/services/business/firebase_business.dart';

class BusinessService {
  AppFirebaseBusiness api;
  Stream<List<Business>> _business;
  Stream<List<Business>> get business => _business;

  Stream<List<Business>> getAppBusiness(){
    _business = api.businessMetadata;
    return business;
  }

  Stream<List<BusinessProductCategory>> getBusinessProductCategories(String businessId){
    return api.getBusinessProductCategories(businessId);
  }


  Stream<List<BusinessProductProducts>> getBusinessProductProducts(String businessId){
    return api.getBusinessProductProducts(businessId);
  }


  dispose() {}

}