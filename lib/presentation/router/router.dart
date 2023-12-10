import 'package:csexplorer/bottom_NavBar.dart';
import 'package:csexplorer/main.dart';
import 'package:csexplorer/presentation/screens/Feedback/feedback_form.dart';
import 'package:csexplorer/presentation/screens/Profile/profile_screen.dart';
import 'package:csexplorer/presentation/screens/FAQ/manage_faq.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MyApp());
      case '/csExplorer':
        return MaterialPageRoute(builder: (_) => const BottomNavBar());
      case '/feedbackForm':
        return MaterialPageRoute(builder: (_) => const FeedbackForm());
      case '/profileScreen':
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case '/manageFAQ':
        return MaterialPageRoute(builder: (_) => const ManageFAQ());
      default:
        return null;
    }
  }
}
