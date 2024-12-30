import 'package:cowok/config/appwrite.dart';
import 'package:cowok/config/color.dart';
import 'package:cowok/config/enum.dart';
import 'package:cowok/config/session.dart';
import 'package:cowok/controllers/booking_controllers.dart';
import 'package:cowok/models/worker_model.dart';
import 'package:cowok/pages/booking_pages.dart';
import 'package:cowok/pages/busines_pages.dart';
import 'package:cowok/pages/checkout_page.dart';
import 'package:cowok/pages/dashboard.dart';
import 'package:cowok/pages/edit_profile_page.dart';
import 'package:cowok/pages/get_started_pages.dart';
import 'package:cowok/pages/health_pages.dart';
import 'package:cowok/pages/list_worker_pages.dart';
import 'package:cowok/pages/productivity_page.dart';
import 'package:cowok/pages/rating_page.dart';
import 'package:cowok/pages/sign_in_page.dart';
import 'package:cowok/pages/sign_up_page.dart';
import 'package:cowok/pages/splash_screen_page.dart';
import 'package:cowok/pages/succes_booking_page.dart';
import 'package:cowok/pages/worker_profile_page.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(
      BookingController()); // Inisialisasi BookingController di awal aplikasi
  Appwrite.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(
        useMaterial3: true,
      ).copyWith(
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme()
              .apply(bodyColor: AppColor.text, displayColor: AppColor.text),
          primaryColor: AppColor.primary,
          colorScheme: const ColorScheme.light(primary: AppColor.primary),
          filledButtonTheme: const FilledButtonThemeData(
              style: ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(Size.fromHeight(52)),
                  textStyle: MaterialStatePropertyAll(
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold))))),
      initialRoute: '/',
      routes: {
        AppRoute.getStarted.name: (context) => const GetStartedPages(),
        AppRoute.signUp.name: (context) => const SignUpPage(),
        AppRoute.signIn.name: (context) => const SignInPage(),
        AppRoute.dashboard.name: (context) {
          return FutureBuilder(
              future: AppSession.getUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return DView.loadingCircle();
                }
                // kalo blom ada data kesini
                if (snapshot.data == null) {
                  return const GetStartedPages();
                }
                // kalo udah kesini
                return Dashboard();
              });
        },
        AppRoute.listWorker.name: (context) {
          String category =
              ModalRoute.of(context)!.settings.arguments as String;
          return ListWorkerPage(category: category);
        },
        AppRoute.workerProfile.name: (context) {
          WorkerModel worker =
              ModalRoute.of(context)!.settings.arguments as WorkerModel;
          return WorkerProfilePage(worker: worker);
        },
        AppRoute.booking.name: (context) {
          WorkerModel worker =
              ModalRoute.of(context)!.settings.arguments as WorkerModel;
          return BookingPage(worker: worker);
        },
        AppRoute.checkout.name: (context) => const CheckoutPage(),
        AppRoute.successBooking.name: (context) => const SuccessBookingPage(),
        AppRoute.editProfile.name: (context) =>
            const EditeProfile(), // Tambahkan route ke Edit Profile
        //  AppRoute.orderPage.name: (context) => const OrderFragment(), // Tambahkan route ke Edit Profile
        '/tipsSelection': (context) => const ProductivityPage(),
        '/scaleUpTips': (context) => const BusinesPages(),
        '/cleanerSelection': (context) => const HealthPages(),
        '/': (context) => const SplashScreenPage(),
        '/rating': (context) {
          final workerId = ModalRoute.of(context)!.settings.arguments as String;
          return RatingPage(workerId: workerId);
        },
      },
    );
  }
}
