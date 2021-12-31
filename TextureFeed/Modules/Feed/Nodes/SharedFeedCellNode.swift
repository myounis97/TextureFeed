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
        verticalStack.children = [
            ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: 4, left: 32, bottom: 4, right: 32),
                child: header
            ),
            body
        ]
        let background = ASDisplayNode()
        background.backgroundColor = UIColor(named: "ogColor")
        return ASInsetLayoutSpec.init(
            insets: .zero,
            child: CoreFeedCellNode(
                feed: feed,
                body: ASBackgroundLayoutSpec(
                    child: verticalStack,
                    background: background
                )
            )
        )
    }
}
