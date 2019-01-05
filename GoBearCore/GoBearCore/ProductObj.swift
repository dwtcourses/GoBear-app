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
    
    // MARK: - Init
    public required init(_ node: XMLIndexer) throws {
        
        self.title       = try node[Constant.Object.Product.Title].value()
        self.pubDate     = try node[Constant.Object.Product.PublicDate].value()
        self.thumbnail   = try node[Constant.Object.Product.Thumbnail].value()
        self.description = try node[Constant.Object.Product.Description].value()
    }
    
    public init(title: String?,
                pubDate: String?,
                thumbnail: String?,
                description: String?) {
        
        self.title       = title
        self.pubDate     = pubDate
        self.thumbnail   = thumbnail
        self.description = description
    }
    
}
