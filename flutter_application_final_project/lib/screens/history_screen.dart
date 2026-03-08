import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/event_model.dart';
import '../widgets/weekly_activity_chart.dart';
import '../widgets/events_table.dart';
import '../widgets/top_bar.dart';
import '../widgets/sidebar.dart';
import 'home_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}
class _HistoryScreenState extends State<HistoryScreen> {
  int _selectedMenuIndex = 1;

  final weeklyData = [
    const WeeklyActivityData(day: 'Mon', value: 35),
    const WeeklyActivityData(day: 'Tue', value: 20),
    const WeeklyActivityData(day: 'Wed', value: 15),
    const WeeklyActivityData(day: 'Thu', value: 25),
    const WeeklyActivityData(day: 'Fri', value: 30),
    const WeeklyActivityData(day: 'Sat', value: 35),
    const WeeklyActivityData(day: 'Sun', value: 38),
  ];

  late List<Event> events;

  @override
  void initState() {
    super.initState();
    events = [
      Event(
        id: '#001',
        type: EventType.fallDetected,
        dateTime: DateTime(2023, 11, 25, 14, 30),
        severity: Severity.high,
        status: EventStatus.resolved,
      ),
      Event(
        id: '#002',
        type: EventType.inactivityAlert,
        dateTime: DateTime(2023, 11, 24, 9, 15),
        severity: Severity.medium,
        status: EventStatus.falseAlarm,
      ),
      Event(
        id: '#003',
        type: EventType.systemCheck,
        dateTime: DateTime(2023, 11, 23, 18, 45),
        severity: Severity.low,
        status: EventStatus.completed,
      ),
      Event(
        id: '#004',
        type: EventType.lowBattery,
        dateTime: DateTime(2023, 11, 22, 11, 20),
        severity: Severity.medium,
        status: EventStatus.charged,
      ),
      Event(
        id: '#005',
        type: EventType.connectivityLost,
        dateTime: DateTime(2023, 11, 21, 16, 10),
        severity: Severity.low,
        status: EventStatus.restored,
      ),
      Event(
        id: '#006',
        type: EventType.normalMovement,
        dateTime: DateTime(2023, 11, 20, 10, 5),
        severity: Severity.low,
        status: EventStatus.completed,
      ),
      Event(
        id: '#007',
        type: EventType.fallDetected,
        dateTime: DateTime(2023, 11, 19, 12, 30),
        severity: Severity.high,
        status: EventStatus.resolved,
      ),
      Event(
        id: '#008',
        type: EventType.lowBattery,
        dateTime: DateTime(2023, 11, 18, 8, 45),
        severity: Severity.medium,
        status: EventStatus.charged,
      ),
      Event(
        id: '#009',
        type: EventType.systemCheck,
        dateTime: DateTime(2023, 11, 17, 15, 20),
        severity: Severity.low,
        status: EventStatus.completed,
      ),
      Event(
        id: '#010',
        type: EventType.inactivityAlert,
        dateTime: DateTime(2023, 11, 16, 19, 50),
        severity: Severity.medium,
        status: EventStatus.falseAlarm,
      ),
      Event(
        id: '#011',
        type: EventType.connectivityLost,
        dateTime: DateTime(2023, 11, 15, 13, 15),
        severity: Severity.low,
        status: EventStatus.restored,
      ),
      Event(
        id: '#012',
        type: EventType.normalMovement,
        dateTime: DateTime(2023, 11, 14, 11, 0),
        severity: Severity.low,
        status: EventStatus.completed,
      ),
      Event(
        id: '#013',
        type: EventType.fallDetected,
        dateTime: DateTime(2023, 11, 13, 9, 30),
        severity: Severity.high,
        status: EventStatus.resolved,
      ),
      Event(
        id: '#014',
        type: EventType.lowBattery,
        dateTime: DateTime(2023, 11, 12, 7, 10),
        severity: Severity.medium,
        status: EventStatus.charged,
      ),
      Event(
        id: '#015',
        type: EventType.systemCheck,
        dateTime: DateTime(2023, 11, 11, 17, 45),
        severity: Severity.low,
        status: EventStatus.completed,
      ),
      Event(
        id: '#016',
        type: EventType.inactivityAlert,
        dateTime: DateTime(2023, 11, 10, 14, 20),
        severity: Severity.medium,
        status: EventStatus.falseAlarm,
      ),
      Event(
        id: '#017',
        type: EventType.connectivityLost,
        dateTime: DateTime(2023, 11, 9, 10, 55),
        severity: Severity.low,
        status: EventStatus.restored,
      ),
      Event(
        id: '#018',
        type: EventType.normalMovement,
        dateTime: DateTime(2023, 11, 8, 12, 5),
        severity: Severity.low,
        status: EventStatus.completed,
      ),
      Event(
        id: '#019',
        type: EventType.fallDetected,
        dateTime: DateTime(2023, 11, 7, 16, 40),
        severity: Severity.high,
        status: EventStatus.resolved,
      ),
      Event(
        id: '#020',
        type: EventType.lowBattery,
        dateTime: DateTime(2023, 11, 6, 9, 25),
        severity: Severity.medium,
        status: EventStatus.charged,
      ),
      Event(
        id: '#021',
        type: EventType.systemCheck,
        dateTime: DateTime(2023, 11, 5, 13, 50),
        severity: Severity.low,
        status: EventStatus.completed,
      ),
      Event(
        id: '#022',
        type: EventType.inactivityAlert,
        dateTime: DateTime(2023, 11, 4, 11, 15),
        severity: Severity.medium,
        status: EventStatus.falseAlarm,
      ),
      Event(
        id: '#023',
        type: EventType.connectivityLost,
        dateTime: DateTime(2023, 11, 3, 15, 30),
        severity: Severity.low,
        status: EventStatus.restored,
      ),
      Event(
        id: '#024',
        type: EventType.normalMovement,
        dateTime: DateTime(2023, 11, 2, 10, 10),
        severity: Severity.low,
        status: EventStatus.completed,
      ),
    ];
  }

  void _onMenuItemSelected(int index) {
    setState(() {
      _selectedMenuIndex = index;
    });

    
    switch (index) {
      case 0: 
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 1: 
        break;
      case 2: 
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Relatives screen coming soon')),
        );
        break;
      case 3: 
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile screen coming soon')),
        );
        break;
    }
  }

  void _exportCSV() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exporting events to CSV...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    if (isMobile) {
      return _buildMobileLayout();
    } else {
      return _buildDesktopLayout();
    }
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: const TopBar(),
      drawer: Drawer(
        child: Sidebar(
          selectedIndex: _selectedMenuIndex,
          onItemSelected: _onMenuItemSelected,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WeeklyActivityChart(data: weeklyData),
            EventsTable(
              events: events,
              onExportCSV: _exportCSV,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Row(
        children: [
          Sidebar(
            selectedIndex: _selectedMenuIndex,
            onItemSelected: _onMenuItemSelected,
          ),
          Expanded(
            child: Column(
              children: [
                const TopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        WeeklyActivityChart(data: weeklyData),
                        EventsTable(
                          events: events,
                          onExportCSV: _exportCSV,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
