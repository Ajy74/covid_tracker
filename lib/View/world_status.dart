import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen> with TickerProviderStateMixin{

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
              PieChart(
                dataMap: {
                  "Total":20,
                  "Recovered":15,
                  "Deaths":5
                },
                animationDuration: const Duration(milliseconds: 1200),
                colorList:colorList ,
                chartType: ChartType.ring,
                chartRadius: MediaQuery.of(context).size.width/3.2,
                legendOptions: const LegendOptions(legendPosition: LegendPosition.left),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                child: Card(
                  child: Column(
                    children: [
                        ReusableRow(title: "Total", value:"200"),
                    ],
                  ),
                ),
              ),

               Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xFF1aa260),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text('Track Countries'),
                ),
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