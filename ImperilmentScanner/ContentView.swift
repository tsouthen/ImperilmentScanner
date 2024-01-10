//
//  ContentView.swift
//  ImperilmentScanner
//
//  Created by Todd Southen on 2023-01-31.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var dataScannerManager: DataScannerManager = DataScannerManager()
    
    var body: some View {
        DataScannerView(dataScannerManager: dataScannerManager)
            .aspectRatio(1, contentMode: .fit)
        .onTapGesture(perform: {
            if !dataScannerManager.recognisedText.isEmpty {
                dataScannerManager.recognisedText.removeAll()
            }
        })
        .overlay(alignment: .bottomLeading, content: {
            if !dataScannerManager.recognisedText.isEmpty {
                ZStack {
                    VStack {
                        Text("Count: \(dataScannerManager.recognisedText.count)")
                        let sorted = dataScannerManager.recognisedText.sorted(by: { $0.value < $1.value })
                        ForEach(sorted, id: \.key) { key, value in
                            Text(value)
                        }
                    }
                    .padding(.leading, 16)
                }
//                    .frame(height: 300)
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
