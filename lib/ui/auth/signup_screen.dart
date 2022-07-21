import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sigevi_1/dashboard/alumnoDashboard.dart';
import 'package:sigevi_1/providers/user_provider.dart';
import 'package:sigevi_1/resources/auth_helper.dart';
import 'package:sigevi_1/dashboard/coordDashboard.dart';

import 'package:sigevi_1/ui/auth/login_screen.dart';
import 'package:sigevi_1/utils/colors.dart';
import 'package:sigevi_1/utils/global_variable.dart';
import 'package:sigevi_1/utils/utils.dart';
import 'package:sigevi_1/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _epController = TextEditingController();
  final TextEditingController _cicloController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        userName: _usernameController.text,
        ep: _epController.text,
        ciclo: _cicloController.text,
        image: _image!);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      addData();
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
              final UserProvider userProvider=Provider.of<UserProvider>(context);
              if(userProvider.getUser.ciclo!='delegado'){
                return AlumnoDashboard();
              }else{
                return CoordDashboard();
              }
             
              

              
            },
            
          
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

   addData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              SvgPicture.asset(
                'assets/logooo.svg',
                color: primaryColor,
                height: 44,
              ),
              const SizedBox(
                height: 44,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 44,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.red,
                        )
                      : const CircleAvatar(
                          radius: 44,
                          backgroundImage: NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          backgroundColor: Colors.red,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              TextFieldInput(
                hintText: 'Ingrese sus nombres y apellidos',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              const SizedBox(
                height: 14,
              ),
              TextFieldInput(
                hintText: 'Ingrese su correo',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(
                height: 14,
              ),
              TextFieldInput(
                hintText: 'Ingrese su contraseña',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              const SizedBox(
                height: 14,
              ),
              TextFieldInput(
                hintText: 'Ingrese su Escuela profesional',
                textInputType: TextInputType.text,
                textEditingController: _epController,
              ),
              const SizedBox(
                height: 14,
              ),
              TextFieldInput(
                hintText: 'Ingrese su Ciclo',
                textInputType: TextInputType.text,
                textEditingController: _cicloController,
              ),
              const SizedBox(
                height: 14,
              ),
              InkWell(
                child: Container(
                  child: !_isLoading
                      ? const Text(
                          'Sign up',
                        )
                      : const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                ),
                onTap: signUpUser,
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      'Already have an account?',
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                    child: Container(
                      child: const Text(
                        ' Login.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
