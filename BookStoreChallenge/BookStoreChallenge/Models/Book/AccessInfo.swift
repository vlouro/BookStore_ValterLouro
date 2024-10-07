//
//  AccessInfo.swift
//  BookStoreChallenge
//
//  Created by Valter Louro on 07/10/2024.
//
import Foundation

struct AccessInfo: Codable {
    let country: String
    let viewability: String
    let embeddable: Bool
    let publicDomain: Bool
    let textToSpeechPermission: String
    let epub: Epub?
    let pdf: Pdf?
    let webReaderLink: String
    let accessViewStatus: String
    let quoteSharingAllowed: Bool
}

struct Epub: Codable {
    let isAvailable: Bool
}

struct Pdf: Codable {
    let isAvailable: Bool
    let acsTokenLink: String
}
