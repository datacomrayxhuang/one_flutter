import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/add_todo.dart';
import 'package:todo_app/view_models/home/home_bloc.dart';
import 'package:ui_elements/widgets/custom_app_bar.dart';
import 'package:ui_elements/widgets/custom_button.dart';
import 'package:ui_elements/widgets/expandable_text_tile.dart';
import 'package:ui_elements/widgets/loading_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = '/home';

  void _onTodoTileLongPressed(BuildContext context, {required TodoModel todo}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Actions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                CustomButton.primary(
                  text: const Text('Mark as complete'),
                  onPressed: () {},
                ),
                const SizedBox(height: 16),
                CustomButton.secondary(
                  text: const Text('Delete'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState homeState) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Home',
            hasBackButton: false,
            actions: [
              if (!homeState.isLoading && homeState.todos.isEmpty)
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => context
                      .read<HomeBloc>()
                      .add(const HomeFetchTodosRequested()),
                ),
            ],
          ),
          body: homeState.isLoading
              ? const LoadingView()
              : RefreshIndicator.adaptive(
                  onRefresh: () async => context
                      .read<HomeBloc>()
                      .add(const HomeFetchTodosRequested()),
                  child: homeState.todos.isNotEmpty
                      ? ListView.builder(
                          itemCount: homeState.todos.length,
                          itemBuilder: (BuildContext context, int index) {
                            final bool isLastItem =
                                index == homeState.todos.length - 1;
                            final todo = homeState.todos[index];

                            final Widget tile = ExpandableTextTile(
                              title: todo.title,
                              titleTextStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                decoration: todo.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                              description: todo.description,
                              descriptionTextStyle: TextStyle(
                                fontSize: 14,
                                decoration: todo.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                              onLongPress: () => _onTodoTileLongPressed(
                                context,
                                todo: todo,
                              ),
                            );

                            // Add padding to the last item to prevent it
                            // from being cut off by the floating action button
                            if (isLastItem) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 72),
                                child: tile,
                              );
                            }

                            return tile;
                          },
                        )
                      : const _HomeEmptyView(),
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

/// A widget that displays a message when there are no todos available.
/// It shows an icon and a message prompting the user to add their first todo.
/// This widget is used in the [HomePage] when the todo list is empty.
/// It is a private widget and should not be used outside of this file.
class _HomeEmptyView extends StatelessWidget {
  const _HomeEmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No todos available',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Tap the button below to add your first todo!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
