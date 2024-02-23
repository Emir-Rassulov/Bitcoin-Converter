//
//  BitcoinDelegate.swift
//  BitcoinConverter
//
//  Created by Emir Rassulov on 27/01/2024.
//

import Foundation

protocol BitcoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}
