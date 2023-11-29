// import 'package:flutter/material.dart';
// import 'dart:math' as math;
// class ExpandableFab extends StatefulWidget {
//   const ExpandableFab({super.key});
//   @override
//   State<ExpandableFab> createState() => _ExpandableFabState();
// }
// class _ExpandableFabState extends State<ExpandableFab> {
//   late AnimationController _controller;
//   late Animation<double> _expandAnimation;
//   bool _open = false;
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       value: _open ? 1.0 : 0.0,
//       duration: const Duration(milliseconds: 250),
//       vsync: this,
//     );
//     _expandAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.fastOutSlowIn,
//       reverseCurve: Curves.easeOutQuad,
//     );
//   }
//   void _toggle() {
//     setState(() {
//       _open = !_open;
//       if (_open) {
//         _controller.forward();
//       } else {
//         _controller.reverse();
//       }
//     });
//   }
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.bottomRight,
//       children: [
//         _tapToClose(),
//         _tapToOpen(),
//       ],
//     );
//   }
//   Widget _tapToClose() {
//     return SizedBox(
//       height: 55,
//       width: 55,
//       child: Material(
//         shape: const CircleBorder(),
//         clipBehavior: Clip.antiAlias,
//         elevation: 4.0,
//         child: InkWell(
//           onTap: _toggle,
//           child: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Icon(
//               Icons.close,
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _tapToOpen() {
//     return AnimatedContainer(
//       duration: const Duration(
//         milliseconds: 250,
//       ),
//       transformAlignment: Alignment.center,
//       transform: Matrix4.diagonal3Values(
//         _open ? 0.7 : 1.0,
//         _open ? 0.1 : 1.0,
//         1.0,
//       ),
//       curve: Curves.easeOut,
//       child: AnimatedOpacity(
//         opacity: _open ? 0.0 : 1.0,
//         duration: const Duration(milliseconds: 250),
//         child: FloatingActionButton(
//           onPressed: _toggle,
//           child: const Icon(Icons.create),
//         ),
//       ),
//     );
//   }
//   List<Widget> _buildExpandableFabEidget() {
//     final List<Widget> children;
//     final count = widget.debugDescribeChildren().length;
//     final step = 90.0 / (count - 1);

//     for (var i = 0, angleInDegrees = 0.0; i < count; i++, angleInDegrees += step) {
//       children.add(_ExpandableFab(directionDegrees: angleInDegrees, maxDistance: widget.distance, progress: progress, child: child))
//     }
//   }
// }
// class _ExpandableFab extends StatelessWidget {
//   const _ExpandableFab(
//       {super.key,
//       required this.directionDegrees,
//       required this.maxDistance,
//       required this.progress,
//       required this.child});

//   final double directionDegrees;
//   final double maxDistance;
//   final Animation<double>? progress;
//   final Widget child;
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: progress!,
//       builder: (context, child) {
//         final offset = Offset.fromDirection(
//           directionDegrees * (math.pi / 100),
//           progress!.value * maxDistance,
//         );
//         return Positioned(
//           right: 4.0 * offset.dx,
//           bottom: 4.0 * offset.dy,
//           child: Transform.rotate(
//             angle: (1.0 - progress!.value) * math.pi / 2,
//             child: child,
//           ),
//         );
//       },
//       child: FadeTransition(
//         opacity: progress!,
//         child: child,
//       ),
//     );
//   }
// }

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class ExpandableFabScreen extends StatefulWidget {
  const ExpandableFabScreen({super.key});

  @override
  State<ExpandableFabScreen> createState() => _ExpandableFabScreenState();
}

class _ExpandableFabScreenState extends State<ExpandableFabScreen> {
  final _key = GlobalKey<_ExpandableFabScreenState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ExpandableFab(
        key: _key,
        duration: const Duration(milliseconds: 250),
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Icons.abc),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Colors.amber,
          backgroundColor: Colors.green,
          shape: const CircleBorder(),
          angle: math.pi * 2,
        ),
        closeButtonBuilder: FloatingActionButtonBuilder(
          size: 56,
          builder: (context, onPressed, progress) {
            return IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.check_circle_outline),
            );
          },
        ),
        children: [
          FloatingActionButton.small(
            onPressed: () {
              const SnackBar(content: Text('add pressed'));
              // scaffoldKey.currentState?.showSnackBar(snackBar);
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton.small(
            onPressed: () {
              const SnackBar(content: Text('menu pressed'));
            },
            child: const Icon(Icons.menu),
          ),
        ],
      ),
    );
  }

//   Widget getExpandableFab() {
//     return ExpandableFab(
//       children: [],
//     );
//   }
}
