import 'package:assignly/pages/planning_page/planning_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PlanningPage extends StatefulWidget {
  const PlanningPage({super.key});
  @override
  _PlanningPageState createState() => _PlanningPageState();
}

class _PlanningPageState extends State<PlanningPage> with WidgetsBindingObserver {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode focus = FocusNode();

  List<Appointment> _shiftCollection = <Appointment>[];
  final List<CalendarResource> _employeeCollection = <CalendarResource>[];
  late _DataSource _events;

  
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

    _events = _DataSource(_shiftCollection, _employeeCollection);
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


                            SfCalendar(
                              view: CalendarView.timelineWeek,
                              allowedViews: const [
                                CalendarView.timelineDay,
                                CalendarView.timelineWeek,
                                CalendarView.timelineWorkWeek,
                              ],
                              showDatePickerButton: true,
                              resourceViewSettings: const ResourceViewSettings(
                                displayNameTextStyle: TextStyle(color: Colors.white),
                                showAvatar: true,
                                size: 120,
                                visibleResourceCount: 5,
                              ),
                              dataSource: _events,
                            ),


                // SIDE MENU
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 60),
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
                        child: Column(
                          children: [

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // SIDE BOX 
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 60),
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



class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source, List<CalendarResource> resourceColl) {
    appointments = source;
    resources = resourceColl;
  }
}