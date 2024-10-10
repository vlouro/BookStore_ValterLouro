//
//  MockApiService.swift
//  BookStoreChallengeTests
//
//  Created by Valter Louro on 10/10/2024.
//

import Foundation
@testable import BookStoreChallenge

class MockApiService: BooksRequestProtocol {
    
    var booksData: [Book] = [Book]()
    var isFetchDataCalled = false
    
    func getBooks(url: String, completion: @escaping ([BookStoreChallenge.Book]?, Bool) -> Void) {
        let industryIdentifiers = [IndustryIdentifiers(type: "ISBN_13", identifier: "9781607056720"), IndustryIdentifiers(type: "ISBN_10", identifier: "1607056720")]
        let readingModes = ReadingModes(text: false, image: true)
        let panelizationSummary = PanelizationSummary(containsEpubBubbles: false, containsImageBubbles: false)
        let imageLinks = ImageLinks(smallThumbnail: "http://books.google.com/books/content?id=1WqjSf8FwooC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api", thumbnail: "http://books.google.com/books/content?id=1WqjSf8FwooC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")
        
        let volumeInfo = VolumeInfo(title: "First Steps to Free-motion Quilting", subtitle: "24 Projects for Fearless Stitching", authors: [
            "Christina Cameli"
        ], publisher: "C&T Publishing Inc", publishedDate: "2013", description: "A refreshingly new approach to free-motion stitching, First Steps to Free-Motion Quilting by Christina Cameli allows you to make something beautiful while improving your free-motion quilting skills. It features 24 simple projects and quilts that are light on assembly so you can spend most of your time stitching. You'll learn the basics, pick a project, and start stitching. A handy troubleshooting guide ensures success every step of the way.", industryIdentifiers: industryIdentifiers, readingModes: readingModes, pageCount: 148, printType: "BOOK", categories:  [
                "Crafts & Hobbies"
        ], maturityRating: "NOT_MATURE", allowAnonLogging: true, contentVersion: "0.1.1.0.preview.1", panelizationSummary: panelizationSummary, imageLinks: imageLinks, language: "en", previewLink: "http://books.google.pt/books?id=1WqjSf8FwooC&printsec=frontcover&dq=quilting&hl=&cd=1&source=gbs_api", infoLink: "http://books.google.pt/books?id=1WqjSf8FwooC&dq=quilting&hl=&source=gbs_api", canonicalVolumeLink: "https://books.google.com/books/about/First_Steps_to_Free_motion_Quilting.html?hl=&id=1WqjSf8FwooC")
        
        let listPrice = ListPrice(amount: 16.99, currencyCode: "EUR")
        let retailPrice = RetailPrice(amount: 16.99, currencyCode: "EUR")
        let offers = [Offer(finskyOfferType: 1, listPrice: OfferListPrice(amountInMicros: 16990000, currencyCode: "EUR"), retailPrice: OfferRetailPrice(amountInMicros: 16990000, currencyCode: "EUR"))]
        let saleInfo = SaleInfo(country: "PT", saleability: "NOT_FOR_SALE", isEbook: false, listPrice: listPrice, retailPrice: retailPrice, buyLink: "https://play.google.com/store/books/details?id=5W-ChoTedM4C&rdid=book-5W-ChoTedM4C&rdot=1&source=gbs_api", offers: offers)
        
        let epub = Epub(isAvailable: false)
        let pdf = Pdf(isAvailable: true, acsTokenLink: "http://books.google.pt/books/download/First_Steps_to_Free_motion_Quilting-sample-pdf.acsm?id=1WqjSf8FwooC&format=pdf&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api")
        let accessInfo = AccessInfo(country: "PT", viewability: "PARTIAL", embeddable: true, publicDomain: false, textToSpeechPermission: "ALLOWED", epub: epub, pdf: pdf, webReaderLink: "http://play.google.com/books/reader?id=1WqjSf8FwooC&hl=&source=gbs_api", accessViewStatus: "SAMPLE", quoteSharingAllowed: false)
        
        let searchInfo = SearchInfo(textSnippet: "A refreshingly new approach to free-motion stitching, First Steps to Free-Motion Quilting by Christina Cameli allows you to make something beautiful while improving your free-motion quilting skills.")
        
        let book = Book(kind: "books#volume", id: "1WqjSf8FwooC", selfLink: "https://www.googleapis.com/books/v1/volumes/1WqjSf8FwooC", volumeInfo: volumeInfo, saleInfo: saleInfo, accessInfo: accessInfo, searchInfo: searchInfo)
        
        completion([book], false)
    }
}
