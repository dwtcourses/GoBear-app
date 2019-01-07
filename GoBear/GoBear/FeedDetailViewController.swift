//
//  FeedDetailViewController.swift
//  GoBear
//
//  Created by Huy Nguyen on 1/7/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import UIKit
import GoBearCore
import SwiftSoup
import WebKit

class FeedDetailViewController: BaseViewController {
    
    // MARK:- IBOutlet
    @IBOutlet weak var wkWebview: WKWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // MARK: - Variable
    fileprivate var viewModel: GoBearServiceViewModelProtocol!
    fileprivate var document: Document = Document.init("")
    fileprivate var feed: ProductObj?
    
    // MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadPage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    class func `init`(feed: ProductObj, coordinator: ViewModelCoordinatorProtocol) -> FeedDetailViewController {
        let viewController = FeedDetailViewController.fromStoryboard(Constant.Storyboard.Feed) as! FeedDetailViewController
        viewController.viewModel = coordinator.goBearServiceViewModel
        viewController.feed = feed
        return viewController
    }
    
    fileprivate func setupUI() {
        
        // MARK: - Navigation bar setup
        self.title = feed?.title ?? ""
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.isNavigationBarHidden = false
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
    }
    
    func loadPage() {
        
        guard let urlString = feed?.link else {
            AlertManager.nativeAlertWithTitle("Error", message: "Can not get product link", cancelButtonTitle: "Cancel").showAlertInController(self)
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        do {
            
            let html = try String.init(contentsOf: url)
            
            document = try parseBodyFragment(html)
            
            if let head = try document.head()?.html() {
                wkWebview.loadHTMLString(head, baseURL: URL(string: urlString))
            }
            
            
            if let fullStory = try document.getElementById("page")?.getElementsByClass("story-body__inner").html() {
                wkWebview.loadHTMLString(fullStory, baseURL: URL(string: urlString))
            }
            
            indicator.stopAnimating()
            
        } catch let error {
            print(error)
        }
    }
}
