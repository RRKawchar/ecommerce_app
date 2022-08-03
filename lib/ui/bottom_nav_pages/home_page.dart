import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/const/app_colors.dart';
import 'package:flutter_ecommerce/ui/product_details_screen.dart';
import 'package:flutter_ecommerce/ui/search_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late var _dotsPosition = 0;
  final List<String> _carouselImages = [];

  final List _products = [];
  final _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(qn.docs[i]["image"]);
        print(qn.docs[i]["image"]);
      }
    });
    return qn.docs;
  }

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.screen_color,
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: TextFormField(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const SearchScreen()));
                    },
                    readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white54,
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent)),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(0)),
                        borderSide: BorderSide(color: Colors.white)),
                    hintText: "Search Products Here",
                    hintStyle: TextStyle(
                        fontSize: 15.sp, color: Colors.white)),
                  ),
                ),
                SizedBox(height: 10.h),
                AspectRatio(
                  aspectRatio: 3.3,
                  child: CarouselSlider(
                      items: _carouselImages.map((item) {
                        return Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(item),
                                  fit: BoxFit.fitWidth)),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 400,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        onPageChanged: (value, carouselPageChangeReason) {
                          setState(() {
                            _dotsPosition = value;
                          });
                        },
                        scrollDirection: Axis.horizontal,
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                DotsIndicator(
                  dotsCount:
                      _carouselImages.isEmpty ? 1 : _carouselImages.length,
                  position: _dotsPosition.toDouble(),
                  decorator: const DotsDecorator(
                    color: Colors.white, // Inactive color
                    activeColor: Colors.redAccent,
                    activeSize: Size(12, 12),
                    size: Size(8, 8),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                   Expanded(
                     child: GridView.builder(
                         scrollDirection: Axis.horizontal,
                         itemCount: _products.length,
                         gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                             crossAxisCount: 2, childAspectRatio: 1),
                         itemBuilder: (_, index) {
                           return GestureDetector(
                             onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductDetailsScreen(_products[index]))),
                             child: SizedBox(
                               child: Column(
                                 children: [
                                   AspectRatio(
                                       aspectRatio: 1.4,
                                       child: Container(
                                           color: Colors.black,
                                           child: Image.network(
                                             _products[index]["product-img"][0],fit: BoxFit.contain,
                                           ))),
                                   Text("${_products[index]["product-name"]}",style: TextStyle(color: Colors.white),),
                                   Text(
                                     "\৳ ${_products[index]["product-price"].toString()}",style: TextStyle(color: Colors.white),),
                                 ],
                               ),
                             ),
                           );
                         }),
                   ),



                      SizedBox(height: 20.h,),




              ],
            ),
          ),
        ));
  }
}
