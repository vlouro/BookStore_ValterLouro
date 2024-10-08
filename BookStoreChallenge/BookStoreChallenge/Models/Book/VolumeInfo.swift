//
//  VolumeInfo.swift
//  BookStoreChallenge
//
//  Created by Valter Louro on 07/10/2024.
//


import Foundation

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let industryIdentifiers: [IndustryIdentifiers]?
    let readingModes: ReadingModes?
    let pageCount: Int?
    let printType: String
    let categories: [String]?
    let maturityRating: String?
    let allowAnonLogging: Bool
    let contentVersion: String
    let panelizationSummary: PanelizationSummary?
    let imageLinks: ImageLinks?
    let language: String
    let previewLink: String
    let infoLink: String
    let canonicalVolumeLink: String
}

struct IndustryIdentifiers: Codable {
    let type: String
    let identifier: String
}

struct ReadingModes: Codable {
    let text: Bool
    let image: Bool
}

struct PanelizationSummary: Codable {
    let containsEpubBubbles: Bool
    let containsImageBubbles: Bool
}

struct ImageLinks: Codable {
    let smallThumbnail: String
    let thumbnail: String
}
