// import 'package:flutter/material.dart';
// import 'package:naturefarm/model/pakan/pakan.dart';
// import 'package:intl/intl.dart'; // Tambahkan import untuk DateFormat

// class PakanDetailScreen extends StatelessWidget {
//   final Pakan pakan;

//   const PakanDetailScreen(
//       {super.key, required this.pakan}); // Tambahkan const constructor
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(pakan.namaPakan),
//         backgroundColor: const Color(0xFF224D31),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (pakan.gambar != null)
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.network(
//                     'http://10.0.2.2:8000/storage/${pakan.gambar}',
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: Colors.grey[300],
//                         child: const Icon(Icons.error),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             const SizedBox(height: 20),
//             Text(
//               pakan.namaPakan,
//               style: Theme.of(context).textTheme.titleLarge, // Ganti headline5
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 Chip(
//                   label: Text(
//                     pakan.statusText ?? 'No Status', // Tambahkan null check
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   backgroundColor:
//                       pakan.statusColor ?? Colors.grey, // Tambahkan null check
//                 ),
//                 const SizedBox(width: 10),
//                 Text(
//                   'Stok: ${pakan.stok}',
//                   style: Theme.of(context)
//                       .textTheme
//                       .titleMedium, // Ganti subtitle1
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Deskripsi:',
//               style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//             const SizedBox(height: 8),
//             Text(pakan.deskripsi),
//             const SizedBox(height: 16),
//             Text(
//               'Ditambahkan pada: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(pakan.createdAt))}',
//               style: Theme.of(context).textTheme.bodySmall, // Ganti caption
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
