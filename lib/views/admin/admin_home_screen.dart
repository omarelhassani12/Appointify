import 'package:appointify/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'admin_appointment_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
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
              'Apointify Admin', // Replace with appropriate title for Admin
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
                  // Perform search here
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
                    backgroundImage: AssetImage(
                        'assets/images/admin.png'), // Replace with admin avatar
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Admin User', // Replace with admin name
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
            flex: 3, // 30% of the available height
            child: Padding(
              padding: const EdgeInsets.only(left: 1, right: 1, top: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.2, // 30% of the screen height
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 0.8,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showToast('Today\'s Appointments: 5', Colors.blue);
                      },
                      child: _buildCardWithTitle(
                        Icons.calendar_today,
                        '5',
                        Colors.blue,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showToast(
                            'Total Appointments: 800', AppColors.accentClr);
                      },
                      child: _buildCardWithTitle(
                        Icons.calendar_month,
                        '800',
                        AppColors.accentClr,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showToast('Rating: 4.5', Colors.orange);
                      },
                      child: _buildCardWithTitle(
                        Icons.person,
                        '4.5',
                        Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7, // 70% of the available height
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.7, // 70% of the screen height
                child: PageView(
                  controller: pageController,
                  onPageChanged: _onPageChanged,
                  children: const [
                    AdminAppointmentsScreen(),
                    // AdminHistoryAppointmentScreen(),
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
            // Handle the action when the FloatingActionButton is pressed
            // For example, show a dialog to create a new item
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

  void _showToast(String message, bgColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: bgColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Widget _buildCardWithTitle(
    IconData icon,
    String count,
    Color color, {
    double width = 90,
    double height = 10,
  }) {
    return Card(
      color: color,
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(height: 5),
              Text(
                count,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




