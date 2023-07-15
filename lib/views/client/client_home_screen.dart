import 'package:appointify/utils/colors.dart';
import 'package:flutter/material.dart';
import 'client_appointment_screen.dart';
import 'client_making_appointment_screen.dart';
import 'client_search_appointment_screen.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  PageController pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Apointify',
          style: TextStyle(color: AppColors.accentClr),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.whiteClr,
        iconTheme: const IconThemeData(
          color: AppColors.accentClr,
        ),
        actions: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Image.asset(
                "./assets/images/appointify.png",
                width: 100,
              ),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.accentClr,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle settings tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                // Handle notifications tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Change Language'),
              onTap: () {
                // Handle language selection tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              onTap: () {
                // Handle dark mode toggle tap
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.bottomCenter,
              child: const Text(
                'App Version: 1.0.0',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: _onPageChanged,
        children: const [
          AppointmentsScreen(),
          SearchAppointmentScreen(),
          MakingAppointmentScreen(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const MakingAppointmentScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  final tween = Tween(begin: begin, end: end);
                  final offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 500),
              ),
            );
          },
          backgroundColor: AppColors.accentClr,
          child: const Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 46.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => _onTabTapped(0),
                icon: Icon(
                  Icons.home,
                  color: _currentIndex == 0 ? AppColors.accentClr : Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () => _onTabTapped(1),
                icon: Icon(
                  Icons.search,
                  color: _currentIndex == 1 ? AppColors.accentClr : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



















// import 'package:appointify/utils/colors.dart';
// import 'package:flutter/material.dart';
// import '../../widgets/appointment_card.dart';

// class ClientHomeScreen extends StatefulWidget {
//   const ClientHomeScreen({super.key});

//   @override
//   State<ClientHomeScreen> createState() => _ClientHomeScreenState();
// }

// class _ClientHomeScreenState extends State<ClientHomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Apointify',
//           style: TextStyle(color: AppColors.accentClr),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: AppColors.whiteClr,
//         iconTheme: const IconThemeData(
//           color: AppColors.accentClr,
//         ),
//         actions: [
//           Builder(
//             builder: (context) => GestureDetector(
//               onTap: () {
//                 Scaffold.of(context).openDrawer();
//               },
//               child: Image.asset(
//                 "./assets/images/appointify.png",
//                 width: 100,
//               ),
//             ),
//           ),
//         ],
//       ),
//       endDrawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: AppColors.accentClr,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 50,
//                     backgroundImage: AssetImage('assets/images/profile.png'),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'John Doe',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings),
//               title: const Text('Settings'),
//               onTap: () {
//                 // Handle settings tap
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.notifications),
//               title: const Text('Notifications'),
//               onTap: () {
//                 // Handle notifications tap
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.language),
//               title: const Text('Change Language'),
//               onTap: () {
//                 // Handle language selection tap
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.dark_mode),
//               title: const Text('Dark Mode'),
//               onTap: () {
//                 // Handle dark mode toggle tap
//               },
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               alignment: Alignment.bottomCenter,
//               child: const Text(
//                 'App Version: 1.0.0',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       const Text(
      //         'Upcoming Appointments',
      //         style: TextStyle(
      //           fontSize: 18,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       const SizedBox(height: 16),
      //       const AppointmentCard(
      //         title: 'Dentist Appointment',
      //         date: 'July 15, 2023',
      //         time: '10:00 AM',
      //         location: 'Dental Clinic',
      //       ),
      //       const SizedBox(height: 16),
      //       const AppointmentCard(
      //         title: 'Massage Therapy',
      //         date: 'July 20, 2023',
      //         time: '2:30 PM',
      //         location: 'Spa Center',
      //       ),
      //       const SizedBox(height: 16),
      //       const Text(
      //         'Past Appointments',
      //         style: TextStyle(
      //           fontSize: 18,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       const SizedBox(height: 16),
      //       Expanded(
      //         child: ListView.builder(
      //           itemCount: 10,
      //           itemBuilder: (context, index) {
      //             return AppointmentCard(
      //               title: 'Appointment ${index + 1}',
      //               date: 'July ${index + 1}, 2023',
      //               time: '9:00 AM',
      //               location: 'Location ${index + 1}',
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 16.0),
//         child: FloatingActionButton(
//           onPressed: () {},
//           backgroundColor: AppColors.accentClr,
//           child: const Icon(Icons.add),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 46.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   // Handle navigation to the desired screen
//                 },
//                 icon: const Icon(Icons.calendar_month_sharp),
//               ),
//               IconButton(
//                 onPressed: () {
//                   // Handle navigation to the desired screen
//                 },
//                 icon: const Icon(Icons.search),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
