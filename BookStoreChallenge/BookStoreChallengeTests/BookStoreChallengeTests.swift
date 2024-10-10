//
//  BookStoreChallengeTests.swift
//  BookStoreChallengeTests
//
//  Created by Valter Louro on 07/10/2024.
//

import Testing
@testable import BookStoreChallenge
import XCTest

class BookStoreChallengeTests : XCTestCase {
    
    var bookVM: BookViewModel!
    var mockApiService: MockApiService!
    
    override func setUp() {
        super.setUp()
        mockApiService = MockApiService()
        bookVM = BookViewModel(bookRequestService: mockApiService)
        
    }
    
    override func tearDown() {
        super.tearDown()
        mockApiService = nil
        bookVM = nil
    }
    
    func testFetchBook() {
        var books : [Book] = []
        mockApiService.getBooks(url: "https://www.googleapis.com/books/v1/volumes?q=quilting") { bookData, hasError in
            guard let book = bookData else {
                XCTFail("Failed to get books")
                return
            }
            books.append(contentsOf: book)
        }
        XCTAssertTrue(books.count > 0)
    }
    
    func testCreateBookCellViewModel() {
        var booksCells : [BookCellViewModel] = []
        mockApiService.getBooks(url: "https://www.googleapis.com/books/v1/volumes?q=quilting") { bookData, hasError in
            guard let bookData = bookData, let firstBook = bookData.first else {
                XCTFail("Failed to get books")
                return
            }
            booksCells.append(self.bookVM.createBookCellModel(book: firstBook))
        }
        XCTAssertTrue(booksCells.count > 0)
        XCTAssert(booksCells.first?.bookTitle == "First Steps to Free-motion Quilting")
    }
}
