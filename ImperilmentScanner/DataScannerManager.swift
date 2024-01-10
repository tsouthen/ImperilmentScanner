//
//  DataScannerManager.swift
//  ImperilmentScanner
//
//  Created by Todd Southen on 1/31/23.
//

import SwiftUI
import VisionKit

extension RecognizedItem {
    func getText() -> String? {
        switch self {
        case let .text(text):
            return text.transcript
        case let .barcode(barcode):
            return barcode.payloadStringValue
        @unknown default: break
        }
        return nil
    }
}

/// Manages the properties and methods related to data scanning.
final class DataScannerManager: NSObject, ObservableObject, DataScannerViewControllerDelegate {
    
    /// Value indicating that scanning has failed.
    @Published private(set) var dataScannerFailure: DataScannerViewController.ScanningUnavailable?
    
    /// The recognized strings.
    @Published var recognisedText: Dictionary<UUID, String> = [:];

    private func updateRecognizedText(_ items: [RecognizedItem]) {
        items.forEach { item in
            if let text = item.getText() {
                recognisedText[item.id] = text
            }
        }
    }
    
    // MARK: - DataScannerViewControllerDelegate
    
    func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
        updateRecognizedText(addedItems)
    }

    func dataScanner(_ dataScanner: DataScannerViewController, didUpdate updatedItems: [RecognizedItem], allItems: [RecognizedItem]) {
        updateRecognizedText(updatedItems)
    }
    
    func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
        removedItems.forEach { recognisedText.removeValue(forKey: $0.id) }
    }
    
    func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
    }
    
    func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
         self.dataScannerFailure = error
    }
}
