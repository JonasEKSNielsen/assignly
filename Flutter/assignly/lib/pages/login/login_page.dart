import 'package:assignly/colors.dart';
import 'package:assignly/pages/forgot_password/password_page.dart';
import 'package:assignly/pages/login/login_bloc.dart';
import 'package:assignly/pages/planning_page/planning_page.dart';
import 'package:assignly/widgets/custom_image_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode focus = FocusNode();
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    focus.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => FocusScope.of(context).unfocus(),
    child: Scaffold(
    resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: BlocProvider(
        create: (_) => LoginBloc(),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) => SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 60),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  // Title
                  const Text(
                    "ASSIGNLY", 
                    style: TextStyle(
                      fontSize: 46, 
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
            
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                    ),
                  ),
            
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),

                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PasswordPage()));
                    },
                    child: const Text("Glemt password"),
                  ),

                  const SizedBox(height: 40),
            
                  CustomImageBtn(
                    text: "Login", 
                    onTap: () {
                      // TODO: BRUG EVENTS
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PlanningPage()));
                    }, 
                    updateFunc: () {}, 
                    gradient: btnGradient,
                    image: const Image(image: AssetImage("assets/asd.jpg")), 
                  ),

                  const SizedBox(height: 20),

                  CustomImageBtn(
                    text: "Login med Microsoft", 
                    onTap: () {}, 
                    updateFunc: () {}, 
                    // TODO: BEDRE FARVE OG NY BILLEDe
                    gradient: greenGradient,
                    image: const Image(image: AssetImage("assets/asd.jpg")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}