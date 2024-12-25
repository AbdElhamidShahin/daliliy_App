// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class Exercise {
//   final String title;
//   final String details;
//   final String image;
//   final List<String> instructions;
//
//   Exercise({
//     required this.title,
//     required this.details,
//     required this.image,
//     required this.instructions,
//   });
// }
//
// class ExerciseScreen extends StatelessWidget {
//   final String currentDay;
//
//   ExerciseScreen({Key? key, required this.currentDay}) : super(key: key);
//
//   final List<Exercise> exercises = [
//     Exercise(
//       title: 'تمرين الضغط',
//       details: 'تمرين رائع لتقوية عضلات الصدر والذراعين.',
//       image: 'assets/images/pushup.jpg',
//       instructions: ['وضعية الجسم مستقيمة', 'النزول والصعود ببطء'],
//     ),
//     Exercise(
//       title: 'تمرين السكوات',
//       details: 'يساعد في تقوية عضلات الساقين والمؤخرة.',
//       image: 'assets/images/squat.jpg',
//       instructions: ['الحفاظ على الظهر مستقيم', 'النزول للأسفل بثبات'],
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[500],
//       appBar: AppBar(
//         title: Text(' $currentDay'),
//       ),
//       body: exercises.isNotEmpty
//           ? ListView.builder(
//         itemCount: exercises.length,
//         itemBuilder: (context, index) {
//           final item = exercises[index];
//           return ExerciseCard(exercise: item);
//         },
//       )
//           : Center(
//         child: Text(
//           'لا توجد تمارين متاحة',
//           style: GoogleFonts.changa(
//             fontSize: 20,
//             color: Colors.amber,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ExerciseCard extends StatelessWidget {
//   final Exercise exercise;
//
//   const ExerciseCard({Key? key, required this.exercise}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _showDialog(context, exercise),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         child: Container(
//           height: 150,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: Colors.white30,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 150,
//                 height: 150,
//                 decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     bottomLeft: Radius.circular(20),
//                   ),
//                   image: DecorationImage(
//                     image: AssetImage(exercise.image),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         exercise.title,
//                         style: GoogleFonts.changa(
//                           fontSize: 20,
//                           color: Colors.amber,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         exercise.details,
//                         style: GoogleFonts.changa(
//                           fontSize: 16,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showDialog(BuildContext context, Exercise exercise) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: const Color(0xFF212121),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Image.asset(
//                 exercise.image,
//                 fit: BoxFit.cover,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 exercise.title,
//                 style: GoogleFonts.changa(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//                 textAlign: TextAlign.right,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 exercise.details,
//                 style: GoogleFonts.changa(
//                   fontSize: 18,
//                   color: Colors.white70,
//                 ),
//                 textAlign: TextAlign.right,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 'إغلاق',
//                 style: GoogleFonts.changa(color: Colors.amber),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
