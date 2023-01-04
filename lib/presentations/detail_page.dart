import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orange_front/internal/calendar/calendar_data.dart';
import 'package:orange_front/internal/detail/bloc/subscribe_bloc.dart';

class DetailPage extends StatelessWidget {
  final AnimeData anime;

  const DetailPage({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SubscribeBloc(),
        child: DetailParserWidget(anime: anime),
      ),
    );
  }
}

class DetailParserWidget extends StatelessWidget {
  const DetailParserWidget({
    Key? key,
    required this.anime,
  }) : super(key: key);

  final AnimeData anime;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscribeBloc, SubscribeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 144,
                    child: Center(
                      child: Container(
                        height: 144,
                        width: 144,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(anime.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        context
                            .read<SubscribeBloc>()
                            .add(QueryParserEvent(anime.name));
                      },
                      icon: const Icon(Icons.search),
                      label: const Text("匹配刮削"))
                ],
              ),
            ),
            if (state is ParserLoading)
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 144,
                  width: 144,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            if (state is ParserDone)
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                final item = state.data.elementAt(index);
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      height: 196,
                      child: Row(
                        children: [
                          Container(
                            height: 196,
                            width: 144,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(item.cover),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("名称: ${item.name}"),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text("季度: ${item.seasonName}"),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "描述: ${item.overview}",
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("匹配"),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }, childCount: state.data.length))
          ],
        );
      },
    );
  }
}
