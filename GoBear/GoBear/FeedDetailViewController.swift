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
    @IBOutlet weak var lblContent: UILabel!
    
    // MARK: - Variable
    fileprivate var viewModel: GoBearServiceViewModelProtocol!
    var document: Document = Document.init("")
    
    // MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.binding()
    }
    
    class func `init`(feedLink: String, coordinator: ViewModelCoordinatorProtocol) -> FeedDetailViewController {
        let viewController = FeedDetailViewController.fromStoryboard(Constant.Storyboard.Feed) as! FeedDetailViewController
        viewController.viewModel = coordinator.goBearServiceViewModel
        return viewController
    }
    
    fileprivate func setupUI() {
        
        self.loadPage()
    }
    
    func loadPage() {
        // url string to URL
        guard let url = URL(string: "https://www.bbc.com/news/world-asia-46772155") else {
            // an error occurred
            return
        }
        
        do {
            
            let html = try String.init(contentsOf: url)
            
            document = try parse(html)
            
            
            guard let contentStory = try document.body()?.getElementById("page")?.child(0).child(1).child(0).child(0).child(0).child(2) else {
                return
            }
            
//            .getElementsByClass("story-body")
            
             lblContent.attributedText = try contentStory.outerHtml().html2Attributed
            
        } catch let error {
            print(error)
        }
    }
    
    fileprivate func binding() {
        
//        viewModel.input.startFetchProductPublisher.onNext(true)
//
//        viewModel.output.productVariable
//            .asObservable()
//            .subscribe(onNext: { (products) in
//
//            }).disposed(by: disposeBag)
    }
}

extension String {
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}

