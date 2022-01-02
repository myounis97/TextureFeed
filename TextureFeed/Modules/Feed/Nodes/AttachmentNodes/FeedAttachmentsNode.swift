//
//  FeedAttachmentsNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit

class FeedAttachmentsNode : BaseNode {
    
    //MARK: - Members
    
    private let feed:Feed
    
    private let flowLayout:UICollectionViewFlowLayout
    
    private let collectionNode:ASCollectionNode
    
    private lazy var popular : PopularNode = {
        let node = PopularNode()
        return node
    }()
    
    //MARK: - Initialization
    
    init(feed:Feed) {
        self.feed = feed
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        super.init()
        collectionNode.isPagingEnabled = true
        collectionNode.showsHorizontalScrollIndicator = false
        collectionNode.delegate = self
        collectionNode.dataSource = self
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let width: CGFloat = constrainedSize.max.width
        let height = width * 9 / 16
        collectionNode.style.preferredSize = CGSize(width: width, height: height)
        
        if feed.attachments?.first?.type == .YOUTUBE {
            return ASWrapperLayoutSpec(layoutElement: collectionNode)
        }
        
        let popularOverlay = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 0), child: popular)
        
        let overlaySpec = ASOverlayLayoutSpec(child: collectionNode, overlay: ASAbsoluteLayoutSpec(children: [popularOverlay]))
        
        return ASWrapperLayoutSpec(layoutElement: overlaySpec)
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

//MARK: - ASCollectionDelegate
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

extension FeedAttachmentsNode: PlayableNode {
    func getPlayableCell() -> PlayableCell? {
        if let node = collectionNode.visibleNodes.first {
            return node is PlayableCell ? (node as! PlayableCell) : nil
        }
        return nil
    }
    
    func getPlayableRect(to node :ASDisplayNode) -> CGRect? {
        if let node = collectionNode.visibleNodes.first {
            return node is PlayableCell ? collectionNode.convert(node.frame, to: nil) : nil
        }
        return nil
    }
}
