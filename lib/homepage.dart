import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



class homepage extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor:Colors.purpleAccent ,
            title: Center(child: const Text('VOTING SYSTEM',
              style: TextStyle(fontWeight:FontWeight.bold),
            ))),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResultPage(_firestoreService)),
                  );
                },
                child: Text('SHOW RESULT'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _firestoreService.addDocument('candidates', {'name': 'WAJID', 'votes': 0});
                },
                child: Text('Add Candidate'),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: _firestoreService.getAllCandidatesStream('candidates'),
                  builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    final candidates = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: candidates.length,
                      itemBuilder: (context, index) {
                        final candidate = candidates[index];
                        if (candidate == null) {
                          return SizedBox();
                        }
                        return ListTile(
                          title: Text(candidate['name'] ?? 'No Name'),
                          trailing: ElevatedButton(
                            onPressed: () async {
                              await _firestoreService.updateVotes('candidates', candidate['id'], candidate['votes'] + 1);
                            },
                            child: Text('Vote'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),

    );}
}

class ResultPage extends StatelessWidget {
  final FirestoreService _firestoreService;

  ResultPage(this._firestoreService);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Candidate Results')),
      body: StreamBuilder(
        stream: _firestoreService.getAllCandidatesStream('candidates'),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          final candidates = snapshot.data ?? [];
          return ListView.builder(
            itemCount: candidates.length,
            itemBuilder: (context, index) {
              final candidate = candidates[index];
              if (candidate == null) {
                return SizedBox(); // Or any other widget to handle null candidates
              }
              return ListTile(
                title: Text(candidate['name'] ?? 'No Name'), // Null check for the 'name' property
                subtitle: Text('Votes: ${candidate['votes'] ?? 0}'),
              );
            },
          );
        },
      ),
    );
  }
}

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getAllDocuments(String collectionName) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore.collection(collectionName).get();
      return querySnapshot.docs.map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>}).toList();
    } catch (e) {
      print('Error fetching documents: $e');
      return [];
    }
  }

  Stream<List<Map<String, dynamic>>> getAllCandidatesStream(String collectionName) {
    return _firestore.collection(collectionName).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>}).toList();
    });
  }

  Future<void> addDocument(String collectionName, Map<String, dynamic> data) async {
    await _firestore.collection(collectionName).add(data);
  }

  Future<void> updateVotes(String collectionName, String documentID, int votes) async {
    await _firestore.collection(collectionName).doc(documentID).update({'votes': votes});
  }
}
