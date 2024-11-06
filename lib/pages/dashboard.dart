import 'package:cowok/controllers/dasboard_controller.dart';
import 'package:cowok/controllers/user_controller.dart';
import 'package:cowok/models/user_model.dart';
import 'package:d_session/d_session.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:cowok/pages/sign_in_page.dart'; // Your sign-in page

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // !controller
    final dashboardController = Get.put(DashboardController());

  @override
  void dispose() {
    dashboardController.clear();
    super.dispose();
  }



  // !floating
  Future<void> _logout(BuildContext context) async {
    bool success = await DSession.removeUser();
    if (success) {
      // Reset user data using GetX UserController
      final userController = Get.put(UserController());
      userController.data = UserModel();

      // Navigate to SignInPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInPage()),
      );
    } else {
      // Handle the failure case if needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log out. Please try again.')),
      );
    }
  }

  // ! botom
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: DView.appBarCenter('Dashboard'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _logout(context), // Call the logout method
        child: Icon(Icons.logout),
      ),


      body: Obx(() => dashboardController.currentFragment),

      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: dashboardController.index,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            dashboardController.index = value;
          },
          selectedFontSize: 14,
          unselectedFontSize: 14,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            height: 2,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            height: 2,
          ),
          items: dashboardController.menu.map((e) {
            return BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(e['icon_off'])),
              activeIcon: ImageIcon(AssetImage(e['icon_on'])),
              label: e['label'],
            );
          }).toList(),
        );
      }),

      
    );
  }
}
