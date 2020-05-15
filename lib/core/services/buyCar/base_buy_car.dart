


import 'package:virtual_mall/core/models/buy_car.dart';

abstract class BaseCart {
  Stream<List<BuyCar>> get cartMetadata;
}