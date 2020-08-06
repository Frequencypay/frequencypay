import 'package:bloc/bloc.dart';

//Events
class CalendarEvent {}

class LoadCalendarEvent extends CalendarEvent {}

//States
class CalendarState {}

class CalendarIsLoadingState extends CalendarState {}

class CalendarIsLoadedState extends CalendarState {
  //final _schedule;

  //CalendarIsLoadedState(PlaceholderTransactionScheduleModel this._schedule);

  //PlaceholderTransactionScheduleModel get getSchedule => _schedule;
}

class CalendarIsNotLoadedState extends CalendarState {}

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc(CalendarState initialState) : super(initialState);

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) async* {
    if (event is LoadCalendarEvent) {
      yield CalendarIsLoadingState();

      try {
        //PlaceholderTransactionScheduleModel schedule = await service.getLocalUserTransactionSchedule();
        //yield CalendarIsLoadedState(schedule);
      } catch (_) {
        print(_);
        yield CalendarIsNotLoadedState();
      }
    }
  }
}
