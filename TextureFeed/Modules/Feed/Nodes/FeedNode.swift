//
//  FeedNode.swift
//  TextureFeed
//
//  Created by Mohammad Younis on 31/12/2021.
//

import Foundation
import AsyncDisplayKit

class FeedNode: BaseNode {
    
    //MARK: - Members

    private lazy var table:ASTableNode = {
        let node = ASTableNode(style: .plain)
        node.backgroundColor = .white
        node.allowsSelection = false
        node.delegate = self
        node.dataSource = self
        return node
    }()
    
    private let myfeeds = feeds
    
    //MARK: - Initialization
    
    override init() {
        super.init()
        backgroundColor = .white
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: self.table)
    }
 
}

//MARK: - ASTableDelegate
extension FeedNode: ASTableDelegate,ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        1
    }
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        myfeeds.count
    }
    
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
      guard myfeeds.count > indexPath.row else { return { ASCellNode() } }
        
      let feed = myfeeds[indexPath.row]
        
      // this may be executed on a background thread - it is important to make sure it is thread safe
      let cellNodeBlock = { () -> ASCellNode in
        let cellNode = feed.type == .NORMAL ? FeedCellNode(feed: feed) : SharedFeedCellNode(feed: feed)
        return cellNode
      }
        
      return cellNodeBlock
    }
    
}
