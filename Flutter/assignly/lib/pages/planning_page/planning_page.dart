
import 'package:assignly/classes/helpers/api.dart';
import 'package:assignly/classes/objects/medarbejder.dart';
import 'package:assignly/classes/objects/path.dart';
import 'package:assignly/colors.dart';
import 'package:assignly/pages/planning_page/planning_bloc.dart';
import 'package:assignly/widgets/calendar.dart';
import 'package:assignly/classes/helpers/scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignly/widgets/topmenu.dart';
import 'package:intl/intl.dart';

class PlanningPage extends StatefulWidget {
  const PlanningPage({super.key});
  @override
  _PlanningPageState createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> with WidgetsBindingObserver {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<Medarbejder> medarbejdere = [];
  final FocusNode focus = FocusNode();
  DateTime _scheduleDate = DateTime.now(); 

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

  Future<void> _runScheduler() async {
    setState(() {});
    try {
      final sched = Scheduler();
      await sched.scheduleUnassignedForDate(
        _scheduleDate,
        durationMinutes: 60,
        dryRun: false,
        // 1000 GANGE
        iterations: 1000,
        onLog: (s) {
          setState(() {});
        },
      );
    } finally {
      setState(() {});
    }
  }

  Future<void> load() async {
    var resp = await API.getRequest(ApiPath.medarbejder);
    medarbejdere = Medarbejder.getMedarbejderFromJson(resp.body);
  }
  

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: load(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const TopMenu(),
          backgroundColor: background,
          body: BlocProvider(
            create: (_) => PlanningBloc(),
            child: BlocBuilder<PlanningBloc, PlanningState>(
              builder: (context, state) => LayoutBuilder(
                builder: (context, constraints) => ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
        
                        // LEFT SIDEBAR
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                            child: Column(
                              children: [
                                // Title
                                const Text(
                                  "Medarbejdere:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                for (Medarbejder medarbejder in medarbejdere)
                                  Text('${medarbejder.navn} - Antal Timer: ${medarbejder.arbejdstimerOmUgen}')
                              ],
                            ),
                          ),
                        ),
                        
                        
                        // MIDDLE CONTENT
                        Expanded(
                          flex: 7,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  margin: const EdgeInsets.only(top: 20, bottom: 20, left: 5, right: 5),
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return SizedBox(
                                        width: double.infinity,
                                        height: constraints.maxHeight,
                                        child: const ShiftScheduler(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
        
                        // RIGHT SIDE BOX
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            margin: const EdgeInsets.only(top: 20, bottom: 100, left: 20, right: 20),
                            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                            child: Column(
                              children: [
                                // Title
                                const Text(
                                  "Automatisk Planlægning",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
        
                                ElevatedButton(
                                  onPressed: () async {
                                    DateTime? newDate = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 1000)));
                                    if (newDate != null) {
                                      _scheduleDate = newDate;
                                    }
        
                                    // TODO: ADD ERROR MESSAGE
                                    setState(() {});
                                  }, 
                                  child: const Text("VÆLG DATO"),
                                ),
        
                                const SizedBox(height: 10),
                                Text("Generer skema for: ${DateFormat.yMMMd().format(_scheduleDate)}"),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () async {
                                    await _runScheduler();
                                  }, 
                                  child: const Text("GENERER SKEMA"),
                                ),
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
          ),
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    }
  );
}
