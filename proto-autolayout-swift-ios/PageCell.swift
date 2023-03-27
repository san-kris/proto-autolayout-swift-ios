//
//  PageCell.swift
//  proto-autolayout-swift-ios
//
//  Created by Santosh Krishnamurthy on 3/27/23.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
       let iv = UIImageView(image: UIImage(named: "Background-Euro"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let descriptionTextView: UITextView = {
        let tv = UITextView()
        // use attributed text
        let attributedText = NSMutableAttributedString(string: "This is text view description", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSAttributedString(string: "\n\n\nThis is a long text. Lets have fun...", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        tv.attributedText = attributedText
        // tv.text = "This is text view description"
        // tv.font = .boldSystemFont(ofSize: 18)
        tv.textAlignment = .center
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    let imageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageContainerView)
        imageContainerView.addSubview(imageView)
        addSubview(descriptionTextView)
        
        setupImageViewLayout()
        setupDescTextViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupImageViewLayout() {
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        imageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        // imageContainerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0 ).isActive = true
        imageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        // Set autolayout. Every view needs approx 4 constraints. X, Y, Width & Height
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor, constant: 0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: imageView.frame.size.width / imageView.frame.size.height).isActive = true
    }

    fileprivate func setupDescTextViewLayout() {
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 0).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
}
