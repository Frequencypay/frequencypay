import 'package:bloc/bloc.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderDataService.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderTransactionScheduleModel.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderUserBillsModel.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderUserContractsModel.dart';

/*TODO:
   This bloc needs to be carefully redesigned to account for the calendar page's ability
   to move between months and bring up transaction history.
 */

//Events
class CalendarEvent {

}

class LoadCalendarEvent extends CalendarEvent {

}

//States
class CalendarState {

}

class CalendarIsLoadingState extends CalendarState {

}

class CalendarIsLoadedState extends CalendarState {

  final _schedule;

  CalendarIsLoadedState(PlaceholderTransactionScheduleModel this._schedule);

  PlaceholderTransactionScheduleModel get getSchedule => _schedule;
}

class CalendarIsNotLoadedState extends CalendarState {

}

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {

  PlaceholderDataService service;

  CalendarBloc(PlaceholderDataService service);

  @override
  CalendarState get initialState => CalendarIsLoadingState();

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) async*{

    if (event is LoadCalendarEvent) {
      yield CalendarIsLoadingState();

      try {

        PlaceholderTransactionScheduleModel schedule = await service.getLocalUserTransactionSchedule();
        yield CalendarIsLoadedState(schedule);
      } catch (_){

        print(_);
        yield CalendarIsNotLoadedState();
      }
    }
  }
}