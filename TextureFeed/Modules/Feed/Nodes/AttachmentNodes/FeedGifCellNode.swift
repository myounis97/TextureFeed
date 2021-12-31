//
//  FeedGifNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit

class FeedGifCellNode:BaseCellNode {
    
    //MARK: - Members
    
    let attachment:Attachment
    
    let imageNode : ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        return node
    }()
    
    //MARK: - Initialization
    
    init(attachment:Attachment) {
        self.attachment = attachment
        super.init()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: imageNode)
    }
}
