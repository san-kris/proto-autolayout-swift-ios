//
//  ViewController.swift
//  proto-autolayout-swift-ios
//
//  Created by Santosh Krishnamurthy on 3/27/23.
//

import UIKit

class ViewController: UIViewController {

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
    
    let imageContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    let previousButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        // btn.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        // btn.backgroundColor = .red
        btn.setTitle("PREV", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.gray, for: UIControl.State.normal)
        return btn
    }()
    
    
    let nextButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setTitle("NEXT", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.red, for: UIControl.State.normal)
        return btn
    }()
    
    let pageControl : UIPageControl = {
       let pc = UIPageControl()
        pc.numberOfPages = 4
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = .lightGray
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageContainerView)
        imageContainerView.addSubview(imageView)
        view.addSubview(descriptionTextView)
        // view.addSubview(previousButton)
        
        setupImageViewLayout()
        setupDescTextViewLayout()
        // setupPreviousButtonLayout()
        
        // setting up stackview at the bottom to arrange buttons and pageview controller
        let bottomControlStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlStackView.distribution = UIStackView.Distribution.fillEqually
        bottomControlStackView.axis = NSLayoutConstraint.Axis.horizontal
        view.addSubview(bottomControlStackView)
        
        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomControlStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        bottomControlStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        bottomControlStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupImageViewLayout() {
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        imageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        imageContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0 ).isActive = true
        imageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
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
        descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }

    fileprivate func setupPreviousButtonLayout() {
        
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        previousButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        previousButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        previousButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        previousButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }


}

