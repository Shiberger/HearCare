//
//  ContentView.swift
//  HearingTestApp
//
//  Created by Hannarong Kaewkiriya on 2/2/2568 BE.
//

// Views/ContentView.swift
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HearingTestViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Hearing Test")
                    .font(.largeTitle)
                    .padding()

                if viewModel.isTesting {
                    Text("Testing \(viewModel.currentEar == .right ? "Right Ear" : "Left Ear") at \(viewModel.frequencies[viewModel.currentFrequencyIndex]) Hz, \(Int(viewModel.currentVolume)) dB")
                    HStack {
                        Button("I hear the tone") {
                            viewModel.recordResponse(heard: true)
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button("I don't hear the tone") {
                            viewModel.recordResponse(heard: false)
                        }
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                } else {
                    Button("Start Test") {
                        viewModel.startTest()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                // Check if testResult is populated before navigating
                if !viewModel.testResult["leftEar"]!.isEmpty && !viewModel.testResult["RightEar"]!.isEmpty {
                    NavigationLink("View Summary", destination: HearingTestSummaryView(testResult: viewModel.testResult))
                        .padding()
                }
            }
            .padding()
            .navigationTitle("Hearing Test")
        }
    }
}
