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

  static Future<StudentCreds?> getUserByNrp({required String nrp}) async {
    DocumentSnapshot doc = await tbUser.doc(nrp).get();
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

  static Future<void> updateWishlist(
      {required String nrp, required String eventID}) async {
    DocumentReference docRef = tbWishlist.doc(nrp);
    DocumentSnapshot doc = await docRef.get();
    if (doc.exists) {
      doc["acara"].contains(eventID)
          ? docRef.update({
              "acara": FieldValue.arrayRemove([eventID])
            })
          : docRef.update({
              "acara": FieldValue.arrayUnion([eventID])
            });
    } else {
      docRef.set({
        "acara": [eventID]
      });
    }

    // await docRef
    //     .update({
    //       "acara": FieldValue.arrayUnion(["$eventID"]),
    //     })
    //     .whenComplete(() => print("wishlist updated"))
    //     .catchError((e) => print(e.toString()));
  }

  static Future<bool> getSpecificWishlist(
      {required String nrp, required String eventID}) async {
    DocumentSnapshot doc = await tbWishlist.doc(nrp).get();
    if (doc.exists) {
      return doc["acara"].contains(eventID) ? true : false;
    } else {
      return false;
    }
  }
}
