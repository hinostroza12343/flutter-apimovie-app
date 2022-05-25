import 'dart:convert'; 

import 'package:flutter/material.dart';
import 'package:movieapp_5/models/actor_model.dart';
import 'package:movieapp_5/models/movie_detail_model.dart';
import 'package:movieapp_5/models/movie_model.dart';
import 'package:movieapp_5/utils/constant.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  Movie pelicula;

  Detail({required this.pelicula});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  List<Actor> listActor = [];
  MovieDetail? movieDetail;
  Actor? actor;
  @override
  void initState() {
    super.initState();
    getDataMovie();
    getDataActor();
  }

  getDataActor() async {
    String path =
        "$urlBase/movie/${widget.pelicula.id}/credits?api_key=$api_key";
    ;

    Uri _uri = Uri.parse(path);
    http.Response response = await http.get(_uri);
    Map<String, dynamic> myMap = json.decode(response.body);
    if (response.statusCode == 200) {
      listActor =
          myMap["cast"].map<Actor>((item) => Actor.fromJson(item)).toList();
      print("-------->  ${myMap["cast"]}");
    } else {
      print("No hat nada");
    }

    setState(() {});
  }

  getDataMovie() async {
    String path2 =
        "$urlBase/movie/${widget.pelicula.id}?api_key=f1b0819d3f970004635b51fbaa411bf2";
    String path = "$urlBase/movie/${widget.pelicula.id}?api_key=$api_key}";

    Uri _uri = Uri.parse(path2);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      movieDetail = MovieDetail.fromJson(myMap);
      // movi2 = myMap["genres"]
      //     .map<MovieDetail>((item1) => MovieDetail.fromJson(item1))
      //     .toList();

      // // print(movieDetail);
      // print(myMap);
      // print("------------------->${myMap["genres"]}");
      setState(() {});
    } else {
      print("No hat data");
    }
  }

  List<Widget> itemList = List.generate(
      20,
      (index) => Container(
            height: 150,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: double.infinity,
            color: Colors.tealAccent,
          ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: movieDetail != null
          ? Stack(
              children: [
                //  Container(
                //       height: double.infinity,
                //       child: Image.network(
                //         pathimage + widget.pelicula.posterPath,
                //         fit: BoxFit.fitHeight,
                //       ),
                //     ),
                //     BackdropFilter(
                //       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                //       child: Container(
                //         color: Colors.grey.withOpacity(0.1),
                //       ),
                //     ),

                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                                pathimage + widget.pelicula.backdropPath,
                                fit: BoxFit.cover),
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0x002E2E2E),
                                    Color(0xff2E2E2E),
                                  ],
                                  begin: Alignment.center,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ],
                        ),
                        centerTitle: true,
                        title: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            widget.pelicula.originalTitle,
                          ),
                        ),
                      ),
                      expandedHeight: 160,
                      // collapsedHeight: 100,
                      // floating: false,
                      pinned: true,
                      // title: Text("My Movie Detail"),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 10),
                            child: SingleChildScrollView(
                              primary: true,
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    width: 120.0,
                                    height: 176.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(pathimage +
                                              widget.pelicula.posterPath)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.pelicula.originalTitle,
                                          style: const TextStyle(
                                            fontSize: 22.0,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4.0,
                                        ),
                                        Container(
                                          child: Text(
                                            "(${widget.pelicula.title})",
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.white54,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6.0,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.date_range,
                                              size: 15,
                                            ),
                                            Text(
                                              " ${widget.pelicula.releaseDate.toString().substring(0, 10)}",
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 6.0,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.timer,
                                              size: 15,
                                            ),
                                            Text(
                                                " ${widget.pelicula.runtimeType.toString()} min."),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 6.0,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              size: 15,
                                            ),
                                            Text(
                                                " ${widget.pelicula.voteAverage.toString()}"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              onPressed: () {},
                              label: Container(
                                margin: EdgeInsets.symmetric(vertical: 16.0),
                                child: const Text(
                                  "Add to watchlist",
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  elevation: 8,
                                  shadowColor:
                                      const Color(0xffFF9F02).withOpacity(0.9),
                                  primary: const Color(0xffFF9F02)),
                            ),
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              "Overview",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6.0),
                            child: Text(
                              widget.pelicula.overview,
                              style: const TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w300),
                            ),
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              "Genres",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Wrap(
                              spacing: 8,
                              alignment: WrapAlignment.start,
                              children: movieDetail!.genres
                                  .map((e) => Chip(
                                        label: Text(
                                          e.name,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 10),
                            child: Text(
                              "Cast",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: ScrollPhysics(),
                              primary: true,
                              child:
                                listActor!=[]?
                               Row(
                                mainAxisSize: MainAxisSize.min,
                                children: listActor
                                    .map((e) => Column(
                                          children: [
                                            Container(
                                              width: 90,
                                              height: 90,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14.0,
                                                      vertical: 4.0),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                // borderRadius:
                                                //     BorderRadius.circular(24),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(pathimage +
                                                              e.profilePath 
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              e.name,
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ))
                                    .toList(),
                              ):
                              const Center (child: CircularProgressIndicator(),)
                            ),
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
