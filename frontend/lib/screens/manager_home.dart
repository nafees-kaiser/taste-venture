import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/widgets/BarChartComponent.dart';
import 'package:frontend/widgets/manager_service_information.dart';
import 'package:frontend/widgets/manager_sidebar.dart';
import 'package:frontend/widgets/review_overview.dart';
import 'package:frontend/widgets/top_customer.dart';
import 'package:frontend/widgets/user_indivisual_review.dart';

class ManagerHome extends StatelessWidget {
  const ManagerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ManagerSidebar(),
      appBar: AppBar(
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
                  color: Color.fromARGB(255, 0, 0, 0),
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
          padding: Theme.of(context).largeHorizontalAndVerticalPadding,
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
              const SizedBox(height: 20),
              const Text(
                "Customer analysis",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const AspectRatio(
                aspectRatio: 1.6,
                child: BarChartComponent(),
              ),
              const SizedBox(height: 10),
              const Text(
                "Food analysis",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                height: 250,
                padding: Theme.of(context).subSectionDividerPadding,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: 40,
                        title: 'Indian',
                        showTitle: true,
                        radius: 50,
                        color: PRIMARY_COLOR.withOpacity(0.9),
                      ),
                      PieChartSectionData(
                        value: 30,
                        title: 'Thai',
                        showTitle: true,
                        radius: 50,
                        color: PRIMARY_COLOR.withOpacity(0.7),
                      ),
                      PieChartSectionData(
                        value: 15,
                        title: 'Chinese',
                        showTitle: true,
                        radius: 50,
                        color: PRIMARY_COLOR.withOpacity(0.5),
                      ),
                      PieChartSectionData(
                        value: 15,
                        title: 'Italian',
                        showTitle: true,
                        radius: 50,
                        color: PRIMARY_COLOR.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Top Customers",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TopCustomer(),
              const SizedBox(height: 10),
              const Text(
                "Recent Reviews",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const ReviewOverview(),
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
