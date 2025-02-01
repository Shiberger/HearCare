//
//  HearingTestResult.swift
//  HearingTestApp
//
//  Created by Hannarong Kaewkiriya on 2/2/2568 BE.
//

import Foundation
import FirebaseFirestore

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
