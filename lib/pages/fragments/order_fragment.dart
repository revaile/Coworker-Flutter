import 'package:cowok/config/color.dart';
import 'package:cowok/config/enum.dart';
import 'package:cowok/models/booking_models.dart';
import 'package:cowok/models/worker_model.dart';
import 'package:cowok/snakbar/snackbar.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/appwrite.dart';
import '../../controllers/fragments/order_controller.dart';
import '../../controllers/user_controller.dart';

class OrderFragment extends StatefulWidget {
  const OrderFragment({super.key});

  @override
  State<OrderFragment> createState() => _OrderFragmentState();
}

class _OrderFragmentState extends State<OrderFragment> {
  final orderController = Get.put(OrderController());
  final userController = Get.put(UserController());

  @override
  void initState() {
    orderController.ini(userController.data.$id!);
    super.initState();
  }

  @override
  void dispose() {
    orderController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 172,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColor.bgHeader,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(80),
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 24),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  header(),
                  DView.spaceHeight(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: menuOrder('In Progress'),
                        ),
                        DView.spaceWidth(30),
                        Expanded(
                          child: menuOrder('Completed'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        DView.spaceHeight(24),
        Expanded(
          child: Obx(() {
            return IndexedStack(
              index: orderController.selected == 'In Progress' ? 0 : 1,
              children: [
                inProgressList(),
                completedList(),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget inProgressList() {
    return Obx(() {
      String statusFetch = orderController.statusInProgress;
      if (statusFetch == '') return DView.nothing();
      if (statusFetch == 'Loading') return DView.loadingCircle();
      if (statusFetch != 'Success') return DView.error(data: statusFetch);
      List<BookingModel> list = orderController.inProgress;
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: list.length,
        itemBuilder: (context, index) {
          BookingModel booking = list[index];
          WorkerModel worker = booking.worker!;
          return GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context,
              //  AppRoute.booking.name,
              //   arguments:booking.worker, // Mengirimkan WorkerModel sebagai argumen
              // );

              orderController.setCompleted(
                context,
                booking.$id,
                booking.workerId,
                userController.data.$id!,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xffeaeaea)),
              ),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Image.network(
                    Appwrite.imageURL(worker.image),
                    width: 60,
                    height: 60,
                  ),
                  DView.spaceWidth(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          worker.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        DView.spaceHeight(2),
                        Text(
                          worker.category,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showBottomSheetToEditHour(
                              context, booking.hiringDuration, (newHour) {
                            // Lakukan sesuatu dengan nilai baru, misalnya:
                            booking.hiringDuration = newHour;
                            print('Updated hour: $newHour');
                          });
                        },
                        child: Image.asset(
                          'assets/ic_edit.png',
                          width: 20,
                        ),
                      ),
                      DView.spaceHeight(5),
                      Row(
                        children: [
                          Text(
                            booking.hiringDuration.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const Text(' hours'),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget completedList() {
    return Obx(() {
      String statusFetch = orderController.statusCompleted;
      if (statusFetch == '') return DView.nothing();
      if (statusFetch == 'Loading') return DView.loadingCircle();
      if (statusFetch != 'Success') return DView.error(data: statusFetch);
      List<BookingModel> list = orderController.completed;
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: list.length,
        itemBuilder: (context, index) {
          BookingModel booking = list[index];
          WorkerModel worker = booking.worker!;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xffeaeaea)),
            ),
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Image.network(
                  Appwrite.imageURL(worker.image),
                  width: 60,
                  height: 60,
                ),
                DView.spaceWidth(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        worker.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      DView.spaceHeight(2),
                      Text(
                        worker.category,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      booking.hiringDuration.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const Text(' hours'),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget menuOrder(String title) {
    return GestureDetector(
      onTap: () {
        orderController.selected = title;
      },
      child: Obx(() {
        bool isActive = orderController.selected == title;
        return Container(
          height: 50,
          decoration: BoxDecoration(
            color: isActive ? Theme.of(context).primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: const Color(0xffE5E7EC).withOpacity(0.5),
                blurRadius: 30,
                offset: const Offset(0, 30),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
        );
      }),
    );
  }

  Padding header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Workers',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '13,492 transactions',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          IconButton.filled(
            onPressed: () {},
            icon: const ImageIcon(AssetImage('assets/ic_search.png')),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Colors.white,
              ),
              foregroundColor: MaterialStatePropertyAll(
                Colors.black,
              ),
            ),
          ),
          IconButton.filled(
            onPressed: () {},
            icon: const ImageIcon(AssetImage('assets/ic_filter.png')),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Colors.white,
              ),
              foregroundColor: MaterialStatePropertyAll(
                Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
