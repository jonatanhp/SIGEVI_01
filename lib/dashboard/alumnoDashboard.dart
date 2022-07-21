import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigevi_1/utils/colors.dart';
import 'package:sigevi_1/utils/global_variable.dart';
import 'package:sigevi_1/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AlumnoDashboard extends StatefulWidget {
  const AlumnoDashboard({Key? key}) : super(key: key);

  @override
  State<AlumnoDashboard> createState() => _AlumnoDashboardState();
}

class _AlumnoDashboardState extends State<AlumnoDashboard> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  

  @override
  void initState() {
    super.initState();
    addData();
    pageController = PageController();
  }

  addData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeAlumnoScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_page == 0) ? primaryColor : secondaryColor,
            ),
            label: 'principall',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: (_page == 1) ? primaryColor : secondaryColor,
              ),
              label: 'Buscar',
              backgroundColor: primaryColor),
          
          
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_page == 2) ? primaryColor : secondaryColor,
            ),
            label: 'Perfil',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
