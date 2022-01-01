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
    
    private var myfeeds:[Feed] = []
    
    //MARK: - Initialization
    
    override init() {
        super.init()
        backgroundColor = .white
    }
    
    override func didLoad() {
        super.didLoad()
        getFeeds()
    }
    
    private func getFeeds()  {
        DispatchQueue.global(qos: .default).async {
            let feeds = createFeedsList()
            DispatchQueue.main.async {
                self.myfeeds = feeds
                self.table.reloadData()
            }
        }
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
    
    private func fetchNewBatchWithContext(_ context: ASBatchContext?) {
        DispatchQueue.global(qos: .default).async {
            let feeds = createFeedsList()
            self.myfeeds.append(contentsOf: feeds)
            self.addRowsIntoTableNode(newFeedCount: feeds.count)
            context?.completeBatchFetching(true)
        }
    }
    
    private func addRowsIntoTableNode(newFeedCount newFeeds: Int) {
        let indexRange = (myfeeds.count - newFeeds..<myfeeds.count)
        let indexPaths = indexRange.map { IndexPath(row: $0, section: 0) }
        DispatchQueue.main.async {
            self.table.insertRows(at: indexPaths, with: .none)
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
    
    func shouldBatchFetchForCollectionNode(collectionNode: ASCollectionNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        fetchNewBatchWithContext(context)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        checkWhichVideoToEnable()
    }
}
