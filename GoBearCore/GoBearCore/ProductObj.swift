//
//  ProductObj.swift
//  GoBearCore
//
//  Created by Huy Nguyen on 1/5/19.
//  Copyright © 2019 GoBear. All rights reserved.
//

import Foundation
import SWXMLHash

public final class ProductObj: XMLElementDeserializable {
    
    // MARK: - Variable
    public private(set) var title: String?
    public private(set) var pubDate: String?
    public private(set) var thumbnail: String?
    public private(set) var description: String?
    public private(set) var link: String?
    
    // MARK: - Init
    public required init(_ node: XMLIndexer) throws {
        
        self.title       = try node[Constant.Object.Product.Title].value()
        self.pubDate     = try node[Constant.Object.Product.PublicDate].value()
        self.thumbnail   = node[Constant.Object.Product.Thumbnail].element?.attribute(by: Constant.Object.Product.Url)?.text
        self.description = try node[Constant.Object.Product.Description].value()
        self.link        = try node[Constant.Object.Product.Link].value()
    }
    
    public init(title: String?,
                pubDate: String?,
                thumbnail: String?,
                description: String?,
                link: String?) {
        
        self.title       = title
        self.pubDate     = pubDate
        self.thumbnail   = thumbnail
        self.description = description
        self.link        = link
    }
}
