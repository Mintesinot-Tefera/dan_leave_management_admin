import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../constants2.dart';
import '../controllers/simple_ui_controller.dart';
import '../responsive.dart';

class AddNewEmployee extends StatelessWidget {
  const AddNewEmployee({Key, key, required this.uid
      // , required this.title
      })
      : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: context.read<MenuController>().scaffoldKey,
      // drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: AddNewEmployeeBody(uid: uid),
            ),
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                  flex: 2,
                  // child: Container(
                  // decoration:
                  // BoxDecoration(color: Color.fromARGB(255, 16, 10, 34)),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo_dan.png',
                      // height: size.height * 0.4,
                      // width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                    // )
                  ) // SideMenu(),
                  ),
            if (Responsive.isTablet(context))
              Expanded(
                flex: 2,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo_dan.png',
                    // height: size.height * 0.4,
                    // width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              )
            // SideMenu(),
          ],
        ),
      ),
    );
  }
}

class AddNewEmployeeBody extends StatefulWidget {
  AddNewEmployeeBody({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  State<AddNewEmployeeBody> createState() => _AddNewEmployeeBodyState();
}

class _AddNewEmployeeBodyState extends State<AddNewEmployeeBody> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController fieldofstudyController = TextEditingController();
  TextEditingController departmentController = TextEditingController();

  static const menuItems = <String>[
    '10+',
    '12+',
    'Diploma',
    'Bachelor of Science',
    'Bachelor of Arts',
    'Masters of Science',
    'Masters of Arts',
  ];

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ))
      .toList();
  String _btnSelectedVal = 'Bachelor of Science';

  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    fieldofstudyController.dispose();
    departmentController.dispose();

    super.dispose();
  }

  // SignUp Button
  Widget signUpButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          onPressed: () async {
            // Validate returns true if the form is valid, or false otherwise.
            if (_formKey.currentState!.validate()) {
              signUp();
            }
          },
          child: Center(
            child: loading
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text('Submit'),
          )),
    );
  }

  Future signUp() async {
    var datetimenow = Timestamp.now();

    // showDialog(
    //     context: this.context,
    //     barrierDismissible: false,
    //     builder: (context) => Center(
    //           child: CircularProgressIndicator(),
    //         ));

    try {
      setState(() {
        loading = true;
      });
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: emailController.text.trim() + '123',
          )
          .then((value) => {
                FirebaseFirestore.instance
                    .collection('Employee')
                    .doc(value.user!.uid)
                    .set({
                  'uid': value.user!.uid,
                  'full_name': nameController.text.trim(),
                  'email': emailController.text.trim(),
                  'education_level': _btnSelectedVal,
                  'fieldofstudy': fieldofstudyController.text.trim(),
                  'department': departmentController.text.trim(),
                  'date': datetimenow
                })
              });
      setState(() {
        nameController.text = '';
        emailController.text = '';
        fieldofstudyController.text = '';
        departmentController.text = '';

        loading = false;
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
        content: Text(
          "Failed with Code: ${e.code}",
          style: TextStyle(color: Colors.white),
        ),
        duration: const Duration(milliseconds: 1000),
        backgroundColor: Colors.red,
        elevation: 8,
      ));
      setState(() {
        loading = false;
      });
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  SimpleUIController simpleUIController = Get.put(SimpleUIController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          // backgroundColor: Colors.black12,
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildLargeScreen(size, simpleUIController, theme);
              } else {
                return _buildSmallScreen(size, simpleUIController, theme);
              }
            },
          )),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(
    Size size,
    SimpleUIController simpleUIController,
    ThemeData theme,
  ) {
    return Row(
      children: [
        const Expanded(flex: 1, child: Center()),
        SizedBox(width: size.width * 0.06),
        Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
              decoration: BoxDecoration(
                border:
                    Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
                borderRadius: const BorderRadius.all(
                  Radius.circular(defaultPadding),
                ),
              ),
              child: _buildMainBody(size, simpleUIController, theme),
            )),
        const Expanded(flex: 1, child: Center())
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
    Size size,
    SimpleUIController simpleUIController,
    ThemeData theme,
  ) {
    return Center(
      child: _buildMainBody(size, simpleUIController, theme),
    );
  }

  /// Main Body
  Widget _buildMainBody(
    Size size,
    SimpleUIController simpleUIController,
    ThemeData theme,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: size.width > 600
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Add New Employee',
              style: kLoginTitleStyle(size),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Add Employee Details',
              style: kLoginSubtitleStyle(size),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  /// username
                  TextFormField(
                    style: kTextFormFieldStyle(),
                    decoration: const InputDecoration(
                      focusColor: Colors.black,
                      fillColor: Colors.black,
                      iconColor: Colors.black,
                      // prefixIcon: Icon(Icons.person),
                      hintText: 'Full name',
                      helperText: "Full name",
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),

                    controller: nameController,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      } else if (value.length < 4) {
                        return 'at least enter 4 characters';
                      } else if (value.length > 13) {
                        return 'maximum character is 13';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  /// Gmail
                  TextFormField(
                    style: kTextFormFieldStyle(),
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      hintText: 'gmail',
                      helperText: "Department",
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter gmail';
                      } else if (!value.endsWith('@gmail.com')) {
                        return 'please enter valid gmail';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Education Level'),
                      DropdownButton<String>(
                        value: _btnSelectedVal,
                        onChanged: (String? newValue) {
                          setState(() {
                            _btnSelectedVal = newValue!;
                          });
                        },
                        items: _dropDownMenuItems,
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    style: kTextFormFieldStyle(),
                    decoration: const InputDecoration(
                      focusColor: Colors.black,
                      fillColor: Colors.black,
                      iconColor: Colors.black,
                      // prefixIcon: Icon(Icons.person),
                      hintText: 'Field of Study',
                      helperText: "Field of Study",
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),

                    controller: fieldofstudyController,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter field of study';
                      } else if (value.length < 4) {
                        return 'at least enter 4 characters';
                      } else if (value.length > 13) {
                        return 'maximum character is 13';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextFormField(
                    style: kTextFormFieldStyle(),
                    decoration: const InputDecoration(
                      focusColor: Colors.black,
                      fillColor: Colors.black,
                      iconColor: Colors.black,
                      // prefixIcon: Icon(Icons.person),
                      hintText: 'Department',
                      helperText: "Department",
                      hoverColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),

                    controller: departmentController,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter department';
                      } else if (value.length < 4) {
                        return 'at least enter 4 characters';
                      } else if (value.length > 13) {
                        return 'maximum character is 13';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  signUpButton(theme),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  // Consumer<RequestController>(
                  //   builder: (context, requestController, child) {
                  //     return (requestController.evidenceattached == true &&
                  //             uploadtask2 != null)
                  //         ? buildUploadStatus(uploadtask2!)
                  //         // ? const Text('progress indicator')
                  //         : Container();
                  //   },
                  // ),
                  // SizedBox(
                  //   height: size.height * 0.02,
                  // ),
                  // Consumer<RequestController>(
                  //   builder: (context, requestController, child) {
                  //     return (requestController.evidenceattached == true &&
                  //             uploadtask3 != null)
                  //         ? buildUploadStatus(uploadtask3!)
                  //         // ? const Text('progress indicator')
                  //         : Container();
                  //   },
                  // ),
                  // SizedBox(
                  //   height: size.height * 0.02,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
