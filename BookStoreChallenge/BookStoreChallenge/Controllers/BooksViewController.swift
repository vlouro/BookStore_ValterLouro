//
//  BooksViewController.swift
//  BookStoreChallenge
//
//  Created by Valter Louro on 07/10/2024.
//

import Foundation
import UIKit

class BooksViewController: UIViewController {
    
    let cellIdentifier = "BookCollectionViewCell"
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
        self.setupViews()
        self.initViewModel()
    }
    
    //MARK: SETUP VIEW
    func setupViews() {
        
        self.view.backgroundColor = .white
        self.bookCollectionView.delegate = self
        self.bookCollectionView.dataSource = self
        self.bookCollectionView.register(BookViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.view.addSubview(bookCollectionView)
        
        NSLayoutConstraint.activate([
            bookCollectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            bookCollectionView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            bookCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            bookCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    func initViewModel() {
        bookViewModel.getBooksData()
        bookViewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.bookCollectionView.reloadData()
            }
        }
    }
    
    func setupNavigationBar() {
        self.navigationController?.appearanceNavigation()
        self.title = "Books"
    }
}

extension BooksViewController: UICollectionViewDelegate {
    
}

extension BooksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.bookViewModel.bookCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bookCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BookViewCell
        cell.cellViewModel = self.bookViewModel.bookCellViewModels[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailbookViewController = BookDetailViewController()
        detailbookViewController.book = self.bookViewModel.bookModels[indexPath.row]
        self.navigationController?.pushViewController(detailbookViewController, animated: true)
    }
}

extension BooksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let columns: CGFloat = 2
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let adjustedWidth = collectionViewWidth - spaceBetweenCells
        let width: CGFloat = adjustedWidth / columns
        let height: CGFloat = 200
        return CGSize(width: width, height: height)
    }
}
