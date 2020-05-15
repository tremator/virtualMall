import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:virtual_mall/core/enums/viewstate.dart';
import 'package:virtual_mall/core/models/bussiness_product_products.dart';
import 'package:virtual_mall/core/viewmodels/business_product_products_model.dart';
import 'package:virtual_mall/translation/app_localizations.dart';
import 'package:virtual_mall/ui/shared/ui_helpers.dart';

part 'product_products.g.dart';

@widget
Widget productProducts(BuildContext context) {
  BusinessProductProductsModel model =
      Provider.of<BusinessProductProductsModel>(context);
  return model.state == ViewState.Busy
      ? const Center(child: CircularProgressIndicator())
      : Container(
          padding: EdgeInsets.all(16.0),
          child: model.filteredProductList.length == 0
              ? Center(child: Text(AppLocalizations.of(context).notProducts))
              : ListView.builder(
                  itemCount: model.filteredProductList.length,
                  itemBuilder: (context, index) {
                    final BusinessProductProducts product =
                        model.filteredProductList[index];

                    return Provider<BusinessProductProducts>.value(
                      key: ValueKey(product.id),
                      value: product,
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
                                  width: 130.0,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(product.img)),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20)),
                                    color: Color(0xff676767),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 120,
                                    padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            product.name,
                                            style: TextStyle(
                                              fontFamily: "Robot",
                                              fontSize: 14.0,
                                              color: Color(0xff707070),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          alignment: Alignment.topCenter,
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
                                              color: Color(0xfff6a45a),
                                              highlightColor: Color(0xffd88a43),
                                              child: Text(
                                                AppLocalizations.of(context)
                                                    .details.toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.0),
                                              ),
                                              onPressed: () {
                                               product.business = model.business;
                                                Navigator.pushNamed(context, '/productDetail',arguments: product);
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
                  }));
}
