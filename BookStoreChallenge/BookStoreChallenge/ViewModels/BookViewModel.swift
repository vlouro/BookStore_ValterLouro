//
//  BookViewModel.swift
//  BookStoreChallenge
//
//  Created by Valter Louro on 07/10/2024.
//

import Foundation

class BookViewModel: NSObject {
    
    var reloadCollectionView: (() -> Void)?
    
    var bookCellViewModels = [BookCellViewModel]() {
        didSet {
            reloadCollectionView?()
        }
    }
    
    var bookModels: [Book] = []
    
    private var bookRequestService: BooksRequestProtocol
    
    init(bookRequestService: BooksRequestProtocol = NetworkRequests()) {
        self.bookRequestService = bookRequestService
    }
    
    //MARK: Get Book Data
    func getBooksData() {
        var error = false
        NetworkRequests.shared.getBooks { result, error in
            
            if error { return }
            
            guard let result = result else {
                return
            }
            
            var vms = [BookCellViewModel]()
            self.bookModels.append(contentsOf: result)
            
            for book in self.bookModels {
                vms.append(self.createBookCellModel(book: book))
            }
            
            self.bookCellViewModels.append(contentsOf: vms)
            
            print(self.bookCellViewModels)
        }
    }
    
    func createBookCellModel(book: Book) -> BookCellViewModel {
        let thumbnailUrl = book.volumeInfo.imageLinks?.thumbnail
        let bookId = book.id
        let selfLink = book.selfLink
        let bookTitle = book.volumeInfo.title
        let smallThumbnailUrl = book.volumeInfo.imageLinks?.smallThumbnail
        return BookCellViewModel(thumbnailUrl: thumbnailUrl, smallThumbnailUrl: smallThumbnailUrl, bookId: bookId, bookTitle: bookTitle, selfLink: selfLink)
    }
    
}
