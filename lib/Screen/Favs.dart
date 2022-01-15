import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Favs extends StatefulWidget {
  List favs;
  Favs( this.favs, {Key? key} ) : super(key: key);

  @override
  State<Favs> createState() => _FavsState();
}

class _FavsState extends State<Favs> {
 bool _isFavorite = false;
  bool isLoading = false;
  List<dynamic> favs = [];
  void _toggleFavorite() {
    setState(() {
      if (_isFavorite) {
        _isFavorite = false;
        print("object2");
      } else {
        _isFavorite = true;
        print("object");
      }
    });
  }

  Future<Map> getNews() async {
    final result = await get(
      Uri.parse("https://api.first.org/data/v1/news"),
    );
    var Data = jsonDecode(result.body);
    // print(Data);
    return jsonDecode(result.body);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     isLoading = true;
  //   });
  //   getNews().then((Data) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     info = Data;
  //   });
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
     print(widget.favs);
    return Scaffold(
        body: FutureBuilder(
      future: getNews(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              itemCount: widget.favs.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 8,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Container(
                    
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          padding: const EdgeInsets.all(2),
                          icon:
                               const Icon(Icons.favorite),
                             
                          color: Colors.red,
                          iconSize: 30,
                          onPressed: () {
                          },
                        ),

                        Container(
                          padding: const EdgeInsets.only(
                            left: 12,
                          ),
                          width: 280,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.favs[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 10),
                              // Text(
                              //   snapshot.data["data"][index]["summary"] ??
                              //       snapshot.data["data"][index]["title"],
                              //   style: const TextStyle(
                              //       fontWeight: FontWeight.w500, fontSize: 16),
                              //   maxLines: 2,
                              //   overflow: TextOverflow.ellipsis,
                              // ),
                              // const SizedBox(height: 10),
                              // Text(
                              //   snapshot.data["data"][index]["published"],
                              //   style: const TextStyle(
                              //       fontWeight: FontWeight.w400, fontSize: 14),
                              //   maxLines: 2,
                              //   overflow: TextOverflow.ellipsis,
                              // ),
                            ],
                          ),
                        ),
                        //  ElevatedButton(onPressed: (){print(snapshot.data["data"][index]["title"]);}, child: Text("data"))
                      ],
                    ),
                  ),
                );
              });
        }
      },
    ));
  }
}
