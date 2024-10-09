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
                imageView.imageFromServerURL(urlString: thumbnailUrl, PlaceHolderImage: UIImage(named:"no_image_icon") ?? UIImage())
            } else {
                imageView.image = UIImage(named:"no_image_icon")
            }
        }
    }
    
    func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [
            imageView
        ])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        //StackView layout
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
