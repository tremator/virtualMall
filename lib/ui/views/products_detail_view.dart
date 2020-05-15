import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/models/bussiness_product_products.dart';
import 'package:virtual_mall/core/models/buy_car.dart';
import 'package:virtual_mall/core/models/user.dart';
import 'package:virtual_mall/core/services/business/business_service.dart';
import 'package:virtual_mall/core/services/buyCar/buy_car_service.dart';
import 'package:virtual_mall/core/viewmodels/product_model.dart';
import 'package:virtual_mall/translation/app_localizations.dart';
import 'package:virtual_mall/ui/shared/app_colors.dart';
import 'package:virtual_mall/ui/shared/ui_helpers.dart';


class ProductDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BusinessProductProducts product =
        Provider.of<BusinessProductProducts>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProxyProvider<BusinessProductProducts, ProductModel>(
          create: (_) => ProductModel(product),
          update: (context, product, model) => model..product = product,
        ),
      ],
      child: Consumer3<ProductModel, BuyCarService, User>(
        builder: (context, model, service, user, child) => (Scaffold(
            appBar: AppBar(
              title: Center(child: Text(model.product.name)),
              actions: <Widget>[
                IconButton(
                 icon: Icon(Icons.shopping_cart),
                 onPressed: () {
                   Navigator.pushNamed(context, '/buycar',arguments: product.business);
                 },
                ),
                SizedBox(
                  width: 20.0,
                )
              ],
            ),
            backgroundColor: Color(0xffebebed),
            body: Center(
                child: SingleChildScrollView(
                    child: Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                margin: EdgeInsets.only(
                    top: 17.0, left: 16.0, right: 16.0, bottom: 17.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        FadeInImage(
                          image: NetworkImage(model.product.img),
                          placeholder:
                              AssetImage('images/img_not_available.jpge'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text('Description',
                                  style: TextStyle(fontSize: 20.0)),
                            ),
                            UIHelper.verticalSpaceMedium(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(model.product.name + ':'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(model.product.description),
                            )
                          ],
                        ),
                        Divider(
                          thickness: 2.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text('Detail',
                                  style: TextStyle(fontSize: 20.0)),
                            ),
                            UIHelper.verticalSpaceMedium(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                model.product.details,
                                textAlign: TextAlign.justify,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text('Price: ₡ ${model.product.price}',
                                  style: TextStyle(fontSize: 20.0)),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {
                                      model.rest(1);
                                    },
                                    icon: Icon(Icons.remove_circle_outline),
                                  ),
                                  Text(model.product.amount.toString()),
                                  IconButton(
                                    onPressed: () {
                                      model.add(1);
                                    },
                                    icon: Icon(Icons.add_circle_outline),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          alignment: Alignment.bottomCenter,
                          child: ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width * 0.8,
                            child: RaisedButton(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Color(0xfff6a45a),
                                highlightColor: Color(0xffd88a43),
                                child: Text(
                                  'Add To Car', 
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                onPressed: product.amount == 0
                                    ? null
                                    : () {
                                        service.insertProductInCart(
                                            product, user.id);
                                        Navigator.pushNamed(context, '/buycar',
                                            arguments: product.business);
                                      }),
                          ),
                        ),
                        UIHelper.verticalSpaceMedium()
                      ],
                    ),
                  ),
                ),
              ),
            ))))),
      ),
    );
  }
}
