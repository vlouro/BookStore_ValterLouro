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
    lazy var bookCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.alwaysBounceVertical = true
        collectionview.showsVerticalScrollIndicator = false
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    lazy var noDatalabel : UILabel = {
        let label = UILabel ()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.text = "Nenhum livro encontrado"
        label.isHidden = true
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var isLoadMore = false
    var isWaiting = false
    var changeListText = "Favoritos"
    var isFavoriteList = false
    
    lazy var bookViewModel = {
        BookViewModel()
    }()
    
    override func viewDidLoad() {
        self.setupNavigationBar()
        self.setupViews()
        self.getViewModelData()
    }
    
    //MARK: SETUP VIEW
    func setupViews() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: changeListText, style: .plain, target: self, action: #selector(changeList))
        self.view.backgroundColor = .white
        self.bookCollectionView.delegate = self
        self.bookCollectionView.dataSource = self
        self.bookCollectionView.register(BookViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.view.addSubview(bookCollectionView)
        self.view.addSubview(noDatalabel)
        
        NSLayoutConstraint.activate([
            bookCollectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            bookCollectionView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            bookCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            bookCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            noDatalabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            noDatalabel.heightAnchor.constraint(equalToConstant: 60),
            noDatalabel.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            noDatalabel.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    func setupNavigationBar() {
        self.navigationController?.appearanceNavigation()
        self.title = "Books"
    }
    
    //MARK: Load Books
    func getViewModelData() {
        if bookViewModel.shouldStopGetData { return }
        bookViewModel.getBooksData()
        bookViewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.bookCollectionView.reloadData()
                self?.isWaiting = false
                self?.checkNoBooksLabel()
            }
        }
    }
    
    //MARK: Reload Favorites
    @objc func reloadFavoriteList(notification: NSNotification) {
        DispatchQueue.main.async {
            self.bookViewModel.bookCellFavoriteViewModels.removeAll()
            self.bookViewModel.getFavorites()
            self.bookCollectionView.reloadData()
            self.checkNoBooksLabel()
        }
    }
    
    //MARK: Change Lists
    @objc func changeList() {
        
        if !isFavoriteList {
            self.isFavoriteList = true
            self.changeListText = "Lista"
            NotificationCenter.default.addObserver(self, selector: #selector(reloadFavoriteList(notification:)), name: NSNotification.Name(rawValue: "ReloadFavoriteList"), object: nil)
            self.bookViewModel.getFavorites()
            self.bookCollectionView.reloadData()
        } else {
            self.isFavoriteList = false
            self.changeListText = "Favoritos"
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReloadFavoriteList"), object: nil)
            if self.bookViewModel.bookCellViewModels.isEmpty {
                self.bookViewModel.getBooksData()
            } else {
                self.bookCollectionView.reloadData()
            }
        }
        
        checkNoBooksLabel()
        if let item = self.navigationItem.rightBarButtonItem {
            item.title = self.changeListText
        }
    }
    
    //MARK: No Books
    func checkNoBooksLabel() {
        if self.bookViewModel.bookCellViewModels.isEmpty && !self.isFavoriteList || self.bookViewModel.bookCellFavoriteViewModels.isEmpty && self.isFavoriteList {
            self.noDatalabel.isHidden = false
        } else {
            self.noDatalabel.isHidden = true
        }
    }
}

//MARK: CollectionViewDataSource
extension BooksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFavoriteList {
            self.bookViewModel.bookCellFavoriteViewModels.count
        } else {
            self.bookViewModel.bookCellViewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bookCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BookViewCell
        cell.cellViewModel = self.isFavoriteList ? self.bookViewModel.bookCellFavoriteViewModels[indexPath.row] : self.bookViewModel.bookCellViewModels[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailbookViewController = BookDetailViewController()
        detailbookViewController.book = self.isFavoriteList ? self.bookViewModel.bookCellFavoriteViewModels[indexPath.row] : self.bookViewModel.bookCellViewModels[indexPath.row]
        self.navigationController?.pushViewController(detailbookViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.bookViewModel.bookCellViewModels.count - 2 && !isWaiting && !isFavoriteList {
            isWaiting = true
            self.getViewModelData()
        }
    }
}

//MARK: CollectionViewDelegateFlowLayout
extension BooksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columns: CGFloat = 2
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let adjustedWidth = collectionViewWidth - spaceBetweenCells
        let width: CGFloat = adjustedWidth / columns
        let height: CGFloat = 300
        return CGSize(width: width, height: height)
    }
}
