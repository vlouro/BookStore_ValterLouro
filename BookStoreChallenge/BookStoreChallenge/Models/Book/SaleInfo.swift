//
//  SaleInfo.swift
//  BookStoreChallenge
//
//  Created by Valter Louro on 07/10/2024.
//

import Foundation

struct SaleInfo: Codable {
    let country: String
    let saleability: String
    let isEbook: Bool
    let listPrice: ListPrice?
    let retailPrice: RetailPrice?
    let buyLink: String?
    let offers: [Offer]?
}

struct ListPrice: Codable {
    let amount: Double
    let currencyCode: String
}

struct RetailPrice: Codable {
    let amount: Double
    let currencyCode: String
}

struct Offer: Codable {
    let finskyOfferType: Int
    let listPrice: OfferListPrice
    let retailPrice: OfferRetailPrice
}

struct OfferListPrice: Codable {
    let amountInMicros: Double
    let currencyCode: String
}

struct OfferRetailPrice: Codable {
    let amountInMicros: Double
    let currencyCode: String
}
