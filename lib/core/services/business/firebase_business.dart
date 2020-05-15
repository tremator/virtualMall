import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/models/bussiness_product_category.dart';
import 'package:virtual_mall/core/models/bussiness_product_products.dart';
import 'package:virtual_mall/core/services/business/base_business.dart';
import 'package:virtual_mall/keys/keys_model.dart';

class AppFirebaseBusiness implements BaseBusiness {
  final Firestore _firebaseStore = Firestore.instance;

  @override
  Stream<List<Business>> get businessMetadata => _firebaseStore
      .collection("app/${keys.appKey}/business")
      .snapshots()
      .map((snapshot) => snapshot.documents
          .map((document) => Business.fromDocument(document))
          .toList());

  @override
  Keys keys;

  @override
  Stream<List<BusinessProductCategory>> getBusinessProductCategories(
      String businessId) {
    return _firebaseStore
        .collection("app/${keys.appKey}/business/$businessId/categories")
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((document) => BusinessProductCategory.fromDocument(document))
            .toList());
  }

  Stream<List<BusinessProductProducts>> getBusinessProductProducts(
      String businessId) {
    return _firebaseStore
        .collection("app/${keys.appKey}/business/$businessId/products")
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((document) => BusinessProductProducts.fromDocument(document))
            .toList());
  }
}
