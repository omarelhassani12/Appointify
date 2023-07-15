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
  bool _isSearching = false;

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

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: _isSearching
          ? IconButton(
              onPressed: () {
                setState(() {
                  _isSearching = false;
                });
              },
              icon: const Icon(Icons.cancel),
              color: AppColors.accentClr,
            )
          : IconButton(
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
              },
              icon: const Icon(Icons.search),
              color: AppColors.accentClr,
            ),
      title: _isSearching
          ? TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                // Perform search based on the input value
                // You can add your search logic here
              },
            )
          : const Text(
              'Apointify',
              style: TextStyle(color: AppColors.accentClr),
            ),
      centerTitle: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.whiteClr,
      actions: _isSearching
          ? [
              IconButton(
                onPressed: () {
                  // Perform search validation
                },
                icon: const Icon(Icons.check),
                color: AppColors.accentClr,
              ),
              IconButton(
                onPressed: () {
                  // Perform filtering
                },
                icon: const Icon(Icons.filter_list),
                color: AppColors.accentClr,
              ),
            ]
          : [
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      endDrawer: Drawer(
          // Drawer content
          ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).padding.top,
                child: PageView(
                  controller: pageController,
                  onPageChanged: _onPageChanged,
                  children: const [
                    AppointmentsScreen(),
                    // CategorieAppointmentScreen(),
                    // MakingAppointmentScreen(),
                  ],
                ),
              ),
            ),
          ),
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






