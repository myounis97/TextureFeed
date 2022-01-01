//
//  FeedFooterNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit
import Lottie
class FeedFooterNode:BaseCellNode {
    
    //MARK: - Members
    
    private let feed:Feed
    
    private lazy var shareButton:ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "share")
        node.style.preferredSize = CGSize(width: 23, height: 23)
        return node
    }()
    
    private lazy var favoriteButton:ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "star")
        node.style.preferredSize = CGSize(width: 23, height: 23)
        return node
    }()
    
    private lazy var commentButton:ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "comment")
        node.style.preferredSize = CGSize(width: 23, height: 23)
        return node
    }()
    
    private lazy var dateNode:ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    private lazy var reactionsNode:ReactionsNode = {
        let node = ReactionsNode(feed: feed)
        return node
    }()
    
    //MARK: - Initialization
    
    init(feed:Feed) {
        self.feed = feed
        super.init()
        dateNode.attributedText = feed.attributedStringForDate(withSize: 12)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.spacing = 8
        
        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0
        
        let horizontalStack = ASStackLayoutSpec.horizontal()
        horizontalStack.spacing = 16
        horizontalStack.alignItems = .center
        
        horizontalStack.children = [
            commentButton,favoriteButton,spacer,shareButton
        ]
        
        verticalStack.children = [
            horizontalStack,
            dateNode
        ]
        
        verticalStack.style.preferredLayoutSize = .init(width: .init(unit: .fraction, value: 1), height: .init(unit: .auto, value: 0))
        
        let centerSpec = ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: reactionsNode)
        
        let overlaySpec = ASOverlayLayoutSpec(child: verticalStack, overlay: centerSpec)
        
        return overlaySpec
    }
    
}
