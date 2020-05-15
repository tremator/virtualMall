import 'package:cloud_firestore/cloud_firestore.dart';

class Business{
  final String id;
  final String name;
  final String email;
  final String image;
  final List<String> carouselImages;
  final String address;
  final String phoneNumber;
  final String webPage;
  final String mainFood;
  final List<String> dishes;
  final String caracteristic;

  const Business(
      {this.id,
      this.name,
      this.email,
      this.image,
      this.carouselImages,
      this.address,
      this.phoneNumber,
      this.webPage,
      this.mainFood,
      this.dishes,
      this.caracteristic});

  const Business.initial():
        id = null,
        name = '',
        email = '',
        image = '',
        carouselImages = null,
        address = '',
        phoneNumber = '',
        webPage = '',
        mainFood = '',
        dishes = null,
        caracteristic = '';

  factory Business.fromDocument(DocumentSnapshot document) {
    String name = document['name'] != null ? document['name'] : '';
    String email = document['email'] != null ? document['email'] : '';
    String profileImage =
        document['profileImage'] != null ? document['profileImage'] : '';
    List<String> carouselImages = document['carouselImages'] != null
        ? List.from(document['carouselImages'])
        : <String>[document['profileImage']];
    String address = document['address'] != null ? document['address'] : '';
    String phoneNumber =
        document['phoneNumber'] != null ? document['phoneNumber'] : '';
    String webPage = document['webPage'] != null ? document['webPage'] : '';
    String mainFood = document['mainFood'] != null ? document['mainFood'] : '';
    String caracteristic =
        document['caracteristic'] != null ? document['caracteristic'] : '';

    List<String> dishes = document['dishes'] != null
        ? List.from(document['dishes'])
        : <String>[""];


    return Business(
        id: document.documentID,
        name: name,
        email: email,
        image: profileImage,
        carouselImages: carouselImages,
        address: address,
        phoneNumber: phoneNumber,
        webPage: webPage,
        mainFood: mainFood,
        dishes: dishes,
        caracteristic: caracteristic);
  }
}
