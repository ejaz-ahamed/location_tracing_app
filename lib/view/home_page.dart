import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_tracer_app/view/widgets/gridview_builder_widget.dart';
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: GridviewBuilderWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
