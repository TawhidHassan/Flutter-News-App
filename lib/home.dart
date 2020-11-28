import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter_news_app/screens/home/homePage.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'backend/rss_to_json.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Map<String,List>newsData=Map<String,List>();
  bool isLoading=true;
  getData() async{
    Future.wait([
      rssToJson('topnews'),
      rssToJson('india'),
      rssToJson('world'),
      rssToJson('business'),
      rssToJson('sports'),
      rssToJson('cricket'),
      rssToJson('tech-features'),
      rssToJson('education'),
      rssToJson('entertainment'),
      rssToJson('music'),
      rssToJson('lifestyle'),
      rssToJson('health-fitness'),
      rssToJson('fashion-trends'),
      rssToJson('art-culture'),
      rssToJson('travel'),
      rssToJson('books'),
      rssToJson('realestate'),
      rssToJson('its-viral'),
     ]).then((value) {
      newsData['topnews'] = value[0];
      newsData['india'] = value[1];
      newsData['world'] = value[2];
      newsData['business'] = value[3];
      newsData['sports'] = value[4];
      newsData['cricket'] = value[5];
      newsData['tech'] = value[6];
      newsData['education'] = value[7];
      newsData['entertainment'] = value[8];
      newsData['music'] = value[9];
      newsData['lifestyle'] = value[10];
      newsData['health-fitness'] = value[11];
      newsData['fashion-trends'] = value[12];
      newsData['art-culture'] = value[13];
      newsData['travel'] = value[14];
      newsData['books'] = value[15];
      newsData['realestate'] = value[16];
      newsData['its-viral'] = value[17];
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {

    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: IconButton(
            icon: SvgPicture.asset("assets/icons/drawer.svg",
              height: 15,
              width: 34,),
            onPressed: (){},
          ),
        ),
        backgroundColor: currentIndex == 3 ? Color(0xffF7F8FA) : Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
      ),
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        opacity: 0,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        //border radius doesn't work when the notch is enabled.
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.black,
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                width: 21,
                color: Colors.black54,
                height: 21,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/home.svg',
                width: 21,
                color: Colors.black,
                height: 21,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.black,
              icon: SvgPicture.asset(
                'assets/icons/search.svg',
                width: 21,
                color: Colors.black54,
                height: 21,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/search.svg',
                width: 21,
                color: Colors.black,
                height: 21,
              ),
              title: Text("Search")),
          BubbleBottomBarItem(
              backgroundColor: Colors.black,
              icon: SvgPicture.asset(
                'assets/icons/bookmark.svg',
                width: 21,
                color: Colors.black54,
                height: 21,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/bookmark.svg',
                width: 21,
                color: Colors.black,
                height: 21,
              ),
              title: Text("Bookmarks")),
          BubbleBottomBarItem(
              backgroundColor: Colors.black,
              icon: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('assets/user.png')),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x5c000000),
                        offset: Offset(0, 1),
                        blurRadius: 5)
                  ],
                ),
              ),
              title: Text("Profile")),
        ],
      ),

      body:isLoading?Center(
        child: CircularProgressIndicator(),
      ): <Widget>[
        HomePage(newsData: newsData,),
        Container(color: Colors.green,),
        Container(color: Colors.orange,),
        Container(color: Colors.blue,),
      ][currentIndex],
    );
  }
}
