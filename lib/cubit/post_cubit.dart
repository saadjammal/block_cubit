import 'package:flutter_bloc/flutter_bloc.dart';

enum PostState{initial, del}

class PostCubit extends Cubit<PostState>{
  PostCubit() : super(PostState.initial);



}