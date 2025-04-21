import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_product_tracker/core/functions/navigation/navigation.dart';
import 'package:smart_product_tracker/core/utils/helpers/helper_functions.dart';
import 'package:hive/hive.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final userBox = Hive.box('userBox');

    final firstName = userBox.get('first_name', defaultValue: 'Unknown');
    final lastName = userBox.get('last_name', defaultValue: '');
    final email = userBox.get('email', defaultValue: 'unknown@example.com');

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.account_circle, size: 100, color: isDark ? Colors.white70 : Colors.black54),
            const SizedBox(height: 16),

            // اسم المستخدم
            Text('$firstName $lastName', style: Theme.of(context).textTheme.headlineSmall),

            const SizedBox(height: 8),

            // البريد الإلكتروني
            Text(email, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey)),

            const SizedBox(height: 32),

            // أي عناصر إضافية تحب تضيفها هنا
            const Divider(),
            ListTile(
              leading: Icon(Icons.notifications, color: isDark ? Colors.white : Colors.black),
              title: Text("Total Alerts"),
              trailing: Text("4"), // لاحقًا نجيب العدد من AlertCubit مثلاً
            ),

            // مثال آخر
            ListTile(
              leading: Icon(Icons.info_outline, color: isDark ? Colors.white : Colors.black),
              title: Text("App Version"),
              trailing: Text("1.0.0"),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () async {
                print('+++++++++++++++0');

                final userBox = Hive.box('userBox');

                try {
                  await FirebaseAuth.instance.signOut();
                  await userBox.clear(); // امسح بيانات المستخدم
                  if (context.mounted) {
                    customNavigate(context, '/signIn');
                  }
                } catch (e) {
                  print('❌ Error signing out: $e');
                }
              },
              icon: const Icon(Icons.logout, size: 24, color: Colors.white),
              label: Text("Sign Out", style: TextStyle(fontSize: 15, color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: isDark ? Colors.red : Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

// class UserProfileView extends StatelessWidget {
//   const UserProfileView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDark = HelperFunctions.isDarkMode(context);
//     final user = FirebaseAuth.instance.currentUser;

//     return Scaffold(
//       appBar: AppBar(title: const Text("Your Profile"), centerTitle: true),
//       body: BlocBuilder<AlertCubit, AlertState>(
//         builder: (context, state) {
//           int alertCount = 0;
//           if (state is AlertLoaded) {
//             alertCount = state.alerts.length;
//           }

//           return Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Icon(Icons.account_circle, size: 100, color: isDark ? Colors.white70 : Colors.black54),
//                 const SizedBox(height: 24),
//                 Text(user?.email ?? "No email found", style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
//                 const SizedBox(height: 24),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(color: isDark ? Colors.grey[800] : Colors.grey[200], borderRadius: BorderRadius.circular(16)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text("Total Alerts", style: TextStyle(fontSize: 18)),
//                       Text("$alertCount", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//                 ElevatedButton.icon(
//                   onPressed: () async {
//                     // زر تسجيل الخروج
//                     IconButton(
//                       icon: Icon(Icons.logout),
//                       onPressed: () {
//                         customNavigate(context, '/signIn');
//                       },
//                     );
//                   },
//                   icon: const Icon(Icons.logout),
//                   label: const Text("Sign Out"),
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
