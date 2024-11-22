import 'package:flutter/material.dart';

void showBottomSheetToEditHour(
    BuildContext context, int currentHour, Function(int) onUpdate) {
  final TextEditingController controller =
      TextEditingController(text: currentHour.toString());

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

  void _updateSelectedDuration(int duration) {
    setState(() {
      selectedDuration = duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: selectedDuration.toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // const Text(
        //   'Edit Hours',
        //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        // ),
        // const SizedBox(height: 20),
        // TextField(
        //   controller: controller,
        //   keyboardType: TextInputType.number,
        //   decoration: const InputDecoration(
        //     labelText: 'Enter new hours',
        //     border: OutlineInputBorder(),
        //   ),
        //   onChanged: (value) {
        //     final int? parsedValue = int.tryParse(value);
        //     if (parsedValue != null) {
        //       _updateSelectedDuration(parsedValue);
        //     }
        //   },
        // ),
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
            itemCount: 10, // Example durations: 1 to 10 hours
            itemBuilder: (context, index) {
              int itemDuration = index + 1; // Durations 1-10
              return GestureDetector(
                onTap: () {
                  _updateSelectedDuration(itemDuration);
                  controller.text = itemDuration.toString();
                },
                child: _buildDurationItem(context, itemDuration,
                    isSelected: itemDuration == selectedDuration),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Sub Total',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              '10.00',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Hiring duration',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              '10.00',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            int? newHour = int.tryParse(controller.text);
            if (newHour != null) {
              widget.onUpdate(newHour);
              Navigator.pop(context); // Close BottomSheet
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Invalid input!')),
              );
            }
          },
          child: const Text('Save'),
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
