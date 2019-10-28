import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scopedmodeltest/providers/bottomNavProvider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
     builder: (context,bottomNavProvider,child){
       return Scaffold(
         appBar: AppBar(
           title: Text(bottomNavProvider.getCurrentPageName()),

         ),
         body: SafeArea(
           child: bottomNavProvider.getCurrentPage(),
         ),
         bottomNavigationBar: BottomNavigationBar(
           type: BottomNavigationBarType.fixed,
           onTap: bottomNavProvider.changePage,
           currentIndex: bottomNavProvider.getCurrentIndex(),
           items: [
             BottomNavigationBarItem(
               icon: Icon(Icons.people),
               title: Text(
                 'Employees',
               ),
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.search),
               title: Text(
                 'Search',
               ),
             ),
             BottomNavigationBarItem(
               icon: Icon(Icons.edit),
               title: Text(
                 'Edit',
               ),
             ),
           ],
         ),
       );
     },
    );
  }
}
