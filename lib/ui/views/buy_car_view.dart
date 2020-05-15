import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/models/bussiness_product_products.dart';
import 'package:virtual_mall/core/models/user.dart';
import 'package:virtual_mall/core/services/buyCar/buy_car_service.dart';
import 'package:virtual_mall/core/viewmodels/buy_car_model.dart';
import 'package:virtual_mall/translation/app_localizations.dart';
import 'package:virtual_mall/ui/shared/ui_helpers.dart';

@widget
Widget buyCarView(BuildContext context) {
  return ChangeNotifierProxyProvider3<BuyCarService, User, Business,
      BuyCarModel>(
    create: (_) => BuyCarModel(),
    update: (_, api, user, business, model) => model
      ..service = api
      ..business = business
      ..user = user,
    child: Consumer<BuyCarModel>(
        builder: (context, model, _) => Scaffold(
              appBar: AppBar(
                title: Center(
                  child: Text('Buy Car'),
                ),
              ),
              body: model.car.products.isEmpty
                  ? emptyView(model, context)
                  : fillCarView(model, context),
            )),
  );
}

Container fillCarView(BuyCarModel model, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('ARTICLES (${model.getTotalItems()})'),
            Text('TOTAL: ₡${model.getTotalPrice()}')
          ],
        ),
        UIHelper.verticalSpaceMedium(),
        Expanded(
          child: ListView.builder(
              itemCount: model.car.products.length,
              itemBuilder: (BuildContext context, int index) {
                final BusinessProductProducts carItem = model.car.products[index];
                return Provider<BusinessProductProducts>.value(
                  key: ValueKey(carItem.id),
                  value: carItem,
                  // it's not necessary to move the click handler to PostListItem
                  // but this allows to use a const constructor, which is better for performance.
                  // this way, only the item that changes rebuilds. Not the whole list.
                  child: SizedBox(
                    child: Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(carItem.img)),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                color: Color(0xff676767),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 120,
                                padding:
                                    EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            ' ${carItem.amount} x ${carItem.name}',
                                            style: TextStyle(
                                              fontFamily: "Robot",
                                              fontSize: 14.0,
                                              color: Color(0xff707070),
                                            ),
                                          ),
                                        ],
                                      ),
                                      alignment: Alignment.topLeft,
                                    ),
                                    Container(
                                      child: IconButton(
                                        icon: Icon(Icons.clear),
                                        onPressed: () {
                                          model.deleteItem(carItem);
                                        },
                                      ),
                                      alignment: Alignment.topRight,
                                    ),
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      child: ButtonTheme(
                                        minWidth: 140.0,
                                        height: 36.0,
                                        child: RaisedButton(
                                          elevation: 4.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          color: Colors.white,
                                          highlightColor: Colors.black,
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .details
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0),
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/productDetail',
                                                arguments: carItem);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
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
                'Buy',
                style: TextStyle(fontSize: 14.0),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    ),
  );
}

Container emptyView(BuyCarModel model, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('ARTICLES (${model.getTotalItems()})'),
            Text('TOTAL: ₡${model.getTotalPrice()}')
          ],
        ),
        Center(
            child: Column(
          children: <Widget>[
            Image(
              image: AssetImage('images/empty_cart.png'),
            ),
            Text(
              'Su carrito se encuentra vacío, para agregar productos ingrese a nuestra sección de productos.',
              textAlign: TextAlign.center,
            )
          ],
        )),
        Container(
          alignment: Alignment.bottomCenter,
          child: ButtonTheme(
            minWidth: MediaQuery.of(context).size.width * 0.8,
            height: 36.0,
            child: RaisedButton(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Color(0xfff6a45a),
              highlightColor: Colors.black,
              child: Text(
                'SEE PRODUCTS',
                style: TextStyle(color: Colors.black, fontSize: 14.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/businessProducts',
                    arguments: model.business);
              },
            ),
          ),
        )
      ],
    ),
  );
}
