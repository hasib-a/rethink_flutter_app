import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final dummySnapshot = [
  {"pollDesc": "do 1", "voteCount": 15},
  {"pollDesc": "do 2", "voteCount": 14},
  {"pollDesc": "do 3", "voteCount": 11},
  {"pollDesc": "kill him", "voteCount": 10},
  {"pollDesc": "chuck 'im out", "voteCount": 1},
];

// // class VotingPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('placehold me'),
// //       ),
// //       body: Center(
// //         child: RaisedButton(
// //           onPressed: () {
// //             Navigator.pop(context);
// //           },
// //           child: Text('go back'),
// //         ),
// //       ),
// //     );
// //   }
// // }
//Demo of just the tabs, how they work.
class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.assignment)),
                Tab(icon: Icon(Icons.question_answer)),
              ],
            ),
            title: Text('Replace with poll.name'),
          ),
          body: TabBarView(
            children: [
              MyVotingPage(),
              // votingForm(context),
              Icon(Icons.add_comment),
            ],
          ),
        ),
      ),
    );
  }
}

Widget votingForm(BuildContext context) {
  return Scaffold(
    body: Container(
        padding: EdgeInsets.all(20.0), child: Text('coding test child data')),
  );
}

class MyVotingPage extends StatefulWidget {
  @override
  _MyVotingPageState createState() => _MyVotingPageState();
}

class _MyVotingPageState extends State<MyVotingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Voting Panel'),
      ),
      body: _buildBody(context),
    );
  }
} // TODO: is this needed or has it now been replaces by TabViewController????

Widget _buildBody(BuildContext context) {
  //TODO: get actual data from firebase
  return _buildList(context, dummySnapshot);
}

Widget _buildList(BuildContext context, List<Map> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, Map data) {
  final record = Record.fromMap(data);
  return Padding(
    key: ValueKey(record.pollDesc),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Text(record.pollDesc),
        trailing: Text(record.voteCount.toString()),
        onTap: () => print(record),
      ),
    ),
  );
}

class Record {
  final String pollDesc;
  final int voteCount;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['pollDesc'] != null),
        assert(map['voteCount'] != null),
        pollDesc = map['pollDesc'],
        voteCount = map['voteCount'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$pollDesc:$voteCount>";
}
