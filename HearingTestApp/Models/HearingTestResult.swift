// Models/HearingTestResult.swift
import Foundation
import FirebaseFirestoreSwift

struct HearingTestResult: Identifiable, Codable {
    @DocumentID var id: String? // Firestore document ID
    let userId: String
    let date: Date
    let results: [String: Float] // Frequency (Hz) -> Volume (dB)

    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case date
        case results
    }
}