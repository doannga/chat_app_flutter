import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
    required this.onNaviSelected,
  }) : super(key: key);

  final Function(int) onNaviSelected;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex:
          _selectedIndex, // HomeBloc() như này nghĩa là mình đang tạo 1 instance mới của home bloc,
      // cái mình muôns ở đây là lấy ra instance của home bloc, từ chỗ BlocProvider
      onTap: (index) {
        _selectedIndex = index;
        setState(() {});
        widget.onNaviSelected(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'People',
        ),
      ],
    );
  }
}
