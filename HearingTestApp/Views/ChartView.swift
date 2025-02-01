//
//  ChartView.swift
//  HearingTestApp
//
//  Created by Hannarong Kaewkiriya on 2/2/2568 BE.
//

import SwiftUI
import AAInfographics

struct ChartView: UIViewRepresentable {
    var testResult: [String: [Int]]
    
    func makeUIView(context: Context) -> AAChartView {
        let aaChartView = AAChartView()
        aaChartView.backgroundColor = .clear
        aaChartView.isScrollEnabled = false
        
        let leftEar = testResult["leftEar"]
        let rightEar = testResult["RightEar"]
        
        let aaChartModel = AAChartModel()
            .chartType(.line)
            .legendEnabled(false)
            .animationType(.linear)
            .dataLabelsEnabled(true)
            .colorsTheme(["#E83A63", "#F5851C"])
            .stacking(.none)
            .yAxisMax(100)
            .animationDuration(2000)
            .yAxisTitle("ระดับความดัง (dB)")
            .xAxisTitle("ความถี่ (Hz)")
            .xAxisLabelsStyle(AAStyle(color: AAColor.black, fontSize: 10, weight: .regular))
            .yAxisLabelsStyle(AAStyle(color: AAColor.black, fontSize: 10, weight: .regular))
            .titleStyle(AAStyle(color: AAColor.black, fontSize: 10, weight: .regular))
            .yAxisReversed(true)
            .dataLabelsStyle(AAStyle().fontSize(8))
            .categories(["500", "1000", "2000", "4000", "8000"])
            .series([
                AASeriesElement()
                    .name("หูซ้าย")
                    .data(leftEar ?? []),
                AASeriesElement()
                    .name("หูขวา")
                    .data(rightEar ?? [])
            ])
        
        let aaOptions = aaChartModel.aa_toAAOptions()
        aaOptions.yAxis?
            .gridLineDashStyle(.shortDot)
            .gridLineWidth(0)
            .gridLineColor(AAColor.black)
        
        let aaPlotBandsArr = [
            AAPlotBandsElement()
                .from(0)
                .to(25)
                .color("#F9FFF6"),
            AAPlotBandsElement()
                .from(26)
                .to(35)
                .color("#F1F6E9"),
            AAPlotBandsElement()
                .from(36)
                .to(50)
                .color("#FFFCEB"),
            AAPlotBandsElement()
                .from(51)
                .to(74)
                .color("#FFF5EC"),
            AAPlotBandsElement()
                .from(75)
                .to(100)
                .color("#FDF0ED")
        ]
        
        aaOptions.yAxis?.plotBands(aaPlotBandsArr)
        
        aaChartView.aa_drawChartWithChartOptions(aaOptions)
        return aaChartView
    }
    
    func updateUIView(_ uiView: AAChartView, context: Context) {}
}
