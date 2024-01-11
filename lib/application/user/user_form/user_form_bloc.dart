import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:institute_app/domain/core/value_objects.dart';
import 'package:institute_app/domain/user/models/user.dart';
import 'package:institute_app/domain/user/models/user_failure.dart';
import 'package:institute_app/domain/user/models/value_objects.dart';
import 'package:institute_app/domain/user/user_repository_interface.dart';

part 'user_form_event.dart';
part 'user_form_state.dart';

part 'user_form_bloc.freezed.dart';

@injectable
class UserFormBloc extends Bloc<UserFormEvent, UserFormState> {
  UserFormBloc(this._userRepository) : super(UserFormState.initial()) {
    on<UserFormEvent>((event, emit) async {
      switch (event) {
        case Initialized(:final isEditing, :final user):
          late final User initialUser;
          if (user != null) {
            initialUser = user;
          } else {
            initialUser = (isEditing
                    ? await _userRepository.getCurrentUser()
                    : await _userRepository.getInitialUserFromAuth())
                .toNullable()!;
          }
          emit(
            state.copyWith(
              user: initialUser,
              isEditing: isEditing,
              showErrorMessages: false,
              isSaving: false,
              saveFailureOrSuccessOption: none(),
            ),
          );
        case NameChanged(:final nameStr):
          emit(
            state.copyWith(
              user: state.user.copyWith(
                name: StringSingleLine(nameStr),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case PhotoUrlChanged(:final photoUrlStr):
          emit(
            state.copyWith(
              user: state.user.copyWith(
                photoUrl: Url(photoUrlStr),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case BioChanged(:final bioStr):
          emit(
            state.copyWith(
              user: state.user.copyWith(
                bio: UserBio(bioStr),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        case Saved():
          Either<UserFailure, Unit>? failureOrSuccess;

          emit(
            state.copyWith(
              isSaving: true,
              saveFailureOrSuccessOption: none(),
            ),
          );

          if (state.user.failureOption.isNone()) {
            failureOrSuccess = state.isEditing
                ? await _userRepository.updateUser(state.user)
                : await _userRepository.createUser(state.user);
          }

          emit(
            state.copyWith(
              isSaving: false,
              showErrorMessages: true,
              saveFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
      }
    });
  }

  final UserRepositoryInterface _userRepository;
}
