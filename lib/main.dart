import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tests/features/post/presentation/bloc/AddDeleteUpdatePosts/add_delete_update_posts_bloc.dart';
import 'package:tests/features/post/presentation/bloc/posts/posts_block.dart';
import 'package:tests/features/post/presentation/bloc/posts/posts_events.dart';
import 'features/post/presentation/pages/posts_page.dart';
import 'global_core/app_theme.dart';
import 'global_core/injection_container.dart' as di;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> di.sl<PostsBloc>()..add(GetAllPostsEvent()) ),
        BlocProvider(create: (_)=> di.sl<AddDeleteUpdatePostsBloc>() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Posts App',
        theme: appTheme,
        home: const PostsPage(),
      ),
    );
  }
}
