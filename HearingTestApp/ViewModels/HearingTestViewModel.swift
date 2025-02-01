//
//  HearingTestViewModel.swift
//  HearingTestApp
//
//  Created by Hannarong Kaewkiriya on 2/2/2568 BE.
//

import Foundation

class HearingTestViewModel: ObservableObject {
    @Published var isTesting = false
    @Published var testResults: [String: Float] = [:]
    private let audioPlayer = AudioPlayer()

    func startTest() {
        isTesting = true
        // Example: Play a tone at 1000 Hz with 50% amplitude
        audioPlayer.playTone(frequency: 1000, amplitude: 0.5)
    }

    func recordResult(frequency: String, volume: Float) {
        testResults[frequency] = volume
    }

    func stopTest() {
        audioPlayer.stopTone()
        isTesting = false
    }
}
