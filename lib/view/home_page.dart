import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_tracer_app/controller/loctaion_controller.dart';
import 'package:location_tracer_app/controller/providers/location_provider.dart';
import 'package:location_tracer_app/view/widgets/button_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff333333),
        title: const Text(
          'Test App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 24),
              color: const Color(0xff333333),
              child: GridView(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 430, mainAxisExtent: 65),
                children: [
                  ButtonWidget(
                    buttonName: 'Request Location Permission',
                    onPressed: () async {
                      if (await isLocationEnabled()) {
                        if (await requestLocationPermission()) {
                          log('Location permission granted');
                        } else {
                          log('Location permission denied');
                        }
                      } else {
                        log('Location not enabled');
                      }
                    },
                    buttonColor: const Color(0xFF2f80ed),
                  ),
                  ButtonWidget(
                    buttonName: 'Request Notification Permission',
                    onPressed: () {
                      {
                        AwesomeNotifications()
                            .requestPermissionToSendNotifications();
                        log("Notification permission granted");
                      }
                    },
                    buttonColor: const Color(0xFFf2c94c),
                  ),
                  ButtonWidget(
                    buttonName: 'Start Location Update',
                    onPressed: () async {
                      if (await requestLocationPermission()) {
                        /// Check if the app has permission
                        Future.sync(() => showDialog(
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Do you want to start location tracing',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: (() {
                                          Navigator.pop(context);
                                        }),
                                        child: const Text('No')),
                                    TextButton(
                                      onPressed: () {
                                        ref
                                            .read(locationProvider.notifier)
                                            .startLocationTracing();
                                        AwesomeNotifications()
                                            .createNotification(
                                          content: NotificationContent(
                                            id: 1,
                                            channelKey: 'location-update',
                                            actionType: ActionType.Default,
                                            title: 'Location updating started',
                                          ),
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Yes'),
                                    )
                                  ],
                                );
                              }),
                            ));
                      } else {
                        Future.sync(() => showDialog(
                              context: context,
                              builder: ((context) {
                                return const AlertDialog(
                                  title: Text('Alert'),
                                  content: Text('Enable Location permission'),
                                );
                              }),
                            ));
                      }
                    },
                    buttonColor: const Color(0xFF27ae60),
                  ),
                  ButtonWidget(
                    buttonName: 'Stop Location Update',
                    onPressed: () {
                      ref.read(locationProvider.notifier).stopLocationTracing();
                      AwesomeNotifications().createNotification(
                        content: NotificationContent(
                          id: 2,
                          channelKey: 'location-update',
                          actionType: ActionType.Default,
                          title: 'Location updating stoped',
                        ),
                      );
                    },
                    buttonColor: const Color(0xFFeb5757),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
