//
//  SwipeController.swift
//  proto-autolayout-swift-ios
//
//  Created by Santosh Krishnamurthy on 3/27/23.
//

import UIKit

class SwipeController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the background color
        collectionView.backgroundColor = .lightGray
        
        // register a cell class and addiciate it with a string ID
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellID)
        
        // get the current collection view layout and down cast it to collection view flow layout
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            // set the scroll direction
            flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        }
        collectionView.isPagingEnabled = true
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    // specify
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    // specify the spacing between cells. Default is 10 points
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
