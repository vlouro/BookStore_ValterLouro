//
//  Book.swift
//  BookStoreChallenge
//
//  Created by Valter Louro on 07/10/2024.
//

import Foundation

typealias Books = [Book]

// MARK: - Api Response
struct BooksApiResponse: Codable {
    let kind: String?
    let totalItems : Int?
    let items: [Book]?
}

struct Book : Codable {
    let kind: String
    let id: String
    let selfLink: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
    let accessInfo: AccessInfo
    let searchInfo: SearchInfo?
}

