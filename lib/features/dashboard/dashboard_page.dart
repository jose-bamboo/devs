import 'package:devs/features/dashboard/dashboard_model.dart';
import 'package:devs/features/devboard/devboard_page.dart';
import 'package:devs/features/jobs/jobs_page.dart';
import 'package:devs/widgets/components/main_filters.dart';
import 'package:devs/widgets/components/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  PageController pageController;
  DashboardModel dashboard;
  List<Widget> pages = [
    DevboardPage(),
    JobsPage(),
  ];

  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    dashboard = Provider.of<DashboardModel>(context);

    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      if (dashboard.selectedPageIndex != pageController.page.floor()) {
        pageController.jumpToPage(
          dashboard.selectedPageIndex,
        );
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 400,
            color: Colors.blue.shade50,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.only(
                top: 32,
                left: 32,
              ),
              height: 64,
              child: Image.asset(
                'logos/logo.png',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 1000,
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: pages,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(
                top: 200,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainFilters(
                        selectedIndex: dashboard.selectedPageIndex,
                        onDevboardPressed: () =>
                            dashboard.setSelectedPageIndex(0),
                        onJobsPressed: () => dashboard.setSelectedPageIndex(1),
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                  SearchBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}