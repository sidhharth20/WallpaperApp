import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pct1/model/wallpaper.dart';

class pg1 extends StatefulWidget {
  const pg1({super.key});

  @override
  State<pg1> createState() => _pg1State();
}

class _pg1State extends State<pg1> {
  late Future <Wallpaper> wallpaper;
  List <dynamic> users = [];


  @override
  void initState() {
    super.initState();
    wallpaper = getWallpaper('Car');
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.square(69),
          child: AppBar(
            backgroundColor: Colors.white,
            leading: SizedBox(
              height: 25,
              width: 25,
              child: Image.asset(
                "assets/logo.png",
              ),
            ),
            title: Text(
              "Matches",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
            ),
            actions: [
              Row(
                children: [
                  Opacity(
                      opacity: 0.80,
                      child: Material(
                          elevation: 1,
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                border: Border.all(color: Colors.black),
                              ),
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.search,
                                color: Colors.purple,
                                size: 30,
                              )))),
                  SizedBox(
                    width: 10,
                  ),
                  Material(
                    elevation: 1,
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Image.asset(
                          "assets/mix.png",
                          color: Colors.purple,
                          height: 30,
                          width: 30,
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
        body: FutureBuilder<Wallpaper>(future: wallpaper, builder:(_, snapshot){
          if(snapshot.hasData){
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      width: 75,
                      height: 30,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.purpleAccent.shade100)),
                          onPressed: () {},
                          child: Text(
                            "All",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 86,
                      height: 31,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.purpleAccent)),
                          onPressed: () {},
                          child: Text(
                            "nearest",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 86,
                      height: 31,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.purpleAccent)),
                          onPressed: () {},
                          child: Text(
                            "newest",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 86,
                      height: 31,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.purpleAccent)),
                          onPressed: () {},
                          child: Text(
                            "online",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: snapshot.data!.photos!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 3),
                      itemBuilder: (_,index) {
                        return Material(
                          elevation: 10,
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot.data!.photos![index].src!.portrait.toString()
                                        ),
                                        fit: BoxFit.fill),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(13))),
                              ),
                              Positioned(
                                  top: 125,
                                  left: 10,
                                  child: Column(
                                    children: [
                                      // Container(
                                      //   height: 30,width:30,
                                      //   decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.all(Radius.circular(50)),
                                      //   ),
                                      // ),
                                      Text(
                                        "Photographer: ${snapshot.data!.photos![index].photographer}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Text(
                                      //   users[index][''].toString() ?? 'N/A',
                                      //   style: TextStyle(
                                      //       color: Colors.white,
                                      //       fontSize: 12,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                    ],
                                  ))
                            ],
                          ),
                        );
                      }),
                ),
              ],
            );
          }else if(snapshot.hasError){
            return Center(child: Text("${snapshot.error}"),);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        }),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: (index){
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.timelapse),label: 'Time'),
              BottomNavigationBarItem(icon: Icon(Icons.heart_broken),label: 'connection'),
              BottomNavigationBarItem(icon: Icon(Icons.message),label: 'Message'),
              BottomNavigationBarItem(icon: Icon(Icons.person),label:'Account'),
            ]),
      ),
    );
  }

  Future<Wallpaper> getWallpaper (String mQuery) async{
    var mUrl = "https://api.pexels.com/v1/search?query=nature&per_page=1000";
    var responce = await http.get(Uri.parse(mUrl),headers: {"Authorization":"ipAVZNcwlbEnLOspi8g0IOQPkqyzwirmwLl3ue0iZPMgUFoFqErOeaF7"});
    if(responce.statusCode == 200){
      var data = jsonDecode(responce.body);
      return Wallpaper.fromJson(data);
    }else{
      print(responce.statusCode);
      return Wallpaper();
    }
  }
}
