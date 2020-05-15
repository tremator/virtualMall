import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:virtual_mall/core/enums/viewstate.dart';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/core/viewmodels/home_model.dart';
import 'package:virtual_mall/translation/app_localizations.dart';
import 'package:virtual_mall/ui/shared/app_colors.dart';
import 'package:virtual_mall/ui/shared/ui_helpers.dart';
import 'package:virtual_mall/ui/widgets/businees_item.dart';

part 'home_view.g.dart';

@widget
Widget homeView(BuildContext context) {
  return Scaffold(
    backgroundColor: backgroundColor,
    body: Consumer<HomeModel>(builder: (context, model, _) {
      return model.state == ViewState.Busy
          ? const Center(child: CircularProgressIndicator())
          : const HomeContent(body: PostList());
    }),
  );
}

@widget
Widget homeContent(BuildContext context, { Widget body}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      UIHelper.verticalSpace(60),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DefaultTextStyle.merge(
            child: Text(
              AppLocalizations.of(context)
                  .associatedBusiness,
            ),
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
                color: homeTitleColor),
          ),
        ],
      ),
      UIHelper.verticalSpace(36),
      Expanded(child: body),
    ],
  );
}

@widget
Widget postList(BuildContext context) {
  final homeModel = Provider.of<HomeModel>(context);

  return OrientationBuilder(builder: (context, orientation) {
    return StreamBuilder<List<Business>>(
      stream: homeModel.appBusiness,
      builder: (BuildContext context, AsyncSnapshot<List<Business>> snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final int messageCount = snapshot.data.length;
        return StaggeredGridView.countBuilder(
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          crossAxisCount: 4,
          itemCount: messageCount,
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          itemBuilder: (context, index) {
            final Business business = snapshot.data[index];
            return Provider<Business>.value(
                key: ValueKey(business.id),
                value: business,
                // it's not necessary to move the click handler to PostListItem
                // but this allows to use a const constructor, which is better for performance.
                // this way, only the item that changes rebuilds. Not the whole list.
                child: const BusinessListItem());
          },
          padding: const EdgeInsets.all(16.0),
        );
      },
    );
  });
}
