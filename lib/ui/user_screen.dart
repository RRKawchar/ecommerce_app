import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/const/app_colors.dart';
import 'package:flutter_ecommerce/ui/buttom_nav_controller.dart';
import 'package:flutter_ecommerce/widgets/custom_buttom.dart';
import 'package:flutter_ecommerce/widgets/my_textfield.dart';
import 'package:flutter_ecommerce/widgets/reuseable_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _ageController = TextEditingController();
  List<String> gender = ["Male", "Female", "Others"];

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screen_color,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              ReuseableText("Submit the form to continue.", 22.sp, Colors.white,
                  FontWeight.normal),
              ReuseableText("We will not share your information with anyone.",
                  14.sp, Colors.white54, FontWeight.normal),
              SizedBox(
                height: 15.h,
              ),
              MyTextField("Enter your name", TextInputType.text,
                  _nameController, AppColors.screen_color),
              SizedBox(
                height: 5.h,
              ),
              MyTextField("Enter your phone number", TextInputType.number,
                  _phoneController, AppColors.screen_color),
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 50.h,
                width: ScreenUtil().screenWidth,
                decoration: const BoxDecoration(color: Colors.white),
                child: TextField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: "Date of Birth",
                      hintStyle: const TextStyle(color: AppColors.screen_color),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _selectDateFromPicker(context);
                        },
                        icon: const Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.blue,
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 50.h,
                width: ScreenUtil().screenWidth,
                decoration: const BoxDecoration(color: Colors.white),
                child: TextField(
                  controller: _genderController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Choose your gender",
                    hintStyle: const TextStyle(color: AppColors.screen_color),
                    prefixIcon: DropdownButton<String>(
                      style: const TextStyle(color: AppColors.screen_color),
                      autofocus: true,
                      items: gender.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                          onTap: () {
                            setState(() {
                              _genderController.text = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              MyTextField("Enter your age", TextInputType.number,
                  _ageController, AppColors.screen_color),
              SizedBox(
                height: 50.h,
              ),

              CustomButton("Continue", () {
                sendUserDataToDB();
              })
            ],
          ),
        ),
      )),
    );
  }

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year - 20),
        firstDate: DateTime(DateTime.now().year - 30),
        lastDate: DateTime(DateTime.now().year));
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-Form-Data");
    return _collectionRef
        .doc(currentUser!.email)
        .set({
          "name": _nameController.text,
          "phone": _phoneController.text,
          "dob": _dobController.text,
          "gender": _genderController.text,
          "age": _ageController.text,
        })
        .then(
          (value) => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ButtomNavController()),
          ),
        )
        .catchError(
          (error) => Fluttertoast.showToast(
            msg: "Something is wrong ${error}",
          ),
        );
  }
}
