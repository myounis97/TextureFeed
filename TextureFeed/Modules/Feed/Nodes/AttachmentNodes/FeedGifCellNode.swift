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
    
    private let attachment:Attachment
    
    private lazy var imageNode : ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        return node
    }()
    
    //MARK: - Initialization
    
    init(attachment:Attachment) {
        self.attachment = attachment
        super.init()
        imageNode.url = URL(string: attachment.url)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: imageNode)
    }
}
