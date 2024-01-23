import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:project_test/screen/login.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<String> categories = [
    'New',
    'Video',
    'Artists',
    'Podcast',
  ];
  int _currentIndex = 0;
  List<MusicItem> musicList = [
    MusicItem('New Album', 'Bad Guy', 'Billie Eilish',
        'https://imagev3.vietnamplus.vn/w660/Uploaded/2024/lepz/2019_08_20/badguy.jpg.webp'),
    MusicItem('New Album', 'Scorpion', 'Drake',
        'https://upload.wikimedia.org/wikipedia/vi/5/58/Scorpion_album_cua_Drake.jpg'),
    MusicItem('New Album', 'Gangnam Style', 'PSY',
        'https://upload.wikimedia.org/wikipedia/vi/f/f9/GangnamStyle.png'),
  ];

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(screen.width * 0.05),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      AdaptiveTheme.of(context).toggleThemeMode();
                    },
                    child: Center(
                      child: Image.asset(
                        "assets/logo.png",
                        width: screen.width * 0.3,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Color(0xFF1ED55F),
                        width: screen.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("New Album",
                                  style: TextStyle(color: Colors.white)),
                              Text("Happier Than Ever",
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white)),
                              Text("Billie Eilish",
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: screen.width * 0.05),
                    child: Container(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 100,
                              child: Center(
                                child: Text(
                                  categories[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: musicList.length,
                      itemBuilder: (context, index) {
                        MusicItem musicItem = musicList[index];
                        return InkWell(
                          onTap: () {},
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Image.network(
                                      musicItem.imagePath,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      width: 150,
                                      height: 165,
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black38,
                                          child: Icon(Icons.play_arrow,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(musicItem.song,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      Text(musicItem.artist,
                                          style: TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: screen.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Playlist", style: TextStyle(fontSize: 18)),
                        Text("See more"),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: musicList.length,
                    itemBuilder: (context, index) {
                      MusicItem musicInfoItem = musicList[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black38,
                            child: Icon(Icons.play_arrow, color: Colors.white),
                          ),
                          title: Text(musicInfoItem.song),
                          subtitle: Text(musicInfoItem.artist),
                          trailing: IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {
                              // Handle favorite button tap
                            },
                          ),
                          onTap: () {
                            // Handle music info item tap
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: FlashyTabBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              icon: Icon(Icons.event),
              title: Text('Events'),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.highlight),
              title: Text('Highlights'),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class MusicItem {
  final String album;
  final String song;
  final String artist;
  final String imagePath;

  MusicItem(this.album, this.song, this.artist, this.imagePath);
}
