//
//  HearingTestSummaryView.swift
//  HearingTestApp
//
//  Created by Hannarong Kaewkiriya on 2/2/2568 BE.
//

// Views/HearingTestSummaryView.swift
import SwiftUI
import AAInfographics

struct HearingTestSummaryView: View {
    var testResult: [String: [Int]]
    
    @State private var leftEarAvg: Int = 0
    @State private var rightEarAvg: Int = 0
    @State private var resultTitle: String = ""
    @State private var resultDescription: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            // Navigation Bar
            HStack {
                Button(action: {
                    // Handle back button action
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                Spacer()
                Text("ผลการทดสอบ")
                    .font(.headline)
                Spacer()
            }
            .padding()
            
            // Chart Section
            ChartView(testResult: testResult)
                .frame(height: 300)
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 5)
            
            // Result Section
            VStack(alignment: .leading, spacing: 8) {
                Text(resultTitle)
                    .font(.title2)
                    .foregroundColor(.pink)
                Text(resultDescription)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
            
            // Message Boxes
            MessageBox(type: .warning, title: "คำแนะนำ", description: "ผลการทำสอบอาจมีความคลาดเคลื่อนเนื่องจากท่านอยู่ในสภาพแวดล้อมที่เสียงดังเกินไป")
            MessageBox(type: .information, title: "การทดสอบเป็นการคัดกรองแบบเบื้องต้นเท่านั้น", description: "เพื่อความถูกต้องแม่นยำมากขึ้นท่านสามารถปรึกษาแพทย์ผู้เชี่ยวชาญเพื่อตรวจอย่างละเอียด")
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .onAppear {
            updateResult()
        }
    }
    
    private func updateResult() {
        guard let leftEar = testResult["leftEar"],
              let rightEar = testResult["RightEar"],
              !leftEar.isEmpty, !rightEar.isEmpty else {
            print("Error: Test results are empty")
            return
        }
        
        // Calculate averages safely
        leftEarAvg = leftEar.reduce(0, +) / leftEar.count
        rightEarAvg = rightEar.reduce(0, +) / rightEar.count
        
        let result = EarTestResultList.evaluate(leftEarAvg: leftEarAvg, rightEarAvg: rightEarAvg)
        resultTitle = result.title
        resultDescription = result.description
    }
}
