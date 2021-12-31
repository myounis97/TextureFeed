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
        verticalStack.children = [header,body]
        return ASInsetLayoutSpec(insets: .zero, child: verticalStack)
    }
    
}
