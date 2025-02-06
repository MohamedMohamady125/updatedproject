import 'package:flutter/material.dart';
import '../../profile/profile_page.dart';
import '../../shared/events/events_screen.dart';
import '../../shared/community/community_screen.dart';
import '../../shared/marketplace/marketplace_screen.dart';
import '../academies/my_branches_screen.dart';
import '../academies/register_branch_screen.dart';

class AcademyHomePage extends StatefulWidget {
  const AcademyHomePage({super.key});

  @override
  _AcademyHomePageState createState() => _AcademyHomePageState();
}

class _AcademyHomePageState extends State<AcademyHomePage>
    with TickerProviderStateMixin {
  final String userRole = 'Academy';
  AnimationController? animationController;
  bool multiple = true;

  List<Map<String, dynamic>> homeItems = [
    {'title': 'My Branches', 'icon': Icons.business, 'screen': MyBranchesScreen(role: 'Academy')},
    {'title': 'Register Branch', 'icon': Icons.add_business, 'screen': RegisterBranchScreen(role: 'Academy')},
    {'title': 'Events', 'icon': Icons.event, 'screen': EventsScreen()},
    {'title': 'Community', 'icon': Icons.group, 'screen': CommunityScreen()},
    {'title': 'Marketplace', 'icon': Icons.store, 'screen': MarketplaceScreen(userRole: 'Academy')},
  ];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academy Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: multiple ? 2 : 1,
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 12.0,
            childAspectRatio: 1.3,
          ),
          itemCount: homeItems.length,
          itemBuilder: (context, index) {
            final item = homeItems[index];
            final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animationController!,
                curve: Interval((1 / homeItems.length) * index, 1.0, curve: Curves.fastOutSlowIn),
              ),
            );
            animationController?.forward();

            return AnimatedItem(
              animation: animation,
              animationController: animationController,
              icon: item['icon'],
              title: item['title'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => item['screen']),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Marketplace'),
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    fullName: 'John Doe',
                    email: 'john.doe@example.com',
                    role: userRole,
                  ),
                ),
              );
              break;
            case 2:
              Navigator.push(context, MaterialPageRoute(builder: (context) => EventsScreen()));
              break;
            case 3:
              Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityScreen()));
              break;
            case 4:
              Navigator.push(context, MaterialPageRoute(builder: (context) => MarketplaceScreen(userRole: userRole)));
              break;
          }
        },
      ),
    );
  }
}

class AnimatedItem extends StatelessWidget {
  final Animation<double> animation;
  final AnimationController? animationController;
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const AnimatedItem({super.key, 
    required this.animation,
    required this.animationController,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 50 * (1.0 - animation.value), 0.0),
            child: GestureDetector(
              onTap: onTap,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 50, color: Colors.blue),
                    const SizedBox(height: 10),
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
