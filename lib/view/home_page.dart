import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_tracer_app/controller/providers/location_provider.dart';
import 'package:location_tracer_app/view/widgets/gridview_widget.dart';

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
              child: const GridviewWidget(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 450, mainAxisExtent: 90),
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: ref.watch(locationProvider).locations.length,
                itemBuilder: (context, index) {
                  final data = ref.watch(locationProvider).locations[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFf2f2f2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Request ${index + 1}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lat :${data.latitude.toStringAsFixed(1)}",
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              "Lng :${data.longitude.toStringAsFixed(1)}",
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              "Speed : ${data.speed.toStringAsFixed(1)}m",
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
