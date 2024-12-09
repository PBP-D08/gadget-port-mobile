// import 'package:flutter/material.dart';
// import 'package:gadget_port_mobile/screens/cart_screen.dart';
// import 'package:gadget_port_mobile/screens/home_screen.dart';

// class BottomNavBar extends StatefulWidget {
//   final int selectedIndex;
//   final Function(int) onItemTapped;

//   const BottomNavBar({
//     super.key,
//     required this.selectedIndex,
//     required this.onItemTapped,
//   });

//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   int _selectedIndex = 0;

//   // Menangani perubahan tab
//   void _onItemTapped(int index) {
//     if (index == 0) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//     }
//     else if (index == 1) {
//       // Navigasi ke halaman
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => CartScreen()),
//       );
//     }
//     else if (index == 2) {
//       // Navigasi ke halaman
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => CartScreen()),
//       );
//     }
//     else if (index == 3) {
//       // Navigasi ke halaman CartScreen jika item ke-4 (index 3) dipilih
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => CartScreen(selectedIndex: index, onItemTapped: (int ) {  },)),
//       );
//     } else {
//       // Ganti tab biasa untuk index selain 3
//       setState(() {
//         _selectedIndex = index;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: selectedIndex,
//       onTap: onItemTapped,
//       selectedItemColor: Color.fromARGB(255, 52, 152, 219),  // Set your selected item color here
//       unselectedItemColor: Color.fromARGB(255, 191, 219, 254),
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.search),
//           label: 'Search',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.account_circle),
//           label: 'Profile',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.shopping_cart),
//           label: 'Cart',
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:gadget_port_mobile/screens/cart/cart_screen.dart';
import 'package:gadget_port_mobile/screens/home_screen.dart';
import 'package:gadget_port_mobile/screens/profile/profile_screen.dart';
import 'package:gadget_port_mobile/screens/review/review_page.dart';
import 'package:gadget_port_mobile/screens/wishlist/wishlist_screen.dart';
import 'package:gadget_port_mobile/screens/store/store_list_screen.dart';
// import 'package:gadget_port_mobile/screens/profile_screen.dart';
// import 'package:gadget_port_mobile/screens/search_screen.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int)? onItemTapped;

  const BottomNavBar({
    Key? key,
    this.selectedIndex = 0,
    this.onItemTapped,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

void _onItemTapped(int index) {
  // Determine the target screen based on the index
  Widget targetScreen;
  switch (index) {
    case 0:
      targetScreen = const HomeScreen();
      break;
    case 1:
      // targetScreen = SearchScreen();
      targetScreen = const ReviewPage(); // Pengen Nyoba doank hehe
      break;
    case 2:
      targetScreen = const ProfileScreen();
      break;
    case 3:
      targetScreen = CartScreen(
        selectedIndex: index,
        onItemTapped: _onItemTapped,
      );
      break;
    case 4:
      targetScreen = const WishlistScreen();
      break;
    case 5:
      targetScreen = const StoreListPage(); 
      break;
    default:
      targetScreen = const HomeScreen();
  }

  // Use custom onItemTapped if provided
  if (widget.onItemTapped != null) {
    widget.onItemTapped!(index);
  }

  // Navigate to the selected screen
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => targetScreen),
  );

  // Update the selected index
  setState(() {
    _selectedIndex = index;
  });
}

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color.fromARGB(255, 52, 152, 219),
      unselectedItemColor: const Color.fromARGB(255, 191, 219, 254),
      backgroundColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Wishlist',
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Stores',
        ),
      ],
    );
  }
}