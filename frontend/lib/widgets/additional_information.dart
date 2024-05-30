import 'package:flutter/material.dart';
import 'package:frontend/widgets/profile_information_card.dart';

class AdditionalInformation extends StatelessWidget {
  const AdditionalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Profileinfocard(
          name: "Employment Type",
          text: "Government",
          icon: Icons.work_history,
        ),
        Profileinfocard(
          name: "Graduation Complete",
          text: "Yes",
          icon: Icons.school,
        ),
        Profileinfocard(
          name: "Monthly food & travel budgets",
          text: "120000",
          icon: Icons.payments,
        ),
        Profileinfocard(
          name: "No. of compfaanions",
          text: "4",
          icon: Icons.group,
        ),
        Profileinfocard(
          name: "Cronic Diseases",
          text: "Yes",
          icon: Icons.coronavirus,
        ),
      ],
    );
  }
}
