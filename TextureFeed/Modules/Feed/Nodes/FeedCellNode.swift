//
//  FeedCell.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit
import UIKit

class FeedCellNode : BaseCellNode {
    
    //MARK: - Members
    
    private let feed:Feed
    
    private lazy var body : FeedBodyNode = {
        let node = FeedBodyNode(feed: feed)
        return node
    }()
    
    private lazy var core : CoreFeedCellNode = {
        let node = CoreFeedCellNode(feed: feed, body: body)
        return node
    }()
    
    //MARK: - Initialization
    
    init(feed:Feed) {
        self.feed = feed
        super.init()
        backgroundColor = .white
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: core)
    }
}

extension FeedCellNode: PlayableNode {
    func getPlayableCell() -> PlayableCell? {
        return body.getPlayableCell()
    }

    func getPlayableRect(to node :ASDisplayNode) -> CGRect? {
        return body.getPlayableRect(to: node)
    }
}
