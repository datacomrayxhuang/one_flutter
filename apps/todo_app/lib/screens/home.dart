import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/screens/add_todo.dart';
import 'package:todo_app/view_models/home/home_bloc.dart';
import 'package:ui_elements/widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = '/home';

  Widget get _loadingView {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget get _emptyView {
    return const Center(
      child: Text('No todos available'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState homeState) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Home',
            hasBackButton: false,
          ),
          body: homeState.isLoading
              ? _loadingView
              : RefreshIndicator(
                  onRefresh: () async => context
                      .read<HomeBloc>()
                      .add(const HomeFetchTodosRequested()),
                  child: homeState.todos.isNotEmpty
                      ? ListView.builder(
                          itemCount: homeState.todos.length,
                          itemBuilder: (BuildContext context, int index) {
                            final bool isLastItem =
                                index == homeState.todos.length - 1;
                            final Widget tile = ListTile(
                              title: Text(homeState.todos[index].title),
                              subtitle:
                                  Text(homeState.todos[index].description),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  // Handle delete action
                                },
                              ),
                            );

                            if (isLastItem) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 72),
                                child: tile,
                              );
                            }

                            return tile;
                          },
                        )
                      : _emptyView,
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.push(AddTodoPage.routeName).then(
              (popResult) {
                if (!context.mounted) return;
                context.read<HomeBloc>().add(const HomeFetchTodosRequested());
              },
            ),
            tooltip: 'Add To-Do',
            label: const Text('Add To-Do'),
            icon: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
