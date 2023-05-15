// import 'package:flutter/material.dart';

// void myBottomModalSheet(BuildContext context, Function(Duration) onSelected) {
//   showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) {
//       return Container(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               title: Text('Lock for 30 minutes'),
//               onTap: () {
//                 Navigator.pop(context);
//                 onSelected(const Duration(minutes: 30));
//               },
//             ),
//             ListTile(
//               title: Text('Lock for 1 hour'),
//               onTap: () {
//                 Navigator.pop(context);
//                 onSelected(const Duration(hours: 1));
//               },
//             ),
//             ListTile(
//               title: Text('Lock for 2 hours'),
//               onTap: () {
//                 Navigator.pop(context);
//                 onSelected(const Duration(hours: 2));
//               },
//             ),
//             ListTile(
//               title: Text('Lock for 1 day'),
//               onTap: () {
//                 Navigator.pop(context);
//                 onSelected(const Duration(days: 1));
//               },
//             ),
//             ListTile(
//               title: Text('Lock for 3 days'),
//               onTap: () {
//                 Navigator.pop(context);
//                 onSelected(const Duration(days: 3));
//               },
//             ),
//             ListTile(
//               title: Text('Lock for 1 week'),
//               onTap: () {
//                 Navigator.pop(context);
//                 onSelected(const Duration(days: 7));
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

import 'package:app_lock/models/preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void myBottomModalSheet(BuildContext context, Function(Duration) onSelected) {
  final sharedPreferencesProvider =
      Provider.of<SharedPreferencesProvider>(context, listen: false);
  List<String> selectedPackages = sharedPreferencesProvider.selectedPackages;
  Duration lockDuration = sharedPreferencesProvider.lockDuration;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Lock for 30 seconds'),
              onTap: () {
                sharedPreferencesProvider.selectedPackages = selectedPackages;
                sharedPreferencesProvider.lockDuration =
                    const Duration(minutes: 30);
                Navigator.pop(context);
                onSelected(const Duration(seconds: 30));
                print(onSelected);
              },
            ),
            ListTile(
              title: Text('Lock for 30 minutes'),
              onTap: () {
                sharedPreferencesProvider.selectedPackages = selectedPackages;
                sharedPreferencesProvider.lockDuration =
                    const Duration(minutes: 30);
                Navigator.pop(context);
                onSelected(const Duration(minutes: 30));
              },
            ),
            ListTile(
              title: Text('Lock for 1 hour'),
              onTap: () {
                sharedPreferencesProvider.selectedPackages = selectedPackages;
                sharedPreferencesProvider.lockDuration =
                    const Duration(hours: 1);
                Navigator.pop(context);
                onSelected(const Duration(hours: 1));
              },
            ),
            ListTile(
              title: Text('Lock for 2 hours'),
              onTap: () {
                sharedPreferencesProvider.selectedPackages = selectedPackages;
                sharedPreferencesProvider.lockDuration =
                    const Duration(hours: 2);
                Navigator.pop(context);
                onSelected(const Duration(hours: 2));
              },
            ),
            ListTile(
              title: Text('Lock for 1 day'),
              onTap: () {
                sharedPreferencesProvider.selectedPackages = selectedPackages;
                sharedPreferencesProvider.lockDuration =
                    const Duration(days: 1);
                Navigator.pop(context);
                onSelected(const Duration(days: 1));
              },
            ),
            ListTile(
              title: Text('Lock for 3 days'),
              onTap: () {
                sharedPreferencesProvider.selectedPackages = selectedPackages;
                sharedPreferencesProvider.lockDuration =
                    const Duration(days: 3);
                Navigator.pop(context);
                onSelected(const Duration(days: 3));
              },
            ),
            ListTile(
              title: Text('Lock for 1 week'),
              onTap: () {
                sharedPreferencesProvider.selectedPackages = selectedPackages;
                sharedPreferencesProvider.lockDuration =
                    const Duration(days: 7);
                Navigator.pop(context);
                onSelected(const Duration(days: 7));
              },
            ),
          ],
        ),
      );
    },
  );
}
