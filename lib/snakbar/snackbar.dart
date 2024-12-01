import 'package:cowok/config/app_format.dart';
import 'package:cowok/controllers/booking_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showBottomSheetToEditHour(
    BuildContext context, int currentHour, Function(int) onUpdate) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.7,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _EditHourContent(
            currentHour: currentHour,
            onUpdate: onUpdate,
          ),
        ),
      );
    },
  );
}

class _EditHourContent extends StatefulWidget {
  final int currentHour;
  final Function(int) onUpdate;

  const _EditHourContent({
    required this.currentHour,
    required this.onUpdate,
    Key? key,
  }) : super(key: key);

  @override
  State<_EditHourContent> createState() => _EditHourContentState();
}

class _EditHourContentState extends State<_EditHourContent> {
  late int selectedDuration;

  @override
  void initState() {
    super.initState();
    selectedDuration = widget.currentHour;
  }

  @override
  Widget build(BuildContext context) {
    final BookingController bookingController = Get.put(BookingController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        const Text(
          'How many hours?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            itemCount: bookingController.hourDuartion.length,
            itemBuilder: (context, index) {
              int itemDuration = bookingController.hourDuartion[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDuration = itemDuration;
                  });
                },
                child: _buildDurationItem(
                  context,
                  itemDuration,
                  isSelected: itemDuration == selectedDuration,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Selected Duration'),
            Text('$selectedDuration hours'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Sub Total'),
            GetBuilder<BookingController>(
              builder: (controller) {
                return Text(
                  AppFormat.price(
                      controller.bookingDetail.subtotal), // Format subtotal
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Update durasi di controller
              bookingController.setDuration(
                selectedDuration,
                bookingController.bookingDetail.worker?.hourRate ?? 0,
              );

              // Callback untuk memperbarui UI eksternal
              widget.onUpdate(selectedDuration);

              // Snackbar konfirmasi
              Get.snackbar(
                "Duration Updated",
                "Duration set to $selectedDuration hours.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                duration: const Duration(seconds: 3),
              );

              // Tutup BottomSheet
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        ),
      ],
    );
  }
}

Widget _buildDurationItem(BuildContext context, int itemDuration,
    {required bool isSelected}) {
  return Container(
    width: 70,
    margin: const EdgeInsets.only(right: 20),
    decoration: BoxDecoration(
      color: isSelected ? Theme.of(context).primaryColor : Colors.white,
      borderRadius: BorderRadius.circular(28),
      border: Border.all(
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$itemDuration',
          style: TextStyle(
            fontSize: 26,
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Hours',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ],
    ),
  );
}
