import 'package:go_router/go_router.dart';
import 'package:orange_front/internal/calendar/calendar_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_front/presentations/detail_page.dart';

import '../internal/calendar/bloc/calendar_bloc.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalendarBloc(),
      child: BlocConsumer<CalendarBloc, CalendarState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CalendarInitial) {
            context.read<CalendarBloc>().add(GetCalendarEvent());
            return Container();
          }
          if (state is CalendarLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CalendarFail) {
            return Center(
              child: Column(
                children: [
                  const Icon(Icons.warning),
                  IconButton(
                    onPressed: () =>
                        context.read<CalendarBloc>().add(GetCalendarEvent()),
                    icon: const Icon(Icons.refresh),
                  ),
                  Text(state.exception.toString())
                ],
              ),
            );
          }
          if (state is CalendarFinish) {
            final calendarData = state.data.table;
            return CustomScrollView(
              slivers: [
                // const SliverToBoxAdapter(
                //   child: SizedBox(height: 16),
                // ),
                for (int i = 0; i < calendarData.entries.length * 2; i++)
                  i % 2 == 1
                      ? SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          sliver: SliverToBoxAdapter(
                            child: AnimeWrap(
                              data: calendarData.entries
                                  .elementAt((i / 2).floor())
                                  .value,
                            ),
                          ),
                        )
                      : SliverToBoxAdapter(
                          child: ListTile(
                            title: Text(
                              calendarData.entries
                                  .elementAt((i / 2).floor())
                                  .key
                                  .name,
                            ),
                          ),
                        ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                ),
              ],
            );
          }
          throw UnimplementedError();
        },
      ),
    );
  }
}

class AnimeWrap extends StatelessWidget {
  final List<AnimeData> data;

  const AnimeWrap({super.key, required this.data});

  int calGap(double width) {
    if (width > 960) {
      return 304;
    }
    if (width > 640) {
      return 72;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int gap = calGap(width);
    int num = ((width - gap - 32) / (144 + 8)).floor();
    double padding = (width - gap - 32 - 8 * (num - 1) - 144 * num) / 2;
    print("num: $num , padding: $padding, gap: $gap");
    print(data.elementAt(0).cover);
    return Padding(
      padding: EdgeInsets.only(left: padding > 0 ? padding : 0),
      child: SizedBox(
        width: 144 * num + 8 * (num - 1),
        child: Wrap(
          runSpacing: 8,
          spacing: 8,
          children: [
            for (var item in data)
              Material(
                child: SizedBox(
                  height: 144,
                  width: 144,
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          context.go(
                            '/calendar/detail/${item.id}',
                            extra: item,
                          );
                        },
                      ),
                      Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(item.cover),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActionChip(
                            label: Text(
                              item.name,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
