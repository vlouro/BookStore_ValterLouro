//
//  BooksViewController.swift
//  BookStoreChallenge
//
//  Created by Valter Louro on 07/10/2024.
//

import Foundation
import UIKit

class BooksViewController: UIViewController {
    
    let cellIdentifier = "NationListCollectionViewCell"
    let bookCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.alwaysBounceVertical = true
        collectionview.showsVerticalScrollIndicator = false
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    lazy var bookViewModel = {
        BookViewModel()
    }()
  
    override func viewDidLoad() {
        self.setupNavigationBar()
        bookViewModel.getBooksData()
    }
    
    //MARK: SETUP VIEW
    func setupViews() {
        
        self.view.backgroundColor = .white
       // self.bookCollectionView.delegate = self
       // self.bookCollectionView.dataSource = self
       // self.bookCollectionView.register(PopulationListViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.view.addSubview(bookCollectionView)
        
        NSLayoutConstraint.activate([
            bookCollectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            bookCollectionView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            bookCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            bookCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    func setupNavigationBar() {
        self.navigationController?.appearanceNavigation()
        self.title = "Books"
    }
}
