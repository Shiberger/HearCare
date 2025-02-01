//
//  EarTestResultList.swift
//  HearingTestApp
//
//  Created by Hannarong Kaewkiriya on 2/2/2568 BE.
//

import Foundation

struct EarTestResultList {
    static func evaluate(leftEarAvg: Int, rightEarAvg: Int) -> (title: String, description: String) {
        // Define your evaluation logic here
        let average = (leftEarAvg + rightEarAvg) / 2
        
        switch average {
        case 0..<25:
            return ("ปกติ", "ระดับการได้ยินของคุณอยู่ในเกณฑ์ปกติ")
        case 25..<40:
            return ("หูตึงเล็กน้อย", "คุณอาจมีปัญหาในการได้ยินเสียงเบา")
        case 40..<70:
            return ("หูตึงปานกลาง", "คุณอาจมีปัญหาในการได้ยินเสียงพูดปกติ")
        case 70..<90:
            return ("หูตึงรุนแรง", "คุณอาจมีปัญหาในการได้ยินเสียงดัง")
        default:
            return ("หูหนวก", "คุณอาจไม่สามารถได้ยินเสียงใดๆ")
        }
    }
}
