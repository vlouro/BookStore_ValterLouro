//
//  BookDatabase.swift
//  BookStoreChallenge
//
//  Created by Valter Louro on 08/10/2024.
//
import Foundation
import UIKit
import CoreData

class BookDatabase {
    static let shared = BookDatabase()
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteBookModel")
        container.loadPersistentStores(completionHandler: { _, error in
            _ = error.map { fatalError("Unresolved error \($0)") }
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func backgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    func loadBooks() -> [BookCellViewModel] {
        var favoriteBooks: [BookCellViewModel] = []
        let mainContext = BookDatabase.shared.mainContext
        let fetchRequest: NSFetchRequest<FavoriteBook> = FavoriteBook.fetchRequest()
        do {
            let results = try mainContext.fetch(fetchRequest)
            
            for result in results {
                let book = BookCellViewModel(thumbnailUrl: result.smallThumbnailUrl ?? "", smallThumbnailUrl: result.smallThumbnailUrl, bookId: result.bookId ?? "", bookTitle: result.bookTitle ?? "", selfLink: result.selfLink ?? "", buyLink: result.buyLink, description: result.descriptionBook, authors: result.authors)
                favoriteBooks.append(book)
            }
            
        }
        catch {
            debugPrint(error)
        }
        return favoriteBooks
    }
    
    func saveBook(book: BookCellViewModel) {
        DispatchQueue.main.async {
            let mainContext = BookDatabase.shared.mainContext
            do{
                let entity = FavoriteBook.entity()
                let favoriteBook = FavoriteBook(entity: entity, insertInto: mainContext)
                favoriteBook.smallThumbnailUrl = book.smallThumbnailUrl
                favoriteBook.bookId = book.bookId
                favoriteBook.bookTitle = book.bookTitle
                favoriteBook.selfLink = book.selfLink
                favoriteBook.buyLink = book.buyLink
                favoriteBook.descriptionBook = book.description
                favoriteBook.authors = book.authors
                try mainContext.save()
                }  catch {
                debugPrint(error)
              
            }
        }
    }
    
    func deleteItemWithIndex(bookId: String)  {
        DispatchQueue.main.async {
            let mainContext = BookDatabase.shared.mainContext
            let fetchRequest: NSFetchRequest<FavoriteBook> = FavoriteBook.fetchRequest()
            do {
                fetchRequest.predicate = NSPredicate(format:"bookId == %@",bookId)

                // Setting includesPropertyValues to false means
                // the fetch request will only get the managed
                // object ID for each object
                fetchRequest.includesPropertyValues = false
                // Perform the fetch request
                let objects = try mainContext.fetch(fetchRequest)
                
                // Delete the objects
                for object in objects {
                    mainContext.delete(object)
                }

                // Save the deletions to the persistent store
                try mainContext.save()
                
            } catch {
                
            }
        }
    }
    
    func checkIsFavorite(bookId: String) -> Bool {
        
        let mainContext = BookDatabase.shared.mainContext
        let fetchRequest: NSFetchRequest<FavoriteBook> = FavoriteBook.fetchRequest()
        do {
        
            fetchRequest.predicate = NSPredicate(format:"bookId == %@",bookId)
            fetchRequest.includesPropertyValues = false
            
            let results = try mainContext.fetch(fetchRequest)
            
            if results.count >= 1 {
                return true
            } else {
                return false
            }
        }  catch {
            debugPrint(error)
            return false
        }
    }
    
}
