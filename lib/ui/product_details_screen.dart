import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/const/app_colors.dart';
import 'package:flutter_ecommerce/widgets/reuseable_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetailsScreen extends StatefulWidget {
  var _product;
  ProductDetailsScreen(this._product);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screen_color,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(9.0),
            child: CircleAvatar(
              backgroundColor: Colors.red,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
          ),
          actions: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-favorite-items")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("items")
                  .where("name", isEqualTo: widget._product['product-name'])
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Text("");
                }

                return Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: IconButton(
                      onPressed: () {
                        snapshot.data.docs.length == 0
                            ? addToFavorite()
                            : Fluttertoast.showToast(msg: "Already Added");
                      },
                      icon: snapshot.data.docs.length == 0
                          ? const Icon(
                              Icons.favorite_outline,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                    ),
                  ),
                );
              },
            ),
          ]),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: CarouselSlider(
                    items: widget._product["product-img"].map<Widget>((item) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(item), fit: BoxFit.fill)),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 300,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      onPageChanged: (value, carouselPageChangeReason) {
                        setState(() {});
                      },
                      scrollDirection: Axis.horizontal,
                    )),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReuseableText(widget._product["product-name"], 20,
                      Colors.white, FontWeight.bold),
                  SizedBox(
                    height: 8.h,
                  ),
                  ReuseableText("\৳ " + widget._product["product-price"], 18,
                      Colors.white, FontWeight.normal),
                  SizedBox(
                    height: 8.h,
                  ),
                  ReuseableText(widget._product["product-description"], 18,
                      Colors.white, FontWeight.normal),
                ],
              ),
            ),
            SizedBox(
              height: 150.h,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-cart-items")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("items")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                return GestureDetector(
                  onTap: () {
                    snapshot.data!.docs.length == 0
                        ? addToCart()
                        : Fluttertoast.showToast(msg: "Already added to cart");
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: Colors.red),
                    child: Center(
                        child: ReuseableText("Add To Cart", 20, Colors.white,
                            FontWeight.normal)),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var _currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-cart-items");
    return _collectionRef
        .doc(_currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._product["product-name"],
      "price": widget._product["product-price"],
      "images": widget._product["product-img"],
    }).then((value) {
      return Fluttertoast.showToast(msg: "Added Cart");
    });
  }

  Future addToFavorite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var _currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-favorite-items");
    return _collectionRef
        .doc(_currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._product["product-name"],
      "price": widget._product["product-price"],
      "images": widget._product["product-img"],
    }).then((value) {
      return Fluttertoast.showToast(msg: "Added to favorite");
    });
  }
}
