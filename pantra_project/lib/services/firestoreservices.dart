// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantra_project/models/student_creds.dart';

CollectionReference tbUser = FirebaseFirestore.instance.collection('tbUser');
CollectionReference tbWishlist =
    FirebaseFirestore.instance.collection('tbWishlist');

class Database {
  static Stream<QuerySnapshot> getUser() {
    return tbUser.snapshots();
  }

  static Future<void> addUser({required StudentCreds student}) async {
    DocumentReference docRef = tbUser.doc(student.nrp);
    await docRef
        .set(student.toJson())
        .whenComplete(() => print("user added"))
        .catchError((e) => print(e.toString()));
  }

  //get spesific user by nrp
  static Future<StudentCreds?> getUserByNrp({required String nrp}) async {
    DocumentSnapshot doc = await tbUser.doc(nrp).get();
    //map doc to student creds
    if (doc.exists) {
      final testing = StudentCreds(
          nrp: doc["nrp"],
          name: doc["name"],
          angkatan: 2019,
          jurusan: doc["jurusan"],
          pengalaman: doc["pengalaman"],
          dateofBirth: doc["dateofBirth"],
          instagram: doc["instagram"],
          photoFilepath: doc["photoFilepath"],
          lastUpdated: doc["lastUpdated"]);
      return testing;
    } else {
      return null;
    }
  }

  //update wishlist array
  static Future<void> updateWishlist(
      {required String nrp, required String event_id}) async {
    DocumentReference docRef = await tbWishlist.doc(nrp);
    //update array field in firestore
    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      doc["acara"].contains(event_id)
          ? docRef.update({
              "acara": FieldValue.arrayRemove([event_id])
            })
          : docRef.update({
              "acara": FieldValue.arrayUnion([event_id])
            });
    } else {
      docRef.set({
        "acara": [event_id]
      });
    }

    // await docRef
    //     .update({
    //       "acara": FieldValue.arrayUnion(["$event_id"]),
    //     })
    //     .whenComplete(() => print("wishlist updated"))
    //     .catchError((e) => print(e.toString()));
  }

  static Future<bool> getSpesificWishlist(
      {required String nrp, required String event_id}) async {
    DocumentSnapshot doc = await tbWishlist.doc(nrp).get();
    if (doc.exists) {
      return doc["acara"].contains(event_id) ? true : false;
    } else {
      return false;
    }
  }
}
