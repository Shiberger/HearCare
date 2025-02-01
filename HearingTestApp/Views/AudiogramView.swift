// Views/AudiogramView.swift
import SwiftUI
import Charts

struct AudiogramView: View {
    let results: [HearingTestResult]

    var body: some View {
        Chart {
            ForEach(results) { result in
                ForEach(result.results.sorted(by: { $0.key < $1.key }), id: \.key) { frequency, volume in
                    LineMark(
                        x: .value("Frequency (Hz)", frequency),
                        y: .value("Volume (dB)", volume)
                    )
                }
            }
        }
        .padding()
        .navigationTitle("Audiogram")
    }
}