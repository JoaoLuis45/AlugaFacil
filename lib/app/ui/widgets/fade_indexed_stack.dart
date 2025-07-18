import 'package:aluga_facil/app/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FadeIndexedStack extends StatefulWidget {
  final int? index;
  final List<Widget> children;
  final Duration duration;

  const FadeIndexedStack({
    super.key,
    this.index,
    this.children = const <Widget>[],
    this.duration = const Duration(milliseconds: 800),
  });

  @override
  // ignore: library_private_types_in_public_api
  _FadeIndexedStackState createState() => _FadeIndexedStackState();
}

class _FadeIndexedStackState extends State<FadeIndexedStack> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     final homeController = Get.find<HomePageController>();
     WidgetsBinding.instance.addPostFrameCallback((_) {
       homeController.refreshPages();
     });
    return FadeTransition(
      opacity: _controller,
      child: IndexedStack(index: widget.index, children: widget.children),
    );
  }
}