//
//  ReactionsNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 01/01/2022.
//

import Foundation
import AsyncDisplayKit

class ReactionsNode: BaseNode {
    
    //MARK: - Members

    private let feed:Feed
    
    private lazy var likeButton:ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "like")
        node.style.preferredSize = CGSize(width: 33, height: 30)
        return node
    }()
    
    private lazy var dislikeButton:ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "angry")
        node.style.preferredSize = CGSize(width: 30, height: 30)
        return node
    }()
    
    private lazy var likeCountNode:ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    private lazy var dislikeCountNode:ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    //MARK: - Initialization
    
    init(feed:Feed) {
        self.feed = feed
        super.init()
        likeCountNode.attributedText = NSAttributedString(string: "0")
        dislikeCountNode.attributedText = NSAttributedString(string: "0")
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let likeStack = ASStackLayoutSpec.vertical()
        likeStack.spacing = 2
        likeStack.children = [likeButton,likeCountNode]
        likeStack.alignItems = .center
        
        let dislikeStack = ASStackLayoutSpec.vertical()
        dislikeStack.spacing = 2
        dislikeStack.children = [dislikeButton,dislikeCountNode]
        dislikeStack.alignItems = .center
        
        let spacer = ASLayoutSpec()
        spacer.style.flexGrow = 1.0
        
        let horizontalStack = ASStackLayoutSpec.horizontal()
        horizontalStack.alignItems = .center
        horizontalStack.children = [likeStack,spacer,dislikeStack]
        
        horizontalStack.style.preferredSize = CGSize(width: 90, height: 0)
        
        return horizontalStack
        
    }
    
}
