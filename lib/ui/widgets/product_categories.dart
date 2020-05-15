import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:virtual_mall/core/models/bussiness_product_category.dart';
import 'package:virtual_mall/core/viewmodels/business_product_category_model.dart';
import 'package:virtual_mall/core/viewmodels/business_product_products_model.dart';
import 'package:virtual_mall/translation/app_localizations.dart';

part 'product_categories.g.dart';

@widget
Widget productsCategories(BuildContext context) {
  BusinessProductCategoryModel model =
      Provider.of<BusinessProductCategoryModel>(context);
  return StreamBuilder<List<BusinessProductCategory>>(
          stream: model.businessProductCategories,
          builder: (BuildContext context,
              AsyncSnapshot<List<BusinessProductCategory>> snapshot) {
            final int messageCount = snapshot.data == null ? 1 : snapshot.data.length + 1;

            return Container(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: messageCount,
                itemBuilder: (context, index) {
                  final BusinessProductCategory category = index == 0
                      ? BusinessProductCategory(
                          id: 'local', name: AppLocalizations.of(context).all)
                      : snapshot.data[index - 1];

                  return Provider<BusinessProductCategory>.value(
                    key: ValueKey(category.id),
                    value: category,
                    // it's not necessary to move the click handler to PostListItem
                    // but this allows to use a const constructor, which is better for performance.
                    // this way, only the item that changes rebuilds. Not the whole list.
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        child: model.selectedCategoryId != category.id
                            ? SizedBox(
                                child: ButtonTheme(
                                  minWidth: 99.9,
                                  child: OutlineButton(
                                    textColor: Color(0xffffffff),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    highlightColor: Color(0xfff6a45a),
                                    child: Text(category.name,
                                        style: model.selectedCategoryId !=
                                                category.id
                                            ? TextStyle(
                                                color: Color(0xffd88a43),
                                                fontSize: 14.0)
                                            : TextStyle(
                                                color: Color(0xffffffff),
                                                fontSize: 14.0)),
                                    borderSide: BorderSide(
                                      color: Color(0xfff6a45a),
                                      style: BorderStyle.solid,
                                      width: 0.8,
                                    ),
                                    onPressed: () {
                                      model.selectedCategoryId = category.id;
                                      Provider.of<BusinessProductProductsModel>(
                                              context)
                                          .setCategoryProducts(category.id);
                                    },
                                  ),
                                ),
                              )
                            : SizedBox(
                                child: ButtonTheme(
                                  minWidth: 99.9,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color: Color(0xffd88a43),
                                    child: Text(
                                      category.name,
                                      style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontSize: 14.0),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                      ),
                    ),
                  );
                },
                padding: const EdgeInsets.all(16.0),
              ),
            );
          },
        );
}
