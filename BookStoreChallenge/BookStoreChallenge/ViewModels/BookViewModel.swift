//
//  BookViewModel.swift
//  BookStoreChallenge
//
//  Created by Valter Louro on 07/10/2024.
//

import Foundation

class BookViewModel: NSObject {
    private var apiKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "SecureKeys", ofType: "plist") else {
          fatalError("Couldn't find file 'SecureKeys.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'SecureKeys.plist'.")
        }
        return value
      }
    }
    
    var reloadCollectionView: (() -> Void)?
    var startIndex = 0
    var shouldStopGetData = false
    var bookCellViewModels = [BookCellViewModel]() {
        didSet {
            reloadCollectionView?()
        }
    }
    
    var bookCellFavoriteViewModels = [BookCellViewModel]()
    var bookModels: [Book] = []
    private var bookRequestService: BooksRequestProtocol
    
    init(bookRequestService: BooksRequestProtocol = NetworkRequests()) {
        self.bookRequestService = bookRequestService
    }
    
    //MARK: Get Book Data
    func getBooksData() {
        let url = String(format: NetworkConstants.bookUrl, NetworkConstants.searchParameter, startIndex, self.apiKey)
        NetworkRequests.shared.getBooks(url: url) { result, error in
            
            if error { return }
            
            guard let result = result else {
                return
            }
            
            if result.count == 0 {
                self.shouldStopGetData = true
                return
            }
            
            var vms = [BookCellViewModel]()
            
            for book in result {
                vms.append(self.createBookCellModel(book: book))
            }
            
            self.bookCellViewModels.append(contentsOf: vms)
            self.startIndex += 10
        }
    }
    
    //MARK: Get Favorites
    func getFavorites() {
        self.bookCellFavoriteViewModels.removeAll()
        let favoriteBooks = BookDatabase.shared.loadBooks()
        self.bookCellFavoriteViewModels.append(contentsOf: favoriteBooks)
    }
    
    //MARK: Create Book Cell Model
    func createBookCellModel(book: Book) -> BookCellViewModel {
        let thumbnailUrl = book.volumeInfo.imageLinks?.thumbnail
        let bookId = book.id
        let selfLink = book.selfLink
        let bookTitle = book.volumeInfo.title
        let smallThumbnailUrl = book.volumeInfo.imageLinks?.smallThumbnail
        let buyLink = book.saleInfo.buyLink
        let description = book.volumeInfo.description
        var authors = ""
        if let authorsString = book.volumeInfo.authors {
            var authorsStr = ""
            for author in authorsString {
                authorsStr = authorsStr + "\(author), "
            }
            authorsStr = String(authorsStr.dropLast(2))
            authors = authorsStr
        }
        return BookCellViewModel(thumbnailUrl: thumbnailUrl, smallThumbnailUrl: smallThumbnailUrl, bookId: bookId, bookTitle: bookTitle, selfLink: selfLink, buyLink: buyLink, description: description, authors: authors)
    }
    
}
