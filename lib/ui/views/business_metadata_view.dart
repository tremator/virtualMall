import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_mall/core/models/business.dart';
import 'package:virtual_mall/translation/app_localizations.dart';
import 'package:virtual_mall/ui/shared/ui_helpers.dart';

class BusinessMetadataView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final business = Provider.of<Business>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(business.name),
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
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
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                    child: Align(
                      alignment: Alignment.center,
                      child: business.carouselImages.length == 1
                          ? Image.network(
                              business.image,
                              fit: BoxFit.fill,
                              height: 250,
                              width: double.infinity,
                            )
                          : CarouselSlider(
                              viewportFraction: 1.0,
                              height: 250,
                              autoPlay: true,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 300),
                              pauseAutoPlayOnTouch: Duration(seconds: 5),
                              items: business.carouselImages.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      child: Image.network(
                                        i,
                                        fit: BoxFit.cover,
                                        height: 200,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: <Widget>[
                          UIHelper.verticalSpace(16),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  color: Color(0xfff6a45a),
                                  highlightColor: Color(0xffd88a43),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .quotationTitle
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14.0),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/businessQuotation',
                                        arguments: business);
                                  },
                                ),
                                flex: 1,
                              ),
                              UIHelper.horizontalSpace(16.0),
                              Expanded(
                                child: OutlineButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Colors.white,
                                  highlightColor: Color(0xfff6a45a),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .call
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: Color(0xffd88a43),
                                        fontSize: 14.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xfff6a45a),
                                    style: BorderStyle.solid,
                                    width: 0.8,
                                  ),
                                  onPressed: () {},
                                ),
                                flex: 1,
                              )
                            ],
                          ),
                          UIHelper.verticalSpace(16),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: Color(0xff707070),
                              ),
                              UIHelper.horizontalSpace(16),
                              Expanded(
                                  child: Text(
                                business.address,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  color: Color(0xff707070),
                                  fontSize: 14.0,
                                ),
                              )),
                            ],
                          ),
                          UIHelper.verticalSpace(16),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    IconTheme(
                                      data: new IconThemeData(
                                          color: Color(0xff707070)),
                                      child: new Icon(
                                        Icons.phone,
                                      ),
                                    ),
                                    UIHelper.horizontalSpace(16),
                                    Text(
                                      business.phoneNumber,
                                      style: TextStyle(
                                        color: Color(0xff707070),
                                        fontSize: 14.0,
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              UIHelper.horizontalSpace(16),
                              Expanded(
                                  flex: 1,
                                  child: Row(children: <Widget>[
                                    IconTheme(
                                      data: new IconThemeData(
                                          color: Color(0xff707070)),
                                      child: new Icon(
                                        Icons.access_time,
                                      ),
                                    ),
                                    UIHelper.horizontalSpace(16),
                                   Expanded(child:
                                   Text(
                                     "6:00 am - 7:00 pm",
                                     maxLines: 2,
                                     overflow: TextOverflow.ellipsis,
                                     style: TextStyle(
                                         color: Color(0xff707070),
                                         fontSize: 14.0),
                                   ),
                                     )

                                  ]))
                            ],
                          ),
                          UIHelper.verticalSpace(16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconTheme(
                                data: new IconThemeData(
                                  color: Color(0xff707070),
                                ),
                                child: new Icon(
                                  Icons.laptop,
                                ),
                              ),
                              UIHelper.verticalSpace(32),
                              Text(
                                "  ${business.webPage}",
                                style: TextStyle(
                                    color: Color(0xff707070),
                                    fontSize: 14,
                                    fontFamily: "Roboto"),
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(0xff707070),
                          ),
                          UIHelper.verticalSpace(16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              UIHelper.horizontalSpaceSmall(),
                              Text(
                                AppLocalizations.of(context)
                                    .foodTypes,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Roboto-Medium",
                                ),
                              ),
                              Text(
                                "${business.mainFood}",
                                style: TextStyle(
                                    color: Color(0xff707070),
                                    fontSize: 14,
                                    fontFamily: "Roboto-Medium"),
                              ),
                              UIHelper.horizontalSpace(16.0),
                              Text(
                                AppLocalizations.of(context)
                                    .foods,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Roboto-Medium",
                                ),
                              ),

                              // ignore: unrelated_type_equality_checks
                              business.dishes == 1
                                  ? Text("")
                                  : Flexible(
                                      child: new Container(
                                          child: Text(
                                      "${StringBuffer(business.dishes.getRange(0, business.dishes.length).toString())}",
                                      style: TextStyle(
                                          color: Color(0xff707070),
                                          fontSize: 14,
                                          fontFamily: "Roboto"),
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            ],
                          ),
                          UIHelper.verticalSpace(16),
                          Text(
                            AppLocalizations.of(context)
                                .characteristics,
                            style: TextStyle(
                                fontFamily: "Roboto-Medium", fontSize: 14),
                          ),
                          UIHelper.verticalSpace(16),
                          Container(
                            child: Text(
                              business.caracteristic,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xff707070),
                                fontSize: 14,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          UIHelper.verticalSpace(16),
                          OutlineButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/businessProducts',
                                  arguments: business);
                            },
                            child: Column(
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)
                                      .showProducts,
                                  style: TextStyle(
                                      color: Color(0xff707070),
                                      fontSize: 14,
                                      fontFamily: "Roboto-Medium"),
                                ),
                                Icon(
                                  Icons.expand_more,
                                  color: Color(0xff707070),
                                )
                              ],
                            ),
                            borderSide: BorderSide(color: Colors.transparent),
                            shape: StadiumBorder(),
                            highlightColor: Colors.white,
                          ),
                          UIHelper.verticalSpace(24),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ))));
  }
}
