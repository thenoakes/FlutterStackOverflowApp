import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterstackapp/home/index.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';

/// This is the 'Home Screen' widget which is presented by the Home Page
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
    @required HomeBloc homeBloc,
  })  : _homeBloc = homeBloc,
        super(key: key);

  /// A BLOC for handling Home Page logic
  final HomeBloc _homeBloc;

  @override
  HomeScreenState createState() {
    return HomeScreenState(_homeBloc);
  }
}

class HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc;
  HomeScreenState(this._homeBloc);

  // Dispatch the LoadHomeEvent
  @override
  void initState() {
    super.initState();
    this._homeBloc.dispatch(LoadHomeEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Build the screen according to the current state
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeEvent, HomeState>(
        bloc: widget._homeBloc,
        builder: (
          BuildContext context,
          HomeState currentState,
        ) {
          if (currentState is UnHomeState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorHomeState) {
            return Container(
                child: Center(
              child: Text(currentState.errorMessage ?? 'Error'),
            ));
          }
          if (currentState is InHomeState) {
            QuestionData questionData = currentState.questionData;

            return Material(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xffd399c1),
                                Color(0xff9b5acf),
                                Color(0xff611cdf),
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            )),
                      ),
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        title: Text("Stack Overflow"),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.15,
                        left: 20,
                        right: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          "Hi, Welcome to Stack Overflow Questions App",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 22,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "All Questions",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: questionData.questions.length,
                      itemBuilder: (context, i) {
                        Question question = questionData.questions[i];
                        return ListTile(
                          dense: true,
                          isThreeLine: true,
                          leading: CircleAvatar(
                            radius: 25,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueGrey,
                            child: Text(question.score.toString()),
                          ),
                          title: Html(
                              data: question.question,
                              style: {
                                "code": Style.fromTextStyle(GoogleFonts.robotoMono(color: Color(0xFF474747)))
                              }),
                          trailing: Chip(
                            backgroundColor: Colors.blueGrey,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Text(
                              question.views.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          subtitle: Wrap(
                            children: question.tags
                                .map((t) => Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Chip(
                                      backgroundColor: Color(0xff9b5acf),
                                      label: Text(
                                        t,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )))
                                .toList(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        });
  }
}
