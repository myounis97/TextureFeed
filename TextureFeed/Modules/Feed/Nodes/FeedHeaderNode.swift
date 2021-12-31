//
//  FeedHeaderNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit

class FeedHeaderNode: BaseNode {
    
    //MARK: - Members
    
    let feed:Feed
    
    let imageNode:ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.contentMode = .scaleAspectFill
        node.imageModificationBlock = ASImageNodeRoundBorderModificationBlock(0, nil)
        return node
    }()
    
    let titleNode:ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    let interestNode:ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    let contentNode:ASTextNode = {
       let node = ASTextNode()
        node.maximumNumberOfLines = 2
        node.truncationAttributedText = createReadmoreStrig(withSize: 14)
        return node
    }()
    
    //MARK: - Initialization
    
    init(feed:Feed) {
        self.feed = feed
        super.init()
        imageNode.url = feed.imageUrl
        titleNode.attributedText = feed.attributedStringForTitle(withSize: 14)
        interestNode.attributedText = feed.attributedStringForInterest(withSize: 9)
        contentNode.attributedText = feed.attributedStringForContent(withSize: 14)
        contentNode.delegate = self
        contentNode.isUserInteractionEnabled = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        imageNode.style.preferredSize = CGSize(
            width: 37,
            height: 37
        )
        
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.alignItems = .start
        verticalStack.spacing = 10
        
        let horizontalStack = ASStackLayoutSpec.horizontal()
        horizontalStack.alignItems = .center
        horizontalStack.spacing = 10
        
        let innerVerticalStack = ASStackLayoutSpec.vertical()
        innerVerticalStack.alignItems = .start
        innerVerticalStack.children = [titleNode,interestNode]
        
        horizontalStack.children = [imageNode,innerVerticalStack]
        
        verticalStack.children = [horizontalStack,contentNode]
        
        return verticalStack
        
    }
    
}

extension FeedHeaderNode : ASTextNodeDelegate {
    
    func textNodeTappedTruncationToken(_ textNode: ASTextNode!) {
        
    }
}
