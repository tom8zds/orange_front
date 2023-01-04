import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orange_front/internal/calendar/calendar_data.dart';
import 'package:orange_front/presentations/detail_page.dart';

import 'presentations/calendar_page.dart';
import 'presentations/home_page.dart';
import 'presentations/index_page.dart';
import 'presentations/init_page.dart';
import 'presentations/total_view_page.dart';
import 'presentations/widgets/adaptive_scaffold.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomePage();
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        final location = state.location;
        final int level;
        if (location.endsWith("/")) {
          level = location.replaceFirst("/", "", 1).split("/").length;
        } else {
          level = location.split("/").length;
        }
        return AdaptiveScaffold(
          appbar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Container(
              color: Theme.of(context).appBarTheme.backgroundColor,
              width: 48,
              height: 56,
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease,
                    width: level > 2 ? 64 : 0,
                    height: 48,
                    padding: const EdgeInsets.only(left: 16),
                    child: level > 2
                        ? TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              size: 24,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(
                    width: 56,
                    child: Center(
                      child: Image(
                        image: NetworkImage(
                            "https://mikanani.me/images/mikan-pic.png"),
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  Text(
                    "ORANGE",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    "PREVIEW",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).disabledColor,
                        ),
                  ),
                ],
              ),
            ),
          ),
          destinations: [
            AdaptiveScaffoldDestination(
              icon: const Icon(Icons.subscriptions),
              title: "追番",
              route: "/subscribe",
            ),
            AdaptiveScaffoldDestination(
              icon: const Icon(Icons.calendar_month),
              title: "时间表",
              route: "/calendar",
            ),
            AdaptiveScaffoldDestination(
              icon: const Icon(Icons.store),
              title: "全部番剧",
              route: "/overview",
            ),
            AdaptiveScaffoldDestination(
              icon: const Icon(Icons.change_circle),
              title: "切换服务器",
              route: "/setting",
            ),
          ],
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/subscribe',
          name: 'subscribe',
          builder: (context, state) {
            return const IndexPage();
          },
        ),
        GoRoute(
            path: '/calendar',
            name: 'calendar',
            builder: (context, state) {
              return const CalendarPage();
            },
            routes: [
              GoRoute(
                path: 'detail/:id',
                builder: (context, state) {
                  final anime = state.extra as AnimeData;
                  return DetailPage(
                    anime: anime,
                  );
                },
              ),
            ]),
        GoRoute(
          path: '/overview',
          name: 'overview',
          builder: (context, state) {
            return TotalViewPage();
            // InitPage(),
          },
        ),
        GoRoute(
          path: '/setting',
          name: 'setting',
          builder: (context, state) {
            return InitPage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/init',
      builder: (context, state) => InitPage(),
    ),
  ],
);
