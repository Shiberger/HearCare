//
//  HearingTestViewModel.swift
//  HearingTestApp
//
//  Created by Hannarong Kaewkiriya on 2/2/2568 BE.
//

import Foundation
import FirebaseAuth

class HearingTestViewModel: ObservableObject {
    @Published var isTesting = false
    @Published var testResults: [String: Float] = [:] // Frequency (Hz) -> Volume (dB)
    @Published var savedResults: [HearingTestResult] = []
    
    // Real test result data for left and right ears
    @Published var testResult: [String: [Int]] = [
        "leftEar": [], // Initialize as empty
        "RightEar": [] // Initialize as empty
    ]

    // Current test state
    public var currentFrequencyIndex = 0
    public var currentVolume: Float = 50.0 // Start at 50 dB
    private var stepSize: Float = 10.0 // Initial step size (10 dB)
    public var currentEar: Ear = .right // Start with the right ear

    // Frequencies to test (in Hz)
    public let frequencies: [Float] = [250, 500, 1000, 2000, 4000, 8000]

    private let audioPlayer = AudioPlayer()
    private let firebaseService = FirebaseService()

    enum Ear {
        case left
        case right
    }

    func startTest() {
        isTesting = true
        currentFrequencyIndex = 0
        currentVolume = 50.0
        stepSize = 10.0
        currentEar = .right // Start with the right ear
        testNextFrequency()
    }

    private func testNextFrequency() {
        if currentFrequencyIndex < frequencies.count {
            let frequency = frequencies[currentFrequencyIndex]
            audioPlayer.playTone(frequency: frequency, amplitude: dbToAmplitude(currentVolume))
        } else {
            // Test complete for the current ear
            if currentEar == .right {
                // Switch to the left ear
                currentEar = .left
                currentFrequencyIndex = 0
                currentVolume = 50.0
                stepSize = 10.0
                testNextFrequency()
            } else {
                // Both ears tested, stop the test
                stopTest()
            }
        }
    }

    func recordResponse(heard: Bool) {
        let frequency = frequencies[currentFrequencyIndex]

        if heard {
            // User heard the tone, decrease volume
            currentVolume -= stepSize
            stepSize = 5.0 // Reduce step size to 5 dB after the first response
        } else {
            // User did not hear the tone, increase volume
            currentVolume += stepSize
        }

        // Check if we've found the threshold
        if stepSize == 5.0 && currentVolume >= 0 && currentVolume <= 120 {
            if !heard {
                // Threshold found (lowest volume the user could hear)
                let key = "\(Int(frequency)) Hz"
                testResults[key] = currentVolume

                // Update testResult for the current ear
                switch currentEar {
                case .right:
                    if testResult["RightEar"]?.count ?? 0 < 5 {
                        testResult["RightEar"]?.append(Int(currentVolume))
                    }
                case .left:
                    if testResult["leftEar"]?.count ?? 0 < 5 {
                        testResult["leftEar"]?.append(Int(currentVolume))
                    }
                }

                currentFrequencyIndex += 1
                currentVolume = 50.0 // Reset volume for the next frequency
                stepSize = 10.0 // Reset step size
                testNextFrequency()
            }
        } else {
            // Continue testing at the same frequency
            testNextFrequency()
        }
    }

    private func dbToAmplitude(_ db: Float) -> Float {
        // Convert dB to amplitude (linear scale)
        return pow(10.0, db / 20.0)
    }

    func stopTest() {
        audioPlayer.stopTone()
        isTesting = false
        saveResults()
    }

    private func saveResults() {
        if let userId = Auth.auth().currentUser?.uid {
            firebaseService.saveTestResult(userId: userId, results: testResults) { error in
                if let error = error {
                    print("Error saving results: \(error.localizedDescription)")
                } else {
                    print("Results saved successfully!")
                }
            }
        }
    }

    func fetchResults() {
        if let userId = Auth.auth().currentUser?.uid {
            firebaseService.fetchTestResults(userId: userId) { results, error in
                if let error = error {
                    print("Error fetching results: \(error.localizedDescription)")
                } else if let results = results {
                    self.savedResults = results
                }
            }
        }
    }
}
