//
//  BookDetailViewController.swift
//  BookStoreChallenge
//
//  Created by Valter Louro on 08/10/2024.
//

import Foundation
import UIKit

class BookDetailViewController : UIViewController, UIScrollViewDelegate {
    
    var book : BookCellViewModel?
    var isFavorite: Bool = false
    var favoriteText = "Add Favorite"
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        scrollView.backgroundColor = UIColor.clear
        scrollView.bounces = true
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.clipsToBounds = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView : UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.clear
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var booktitleLabel : UILabel = {
        let label = UILabel ()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var authorLabel : UILabel = {
        let label = UILabel ()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel : UILabel = {
        let label = UILabel ()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var buyButton : UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("Comprar Livro", for: .normal)
        button.setTitleColor(.black, for: UIControl.State.normal)
        button.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1.0)
        button.layer.masksToBounds = true
        let borderColor : UIColor = .black
        button.layer.borderColor = borderColor.cgColor
        button.isUserInteractionEnabled = true
        button.layer.borderWidth = 1.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: favoriteText, style: .plain, target: self, action: #selector(addFavorite))
        self.view.backgroundColor = UIColor.white
        self.scrollView.delegate = self
        self.setupViews()
        self.setupLabelsInformation()
        self.checkFavorite()
    }

    func setupViews(){
        // Add views
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Constraints
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        self.contentView.addSubview(booktitleLabel)
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(buyButton)
    }
    
    func checkFavorite()  {
        guard let bookid = self.book?.bookId else { return }
        if CoreDataManager.shared.checkIsFavorite(bookId: bookid) {
            self.isFavorite = true
            self.favoriteText = "Remove Favorite"
        } else {
            self.isFavorite = false
            self.favoriteText = "Add Favorite"
        }
        
        if let item = self.navigationItem.rightBarButtonItem {
            item.title = self.favoriteText
        }
    }
    
    func setupLabelsInformation(){
        NSLayoutConstraint.activate([
            self.booktitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            self.booktitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            self.booktitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 20),
            self.authorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            self.authorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            self.authorLabel.topAnchor.constraint(equalTo: self.booktitleLabel.bottomAnchor , constant: 20),
            self.descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            self.descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor , constant: 20),
            self.buyButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            self.buyButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            self.buyButton.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor , constant: 20),
            self.buyButton.heightAnchor.constraint(equalToConstant: 30),
            self.buyButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16)
        ])
       
        self.booktitleLabel.text = book?.bookTitle

        if let authors = book?.authors, !authors.isEmpty {
            self.authorLabel.text = authors
        } else {
            self.authorLabel.text = "No author name available"
        }
    
        self.descriptionLabel.text = book?.description
        
        if let _ = book?.buyLink {
            self.buyButton.isHidden = false
            self.buyButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        } else {
            self.buyButton.isHidden = true
        }
        
    }
    
    @objc func buttonAction(sender: UIButton!){
        
        guard let bookBuyLink = book?.buyLink else {
            return
        }
        
        if let url = URL(string: bookBuyLink) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    
    @objc func addFavorite() {
        
        if self.isFavorite {
            guard let book = self.book else {return}
            CoreDataManager.shared.deleteItemWithIndex(bookId: book.bookId)
            self.isFavorite = false
            self.favoriteText = "Add Favorite"
        } else {
            guard let book = self.book else {return}
            CoreDataManager.shared.saveBook(book: book)
            self.isFavorite = true
            self.favoriteText = "Remove Favorite"
        }
            
        if let item = self.navigationItem.rightBarButtonItem {
            item.title = self.favoriteText
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("ReloadFavoriteList"), object: nil)

    }
}
