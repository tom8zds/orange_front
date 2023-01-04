import 'package:go_router/go_router.dart';
import 'package:orange_front/internal/index/bloc/subscribe_index_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_front/internal/setting/bloc/setting_bloc.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.read<SettingBloc>().state is! SettingIdle) {
      context.go("/init");
    }
    return BlocProvider(
      create: (_) => SubscribeIndexBloc(),
      child: BlocConsumer<SubscribeIndexBloc, SubscribeIndexState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SubscribeIndexInitial) {
            context.read<SubscribeIndexBloc>().add(GetSubscribeIndexEvent());
            return Container();
          }
          if (state is SubscribeIndexLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SubscribeIndexFail) {
            return Center(
              child: Column(
                children: [
                  const Icon(Icons.warning),
                  IconButton(
                    onPressed: () => context
                        .read<SubscribeIndexBloc>()
                        .add(GetSubscribeIndexEvent()),
                    icon: const Icon(Icons.refresh),
                  ),
                  Text(state.exception.toString())
                ],
              ),
            );
          }
          if (state is SubscribeIndexFinish) {
            final subscribeItems = state.data;
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: 16),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = subscribeItems.elementAt(index);
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              item.cover.replaceFirst(
                                  "/bangumi/cover/https/", "https://"),
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Chip(
                                  label: Text(
                                    "${item.episode}",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ActionChip(
                                  label: Text(
                                    item.bangumiName,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
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
                      );
                    }, childCount: subscribeItems.length),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 304,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                  ),
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
