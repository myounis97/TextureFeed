//
//  BaseFeedCell.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit

class CoreFeedCellNode : BaseCellNode {
    
    //MARK: - Members
    
    private let feed:Feed
    
    private let body:ASLayoutElement
    
    private lazy var header : FeedHeaderNode = {
        let node = FeedHeaderNode(feed: feed)
        return node
    }()
    
    private lazy var footer : FeedFooterNode = {
        let node = FeedFooterNode(feed: feed)
        return node
    }()
    
    //MARK: - Initialization
    
    init(feed:Feed,body:ASLayoutElement) {
        self.feed = feed
        self.body = body
        super.init()
        backgroundColor = .white
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.alignItems = .start
        verticalStack.spacing = 10
        verticalStack.children = [
            ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16),
                child:  header
            ),
            body,
            ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16),
                child:  footer
            )
        ]
        return ASInsetLayoutSpec(insets: .zero, child: verticalStack)
    }
    
}
