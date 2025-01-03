import 'package:cowok/config/appwrite.dart';
import 'package:cowok/config/enum.dart';
import 'package:cowok/controllers/fragments/browse_controller.dart';
import 'package:cowok/controllers/user_controller.dart';
import 'package:cowok/datasources/worker_datasource.dart';
import 'package:cowok/models/worker_model.dart';
import 'package:cowok/widgets/section_title.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrowseFragment extends StatefulWidget {
  const BrowseFragment({super.key});

  @override
  State<BrowseFragment> createState() => _BrowseFragmentState();
}

class _BrowseFragmentState extends State<BrowseFragment> {
  final browseController = Get.put(BrowseController());
  final userController = Get.put(UserController());
  final TextEditingController searchController = TextEditingController();

  int totalWorkers = 0;
  int availableWorkers = 0;
  String errorMessage = '';

  @override
  void initState() {
    browseController.fetchTopRatedWorkers();
    browseController.fetchNewcomerWorkers();
    super.initState();
    fetchStats();
  }

  @override
  void dispose() {
    browseController.clear();
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchStats() async {
    final result = await WorkerDatasource.fetchStats();
    result.fold(
      (error) {
        setState(() {
          errorMessage = error;
        });
      },
      (data) {
        setState(() {
          totalWorkers = data['total']!;
          availableWorkers = data['available']!;
        });
      },
    );
  }

  void onSearch(String query) {
    browseController.searchWorker(query); // Panggil fungsi pencarian
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        SizedBox(
          height: 414,
          child: Stack(
            children: [
              Image.asset(
                'assets/bg_discover_page.png',
              ),
              Transform.translate(
                offset: const Offset(0, 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    header(),
                    DView.spaceHeight(30),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Anda butuh pekerja\napa untuk hari ini?',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DView.spaceHeight(20),
                    categories(),
                    DView.spaceHeight(40),
                    searchBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
        DView.spaceHeight(50),
        latestStats(),
        DView.spaceHeight(30),
        displayWorkers(),
        DView.spaceHeight(30),
        curatedTips(),
        DView.spaceHeight(30),
      ],
    );
  }

  Widget curatedTips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(text: 'Curated Tips'),
          Column(
            children: browseController.curatedTips.map((item) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, item['route'] ?? '/');
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            item['image'] ?? 'assets/placeholder.png',
                            width: 70,
                            height: 70,
                          ),
                          if (item['is_popular'] ?? false)
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xffBFA8FF),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                ),
                                height: 24,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Popular',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      DView.spaceWidth(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item['name'] != null)
                            Text(
                              item['name']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          if (item['category'] != null)
                            Text(
                              item['category']!,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget displayWorkers() {
    return Obx(() {
      final workers = browseController.filteredWorkers;
      final title = browseController.sectionTitle;

      // Use ternary condition to check if search query is empty or not
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // High Rated Workers section
                    if (browseController.topRated.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionTitle(
                              text: 'High Rated Workers', autoPadding: true),
                          DView.spaceHeight(),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: browseController.topRated.length,
                              itemBuilder: (context, index) {
                                WorkerModel worker =
                                    browseController.topRated[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoute.workerProfile.name,
                                      arguments: worker,
                                    );
                                  },
                                  child: Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: const Color(0xffeaeaea)),
                                    ),
                                    margin: EdgeInsets.only(
                                      left: index == 0 ? 20 : 8,
                                      right: index ==
                                              browseController.topRated.length -
                                                  1
                                          ? 20
                                          : 8,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          Appwrite.imageURL(worker.image),
                                          width: 46,
                                          height: 46,
                                          fit: BoxFit.cover,
                                        ),
                                        DView.spaceHeight(6),
                                        Text(
                                          worker.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        DView.spaceHeight(4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/ic_star_small.png',
                                              height: 16,
                                              width: 16,
                                            ),
                                            DView.spaceWidth(2),
                                            Text(
                                              '${worker.rating.toStringAsFixed(1)}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                    // Newcomers section
                    if (browseController.newcomers.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionTitle(
                              text: 'Newcomers', autoPadding: true),
                          DView.spaceHeight(),
                          GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 74,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: browseController.newcomers.length,
                            itemBuilder: (context, index) {
                              WorkerModel worker =
                                  browseController.newcomers[index];
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: const Color(0xffeaeaea)),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      Appwrite.imageURL(worker.image),
                                      width: 46,
                                      height: 46,
                                    ),
                                    DView.spaceWidth(12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            worker.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            worker.category,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(
                        text: title, autoPadding: true), // 'Search Results'
                    DView.spaceHeight(),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: workers.length,
                        itemBuilder: (context, index) {
                          WorkerModel worker = workers[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoute.workerProfile.name,
                                arguments: worker,
                              );
                            },
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    Border.all(color: const Color(0xffeaeaea)),
                              ),
                              margin: EdgeInsets.only(
                                left: index == 0 ? 20 : 8,
                                right: index ==
                                        browseController.topRated.length - 1
                                    ? 20
                                    : 8,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    Appwrite.imageURL(worker.image),
                                    width: 46,
                                    height: 46,
                                    fit: BoxFit.cover,
                                  ),
                                  DView.spaceHeight(6),
                                  Text(
                                    worker.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  DView.spaceHeight(4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/ic_star_small.png',
                                        height: 16,
                                        width: 16,
                                      ),
                                      DView.spaceWidth(2),
                                      Text(
                                        '${worker.rating.toStringAsFixed(1)}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ],
      );
    });
  }

  Widget latestStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(text: 'Latest Worker stats'),
          DView.spaceHeight(),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/ic_hired_stats.png',
                      width: 46,
                      height: 46,
                    ),
                    DView.spaceWidth(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '$totalWorkers',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/ic_money_spend.png',
                      width: 46,
                      height: 46,
                    ),
                    DView.spaceWidth(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Available ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '$availableWorkers',
                            style: TextStyle(
                              color: Colors.black,
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
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffe5e7ec).withOpacity(0.5),
            blurRadius: 30,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 20, right: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: onSearch,
              decoration: const InputDecoration(
                hintText: 'Search your dream worker',
                hintStyle: TextStyle(
                  color: Color(0xffA7A8B3),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(0),
                isDense: true,
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: () => onSearch(searchController.text),
            icon: const ImageIcon(
              AssetImage(
                'assets/ic_search.png',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categories() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: browseController.categories.length,
        itemBuilder: (context, index) {
          Map category = browseController.categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoute.listWorker.name,
                arguments: category['label'],
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                left: index == 0 ? 20 : 8,
                right: index == browseController.categories.length - 1 ? 20 : 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    category['icon'],
                    width: 46,
                    height: 46,
                  ),
                  DView.spaceHeight(8),
                  Text(
                    category['label'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Aligns the content to the start
              children: [
                Obx(() {
                  return Text(
                    'Hi, ${userController.data.name ?? ''}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  );
                }),
                const SizedBox(
                    height: 4), // Add space between the name and title
                const Text(
                  'Recruiter',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          DView.spaceWidth(12), // Adds a small horizontal space between widgets
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, AppRoute.editProfile.name),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: const Color(0xffBFA8FF),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: Obx(() {
                return Text(
                  userController.data.name?[0] ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
