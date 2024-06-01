import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/manager_service_information.dart';
import 'package:frontend/widgets/manager_sidebar.dart';
import 'package:frontend/widgets/top_customer.dart';
import 'package:frontend/widgets/user_indivisual_review.dart';

class ManagerHome extends StatelessWidget {
  const ManagerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ManagerSidebar(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.pin_drop,
                size: 18,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Jatrabari, Dhaka-1236",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  ManagerServiceInformation(
                    icon: Icons.people,
                    percent: "23%",
                    header: "Total Customers",
                    number: "1289",
                  ),
                  ManagerServiceInformation(
                    icon: Icons.list_alt,
                    percent: "10%",
                    header: "Total Orders",
                    number: "450",
                  ),
                  ManagerServiceInformation(
                    icon: Icons.widgets,
                    percent: "-13%",
                    header: "Total Products",
                    number: "52",
                  ),
                  ManagerServiceInformation(
                    icon: Icons.payments,
                    percent: "32%",
                    header: "Total Revenue",
                    number: "120000",
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                "Customer analysis",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 400,
                child: LineChart(
                  LineChartData(
                    minY: 0,
                    maxY: 100,
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const style = TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            );
                            switch (value.toInt()) {
                              case 0:
                                return Text('Sun', style: style);
                              case 1:
                                return Text('Mon', style: style);
                              case 2:
                                return Text('Tue', style: style);
                              case 3:
                                return Text('Wed', style: style);
                              case 4:
                                return Text('Thu', style: style);
                              case 5:
                                return Text('Fri', style: style);
                              case 6:
                                return Text('Sat', style: style);
                              default:
                                return Text('', style: style);
                            }
                          },
                          reservedSize: 30,
                        ),
                      ),
                    ),
                    gridData: FlGridData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: const [
                          FlSpot(0, 20),
                          FlSpot(1, 50),
                          FlSpot(2, 55),
                          FlSpot(3, 80),
                          FlSpot(4, 90),
                          FlSpot(5, 70),
                          FlSpot(6, 70),
                        ],
                        isCurved: true,
                        color: Colors.indigo[500],
                        barWidth: 6,
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.indigo.withOpacity(0.3),
                        ),
                        dotData: const FlDotData(
                          show: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Food analysis",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 250,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: 40,
                        title: 'Indian',
                        showTitle: true,
                        radius: 50,
                        color: Colors.indigo[400],
                      ),
                      PieChartSectionData(
                        value: 30,
                        title: 'Japanese',
                        showTitle: true,
                        radius: 50,
                        color: Colors.blueGrey[200],
                      ),
                      PieChartSectionData(
                        value: 15,
                        title: 'Chinese',
                        showTitle: true,
                        radius: 50,
                        color: Colors.yellow[100],
                      ),
                      PieChartSectionData(
                        value: 15,
                        title: 'Italian',
                        showTitle: true,
                        radius: 50,
                        color: Colors.indigo[200],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Top Customers",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const TopCustomer(),
              const SizedBox(height: 20),
              const Text(
                "Recent Reviews",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const UserIndivisualReview(),
              const UserIndivisualReview(),
              const UserIndivisualReview(),
            ],
          ),
        ),
      ),
    );
  }
}
