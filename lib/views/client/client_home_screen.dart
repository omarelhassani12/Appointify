import 'package:appointify/utils/colors.dart';
import 'package:flutter/material.dart';
import 'client_appointment_screen.dart';
import 'client_categories_appointment_screen.dart';
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
  String _selectedFilter = '';

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
    IconData filterIcon = Icons.filter_list; // Default filter icon

    // Update the filter icon based on the selected filter
    if (_selectedFilter == 'country') {
      filterIcon = Icons.location_on;
    } else if (_selectedFilter == 'city') {
      filterIcon = Icons.location_city;
    } else if (_selectedFilter == 'category') {
      filterIcon = Icons.category;
    } else if (_selectedFilter == 'stars') {
      filterIcon = Icons.star;
    }
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
              'Appointify',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchAppointmentScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.search),
                color: AppColors.accentClr,
              ),
              PopupMenuButton<String>(
                onSelected: _onFilterSelected,
                itemBuilder: (BuildContext context) {
                  return [
                    _buildFilterMenuItem(
                        'country', Icons.location_on, 'Country'),
                    _buildFilterMenuItem('city', Icons.location_city, 'City'),
                    _buildFilterMenuItem(
                        'category', Icons.category, 'Category'),
                    _buildFilterMenuItem('stars', Icons.star, 'Stars'),
                  ];
                },
                icon: Icon(
                  filterIcon,
                  color: AppColors.accentClr,
                ),
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

  void _onFilterSelected(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  PopupMenuItem<String> _buildFilterMenuItem(
      String value, IconData icon, String text) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
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
                    backgroundImage: AssetImage('assets/images/client.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'client',
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).padding.top,
                child: PageView(
                  controller: pageController,
                  onPageChanged: _onPageChanged,
                  children: const [
                    AppointmentsScreen(),
                    CategoriesAppointmentScreen(),
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
          child: const Icon(Icons.add, color: Colors.white),
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
                  Icons.category,
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
