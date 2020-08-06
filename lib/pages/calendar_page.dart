//  Original Copyright Info for table_calendar is following 2 lines
//  Copyright (c) 2019 Aleksander Woźniak
//  Licensed under Apache License v2.0

//(if the apache license v2.0 copyright stuff is a problem, there's another flutter calendar widget available that we can switch to)
//(not sure about its copyright status though)

import 'package:flutter/material.dart';
import 'package:frequencypay/widgets/app_bar_header.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

//ISSUES
//Unable to make it say "no payments due" when day with no payments selected

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    //NOTES: requires at least 2 dates (_selectedDay or DateTime) or will crash
    //_selectedDay dates override DateTime dates regardless of input order
    //Otherwise, first event per date is used
    _events = {
      DateTime(2020, 6, 7): ['First Event'],
      DateTime(2020, 6, 23): ['Second Event'],
      DateTime(2020, 6, 26): ['Third Event', 'Fourth Event'],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  //month int to string; find a better way to do this if available
  String _monthIntToString(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        {
          print('Invalid Month Called');
          return 'Invalid Month';
        }
    }
  }

  //weekday int to string; find a better way to do this if available
  String _weekdayIntToString(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        {
          print('Invalid Weekday Called');
          return 'Invalid Weekday';
        }
    }
  }

  //Date formatted as in screen; find a better way to do this if available
  String _formatDateToString(DateTime date) {
    String weekday = _weekdayIntToString(date.weekday);
    String month = _monthIntToString(date.month);
    String day = date.day.toString();
    return '$weekday, $month $day';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Calendar', context),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SizedBox(height: 20.0),
          SafeArea(
            child: Row(
              children: <Widget>[
                Expanded(flex: 1, child: Container()),
                Expanded(
                    flex: 5,
                    child: Row(children: <Widget>[
                      Text('Your ',
                          style: TextStyle(
                              color: Color(0xFF8C8C8C), fontSize: 18.0)),
                      Text('Month',
                          style: TextStyle(
                              color: Color(0xFF3665FF),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)),
                    ])),
                Expanded(flex: 1, child: Container()),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              Expanded(flex: 1, child: Container()),
              Expanded(
                  flex: 5,
                  child: Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: _buildTableCalendar())),
              Expanded(flex: 1, child: Container()),
            ],
          ),
          const SizedBox(height: 30.0),
          _buildEventList(),
          const SizedBox(height: 25.0),
          //TODO: Make the bottom sheet appear partially by default and open up the rest when pressed
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          _openBottomSheet(context);
        },
        child: new Icon(Icons.add),
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
      availableCalendarFormats: const {CalendarFormat.month: ''},
      calendarStyle: CalendarStyle(
        weekdayStyle: TextStyle(
            color: Color(0xFF595959),
            fontSize: 13.0,
            fontWeight: FontWeight.bold),
        weekendStyle: TextStyle(
            color: Color(0xFF595959),
            fontSize: 13.0,
            fontWeight: FontWeight.bold),
        selectedStyle: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 13.0,
            fontWeight: FontWeight.bold),
        outsideStyle: TextStyle(
            color: Color(0xFFBFBFBF),
            fontSize: 13.0,
            fontWeight: FontWeight.bold),
        outsideWeekendStyle: TextStyle(
            color: Color(0xFFBFBFBF),
            fontSize: 13.0,
            fontWeight: FontWeight.bold),
        selectedColor: Color(0xFF3665FF),
        markersColor:
        Color(0xFFE5E5E5), //Should be full circle rather than just marker
        renderDaysOfWeek: false,
        highlightToday: false,
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
        titleTextBuilder: (date, locale) => _monthIntToString(date.month),
        titleTextStyle: TextStyle(color: Color(0xFF8C8C8C), fontSize: 17.0),
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    DateTime titleDay = DateTime.now();
    if (_calendarController != null) {
      if (_calendarController.selectedDay != null) {
        titleDay = _calendarController.selectedDay;
      }
    }
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 5,
              child: Text(
                _formatDateToString(titleDay),
                style: TextStyle(color: Color(0xFF575757), fontSize: 14.0),
              ),
            ),
            Expanded(flex: 1, child: Container()),
          ],
        ),
        const SizedBox(height: 15.0),
        Row(
          children: <Widget>[
            Expanded(flex: 1, child: Container()),
            Expanded(
                flex: 5,
                child: Column(
                  children: <Widget>[
                    //Text('payments due placeholder', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                    //TODO: Add placeholder for when no events on day; should say 'No payments due'
                    Column(
                      children: _selectedEvents
                          .map(
                            (event) => Container(
                          child: ListTile(
                            title: Text(event.toString(),
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                            onTap: () => print('$event tapped!'),
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  ],
                )),
            Expanded(flex: 1, child: Container()),
          ],
        ),
      ],
    );
  }

  void _openBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return _buildBottomSheetContents();
        }
    );
  }

  Widget _buildBottomSheetContents() {
    return Container(
      height: 295,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(35.0)),
        boxShadow: [BoxShadow(blurRadius: 10.0)],
      ),
      child: ListView(
        children: <Widget>[
          //not sure how to make the gray line thing
          Row(
            children: <Widget>[
              Expanded(flex: 1, child: Container()),
              Expanded(
                  flex: 4,
                  child: Row(
                    children: <Widget>[
                      Text('Your ',
                          style: TextStyle(
                              color: Color(0xFF8C8C8C), fontSize: 18.0)),
                      Text('Transactions',
                          style: TextStyle(
                              color: Color(0xFF3665FF),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Icon(Icons.search,
                      color: Color(0xFF8C8C8C), size: 25.0)),
              Expanded(flex: 1, child: Container()),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(flex: 1, child: Container()),
              Expanded(flex: 5, child: _buildTransactionsList()),
              Expanded(flex: 1, child: Container()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList() {
    //creating static model for now; not dynamically generated at this time
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        _buildTransaction('Josh', 'Comcast', DateTime(2020, 6, 9), -120),
        _buildTransaction('You', 'Sam', DateTime(2020, 6, 6), 15),
        _buildTransaction('You', 'Treon', DateTime(2020, 6, 1), 25),
        _buildTransaction('Sam', 'Netflix', DateTime(2020, 5, 29), -15),
        _buildTransaction('You', 'Seth', DateTime(2020, 5, 25), 25),
      ],
    );
  }

  Widget _buildTransaction(
      String borrower, String lender, DateTime date, int amount) {
    return Row(
      children: <Widget>[
        Expanded(flex: 1, child: CircleAvatar(radius: 40)),
        Expanded(
          flex: 3,
          child: Column(
            children: <Widget>[
              Text('${borrower} paid ${lender}',
                  style: TextStyle(color: Color(0xFF595959), fontSize: 10.0)),
              Text('${_monthIntToString(date.month)} ${date.day.toString()}',
                  style: TextStyle(color: Color(0xFF8C8C8C), fontSize: 10.0)),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: (() {
            if (amount > 0) {
              return Text('\$${amount}', style: TextStyle(color: Color(0xFF68BA76), fontSize: 11.0));
            } else if (amount < 0) {
              return Text('-\$${amount * -1}', style: TextStyle(color: Color(0xFFEE5353), fontSize: 11.0));
            } else {  //amount = 0
              return Text('\$0', style: TextStyle(color: Color(0xFF000000), fontSize: 11.0));
            };
          }()),
        ),
      ],
    );
  }
}
