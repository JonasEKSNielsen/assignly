
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
  final FocusNode focus = FocusNode();
  DateTime? _scheduleDate;

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
      final today = DateTime.now();
      final sched = Scheduler();
      await sched.scheduleUnassignedForDate(
        _scheduleDate ?? DateTime(today.year, today.month, today.day),
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
  

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: TopMenu(),
          backgroundColor: background,
          body: BlocProvider(
            create: (_) => PlanningBloc(),
            child: BlocBuilder<PlanningBloc, PlanningState>(
              builder: (context, state) => LayoutBuilder(
                // FIX: LayoutBuilder must use `builder:` to access viewport constraints
                builder: (context, constraints) => ConstrainedBox(
                  // Make the Row at least as tall as the viewport
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    // Make children match the tallest height => full-height sidebars
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch, // stretch children vertically
                      children: [
                        // LEFT SIDEBAR (≈15%)
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            margin: const EdgeInsets.only(
                                top: 20, bottom: 20, left: 20, right: 20),
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 10),
                            child: const Column(
                              children: [
                                // Title
                                Text(
                                  "Medarbejdere:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        // MIDDLE CONTENT — keeps top card, makes calendar fill the rest
                        Expanded(
                          flex: 7,
                          child: Column(
                            children: [

                              // Calendar area fills the remaining vertical space
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

                                  // Use LayoutBuilder to give ShiftScheduler the exact remaining height
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return SizedBox(
                                        width: double.infinity,
                                        height: constraints.maxHeight,
                                        child: const ShiftScheduler(), // ⬅️ now fills the rest cleanly
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // RIGHT SIDE BOX (≈15%)
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            margin: const EdgeInsets.only(
                                top: 20, bottom: 100, left: 20, right: 20),
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 10),
                            child: Column(
                              children: [
                                // Title
                                const Text(
                                  "Automatisk Planlægning",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),

                                ElevatedButton(
                                  onPressed: () async {
                                    await _runScheduler();
                                  }, 
                                  child: const Text("KØR LORTET"),
                                ),

                                if (_scheduleDate != null)
                                  Text(DateFormat.yMMMd().format(_scheduleDate!)),

                                ElevatedButton(
                                  onPressed: () async {
                                    _scheduleDate = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 1000)));
                                    setState(() {});
                                  }, 
                                  child: const Text("VÆLG DATO"),
                                )

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
        ),
      );
}
