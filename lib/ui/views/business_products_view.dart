import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/models/buy_car.dart';
import 'package:virtual_mall/core/services/business/business_service.dart';
import 'package:virtual_mall/core/viewmodels/business_product_category_model.dart';
import 'package:virtual_mall/core/viewmodels/business_product_products_model.dart';
import 'package:virtual_mall/ui/shared/app_colors.dart';
import 'package:virtual_mall/ui/widgets/product_categories.dart';
import 'package:virtual_mall/ui/widgets/product_products.dart';

part 'business_products_view.g.dart';

@widget
Widget businesssProductsview(BuildContext context) {
  final business = Provider.of<Business>(context);
  return MultiProvider(
      providers: [
        
        ChangeNotifierProxyProvider2<Business, BusinessService,
                BusinessProductProductsModel>(
            create: (_) => BusinessProductProductsModel(),
            update: (context, business, api, model) => model
              ..businessService = api
              ..businessId = business.id
              ..business = business),
        ChangeNotifierProxyProvider2<Business, BusinessService,
                BusinessProductCategoryModel>(
            create: (_) => BusinessProductCategoryModel(),
            update: (context, business, api, model) => model
              ..businessService = api
              ..businessId = business.id
              ..businessId)
      ],
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: Text(
              business.name,
            ),
          ),
          body: Column(
            children: <Widget>[
              ProductsCategories(),
              Expanded(
                child: ProductProducts(),
              ),
            ],
          )));
}
