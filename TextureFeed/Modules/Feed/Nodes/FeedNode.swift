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
    
    private var lastPlayableCell:PlayableCell? = nil
    
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
    
    private func findVisiblityPercentage(to rect:CGRect) -> CGFloat {
        let superview = table.supernode
        var convertedRect = table.convert(rect, to: superview)
        convertedRect = convertedRect.offsetBy(dx: table.contentOffset.x, dy: table.contentOffset.y);
        let intersect = table.frame.intersection(convertedRect)
        let visibleHeight = intersect.height
        let visiblePercentage = visibleHeight / rect.height
        print("Visible height : \(visiblePercentage)")
        return visiblePercentage
    }
 
    private func findPlayableCell() -> PlayableCell? {
        
        var firstPlayableCell:PlayableCell? = nil
        
        for node in table.visibleNodes {
            
            guard let playableNode = node as? PlayableNode,
                  let playableCell = playableNode.getPlayableCell(),
                  let rect = playableNode.getPlayableRect(to: table)
            else { continue }
            
            let visibilityPercentage = findVisiblityPercentage(to: rect)

            if visibilityPercentage > 0.6 {
                if firstPlayableCell == nil {
                    firstPlayableCell = playableCell
                }
            } else {
                playableCell.pause()
            }
        }
    
        return firstPlayableCell
    }
    
    func checkWhichVideoToPlay() {
        if let playableCell = self.findPlayableCell() {
            guard playableCell.id() != self.lastPlayableCell?.id() else {
                playableCell.play()
                return
            }
            self.lastPlayableCell?.pause()
            self.lastPlayableCell = playableCell
            self.lastPlayableCell?.play()
        }
    }
    
    private func fetchNewBatchWithContext(_ context: ASBatchContext?) {
        DispatchQueue.global(qos: .default).async {
            let feeds = createFeedsList()
            self.myfeeds.append(contentsOf: feeds)
            print("Feeds Count : \(self.myfeeds.count)")
            self.addRowsIntoTableNode(newFeedCount: feeds.count,context: context)
        }
    }
    
    private func addRowsIntoTableNode(newFeedCount newFeeds: Int,context: ASBatchContext?) {
        let indexRange = (myfeeds.count - newFeeds..<myfeeds.count)
        let indexPaths = indexRange.map { IndexPath(row: $0, section: 0) }
        DispatchQueue.main.async {
            self.table.insertRows(at: indexPaths, with: .none)
            context?.completeBatchFetching(true)
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
        checkWhichVideoToPlay()
    }
}
