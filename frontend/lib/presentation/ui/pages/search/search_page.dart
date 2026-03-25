import 'package:flutter/material.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:mapa_adoleser/presentation/ui/pages/search/widgets/search_map_widget.dart';
import 'package:mapa_adoleser/presentation/ui/pages/search/widgets/search_panel_widget.dart';
import 'package:mapa_adoleser/providers/activity_search_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ActivitySearchProvider>().searchActivities();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: authProvider.isLoggedIn),
      endDrawer: CustomDrawer(isLoggedIn: authProvider.isLoggedIn),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (ResponsiveBreakpoints.of(context).largerThan(TABLET)) {
            return const Row(
              children: [
                Expanded(flex: 2, child: SearchMapWidget()),
                Expanded(flex: 1, child: SearchPanelWidget()),
              ],
            );
          } else {
            return const Column(
              children: [
                Expanded(flex: 1, child: SearchMapWidget()),
                Expanded(flex: 1, child: SearchPanelWidget()),
              ],
            );
          }
        },
      ),
    );
  }
}
