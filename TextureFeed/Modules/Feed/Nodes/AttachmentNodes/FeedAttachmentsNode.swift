//
//  FeedAttachmentsNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit

class FeedAttachmentsNode : BaseNode {
    let feed:Feed
    
    let flowLayout:UICollectionViewFlowLayout
    
    let collectionNode:ASCollectionNode
    
    init(feed:Feed) {
        self.feed = feed
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        super.init()
        collectionNode.isPagingEnabled = true
        collectionNode.delegate = self
        collectionNode.dataSource = self
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 16 / 9, child: collectionNode)
    }
    
    private func getCellFor(attachment:Attachment) -> BaseCellNode {
        switch attachment.type {
        case .IMAGE:
            return FeedImageCellNode(attachment: attachment)
        case .VIDEO:
            return FeedVideoCellNode(attachment: attachment)
        case .GIF:
            return FeedGifCellNode(attachment: attachment)
        case .AUDIO:
            return FeedAudioCellNode(attachment: attachment)
        case .YOUTUBE:
            return FeedYoutubeCellNode(attachment: attachment)
        }
    }
    
}

extension FeedAttachmentsNode: ASCollectionDelegate,ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return feed.attachments?.count ?? 0
    }
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard (feed.attachments?.count ?? 0) > indexPath.row, let attachemnt = feed.attachments?[indexPath.row]  else { return { BaseCellNode() } }
        // this may be executed on a background thread - it is important to make sure it is thread safe
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = self.getCellFor(attachment: attachemnt)
            return cellNode
        }
        return cellNodeBlock
    }
    
}
