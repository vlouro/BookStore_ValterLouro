//
//  BookViewCell.swift
//  BookStoreChallenge
//
//  Created by Valter Louro on 07/10/2024.
//

import UIKit

class BookViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    
    var cellViewModel: BookCellViewModel? {
        didSet {
            if let thumbnailUrl = cellViewModel?.thumbnailUrl {
                imageView.imageFromServerURL(urlString: thumbnailUrl, PlaceHolderImage: UIImage())
            } else {
                imageView.image = UIImage()
            }
            
        }
    }
    
    func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [
            imageView
        ])
        stackView.axis = .vertical
        // enables auto layout
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        //stackView layout
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
