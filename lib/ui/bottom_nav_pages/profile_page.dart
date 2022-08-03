import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/const/app_colors.dart';
import 'package:flutter_ecommerce/widgets/my_textformfield.dart';
import 'package:flutter_ecommerce/widgets/reuseable_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  TextEditingController? _ageController;
  setDataToTextField(data){
    return Column(
      children: [
        SizedBox(height: 12.h,),
        MyTextFormField(TextInputType.text, _nameController=TextEditingController(text: data['name'])),
        SizedBox(height: 12.h,),
        MyTextFormField(TextInputType.text, _phoneController=TextEditingController(text: data['phone'])),
        SizedBox(height: 12.h,),
        MyTextFormField(TextInputType.text, _ageController=TextEditingController(text: data['age'])),
        SizedBox(height: 50.h,),
        GestureDetector(
          onTap: (){
            UpdateData();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration:const BoxDecoration(
                  color: Colors.red
              ),
              child: Center(child: ReuseableText("Update", 20, Colors.white, FontWeight.normal)),
            ),
          ),
        )
      ],
    );
  }
  UpdateData(){
    CollectionReference _collectionRef=FirebaseFirestore.instance.collection("users-Form-Data");
    _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "name":_nameController!.text,
      "phone":_phoneController!.text,
      "age":_ageController!.text,
    }).then((value) => Fluttertoast.showToast(msg: "Update Successfully",textColor: Colors.white,backgroundColor: Colors.red));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screen_color,
        body:SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users-Form-Data").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
              builder: (BuildContext context,AsyncSnapshot snapshot){
                var data=snapshot.data;

                if(data==null){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return setDataToTextField(data);
              },

            ),
          ),
        )
    );
  }
}
