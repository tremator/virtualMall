import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/models/bussiness_product_category.dart';
import 'package:virtual_mall/keys/keys_model.dart';

abstract class BaseBusiness {
  Keys keys;
  Stream<List<Business>> get businessMetadata;
  Stream<List<BusinessProductCategory>> getBusinessProductCategories(String businessId);
}