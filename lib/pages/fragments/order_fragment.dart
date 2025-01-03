import 'package:cowok/config/color.dart';
import 'package:cowok/models/booking_models.dart';
import 'package:cowok/models/worker_model.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/appwrite.dart';
import '../../controllers/fragments/order_controller.dart';
import '../../controllers/user_controller.dart';
import '../rating_page.dart';

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
                border: Border.all(color: const Color(0xffB3DCF2)),
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
                      Column(
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
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/ic_edit.png',
                            width: 20,
                          ),
                          Text('endOrder')
                        ],
                      ),
                    ],
                  ),
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
        bool hasRated = booking.hasRated; // Awalnya dari data model

        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green),
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
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
                      DView.spaceHeight(8),
                      hasRated
                          ? const Text(
                              'Rated',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                final workerId = worker.$id; // Worker ID
                                final bookingId = booking.$id;
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RatingPage(
                                      workerId: workerId,
                                      bookingId: bookingId,
                                    ),
                                  ),
                                );
                                // Perbarui status hasRated setelah kembali dari halaman Rating
                                setState(() {
                                  hasRated = true;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: const Text(
                                'Give Rating',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            );
          },
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
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Workers',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
