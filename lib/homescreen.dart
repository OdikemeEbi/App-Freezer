import 'package:app_lock/models/preferences.dart';
import 'package:app_lock/provider/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:provider/provider.dart';

// import 'app_info.dart';
import 'models/app_models.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AppInfo> _installedApps = [];
  bool isLoading = false;

  late SharedPreferencesProvider _sharedPreferencesProvider;

  @override
  void initState() {
    super.initState();
    getInstalledApps();
    _sharedPreferencesProvider = SharedPreferencesProvider();
  }

  Future<void> _lockApps(
      List<String> selectedPackages, Duration lockDuration) async {
    final sharedPreferencesProvider =
        Provider.of<SharedPreferencesProvider>(context, listen: false);

    await Future.wait(selectedPackages.map((packageName) async {
      final appIcon = sharedPreferencesProvider.getAppIcon(packageName);
      final appName = sharedPreferencesProvider.getAppName(packageName);

      if (appIcon != null && appName != null) {
        await sharedPreferencesProvider.saveAppIcon(packageName, appIcon);
        await sharedPreferencesProvider.saveAppName(packageName, appName);

        print('Locked app: $packageName');

        if (appIcon != null) {
          await sharedPreferencesProvider.saveAppIcon(packageName, appIcon);
        } else {
          // Handle the case when appIcon is null
          final defaultAppIcon = appIcon;
          final defaultAppName = packageName;

          await sharedPreferencesProvider.saveAppIcon(packageName, appIcon);
          await sharedPreferencesProvider.saveAppName(packageName, appName);
        }

        await sharedPreferencesProvider.saveAppName(
            packageName, 'Locked - ${lockDuration.inMinutes} mins');
      }
    }));

    await Future.delayed(lockDuration);

    await Future.wait(selectedPackages.map((packageName) async {
      final originalAppIcon = sharedPreferencesProvider.getAppIcon(packageName);
      final originalAppName = sharedPreferencesProvider.getAppName(packageName);

      await sharedPreferencesProvider.saveAppIcon(
          packageName, originalAppIcon!);
      await sharedPreferencesProvider.saveAppName(
          packageName, originalAppName!);
    }));
  }

  @override
  Widget build(BuildContext context) {
    // // ignore: no_leading_underscores_for_local_identifiers
    // final _sharedPreferencesProvider =
    //     Provider.of<SharedPreferencesProvider>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => _sharedPreferencesProvider,
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Freeze App'),
        // ),
        body: SafeArea(
          child: Stack(
            children: [
              if (isLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child:
                        CircularProgressIndicator(), // Show the CircularProgressIndicator while loading
                  ),
                ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _installedApps
                                .forEach((app) => app.isSelected = false);
                          });
                        },
                        icon: _installedApps.any((app) => app.isSelected!)
                            ? Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.amberAccent,
                                ),
                                child: const Icon(Icons.remove),
                              )
                            : const SizedBox(),
                      ),
                      IconButton(
                          onPressed: () {
                            getInstalledApps();
                          },
                          icon: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.amberAccent),
                              child: const Icon(Icons.add))),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      height: 500,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 2 / 2,
                          // mainAxisSpacing: 2,
                          // crossAxisSpacing: 2,
                        ),
                        itemCount: _installedApps.length,
                        itemBuilder: (context, index) {
                          final app = _installedApps[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  app.isSelected = !app.isSelected!;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: app.isSelected!
                                      ? Color.fromARGB(255, 201, 196, 196)
                                      : Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    app.appIcon != null
                                        ? Image.memory(
                                            app.appIcon!,
                                            width: 30,
                                            height: 30,
                                          )
                                        : Icon(Icons.android),
                                    SizedBox(height: 8),
                                    Text(
                                      app.appName,
                                      style: TextStyle(fontSize: 10),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    // Text(
                                    //   app.packageName,
                                    //   textAlign: TextAlign.center,
                                    //   maxLines: 1,
                                    //   overflow: TextOverflow.ellipsis,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              Positioned(
                bottom: 20,
                right: 60,
                child: FloatingActionButton(
                  onPressed: () {
                    myBottomModalSheet(context, (Duration duration) {
                      _sharedPreferencesProvider.selectedPackages =
                          _installedApps
                              .where((app) => app.isSelected!)
                              .map((app) => app.packageName)
                              .toList();
                      _sharedPreferencesProvider.lockDuration = duration;
                      _lockApps(_sharedPreferencesProvider.selectedPackages,
                          duration);

                      print(
                          'Selected apps to lock: ${_sharedPreferencesProvider.selectedPackages}');
                    });
                  },
                  tooltip: 'Lock apps',
                  child: Icon(Icons.lock_clock),
                ),
              ),
              //  FloatingActionButton(
              //   onPressed: () {
              //     myBottomModalSheet();
              //     List<String> selectedPackages = [];
              //     for (var app in _installedApps) {
              //       if (app.isSelected!) {
              //         selectedPackages.add(app.packageName);
              //       }
              //     }
              //     print('Selected apps to lock: $selectedPackages');
              //   },
              //   tooltip: 'Lock apps',
              //   child: Icon(Icons.lock_clock),
              // ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void getInstalledApps() async {
    try {
      List<Application> apps = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        // onlyAppsWithLaunchIntent: true,
        includeSystemApps: false,
      );

      setState(() {
        _installedApps = apps
            .map((app) => AppInfo(
                  appName: app.appName,
                  packageName: app.packageName,
                  versionName: app.versionName.toString(),
                  versionCode: app.versionCode,
                  appIcon: app is ApplicationWithIcon ? app.icon : null,
                ))
            .toList();
      });
    } catch (e) {
      // Handle the exception here
      print('Error fetching installed apps: $e');
    }
  }
}
