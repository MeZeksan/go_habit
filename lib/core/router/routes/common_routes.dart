// part of '../app_router.dart';

// final _commonRoutes = [
//   GoRoute(
//     parentNavigatorKey: rootNavigatorKey,
//     path: TasksRoutes.taskBottomSheet.path,
//     name: TasksRoutes.taskBottomSheet.name,
//     pageBuilder: (context, state) {
//       final extra = state.extra as Map<String, Object?>? ?? {};

//       final type = extra['type'] ?? 'add';
//       final habit =
//           extra['habit'] != null && type == 'edit' ? (extra['habit'] as Map<String, dynamic>).toHabitFromJson() : null;

//       return CustomTransitionPage(
//         key: state.pageKey,
//         name: TasksRoutes.taskBottomSheet.name,
//         barrierColor: Colors.black54,
//         transitionDuration: const Duration(milliseconds: 500),
//         reverseTransitionDuration: const Duration(milliseconds: 500),
//         opaque: false,
//         barrierDismissible: true,
//         child: TaskBottomSheet(
//             habit: type == 'edit' ? habit : null,
//             type: switch (type) {
//               'add' => TaskBottomSheetType.add,
//               'edit' => TaskBottomSheetType.edit,
//               _ => TaskBottomSheetType.add
//             }),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           return SlideTransition(
//             position: Tween<Offset>(
//               begin: const Offset(0, 1),
//               end: Offset.zero,
//             ).animate(
//               CurvedAnimation(
//                 parent: animation,
//                 curve: Curves.easeOut,
//               ),
//             ),
//             child: child,
//           );
//         },
//       );
//     },
//   ),
// ];
