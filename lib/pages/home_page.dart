import 'dart:convert';  
import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpta;
import 'package:movieapp_5/models/movie_model.dart';
import 'package:movieapp_5/pages/detail.dart';
import 'package:movieapp_5/utils/constant.dart';
import 'package:movieapp_5/widgets/item_list_movie.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List movies = [];
  List<Movie> movies2 = [];

  @override
  void initState() {
    getDataMovie();
    super.initState();
  }

  getDataMovie() async {
    String path = "$urlBase/discover/movie?api_key=$api_key";

    Uri uri = Uri.parse(path);
    httpta.Response response = await httpta.get(uri);
    if (response.statusCode == 200) {
      // print(response.body);
     
     
      Map myMap = json.decode(response.body);
      // myMap["results"];
      //  print("MI MAPAAAAAA---->  ${myMap["results"]}");
      //  myMap["results"];
      // movies = myMap["results"];
      // print("LISTAA----->${movies}");
      //  myMap["results"].forEach(( item) {
      //           print(item ["original_title"]);
      //       });

      movies2 = myMap["results"]
          .map<Movie>((item1) => Movie.fromJson(item1))
          .toList();

      // myMap["results"].forEach((item) {
      //   Movie movi2 = Movie.fromJson(item);
      //   movies2.add(movi2);
      // });

    } else {
      print("SIN DATOS");
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Movies',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favoritos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.thumb_up), label: "Me Gusta"),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.all_inclusive),
      ),
      drawer: const Drawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Top Movies",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      color: Colors.tealAccent),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              // ListView(
              //   scrollDirection: Axis.horizontal,
              //   primary: true,
              //   shrinkWrap: true,
              //     children: movies.map((e) => GestureDetector(
              //       onTap: (){
              //         Navigator.push(context,MaterialPageRoute(builder: (context) => Detail(pelicula: e),));
              //       },
              //       child: Expanded(
              //         child: Container(
              //           height: 50,
              //           width: 50,
              //           decoration: BoxDecoration(
              //           image: DecorationImage(image:
              //           NetworkImage(e["poster_path"])),
              //         ) ,),
              //       ))).toList(),

              // ),

              ListView.builder(
                primary: true,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: movies2.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Detail(pelicula: movies2[index]),
                          ));
                    },
                    child: ItemMovie(
                      movie: movies2[index],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
