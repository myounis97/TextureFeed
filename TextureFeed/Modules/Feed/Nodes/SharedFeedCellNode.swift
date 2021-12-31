//
//  SharedFeedCell.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit

class SharedFeedCellNode:BaseCellNode {
    
    //MARK: - Members
    
    private let feed:Feed
    
    private lazy var header : FeedHeaderNode = {
        let node = FeedHeaderNode(feed: feed.sharedFeed!)
        return node
    }()
    
    private lazy var body : FeedBodyNode = {
        let node = FeedBodyNode(feed: feed.sharedFeed!)
        return node
    }()
    
    //MARK: - Initialization
    
    init(feed:Feed) {
        self.feed = feed
        super.init()
        backgroundColor = .white
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.children = [header,body]
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16),
            child: CoreFeedCellNode(
                feed: feed,
                body: ASInsetLayoutSpec(
                    insets: UIEdgeInsets(top: 11, left: 23, bottom: 4, right: 23),
                    child: verticalStack
                )
            )
        )
    }
}
