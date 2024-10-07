// 1
import 'package:flutter/material.dart';
import '../models/cart_manager.dart';
import '../models/order_manager.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  // 2
  final CartManager cartManager;
  // 3
  final Function() didUpdate;
  // 4
  final Function(Order) onSubmit;

  const CheckoutPage(
      {super.key,
        required this.cartManager,
        required this.didUpdate,
        required this.onSubmit,
      });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // 5
  // TODO: Add State Properties
  // 1
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text('Delivery'),
    1: Text('Self Pick-Up'),
  };
// 2
  Set<int> selectedSegment = {0};
// 3
  TimeOfDay? selectedTime;
// 4
  DateTime? selectedDate;
// 5
  final DateTime _firstDate = DateTime(DateTime.now().year - 2);
  final DateTime _lastDate = DateTime(DateTime.now().year + 1);
// 6
  final TextEditingController _nameController = TextEditingController();

  // TODO: Configure Date Format
  // 1
  String formatDate(DateTime? dateTime) {
    // 2
    if (dateTime == null) {
      return 'Select Date';
    }
    // 3
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  // TODO: Configure Time of Day
  // 1
  String formatTimeOfDay(TimeOfDay? timeOfDay) {
    // 2
    if (timeOfDay == null) {
      return 'Select Time';
    }
    // 3
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // TODO: Set Selected Segment
  void onSegmentSelected(Set<int> segmentIndex) {
    setState(() {
      selectedSegment = segmentIndex;
    });
  }

  // TODO: Build Segmented Control
  Widget _buildOrderSegmentedType() {
    // 1
    return SegmentedButton(
      // 2
      showSelectedIcon: false,
      // 3
      segments: const [
        ButtonSegment(
          value: 0,
          label: Text('Delivery'),
          icon: Icon(Icons.pedal_bike),
        ),
        ButtonSegment(
          value: 1,
          label: Text('Pickup'),
          icon: Icon(Icons.local_mall),
        ),
      ],
      // 4
      selected: selectedSegment,
      // 5
      onSelectionChanged: onSegmentSelected,
    );
  }

  // TODO: Build Name Textfield
  Widget _buildTextField() {
    // 1
    return TextField(
      // 2
      controller: _nameController,
      // 3
      decoration: const InputDecoration(
        labelText: 'Contact Name',
      ),
    );
  }

  // TODO: Select Date Picker
  // 1
  void _selectDate(BuildContext context) async {
    // 2
    final picked = await showDatePicker(
      // 3
      context: context,
      // 4
      initialDate: selectedDate ?? DateTime.now(),
      // 5
      firstDate: _firstDate,
      lastDate: _lastDate,
    );
    // 6
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // TODO: Select Time Picker
  // 1
  void _selectTime(BuildContext context) async {
    // 2
    final picked = await showTimePicker(
      // 3
      context: context,
      // 4
      initialEntryMode: TimePickerEntryMode.input,
      //  5
      initialTime: selectedTime ?? TimeOfDay.now(),
      // 6
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child!,
        );
      },
    );
    // 7
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  // TODO: Build Order Summary
  // 1
  Widget _buildOrderSummary(BuildContext context) {
    // 2
    final colorTheme = Theme.of(context).colorScheme;

    // 3
    return Expanded(
      // 4
      child: ListView.builder(
        // 5
        itemCount: widget.cartManager.items.length,
        itemBuilder: (context, index) {
          // 6
          final item = widget.cartManager.itemAt(index);
          // 7
          // TODO: Wrap in a Dismissible Widget
          return Dismissible(
            // 1
            key: Key(item.id),
// 2
            direction: DismissDirection.endToStart,
// 3
            background: Container(),
// 4
            secondaryBackground: const SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete),
                ],
              ),
            ),
// 5
            onDismissed: (direction) {
              setState(() {
                widget.cartManager.removeItem(item.id);
              });
              // 6
              widget.didUpdate();
            },

            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8.0)),
                  border: Border.all(
                    color: colorTheme.primary,
                    width: 2.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(8.0)),
                  child: Text('x${item.quantity}'),
                ),
              ),
              title: Text(item.name),
              subtitle: Text('Price: \$${item.price}'),
            ),
          );
        },
      ),
    );
  }

  // TODO: Build Submit Order Button

  Widget _buildSubmitButton() {
    // 1
    return ElevatedButton(
      // 2
      onPressed: widget.cartManager.isEmpty
          ? null
      // 3
          : () {
        final selectedSegment = this.selectedSegment;
        final selectedTime = this.selectedTime;
        final selectedDate = this.selectedDate;
        final name = _nameController.text;
        final items = widget.cartManager.items;
        // 4
        final order = Order(
          selectedSegment: selectedSegment,
          selectedTime: selectedTime,
          selectedDate: selectedDate,
          name: name,
          items: items,
        );
        // 5
        widget.cartManager.resetCart();
        // 6
        widget.onSubmit(order);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        // 7
        child: Text(
            '''Submit Order - \$${widget.cartManager.totalCost.toStringAsFixed(2)}'''),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // 6
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    // 7
    return Scaffold(
      // 8
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      // 9
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Order Details',
              style: textTheme.headlineSmall,
            ),
            // TODO: Add Segmented Control
            const SizedBox(height: 16.0),
            _buildOrderSegmentedType(),

            // TODO: Add Name Textfield
            const SizedBox(height: 16.0),
            _buildTextField(),

            // TODO: Add Date and Time Picker
            // 1
            const SizedBox(height: 16.0),
// 2
            Row(
              children: [
                TextButton(
                  // 3
                  child: Text(formatDate(selectedDate)),
                  // 4
                  onPressed: () => _selectDate(context),
                ),
                TextButton(
                  // 5
                  child: Text(formatTimeOfDay(selectedTime)),
                  // 6
                  onPressed: () => _selectTime(context),
                ),
              ],
            ),
// 7
            const SizedBox(height: 16.0),

            // TODO: Add Order Summary
            const Text('Order Summary'),
            _buildOrderSummary(context),

            // TODO: Add Submit Order Button
            _buildSubmitButton(),

          ],
        ),
      ),
    );
  }
}
