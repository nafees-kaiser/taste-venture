import 'package:flutter/material.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/widgets/bar_chart_component.dart';
import 'package:frontend/widgets/pie_chart_component.dart';
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
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: Theme.of(context).largeHorizontalAndVerticalPadding,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
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
              SizedBox(height: 20),
              Text(
                "Customer analysis",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AspectRatio(
                aspectRatio: 1.6,
                child: BarChartComponent(),
              ),
              SizedBox(height: 10),
              Text(
                "Food analysis",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              PieChartComponent(),
              SizedBox(height: 10),
              Text(
                "Top Customers",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TopCustomer(),
              SizedBox(height: 10),
              Text(
                "Recent Reviews",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ReviewOverview(),
              UserIndivisualReview(),
              UserIndivisualReview(),
              UserIndivisualReview(),
            ],
          ),
        ),
      ),
    );
  }
}
