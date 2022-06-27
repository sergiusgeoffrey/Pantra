import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantra_project/models/event.dart';
import 'package:pantra_project/models/student_creds.dart';
import 'package:pantra_project/services/event/event_details.dart';

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
    //check if doc has field "acara"
    try {
      doc["acara"].contains(eventID)
          ? docRef.update({
              "acara": FieldValue.arrayRemove([eventID])
            })
          : docRef.update({
              "acara": FieldValue.arrayUnion([eventID])
              //show snackbar
            });
    } catch (e) {
      docRef.set({
        "acara": [eventID]
      });
    }

    if (doc.data() != null) {
    } else {}
  }

  static Future<bool> getSpecificWishlist(
      {required String nrp, required String eventID}) async {
    DocumentSnapshot doc = await tbWishlist.doc(nrp).get();
    try {
      return doc["acara"].contains(eventID);
    } catch (e) {
      return false;
    }
  }

  static Future<List<Event>> getWishlist({required String nrp}) async {
    DocumentSnapshot doc = await tbWishlist.doc(nrp).get();
    EventDetailService eventDetailService = EventDetailService();
    if (doc.exists) {
      List<Event> events = [];
      for (String eventID in doc["acara"]) {
        await eventDetailService
            .getAllData(id: int.parse(eventID))
            .then((value) {
          events.add(value);
        });
      }
      return events;
    } else {
      return [];
    }
  }
}
