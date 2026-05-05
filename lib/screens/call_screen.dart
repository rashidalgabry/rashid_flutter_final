import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class CallScreen extends StatefulWidget {
  final String phone;

  const CallScreen({super.key, required this.phone});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {

  @override
  void initState() {
    super.initState();
    DBHelper.instance.insertRecent(widget.phone); // ✅ هنا المكان الصحيح
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            const SizedBox(height: 60),

            Column(
              children: [
                Text(
                  widget.phone,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Calling...',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),

            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 40),
              children: const [
                _CallIcon(icon: Icons.mic_off, label: 'Mute'),
                _CallIcon(icon: Icons.dialpad, label: 'Keypad'),
                _CallIcon(icon: Icons.volume_up, label: 'Speaker'),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                child: const Icon(Icons.call_end),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CallIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _CallIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade800,
          radius: 28,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
