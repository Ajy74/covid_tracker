import 'package:covid_tracker/View/countries_list.dart';
import 'package:covid_tracker/models/world_states_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../services/states_services.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen> with TickerProviderStateMixin{

   final StateServices _stateServices = StateServices();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this
  )..repeat();

  
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xFF4285f4),
    const Color(0xFF1aa260),
    const Color(0xFFde5246),
  ]; 

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
        child:Padding(
          padding:const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.01,),

              FutureBuilder(
                future: _stateServices.fetchWorldStatesRecord(), 
                builder: (context,AsyncSnapshot<WorldStateModel> snapshot){
                    if(!snapshot.hasData){
                      return  Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ),
                      );
                    }
                    else{
                        return Column(
                          children: [
                            PieChart(
                                dataMap: {
                                  "Total": double.parse(snapshot.data!.cases!.toString()),
                                  "Recovered": double.parse(snapshot.data!.recovered!.toString()),
                                  "Deaths": double.parse(snapshot.data!.deaths!.toString())
                                },
                                chartValuesOptions: const ChartValuesOptions(showChartValuesInPercentage: true),
                                animationDuration:
                                    const Duration(milliseconds: 1200),
                                colorList: colorList,
                                chartType: ChartType.ring,
                                chartRadius:
                                    MediaQuery.of(context).size.width / 3.2,
                                legendOptions: const LegendOptions(
                                    legendPosition: LegendPosition.left),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * .06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(title: "Total", value: snapshot.data!.cases.toString()),
                                    ReusableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                    ReusableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                    ReusableRow(title: "Active", value: snapshot.data!.active.toString()),
                                    ReusableRow(title: "Criticle", value: snapshot.data!.critical.toString()),
                                    ReusableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                                    ReusableRow(title: "Today Recovered", value: snapshot.data!.todayRecovered.toString()),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesList())),
                              child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xFF1aa260),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text('Track Countries'),
                              ),
                                                      ),
                            ),
                        ],
                      );
                    }
                }
              ),

             

            ],
          ),
        ), 
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {

  String title,value;
  ReusableRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}