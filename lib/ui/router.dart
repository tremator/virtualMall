import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/models/bussiness_product_products.dart';
import 'package:virtual_mall/core/models/buy_car.dart';
import 'package:virtual_mall/ui/views/business_metadata_view.dart';
import 'package:virtual_mall/ui/views/business_products_view.dart';

import 'package:virtual_mall/ui/views/buy_car_view.dart';
import 'package:virtual_mall/ui/views/full_photo_view.dart';
import 'package:virtual_mall/ui/views/quotation_chat_view.dart';
import 'package:virtual_mall/ui/views/products_detail_view.dart';
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/business':
        var post = settings.arguments as Business;
        return MaterialPageRoute(
          builder: (_) => Provider.value(value: post, child: BusinessMetadataView()),
        );
      case '/businessProducts' :
        var post = settings.arguments as Business;
        return MaterialPageRoute(
          builder: (_) => Provider.value(value: post, child: BusinesssProductsview()),
        );
      case '/businessQuotation':
        var business = settings.arguments as Business;
        return MaterialPageRoute(
          builder: (_) => Provider.value(value: business, child: NewBusinessQuotationView()),
        );
      case '/fullPhoto':
        var url = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => Provider.value(value: url, child: FullPhotoView()),
        );
      
      case '/productDetail':
        var product = settings.arguments as BusinessProductProducts;
        return MaterialPageRoute(
          builder: (_) =>  Provider.value(value: product,  child: ProductDetailView()),
        );
      case '/buycar':
        var car = settings.arguments as Business;
        return MaterialPageRoute(
          builder: (_) =>  Provider<Business>.value(value: car,child: buyCarView(_)), 
        );
      default:
        return null;
    }
  }
}