//
//  AudiogramView.swift
//  HearingTestApp
//
//  Created by Hannarong Kaewkiriya on 2/2/2568 BE.
//

import SwiftUI

struct AudiogramView: View {
    let results: [HearingTestResult]

    // Frequencies to display (in Hz)
    private let frequencies: [String] = ["250", "500", "1000", "2000", "4000", "8000"]

    // Volume levels to display (in dB)
    private let volumes: [Int] = Array(stride(from: 0, through: 120, by: 10))

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Pure Tone Audiogram")
                    .font(.title)
                    .padding(.bottom, 10)

                // Frequency Header
                HStack {
                    Text("Frequency (Hz)")
                        .frame(width: 120, alignment: .leading)
                    ForEach(frequencies, id: \.self) { frequency in
                        Text(frequency)
                            .frame(width: 40, alignment: .center)
                    }
                }

                // Volume and Grid
                ForEach(volumes, id: \.self) { volume in
                    HStack {
                        Text("\(volume)")
                            .frame(width: 120, alignment: .leading)
                        ForEach(frequencies, id: \.self) { frequency in
                            let key = "\(frequency) Hz"
                            if let result = results.first(where: { $0.results[key] == Float(volume) }) {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 20, height: 20)
                            } else {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(width: 20, height: 20)
                            }
                        }
                    }
                }

                // Legend
                VStack(alignment: .leading, spacing: 5) {
                    Text("Right Ear")
                    Text("Left Ear")
                    Text("Normal Hearing")
                    Text("Mild")
                    Text("Moderate")
                    Text("Moderately Severe")
                    Text("Severe")
                    Text("Profound")
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationTitle("Audiogram")
    }
}
