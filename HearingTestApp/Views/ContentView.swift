//
//  ContentView.swift
//  HearingTestApp
//
//  Created by Hannarong Kaewkiriya on 2/2/2568 BE.
//

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
                    Text("Testing...")
                    Button("I hear the tone") {
                        // Record the result for 1000 Hz
                        viewModel.recordResult(frequency: "1000 Hz", volume: 50)
                        viewModel.stopTest()
                    }
                } else {
                    Button("Start Test") {
                        viewModel.startTest()
                    }
                }

                if !viewModel.testResults.isEmpty {
                    Text("Results:")
                    ForEach(viewModel.testResults.sorted(by: { $0.key < $1.key }), id: \.key) { frequency, volume in
                        Text("\(frequency): \(volume) dB")
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Hearing Test")
        }
    }
}
