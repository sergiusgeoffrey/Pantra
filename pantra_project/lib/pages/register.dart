import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pantra_project/models/student_creds.dart';
import 'package:pantra_project/services/firestoreservices.dart';
import 'package:pantra_project/services/student_creds.dart';
import 'package:pantra_project/utils/color.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<String> _signUp(
      {required String email, required String password}) async {
    try {
      final auth = FirebaseAuth.instance;
      final user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 234, 213, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Register Your Pantra Account",
              style: TextStyle(
                fontSize: 30,
                color: primary,
                fontFamily: 'Recoleta',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _accountController,
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                  labelText: "NRP",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                    //make the border transparent
                  ),
                  fillColor: const Color.fromRGBO(253, 205, 95, 1),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(253, 126, 20, 1), width: 2.0),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: const Icon(Icons.lock),
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                    //make the border transparent
                  ),
                  fillColor: const Color.fromRGBO(253, 205, 95, 1),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(253, 126, 20, 1), width: 2.0),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  String nrp = _accountController.text;
                  String password = _passwordController.text;
                  if (nrp.isNotEmpty && password.length >= 6) {
                    final user = Database.getUserByNrp(nrp: nrp);
                    user.then(
                      (value) async {
                        if (value == null) {
                          StudentCredsService studentApi =
                              StudentCredsService();
                          try {
                            //if data exist, add data values from api to firestore
                            List<StudentCreds> data =
                                await studentApi.getAllData(nrp: nrp);
                            //pakai authentication firebase jadi harus ubah nrp menjadi email dahulu
                            String email = nrp + "@john.petra.ac.id";
                            _signUp(email: email, password: password);
                            //add data to firestore
                            for (StudentCreds student in data) {
                              student.portfolio ??= "";
                              Database.addUser(student: student);
                            }
                          } catch (e) {
                            //if data is not exist in api, add empty data values to firestore
                            StudentCreds student = StudentCreds(
                                nrp: nrp,
                                name: "",
                                angkatan: 0,
                                jurusan: "",
                                pengalaman: "",
                                dateofBirth: "",
                                instagram: "",
                                photoFilepath: "",
                                lastUpdated: "");
                            String email = nrp + "@john.petra.ac.id";
                            _signUp(email: email, password: password);

                            //add data to firestore
                            Database.addUser(student: student);
                          }
                          Navigator.pop(context);
                          // List<StudentCreds> data =
                          //     await studentApi.getAllData(nrp: nrp);
                          // if (data.isNotEmpty) {
                          //   //create
                          // } else {
                          //   print("data kosong");
                          // }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "user $nrp already exists, please Login or use another NRP"),
                            ),
                          );
                        }
                      },
                    );
                  } else if (password.length < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Password must be at least 6 characters"),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill all the fields"),
                      ),
                    );
                  }
                  // database getuser and save to var
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'Recoleta'),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  "Back to Login",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'Recoleta'),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "est. MMXXII",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
