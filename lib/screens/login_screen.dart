import 'package:coach_flutter/resources/auth_methods.dart';
import 'package:coach_flutter/responsive/mobile_screen_layout.dart';
import 'package:coach_flutter/responsive/responsive_layout_screen.dart';
import 'package:coach_flutter/responsive/web_screen_layout.dart';
import 'package:coach_flutter/screens/signup_screen.dart';
import 'package:coach_flutter/utils/colors.dart';
import 'package:coach_flutter/utils/utils.dart';
import 'package:coach_flutter/widgets/text_field_input.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navitageToSignUp(){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SignupScreen(),
      ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                //svg image
                Image.asset(
                  'assets/progression.png',
                  height: 200,
                ),
                const SizedBox(height: 64),
                // text field for email
                TextFieldInput(
                 
                  hintText: 'enter your email',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                  
                ),
                // text field pw
                const SizedBox(height: 24),
                TextFieldInput(
                  hintText: 'enter password',
                  textInputType: TextInputType.text,
                  textEditingController: _passwordController,
                  isPass: true,
                ),
              
                //button login
                const SizedBox(height: 24),
                InkWell(
                  onTap: loginUser,
                  child: Container(
                    child: _isLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: primaryColor),
                          )
                        : const Text('Log in'),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: blueColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Flexible(child: Container(), flex: 2),

                //sign up transition
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("don't have an account? "),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                    GestureDetector(
                      onTap: navitageToSignUp,
                      child: Container(
                        child: const Text("Sign up"),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
