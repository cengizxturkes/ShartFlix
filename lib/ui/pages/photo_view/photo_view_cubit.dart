import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/models/enums/load_status.dart';

part 'photo_view_state.dart';

class PhotoViewCubit extends Cubit<DetailMoviePhotoViewState> {
  PhotoViewCubit() : super(const DetailMoviePhotoViewState());
}
