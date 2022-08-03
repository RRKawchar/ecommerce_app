import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/const/app_colors.dart';
import 'package:flutter_ecommerce/ui/login_screen.dart';
import 'package:flutter_ecommerce/ui/user_screen.dart';
import 'package:flutter_ecommerce/widgets/custom_buttom.dart';
import 'package:flutter_ecommerce/widgets/reuseable_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _obscureText = true;
  String errorMessage="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screen_color,
      body: SafeArea(
        child: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(
                height: 150.h,
                width: ScreenUtil().screenWidth,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.light,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      ReuseableText("Sign Up", 22.sp, Colors.white, FontWeight.normal),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                    width: ScreenUtil().screenWidth,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(28.r),
                            topRight: Radius.circular(28.r)
                        )
                    ),
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
                            ReuseableText("Welcome Here", 22.sp, AppColors.screen_color, FontWeight.normal),
                            ReuseableText("Glad to see you back my friend.", 14.sp, Colors.black87, FontWeight.normal),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 48.h,
                                  width: 41.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.screen_color,
                                      borderRadius: BorderRadius.circular(12.r)),
                                  child: Center(
                                    child: Icon(
                                      Icons.email_outlined,
                                      color: Colors.white,
                                      size: 20.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    validator: emailValidation,
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      hintText: "Enter Your Email",
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: const Color(0xFF414041),
                                      ),
                                      labelText: 'email',
                                      labelStyle: TextStyle(
                                        fontSize: 15.sp,
                                        color: AppColors.screen_color,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h,),
                            Center(
                              child: Text(errorMessage,style:const TextStyle(fontSize: 20,color: Colors.red),),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 48.h,
                                  width: 41.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.screen_color,
                                      borderRadius: BorderRadius.circular(12.r)),
                                  child: Center(
                                    child: Icon(
                                      Icons.lock_outline,
                                      color: Colors.white,
                                      size: 20.w,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    validator: passwordValidation,
                                    controller: passwordController,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      hintText: "password must be 6 character",
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: const Color(0xFF414041),
                                      ),
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        fontSize: 15.sp,
                                        color: AppColors.screen_color,
                                      ),
                                      suffixIcon: _obscureText == true
                                          ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = false;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            size: 20.w,
                                          ))
                                          : IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = true;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.visibility_off,
                                            size: 20.w,
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h,),
                            Center(
                              child: Text(errorMessage,style:const TextStyle(fontSize: 20,color: Colors.red),),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            CustomButton("Continue", (){
                              signUp();
                            }),
                            SizedBox(
                              height: 20.h,
                            ),
                            Wrap(
                              children: [
                                ReuseableText("You already have an account?", 16.sp, Colors.black38, FontWeight.w600),
                                GestureDetector(

                                  child:ReuseableText(" Sign In", 17.sp, Colors.blueAccent, FontWeight.w600),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()));
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
   signUp()async{
     setState((){
       errorMessage="";
     });
     try {
       final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: emailController.text,
         password: passwordController.text,
       );

       var authCredential=credential.user;
       print(authCredential!.uid);
       if(authCredential.uid.isNotEmpty){
         Navigator.push(context, CupertinoPageRoute(builder: (_)=>UserScreen()));
       }else{
         Fluttertoast.showToast(msg: "Something is wrong",textColor: Colors.red);
       }
       errorMessage="";
     } on FirebaseAuthException catch (e) {
       if (e.code == 'weak-password') {
         errorMessage=e.message!;
         Fluttertoast.showToast(msg: "The password provided is too weak.",textColor: Colors.red);
       } else if (e.code == 'email-already-in-use') {
         errorMessage=e.message!;
         Fluttertoast.showToast(msg: "The account already exists for that email.",textColor: Colors.red);
       }
     } catch (e) {
       print(e);
     }
     setState((){

     });
   }

  String? emailValidation(String? email){
    if(email==null || email.isEmpty){
      return "Enter email address";
    }else{
      String pattern ='^[^@]+@[^@]+\.[^@]+';
      RegExp regex = RegExp(pattern);
      if(!regex.hasMatch(email)){
        return "Invalid email .please enter valid email";
      }

      return null;
    }
  }
  String? passwordValidation(String? password){
    if(password==null || password.isEmpty){
      return "Enter password";
    }else{
      String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      RegExp regExp = RegExp(pattern);
      if(!regExp.hasMatch(password)){
        return "Password must be 8 characters long\n And it must have Upper letters, numbers,symbols.";
      }
      return null;
    }
  }
}