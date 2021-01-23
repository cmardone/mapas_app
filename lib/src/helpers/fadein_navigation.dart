part of 'helpers.dart';

Route mapNavigationFadeIn(BuildContext context, Widget page) =>
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, _, child) => FadeTransition(
        child: child,
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(curve: Curves.easeInOut, parent: animation),
        ),
      ),
    );
