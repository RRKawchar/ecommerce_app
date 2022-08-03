import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/widgets/reuseable_text.dart';

Widget fetchData(String collectionName){
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection(collectionName)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("items")
        .snapshots(),
    builder:
        (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Center(
          child: Text("Something wrong"),
        );
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (_, index) {
            DocumentSnapshot _documentSnapshot =
            snapshot.data!.docs[index];
            return Card(
              elevation: 5,
              child: ListTile(
                  leading: ReuseableText(_documentSnapshot['name'], 15,
                      Colors.black, FontWeight.bold),
                  title: ReuseableText(
                      "\$${_documentSnapshot['price']}",
                      15,
                      Colors.red,
                      FontWeight.bold),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title:ReuseableText("Warning", 20.0, Colors.red, FontWeight.bold),
                          content: const Text('Do you want to delete??'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () => FirebaseFirestore.instance
                                  .collection(collectionName)
                                  .doc(FirebaseAuth.instance.currentUser!.email)
                                  .collection("items")
                                  .doc(_documentSnapshot.id)
                                  .delete().then((value) => Navigator.pop(context)),
                              child: const Text('Yes'),
                            ),
                          ],
                        ),
                      );



                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )),
            );
          });
    },
  );
}