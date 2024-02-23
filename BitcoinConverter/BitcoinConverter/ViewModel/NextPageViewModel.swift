//
//  NextPageViewModel.swift
//  BitcoinConverter
//
//  Created by Emir Rassulov on 27/01/2024.
//

import Foundation
import SwiftUI

class NextPageViewModel: ObservableObject {
    @Published var bitcoinPrice = ""
    @Published var selectedCurrency = "USD"
    @Published var rotationAngle: Double = 0
    @Published var isLoading: Bool = false

    var currencyArray = ["AUD", "BRL", "CAD", "CNY", "EUR", "GBP", "HKD", "IDR", "ILS", "INR", "JPY", "KZT", "MXN", "NOK", "NZD", "PLN", "RON", "RUB", "SEK", "SGD", "USD", "ZAR", "CZK"]

    private var bitcoinManager = BitcoinManager()

    init() {
        bitcoinManager.delegate = self
    }

    func getCoinPrice() {
        isLoading = true
        bitcoinManager.getCoinPrice(for: selectedCurrency)
    }

    func startRotation() {
        withAnimation(Animation.linear(duration: 15).repeatForever(autoreverses: false)) {
            rotationAngle = 360
        }
    }

    var formattedBitcoinPrice: String {
        // Use the actual bitcoinPrice here
        let formatter = NumberFormatter()
        formatter.currencyCode = selectedCurrency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2

        if let priceDouble = Double(bitcoinPrice),
           let formattedPrice = formatter.string(from: NSNumber(value: priceDouble)) {
            return formattedPrice
        } else {
            return ""
        }
    }
}

extension NextPageViewModel: BitcoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinPrice = price
            self.selectedCurrency = currency
            self.isLoading = false
        }
    }

    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            print(error)
            self.isLoading = false
        }
    }
}

