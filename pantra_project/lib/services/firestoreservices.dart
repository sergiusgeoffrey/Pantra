import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pantra_project/models/student_creds.dart';

CollectionReference tbUser = FirebaseFirestore.instance.collection('tbUser');

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
}
