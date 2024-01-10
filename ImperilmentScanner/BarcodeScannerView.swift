//
//  BarcodeScannerView.swift
//  ImperilmentScanner
//
//  Created by Todd Southen on 1/31/23.
//

import SwiftUI
import VisionKit

/// A view that allows for the scanning of a barcode.
struct BarcodeScannerView: UIViewControllerRepresentable {
    
    /// Manages the logic related to scanning data.
    @ObservedObject var dataScannerManager: DataScannerManager
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let dataScannerViewController = DataScannerViewController(recognizedDataTypes: [.barcode(symbologies: [.upce,.ean8,.ean13])], qualityLevel: .fast, isHighlightingEnabled: true)
        dataScannerViewController.delegate = dataScannerManager
        try? dataScannerViewController.startScanning()
        return dataScannerViewController
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {}
}

