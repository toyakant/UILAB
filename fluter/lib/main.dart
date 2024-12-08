import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
void main() {
  runApp(HabitTrackerApp());
}
class HabitTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> habits = [
    {'title': 'Morning Exercise', 'progress': 0.8},
    {'title': 'Read a Book', 'progress': 0.5},
    {'title': 'Drink Water', 'progress': 0.9},
  ];
  void _addHabit(String habitName) {
    setState(() {
      habits.add({'title': habitName, 'progress': 0.0});
    });
  }
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HabitList(habits: habits),
      CalendarView(),
      StatsView(totalHabits: habits.length),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Tracker'),
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
        onPressed: () {
          _showAddHabitDialog(context);
        },
        child: Icon(Icons.add),
        tooltip: 'Add New Habit',
      )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Habits'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
  void _showAddHabitDialog(BuildContext context) {
    final TextEditingController habitController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Habit'),
          content: TextField(
            controller: habitController,
            decoration: InputDecoration(hintText: 'Enter habit name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (habitController.text.isNotEmpty) {
                  _addHabit(habitController.text);
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
class HabitList extends StatelessWidget {
  final List<Map<String, dynamic>> habits;
  HabitList({required this.habits});
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: habits.length,
      itemBuilder: (context, index) {
        final habit = habits[index];
        return HabitCard(title: habit['title'], progress: habit['progress']);
      },
    );
  }
}
class HabitCard extends StatelessWidget {
  final String title;
  final double progress;
  HabitCard({required this.title, required this.progress});
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 100,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class CalendarView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TableCalendar(
        firstDay: DateTime.utc(2024, 1, 1),
        lastDay: DateTime.utc(2024, 12, 31),
        focusedDay: DateTime.now(),
        calendarFormat: CalendarFormat.month,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
      ),
    );
  }
}
class StatsView extends StatelessWidget {
  final int totalHabits;
  StatsView({required this.totalHabits});
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bar_chart,
            size: 80,
            color: Colors.blue,
          ),
          SizedBox(height: 20),
          Text(
            'Total Habits: $totalHabits',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
