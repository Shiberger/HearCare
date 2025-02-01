// Models/FirebaseService.swift
import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirebaseService {
    private let db = Firestore.firestore()

    // Save hearing test results to Firestore
    func saveTestResult(userId: String, results: [String: Float], completion: @escaping (Error?) -> Void) {
        let testResult = HearingTestResult(
            userId: userId,
            date: Date(),
            results: results
        )

        do {
            _ = try db.collection("hearingTests").addDocument(from: testResult, completion: completion)
        } catch {
            completion(error)
        }
    }

    // Fetch hearing test results for a user
    func fetchTestResults(userId: String, completion: @escaping ([HearingTestResult]?, Error?) -> Void) {
        db.collection("hearingTests")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }

                let results = snapshot?.documents.compactMap { document in
                    try? document.data(as: HearingTestResult.self)
                }
                completion(results, nil)
            }
    }
}