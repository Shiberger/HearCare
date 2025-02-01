//
//  MessageBox.swift
//  HearingTestApp
//
//  Created by Hannarong Kaewkiriya on 2/2/2568 BE.
//

import SwiftUI

struct MessageBox: View {
    enum MessageBoxType {
        case warning, information
    }
    
    var type: MessageBoxType
    var title: String
    var description: String
    
    var body: some View {
        HStack {
            Image(systemName: type == .warning ? "exclamationmark.triangle.fill" : "info.circle.fill")
                .foregroundColor(type == .warning ? .orange : .blue)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}
