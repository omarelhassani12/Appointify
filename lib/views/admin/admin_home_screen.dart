import 'package:appointify/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../models/appointment.dart';
import '../client/client_search_appointment_screen.dart';
import 'admin_edit_store_screen.dart';
import 'admin_store_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  PageController pageController = PageController();
  int _currentIndex = 0;
  bool _isSearching = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: PageView(
        controller: pageController,
        onPageChanged: _onPageChanged,
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                leading: null,
                expandedHeight: MediaQuery.of(context).size.height * 0.20,
                backgroundColor: AppColors.whiteClr,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 20),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: GridView.count(
                              crossAxisCount: 3,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 7,
                              childAspectRatio: 1,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showToast('Today\'s Appointments: 5',
                                        Colors.blue);
                                  },
                                  child: _buildCardWithTitle(
                                      Icons.calendar_today, '5', Colors.blue),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showToast('Total Appointments: 800',
                                        AppColors.accentClr);
                                  },
                                  child: _buildCardWithTitle(
                                      Icons.calendar_month,
                                      '800',
                                      AppColors.accentClr),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showToast('Rating: 4.5', Colors.orange);
                                  },
                                  child: _buildCardWithTitle(
                                      Icons.person, '4.5', Colors.orange),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'Today\'s Appointments',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentClr,
                        ),
                      ),
                      const SizedBox(height: 8),
                      FutureBuilder<List<Appointment>>(
                        future: _fetchAppointmentsForToday(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No appointments for today.'));
                          } else {
                            return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final appointment = snapshot.data![index];
                                return ListTile(
                                  leading: const CircleAvatar(
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.accentClr,
                                    ),
                                  ),
                                  title: Text('Name: ${appointment.name}'),
                                  subtitle: Text('Time: ${appointment.time}'),
                                  onTap: () {},
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const AdminStoreScreen(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AdminEditStoreScreen()),
            );
          },
          backgroundColor: AppColors.accentClr,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
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
                  Icons.store,
                  color: _currentIndex == 1 ? AppColors.accentClr : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          Expanded(
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
                        backgroundImage: AssetImage('assets/images/admin.png'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Admin',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Account Settings'),
                  onTap: () {
                    // Handle account settings tap
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
                ListTile(
                  leading: const Icon(Icons.question_answer),
                  title: const Text('FAQ'),
                  onTap: () {
                    // Handle settings tap
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About Us'),
                  onTap: () {
                    // Handle "About Us" tap
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.feedback),
                  title: const Text('Feedback'),
                  onTap: () {
                    // Handle feedback tap
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_support),
                  title: const Text('Contact Support'),
                  onTap: () {
                    // Handle contact support tap
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.local_offer),
                  title: const Text('Terms of Service'),
                  onTap: () {
                    // Handle terms of service tap
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.bottomCenter,
            child: const Text(
              'V 1.0.0',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: InkWell(
        onTap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        child: Image.asset(
          "./assets/images/appointify.png",
          width: 100,
        ),
      ),
      title: _isSearching
          ? TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
              onSubmitted: (value) {},
            )
          : const Text(
              'Appointify',
              style: TextStyle(color: AppColors.accentClr),
            ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.whiteClr,
      actions: _isSearching
          ? [
              IconButton(
                onPressed: () {
                  setState(() {
                    _isSearching = false;
                  });
                },
                icon: const Icon(Icons.cancel),
                color: AppColors.accentClr,
              )
            ]
          : [
              IconButton(
                onPressed: () {
                  setState(() {
                    _isSearching = true;
                  });
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const SearchAppointmentScreen(),
                  //   ),
                  // );
                },
                icon: const Icon(Icons.search),
                color: AppColors.accentClr,
              ),
            ],
    );
  }

  void _showToast(String message, Color bgColor) {
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
    double height = 20,
  }) {
    return Card(
      color: color,
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(10),
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

  Future<List<Appointment>> _fetchAppointmentsForToday() async {
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm');
    return List.generate(
      20,
      (index) => Appointment(
        name: 'Client ${index + 1}',
        time:
            formatter.format(DateTime(now.year, now.month, now.day, 9 + index)),
        day: 'Monday',
        phone: '123-456-7890',
      ),
    );
  }
}
