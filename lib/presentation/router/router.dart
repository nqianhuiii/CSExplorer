import 'package:csexplorer/bottom_NavBar.dart';
import 'package:csexplorer/main.dart';
import 'package:csexplorer/presentation/screens/Feedback/feedback_form.dart';
<<<<<<< HEAD
=======
import 'package:csexplorer/presentation/screens/Profile/profile_screen.dart';
>>>>>>> 0fb28d1 (Sign in and Sign up page)
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
<<<<<<< HEAD
=======
      case '/profileScreen':
        return MaterialPageRoute(builder: (_) => const ProfilePage());
>>>>>>> 0fb28d1 (Sign in and Sign up page)
      default:
        return null;
    }
  }
}
