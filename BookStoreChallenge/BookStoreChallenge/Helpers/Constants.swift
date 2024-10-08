//
//  Constants.swift
//  BookStoreChallenge
//
//  Created by Valter Louro on 07/10/2024.
//

//https://www.googleapis.com/books/v1/volumes?q=quilting&key=AIzaSyCNjYq8wbW4Ee-VC4XxmChq3lvMpgLQC3Y

struct NetworkConstants {
    
    static let bookUrl = "https://www.googleapis.com/books/v1/volumes?q=%@&startIndex=%d&key=AIzaSyCNjYq8wbW4Ee-VC4XxmChq3lvMpgLQC3Y"
    static let searchParameter = "quilting"
}
