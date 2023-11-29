import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendwise/core/constants/budget_amount.dart';
import 'package:spendwise/core/constants/constant_widgets/apptextfield.dart';
import 'package:spendwise/core/constants/route.dart';
import 'package:spendwise/services/models/budgets/budget_data.dart';
import 'package:spendwise/services/models/budgets/budget_item.dart';
import 'package:spendwise/services/models/budgets/budget_tile.dart';
import 'package:spendwise/src/page/budget_two_fab_page.dart';
import 'package:spendwise/src/page/expense_fab.dart';
import 'package:spendwise/services/auth/auth_exceptions.dart';
import 'package:spendwise/services/auth/auth_service.dart';
import 'package:spendwise/core/tabs/budget_tab.dart';
import 'package:spendwise/core/tabs/expense_tab.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:spendwise/core/utilities/dialogs/error_dialog.dart';
import 'package:spendwise/core/utilities/dialogs/logout_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FabCircularMenuState> fabKey =
      GlobalKey<FabCircularMenuState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  String get userId => AuthService.firebase().currentUser!.id;

  void deleteBudget(BudgetItem budget) {
    Provider.of<BudgetData>(context, listen: false).deleteBudget(budget);
  }

  // final TabController tabController =
  //     TabController(length: 2, vsync: this);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey.shade50,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (context) => FabCircularMenu(
            key: fabKey,
            alignment: Alignment.bottomRight,
            ringColor: Colors.grey[200],
            ringDiameter: 250.0,
            ringWidth: 70.0,
            fabSize: 45.0,
            fabElevation: 3.0,
            fabOpenColor: Colors.white,
            fabCloseColor: Colors.black,
            fabColor: Colors.white,
            fabIconBorder: const CircleBorder(),
            fabOpenIcon: const Icon(
              Icons.create,
              color: Colors.white,
            ),
            fabCloseIcon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            fabMargin: const EdgeInsets.all(16.0),
            animationDuration: const Duration(milliseconds: 250),
            animationCurve: Curves.easeInOutBack,
            onDisplayChange: (isOpen) {},
            children: [
              RawMaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(fabRoute);
                },
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.add,
                ),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(budgetFabRoute);
                },
                shape: const CircleBorder(),
                child: const Icon(Icons.money),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const BudgetTwoFabPage(),
                  ));
                },
                child: const Icon(Icons.abc_outlined),
              ),
              // RawMaterialButton(
              //   onPressed: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //       builder: (context) => const ExpenseFabPage(),
              //     ));
              //   },
              //   child: const Icon(Icons.abc_outlined),
              // ),
            ],
          ),
        ),
        drawerDragStartBehavior: DragStartBehavior.down,
        endDrawer: Drawer(
          backgroundColor: Colors.black,
          width: 230.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    _closeEndDrawer();
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
                const SizedBox(height: 50),
                Center(
                  child: AppButton(
                    onTap: () async {
                      // await logoutDialog(context, 'Logout', () => null);
                      try {
                        await AuthService.firebase().logOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute,
                          (route) => false,
                        );
                      } on UserNotLoggedInAuthException {
                        await showErrorDialog(
                          context,
                          'User not logged in',
                        );
                      } catch (_) {
                        throw GenericAuthException();
                      }
                    },
                    text: 'Logout',
                  ),

                  // ElevatedButton(
                  //   onPressed: () async {
                  //     try {
                  //       await AuthService.firebase().logOut();
                  //       Navigator.of(context).pushNamedAndRemoveUntil(
                  //         loginRoute,
                  //         (route) => false,
                  //       );
                  //     } on UserNotLoggedInAuthException {
                  //       await showErrorDialog(
                  //         context,
                  //         'User not logged in',
                  //       );
                  //     }
                  //   },
                  //   child: const Text(
                  //     'Log out',
                  //     style: TextStyle(
                  //       color: Colors.blue,
                  //     ),
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Dashboard',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.arrow_down,
                              size: 17,
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              CupertinoIcons.lightbulb,
                              size: 17,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _openEndDrawer();
                            },
                            icon: const Icon(
                              Icons.menu,
                              size: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'TOTAL BALANCE',
                            style: TextStyle(fontSize: 10),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '#23,000',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 100,
                        width: 150,
                        child: Stack(
                          children: [
                            const Positioned(
                              right: 5,
                              top: 5,
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 137, 186, 139),
                                radius: 13,
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: Color.fromARGB(255, 74, 232, 80),
                                  size: 13,
                                ),
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'TOTAL BUDGET',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  const SizedBox(height: 10),
                                  Consumer<BudgetData>(
                                    builder: (context, value, child) {
                                      return BudgetAmount(
                                          startOfWeek: value.startOfWeek());
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 100,
                        width: 150,
                        child: const Stack(
                          children: [
                            Positioned(
                              right: 5,
                              top: 5,
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 214, 176, 173),
                                radius: 13,
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: Colors.red,
                                  size: 13,
                                ),
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'TOTAL EXPENSE',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '0.0',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                    ),
                    // Tab(
                    //   icon: Icon(
                    //     Icons.abc_outlined,
                    //     color: Colors.blue,
                    //   ),
                    // ),
                    Tab(
                      icon: Icon(
                        Icons.money,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: TabBarView(
                    children: [
                      // 1st tab
                      ExpenseTab(userId: userId),

                      // 2nd tab
                      BudgetTab(userId: userId)
                    ],
                  ),
                ),
                // const Padding(
                //   padding: EdgeInsets.only(left: 8.0),
                //   child: Text('Recent Budget Transaction'),
                // ),
                // Consumer<BudgetData>(
                //   builder: (context, value, child) {
                //     return ListView.builder(
                //       itemCount: value.getAllBudgetItemList().length,
                //       itemBuilder: (context, index) {
                //         return SizedBox(
                //           child: BudgetTile(
                //             name:
                //                 value.getAllBudgetItemList()[index].title,
                //             amount: value
                //                 .getAllBudgetItemList()[index]
                //                 .amount,
                //             dateTime: value
                //                 .getAllBudgetItemList()[index]
                //                 .datetime,
                //             deleteTapped: (p0) {
                //               deleteBudget(
                //                   value.getAllBudgetItemList()[index]);
                //             },
                //           ),
                //         );
                //       },
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// i have to convert all text field to text form field
