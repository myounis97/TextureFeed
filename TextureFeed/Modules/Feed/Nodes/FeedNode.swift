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

    private var table:ASTableNode!
    
    private let myfeeds = feeds
    
    //MARK: - Initialization
    override init() {
        super.init()
        table = ASTableNode(style: .plain)
        table.backgroundColor = .white
        table.allowsSelection = false
        table.delegate = self
        table.dataSource = self
        backgroundColor = .white
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: self.table)
    }
 
}

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
        let cellNode = feed.type == .NORMAL ? FeedCell(feed: feed) : SharedFeedCell(feed: feed)
        return cellNode
      }
        
      return cellNodeBlock
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let width = UIScreen.main.bounds.width
        return .init(min: .zero, max: .init(width: width, height:100))
    }
}
