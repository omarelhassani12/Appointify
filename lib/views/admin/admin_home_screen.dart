import 'package:appointify/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../models/appointment.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
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
              'Appointify Admin', // Replace with appropriate title for Admin
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
            ]
          : [
              GestureDetector(
                onTap: () {
                  // You can add custom action when the Appointify logo is tapped
                },
                child: Image.asset(
                  "./assets/images/appointify.png",
                  width: 100,
                ),
              ),
            ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: CustomScrollView(
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
                    flex: 1, // 30% of the available height
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.1, // 30% of the screen height
                        child: GridView.count(
                          crossAxisCount: 3,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showToast(
                                    'Today\'s Appointments: 5', Colors.blue);
                              },
                              child: _buildCardWithTitle(
                                  Icons.calendar_today, '5', Colors.blue),
                            ),
                            GestureDetector(
                              onTap: () {
                                _showToast('Total Appointments: 800',
                                    AppColors.accentClr);
                              },
                              child: _buildCardWithTitle(Icons.calendar_month,
                                  '800', AppColors.accentClr),
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
                  const SizedBox(
                      height:
                          8), // Add some spacing between the text and the appointments list
                  FutureBuilder<List<Appointment>>(
                    future: _fetchAppointmentsForToday(),
                    // Replace with your method to fetch appointments
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No appointments for today.'));
                      } else {
                        return ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final appointment = snapshot.data![index];
                            return ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              title: Text('Name: ${appointment.name}'),
                              subtitle: Text('Time: ${appointment.time}'),
                              // Add more appointment details as needed
                              onTap: () {
                                // Add onTap functionality for each appointment if needed
                              },
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.accentClr,
          child: const Icon(Icons.edit),
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

  Future<List<Appointment>> _fetchAppointmentsForToday() async {
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm');
    return List.generate(
      20,
      (index) => Appointment(
        name: 'Client ${index + 1}',
        time:
            formatter.format(DateTime(now.year, now.month, now.day, 9 + index)),
        day: 'Monday', // Replace with the actual day of the appointment
        phone: '123-456-7890', // Replace with the actual phone number
      ),
    );
  }
}

