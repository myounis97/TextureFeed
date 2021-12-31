//
//  FeedOGNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit

class FeedOGNode:BaseNode {
    let feed:Feed
    
    init(feed:Feed) {
        self.feed = feed
        super.init()
    }
}
