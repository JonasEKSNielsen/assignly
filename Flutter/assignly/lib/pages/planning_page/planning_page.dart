import 'package:assignly/pages/planning_page/planning_bloc.dart';
import 'package:assignly/widgets/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanningPage extends StatefulWidget {
  const PlanningPage({super.key});
  @override
  _PlanningPageState createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> with WidgetsBindingObserver {
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
      appBar: AppBar(
        title: const Text("Vagtplan"),
      ),

      body: BlocProvider(
        create: (_) => PlanningBloc(),
        child: BlocBuilder<PlanningBloc, PlanningState>(
          builder: (context, state) => SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // USE 15% FOR SIDE MENU
                // SIDE MENU
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(top: 40, bottom: 40, right: 60),
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    child: const Column(
                      children: [
                        // Title
                        Text(
                          "abc", 
                          style: TextStyle(
                            fontSize: 30, 
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        Text(
                          "cba", 
                          style: TextStyle(
                            fontSize: 30, 
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        Text(
                          "cda", 
                          style: TextStyle(
                            fontSize: 30, 
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // USE 75% FOR MAIN CONTENT, INCREASE HEIGHT
                // MAIN CONTENT
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
                        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 60),
                        child: const Column(
                          children: [
                            // Title
                            Text(
                              "SKEMA", 
                              style: TextStyle(
                                fontSize: 46, 
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                      
                            SizedBox(height: 10),
                          ],
                        ),
                      ),


                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                        child: const Column(
                          children: [
                            ShiftScheduler(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // TODO: 10% FOR SIDE BOX
                // SIDE BOX 
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(top: 40, bottom: 40, left: 60),
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    child: const Column(
                      children: [
                        // Title
                        Text(
                          "Vagtplan", 
                          style: TextStyle(
                            fontSize: 46, 
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                  
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    ),
  );
}
