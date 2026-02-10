import 'package:flutter/material.dart';
import 'package:quick_actions/quick_actions.dart';
import 'events.dart';
import 'tickets.dart';
import 'records.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  final QuickActions quickActions = const QuickActions();

  // Define the pages list to correspond with your tabs
  final List<Widget> _pages = [
    const EventsPage(),
    const TicketsPage(),
    const RecordsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _setupQuickActions();
  }

  void _setupQuickActions() {
    quickActions.initialize((String shortcutType) {
      setState(() {
        if (shortcutType == 'action_event') {
          _index = 0;
        } else if (shortcutType == 'action_tickets') {
          _index = 1;
        } else if (shortcutType == 'action_records') {
          _index = 2;
        }
      });
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'action_event',
        localizedTitle: "Events",
        icon: 'event',
      ),
      const ShortcutItem(
        type: 'action_tickets',
        localizedTitle: "Tickets",
        icon: 'confirmation_number',
      ),
      const ShortcutItem(
        type: 'action_records',
        localizedTitle: "Records",
        icon: 'receipt_long',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Events"),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: "Tickets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "Records",
          ),
        ],
      ),
    );
  }
}
