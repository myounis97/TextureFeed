//
//  FeedOGNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit
import UIKit

class FeedOGNode:BaseNode {
    
    //MARK: - Members
    
    private let feed:Feed
    
    private lazy var imageNode:ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    private lazy var titleNode:ASTextNode = {
        let node = ASTextNode()
        node.style.flexGrow = 1.0
        return node
    }()
    
    private lazy var descriptionNode:ASTextNode = {
        let node = ASTextNode()
        node.style.flexGrow = 1.0
        node.maximumNumberOfLines = 2
        node.truncationAttributedText = NSAttributedString(string: "...")
        return node
    }()
    
    //MARK: - Initialization
    
    init(feed:Feed) {
        self.feed = feed
        super.init()
        if let og = feed.og {
            imageNode.url = URL(string: og.image)!
            titleNode.attributedText = feed.attributedStringForOGTitle(withSize: 13)
            descriptionNode.attributedText = feed.attributedStringForOGDescription(withSize: 12)
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        imageNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 250)
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.spacing = 8
        verticalStack.alignItems = .start
        
        let innerVerticalStack = ASStackLayoutSpec.vertical()
        innerVerticalStack.spacing = 4
        innerVerticalStack.alignItems = .start
        
        innerVerticalStack.children = [titleNode,descriptionNode]
        verticalStack.children = [imageNode,ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 11, bottom: 8, right: 11), child: innerVerticalStack)]
        
        let background = BaseNode()
        background.backgroundColor = UIColor(named: "ogColor")
        
        let backgroundSpec = ASBackgroundLayoutSpec(child: verticalStack, background: background)
        
        return ASInsetLayoutSpec(insets: .zero, child: backgroundSpec)
    }
}
