//
//  NetworkRequests.swift
//  BookStoreChallenge
//
//  Created by Valter Louro on 07/10/2024.
//

import Foundation

enum NetworkError: Error {
    case badURL(String)
    case networkError(Error)
    case invalidData
    case jsonParsingError(DecodingError)
    case invalidStatusCode(Int)
    case unknown(Error)
}

protocol BooksRequestProtocol {
    func getBooks(completion: @escaping ([Book]?, Bool) -> Void)
}

class NetworkRequests: BooksRequestProtocol {
    
    // MARK: Variables
    static let shared = NetworkRequests()
    
    // MARK: Methods
    
    // dataRequest which sends request to given URL and convert to Decodable Object
    func dataRequest<T: Decodable>(with url: String, objectType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        // create the URL instance
        guard let requestURL = URL(string: url) else {
            completion(.failure(NetworkError.badURL(url)))
            return
        }
        
        // create the session object
        let session = URLSession.shared
        
        // Now create the URLRequest object using the URL object
        let request = URLRequest(url: requestURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        // create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            // declare result type
            let result: Result<T, NetworkError>
            
            // defer the to call completion handler
            defer {
                completion(result)
            }
            
            if let error {
                result = .failure(.networkError(error))
                return
            }
            
            guard let data = data, !data.isEmpty else {
                result = .failure(.invalidData)
                return
            }
            
            do {
                // create decodable object from data
                let responseObject = try JSONDecoder().decode(objectType.self, from: data)
                result = .success(responseObject)
            } catch let error as DecodingError {
                result = .failure(.jsonParsingError(error))
            } catch {
                result = .failure(.unknown(error))
            }
        })
        task.resume()
    }
    
    func getBooks(completion: @escaping ([Book]?, Bool) -> Void) {
        var books: [Book] = []
        var hasError: Bool = false
        
        self.dataRequest(with: "https://www.googleapis.com/books/v1/volumes?q=quilting&key=AIzaSyCNjYq8wbW4Ee-VC4XxmChq3lvMpgLQC3Y", objectType: BooksApiResponse.self) { (result: Result) in
            switch result {
            case .success(let object):
                print(object)
                if let booksArr = object.items, booksArr.count > 0 {
                    books.append(contentsOf: booksArr)
                }
                completion(books, hasError)
            case .failure(let error):
                print(error)
                hasError = true
                completion(books, hasError)
            }
        }
    }
}
