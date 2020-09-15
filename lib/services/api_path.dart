class APIPath {
  static String question(String uid, String questionId) =>
      'users/$uid/questions/$questionId';
  static String questions(String uid) => 'users/$uid/questions';
  static String allQuestions() => 'questions/';
  static String createInAllQuestions(String questionId) =>
      'questions/$questionId';
}
