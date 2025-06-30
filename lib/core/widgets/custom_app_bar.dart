import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int notificationCount;
  final VoidCallback onMenuPressed;
  final VoidCallback onSearchPressed;
  final VoidCallback onNotificationPressed;

  const CustomAppBar({
    super.key,
    required this.notificationCount,
    required this.onMenuPressed,
    required this.onSearchPressed,
    required this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1976D2),
              Color(0xFF303F9F),
            ],
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: onMenuPressed,
          ),
        ),
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AI For Exam",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Your Success Partner 🎯",
            style: TextStyle(
              color: Color(0xE6FFFFFF),
              fontSize: 12,
            ),
          ),
        ],
      ),
      actions: [
        // Search
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: onSearchPressed,
          ),
        ),

        // Notification with badge
        Container(
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: onNotificationPressed,
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD32F2F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      notificationCount > 99 ? '99+' : notificationCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
