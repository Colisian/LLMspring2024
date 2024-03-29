import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educ_ai_tion/models/assignment_submission.dart';

class AssignmentData {
  Future<void> addAssignmentSubmission(AssignmentSubmission submission) async {
    String documentId =
        '${submission.studentName}_${submission.assignmentName}'; // Use assignmentName

    try {
      await FirebaseFirestore.instance
          .collection('assignment_submissions')
          .doc(documentId)
          .set({
        'assignmentName': submission.assignmentName,
        'studentName': submission.studentName,
        'studentEmail': submission.studentEmail,
        'answers': submission.answers,
        'submissionDateTime': submission.submissionDateTime
      });
    } catch (e) {
      print('Error adding assignment submission: $e');
      throw e;
    }
  }
}
