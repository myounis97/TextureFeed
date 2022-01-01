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
 
    func checkWhichVideoToEnable() {
        for cell in table.visibleNodes {
           
            if cell is FeedCellNode || cell is SharedFeedCellNode {
                
                guard let indexPath = table.indexPath(for: cell) else {
                    continue
                }
                
                
                let feed = myfeeds[indexPath.row]
                
                guard feed.contentType == .ATTACHMENTS else {
                    continue
                }
                
                let cellRect: CGRect = table.rectForRow(at: indexPath)
                let superview = table.supernode

                let convertedRect = table.convert(cellRect, to: superview)
                let intersect = table.frame.intersection(convertedRect)
                let visibleHeight = intersect.height
                
                let visiblePercentage = visibleHeight / cellRect.height

                print("Visible height : \(visiblePercentage)")
                if visiblePercentage > 0.6 {
                    
                } else {
                    
                }
            }
        }
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        checkWhichVideoToEnable()
    }
}
