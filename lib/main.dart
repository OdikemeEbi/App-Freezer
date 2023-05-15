import 'package:app_lock/homescreen.dart';
import 'package:app_lock/models/preferences.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SharedPreferencesProvider>(
          create: (_) => SharedPreferencesProvider(),
        ),
        // Add more providers here if needed
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'App Locker',
          home: HomeScreen()),
    );
  }
}

// class LockScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('App Locker'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             final status = await Permission.storage.request();
//             if (status.isGranted) {
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (_) => A,
//               ));
//             }
//             // TODO: Handle permission denied

//             else {
//               showDialog(
//                 context: context,
//                 builder: (_) => AlertDialog(
//                   title: Text('Unsupported platform'),
//                   content: Text('This feature is only available on Android.'),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: Text('OK'),
//                     ),
//                   ],
//                 ),
//               );
//             }
//           },
//           child: Text('Select Apps to Lock'),
//         ),
//       ),
//     );
//   }
// }
