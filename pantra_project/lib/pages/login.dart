import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pantra_project/pages/nav_bar.dart';
import 'package:pantra_project/services/login.dart';
import 'package:pantra_project/utils/color.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<String> firebaseAuth(
      {required String email, required String password}) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        try {
          final auth = FirebaseAuth.instance;
          await auth.signInWithEmailAndPassword(
              email: email, password: password);

          return "Success";
        } on FirebaseAuthException catch (e) {
          return e.message.toString();
        }
      }
      return e.message.toString();
    }
  }

  final LoginService _loginService = LoginService();
  late Future<bool> _futureLogin;

  final _nrpController = TextEditingController();
  final _passwordController = TextEditingController();

  // final List<String> greeting = <String>[
  //   "Welcome!",
  //   "Bonjour!",
  //   "Hola!",
  //   "Privyet!",
  //   "Ni Hao!",
  //   "Hallo!",
  //   "Ola!",
  //   "Anyoung!",
  //   "Ahlan!",
  //   "Guten Tag!",
  //   "Namaste",
  //   "Shalom!",
  //   "Aloha!",
  // ];
  // final _random = Random();

  String buttonText = "L O G I N";
  bool _validateNRP = false;
  bool _validatePass = false;

  Future<void> isLoggedin() async {
    User? user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NavBar(),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedin();
  }

  @override
  void dispose() {
    _nrpController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome!",
              style: TextStyle(
                fontSize: 40,
                color: primary,
                fontWeight: FontWeight.bold,
                fontFamily: 'Recoleta',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                maxLength: 9,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: _nrpController,
                decoration: InputDecoration(
                  counterText: "",
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                  labelText: "NRP",
                  errorText: _validateNRP ? 'NRP is required' : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: secondary,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: orange, width: 2.0),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: red, width: 2.0),
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
                  errorText: _validatePass ? 'Password is required' : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                    //make the border transparent
                  ),
                  fillColor: secondary,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: orange,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: red,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    buttonText = "LOGGING IN...";
                    _nrpController.text.isEmpty
                        ? _validateNRP = true
                        : _validateNRP = false;
                    _passwordController.text.isEmpty
                        ? _validatePass = true
                        : _validatePass = false;
                  });

                  String nrp = _nrpController.text.toLowerCase();
                  String password = _passwordController.text;

                  if (nrp.isNotEmpty && password.isNotEmpty) {
                    _futureLogin = _loginService.login(
                      nrp: nrp,
                      password: password,
                    );

                    _futureLogin.then((bool success) {
                      if (success) {
                        String email = "$nrp@john.petra.ac.id";

                        setState(() {
                          buttonText = "LOGGING IN...";
                        });

                        firebaseAuth(email: email, password: password).then(
                          (value) {
                            setState(() {
                              buttonText = "L O G I N";
                              _nrpController.text = "";
                              _passwordController.text = "";
                            });
                            value == "Success"
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const NavBar(),
                                    ),
                                  )
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        value,
                                      ),
                                      backgroundColor: red,
                                      action: SnackBarAction(
                                        label: "DISMISS",
                                        textColor: Colors.white,
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                        },
                                      ),
                                    ),
                                  );
                          },
                        );
                      } else {
                        setState(() {
                          buttonText = "L O G I N";
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              "Invalid NRP or Password. Please try again.",
                            ),
                            backgroundColor: red,
                            action: SnackBarAction(
                              label: "DISMISS",
                              textColor: Colors.white,
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                            ),
                          ),
                        );
                      }
                    });
                  } else {
                    setState(() {
                      buttonText = "L O G I N";
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'Recoleta'),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
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
