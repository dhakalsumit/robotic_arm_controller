import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final ipProvider = StateProvider<String>((ref) => '');

class IPConfigScreen extends ConsumerStatefulWidget {
  const IPConfigScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<IPConfigScreen> createState() => _IPConfigScreenState();
}

class _IPConfigScreenState extends ConsumerState<IPConfigScreen> {
  late Box<String> _ipBox;
  final TextEditingController _ipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    _ipBox = await Hive.openBox<String>('ipBox'); // Open the Hive box
    String? savedIP = _ipBox.get('ip', defaultValue: '');
    ref.read(ipProvider.notifier).state = savedIP!;
    _ipController.text = savedIP!;
  }

  void _saveIP() async {
    String ip = _ipController.text.trim();
    await _ipBox.put('ip', ip);
    ref.read(ipProvider.notifier).state = ip;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('IP address saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    String currentIP = ref.watch(ipProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('IP Configuration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter the Server IP:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: TextField(
                focusNode: FocusNode(),
                controller: _ipController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      currentIP.isNotEmpty ? ' $currentIP' : '192.168.4.1',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _saveIP,
                  child: const Text('Save IP'),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }
}