//
//  MultiTextScannerView.swift
//  ImperilmentScanner
//
//  Created by Todd Southen on 2023-01-17.
//

import SwiftUI
import VisionKit

/// A view that allows for the scanning of a barcode.
struct DataScannerView: UIViewControllerRepresentable {
    var barcodes = false;
    var text = true;
    var multiple = true;
    
    /// Manages the logic related to scanning data.
    @ObservedObject var dataScannerManager: DataScannerManager
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        var dataTypes: Set<DataScannerViewController.RecognizedDataType> = []
        if text {
            dataTypes.insert(.text())
        }
        if barcodes {
            dataTypes.insert(.barcode(symbologies: [.upce,.ean8,.ean13]))
        }
        let dataScannerViewController = DataScannerViewController(recognizedDataTypes: dataTypes, qualityLevel: .fast, recognizesMultipleItems: multiple, isHighlightingEnabled: true)
        dataScannerViewController.delegate = dataScannerManager
        try? dataScannerViewController.startScanning()
        return dataScannerViewController
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {}
}

