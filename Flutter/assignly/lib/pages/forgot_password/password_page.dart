import 'package:assignly/colors.dart';
import 'package:assignly/pages/forgot_password/password_bloc.dart';
import 'package:assignly/widgets/custom_image_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> with WidgetsBindingObserver {
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
        create: (_) => PasswordBloc(),
        child: BlocBuilder<PasswordBloc, PasswordState>(
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
                    "GLEMT PASSWORD", 
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

                  const SizedBox(height: 40),
            
                  CustomImageBtn(
                    text: "Send email", 
                    onTap: () {}, 
                    updateFunc: () {}, 
                    gradient: btnGradient,
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