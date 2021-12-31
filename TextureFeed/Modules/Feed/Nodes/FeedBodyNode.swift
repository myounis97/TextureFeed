//
//  FeedBodyNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit

class FeedBodyNode:BaseNode {
    let feed:Feed
    
    init(feed:Feed) {
        self.feed = feed
        super.init()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let node = feed.contentType == FeedContent.ATTACHMENTS ?
        FeedAttachmentsNode(feed: feed)
        : feed.contentType == FeedContent.OG ?
        FeedOGNode(feed: feed) : BaseNode()
        return ASInsetLayoutSpec(insets: .zero, child: node)
    }
}
