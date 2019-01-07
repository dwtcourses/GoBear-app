//
//  WalkthroughViewController.swift
//  GoBear
//
//  Created by Huy Nguyen on 1/5/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import UIKit
import GoBearCore

class WalkthroughViewController: BaseViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIStackView!
    
    // MARK:- Variable
    fileprivate var coordinator: ViewModelCoordinatorProtocol!
    fileprivate var authenViewModel: AuthenticationViewModelProtocol?
    fileprivate let contents = [Constant.Label.Text1, Constant.Label.Text2, Constant.Label.Text3]
    
    // MARK:- View Controller Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Init
    ///
    /// - Parameter coordinator: View model coordinator
    /// - Returns: self view controller
    class func `init`(coordinator: ViewModelCoordinatorProtocol) -> WalkthroughViewController {
        let viewController = WalkthroughViewController.fromStoryboard(Constant.Storyboard.Main) as! WalkthroughViewController
        viewController.coordinator = coordinator
        viewController.authenViewModel = coordinator.authenticationViewModel
        return viewController
    }
    
    private func setupUI() {
        
        self.collectionView.registerCell(WalkthroughPageCell.self)
        
        guard let collectionViewLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        collectionViewLayout.itemSize = CGSize(width: self.view.frame.width, height: self.collectionView.frame.height)
    }
    
    @IBAction func pressedSkipButton(_ sender: UIButton) {
        
        authenViewModel?.output.authenticationStateDriver
            .asObservable()
            .subscribe(onNext: { (authenState) in
                print(authenState)
                self.setupContentController(authenState: authenState!)
            }).disposed(by: disposeBag)
    }
    
    @IBAction func pressedPageControlButton(_ sender: UIButton) {
        let indexPath = IndexPath(item: 0, section: sender.tag)
        self.collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
    }
    
    fileprivate func setupContentController(authenState: AuthenticationState) {
        
        switch authenState {
        case .authenticated:
            navigationController?.viewControllers = [FeedViewController.init(coordinator: coordinator!)]
        case .unAuthenticated:
            navigationController?.viewControllers = [LoginViewController.init(coordinator: coordinator!)]
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WalkthroughViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WalkthroughPageCell.identifier, for: indexPath) as! WalkthroughPageCell
        
        cell.configure(contents[indexPath.section])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension WalkthroughViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        pageControl.arrangedSubviews[indexPath.section].viewWithTag(10)?.alpha = 0.1
        
        guard let cell = collectionView.visibleCells.first else {
            return
        }
        
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        
        pageControl.arrangedSubviews[indexPath.section].viewWithTag(10)?.alpha = 1.0
    }
}
