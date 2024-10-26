import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se7ety/core/enum/user_type.dart';
import 'package:se7ety/core/services/local_storage.dart';
import 'package:se7ety/feature/auth/presntation/bloc/auth_event.dart';
import 'package:se7ety/feature/auth/presntation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterEvent>(register);
    on<LoginEvent>(login);
  }
}

login(LoginEvent event, Emitter<AuthState> emit) async {
  emit(LoginLoadingState());
  try {
    var userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email, password: event.passWord);
    User user = userCredential.user!;
    AppLocalStorage.cacheData(key: AppLocalStorage.userToken, value: user.uid);
    AppLocalStorage.cacheData(key: AppLocalStorage.isLoggedIn, value: true);
    emit(LoginSuccesState());
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      emit(AuthErrorState(error: "الحساب غير موجود"));
    } else if (e.code == 'wrong-password') {
      emit(AuthErrorState(error: "كلمة المرور غير صحيحة"));
    } else {
      emit(AuthErrorState(error: ' خطأ '));
    }
  } catch (e) {
    emit(AuthErrorState(error: 'حدث خطأ غير متوقع.'));
  }
}

register(RegisterEvent event, Emitter<AuthState> emit) async {
  emit(RegisterLoadingState());
  try {
    var userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: event.email,
      password: event.passWord,
    );
    User user = userCredential.user!;
    user.updateDisplayName(event.name);
    AppLocalStorage.cacheData(key: AppLocalStorage.userToken, value: user.uid);
    if (event.userType == UserType.patient) {
      await FirebaseFirestore.instance
          .collection("patients")
          .doc(user.uid)
          .set({
        'name': event.name,
        'image': '',
        'age': '',
        'email': event.email,
        'phone': '',
        'bio': '',
        'city': '',
        'uid': user.uid,
      });
    } else {
      await FirebaseFirestore.instance.collection("doctors").doc(user.uid).set({
        'name': event.name,
        'image': '',
        'specialization': '',
        'rating': 3,
        'email': event.email,
        'phone1': '',
        'phone2': '',
        'bio': '',
        'openHour': '',
        'closeHour': '',
        'address': '',
        'uid': user.uid,
      });
    }
    AppLocalStorage.cacheData(key: AppLocalStorage.isLoggedIn, value: true);

    emit(RegisterSuccesState());
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      emit(AuthErrorState(error: 'كلمة المرور المستخدمه ضعيفه . '));
    } else if (e.code == 'email-already-in-use') {
      emit(AuthErrorState(error: "الايميل مستخدم بالفعل ."));
    }
  } catch (e) {
    emit(AuthErrorState(error: "حدث خطأ ما "));
  }
}
