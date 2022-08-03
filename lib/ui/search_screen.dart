import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/const/app_colors.dart';
import 'package:flutter_ecommerce/ui/product_details_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var inputText = "";
  late AsyncSnapshot<QuerySnapshot> snap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screen_color,
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
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
              onChanged: (val) {
                setState(() {
                  inputText = val;
                  if(inputText.isEmpty){
                     ListView(
                      children:
                      snap.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                        return Card(
                          elevation: 3,
                          child: ListTile(
                            title: Text(data["product-name"],style: TextStyle(fontSize: 20.sp),),
                            leading: Image.network(data["product-img"][0]),
                          ),
                        );
                      }).toList(),
                    );
                  }
                  print(inputText);
                });
              },
            ),
            Expanded(
                child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("products").where("product-name",isLessThanOrEqualTo: inputText)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text("Loading..."),
                    );
                  }
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return Card(
                        elevation: 3,
                        child: ListTile(
                          title: Text(data["product-name"],style: TextStyle(fontSize: 20.sp),),
                          leading: Image.network(data["product-img"][0]),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ))
          ],
        ),
      ),
    ));
  }
}
