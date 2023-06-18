

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../services/country_services.dart';


class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  final CountryServices _stateServices = CountryServices();

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                // onChanged: (value) => setState(() {print(".....@#..$value"); }),
                controller: _searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20,),
                  hintText: "Search with country name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(55.0),
                  )
                ),
              ),
            ),

            Expanded(
              child: FutureBuilder(
                future: _stateServices.countriesListApi(), 
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot ){
                    if(!snapshot.hasData){
                        return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context,index){

                          return Shimmer.fromColors( 
                            baseColor: Colors.grey.shade700, 
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                            children: [
                                  ListTile(
                                    leading: Container(height: 50,width: 50,color: Colors.white,),
                                    title: Container(height: 10,width: 89,color: Colors.white,),
                                    subtitle: Container(height: 5,width: 89,color: Colors.white,),
                                  ),
                            ],
                          ),
                          );
                        }
                      ) ;
                    }
                    else{
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context,index){

                          //to filter
                          String cName = snapshot.data![index]['country'];
                          if(_searchController.text.isEmpty){
                              return Column(
                                children: [
                                      ListTile(
                                        leading: Image(
                                          height: 50,
                                          width: 50,
                                          image:NetworkImage(snapshot.data![index]['countryInfo']['flag']), 
                                        ),
                                        title: Text(snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]['cases'].toString()),
                                      ),
                                ],
                              );
                          }
                          else if(cName.toLowerCase().contains(_searchController.text.toLowerCase())){
                                return Column(
                                  children: [
                                        ListTile(
                                          leading: Image(
                                            height: 50,
                                            width: 50,
                                            image:NetworkImage(snapshot.data![index]['countryInfo']['flag']), 
                                          ),
                                          title: Text(snapshot.data![index]['country']),
                                          subtitle: Text(snapshot.data![index]['cases'].toString()),
                                        ),
                                  ],
                                );
                          }
                          else{
                              return Container() ;
                          }

                          
                        }
                      ) ;
                    }

                }
              ),
            ),

          ],
        ) 
      ),

    );
  }
}
