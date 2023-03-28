//
//  SwipeController.swift
//  proto-autolayout-swift-ios
//
//  Created by Santosh Krishnamurthy on 3/27/23.
//

import UIKit

class SwipeController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let cellID = "cellID"
    
    lazy var previousButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        // btn.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        // btn.backgroundColor = .red
        btn.setTitle("PREV", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.gray, for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(handlePrevious), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    @objc private func handlePrevious(sender: UIButton){
        print("Handling Previous")
        let index = max(pageControl.currentPage - 1, 1)
        pageControl.currentPage = index
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
    
    lazy var nextButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setTitle("NEXT", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.red, for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(handleNext), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    @objc private func handleNext(sender: UIButton){
        print("Handling Next")
        let index = min(pageControl.currentPage + 1 , 2)
        pageControl.currentPage = index
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        
    }
    
    lazy var pageControl : UIPageControl = {
       let pc = UIPageControl()
        pc.numberOfPages = 4
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = .lightGray
        return pc
    }()

    // collection view is a sub class of scrollview
    // target offset gives an X value that tells where the scroon scrlling will stopo
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        // use the devided value to find the page # you are on
        print(x, view.frame.width, x/view.frame.width)
        pageControl.currentPage = Int(x/view.frame.width)
    }
    
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
        
        setupBottomControlStackViewLayout()
        
    }
    
    // when devices transitions to different oorientation, this methd is called
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate { (_) in
            // the cells are not layedout correctly.
            // we can invalidate the layout, which will trigger drawing new layout
            self.collectionViewLayout.invalidateLayout()
            
            // If the first page is not center aligned( a bug ) you can set the contetn offset
            if self.pageControl.currentPage == 0 {
                self.collectionView.contentOffset = .zero
            } else {
                // get the index path of the current page
                let indexPath = IndexPath(row: self.pageControl.currentPage, section: 0)
                // changing orientation does not automatically center align the cell
                // scroll to page with center alignment
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

            }
            
        } completion: { (_) in
            print("animation completed")
        }

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
    
    fileprivate func setupBottomControlStackViewLayout() {
        
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
}
