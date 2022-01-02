//
//  Feed.swift
//  Practice
//
//  Created by Mohammad Younis on 10/30/20.
//

import UIKit
import LoremSwiftum

class Feed {
    var id:UUID
    var title: String
    var interest: String
    var content: String
    var time: String
    var attachments: [Attachment]?
    var og: OG?
    var sharedFeed: Feed?
    var type: FeedType = FeedType.NORMAL
//    FeedContent = FeedContent.allCases[Int.random(in: 0..<FeedContent.allCases.count)]
    var contentType:FeedContent = .ATTACHMENTS
    var imageUrl:URL
    var hasPlayable:Bool = false
    init(id:UUID,title:String,interest:String,content:String,time:String,attachments:[Attachment]?,og:OG?,sharedFeed:Feed?,type:FeedType,imageUrl:URL) {
        
        self.id = id
        self.title = title
        self.interest = interest
        self.content = content
        self.time = time
        self.attachments = attachments
        self.og = og
        self.sharedFeed = sharedFeed
        self.type = type
        self.imageUrl = imageUrl
        checkHasPlayableMedia()
    }
    
    func checkHasPlayableMedia() {
        hasPlayable = (attachments?.first(where: { attachment in
            attachment.type == .VIDEO
        }) != nil)
    }
    
}

enum FeedType:String {
    case NORMAL
    case SHARED
}

enum FeedContent:String,CaseIterable {
    case TEXT
    case ATTACHMENTS
    case OG
}

enum AttachmentType :String,CaseIterable {
    case IMAGE
    case VIDEO
    case GIF
    case AUDIO
    case YOUTUBE
}

struct Attachment {
    let id:UUID
    let type: AttachmentType
    let url: String
    let thumb: String
}

struct OG {
    let url: String
    let title: String
    let description: String
    let image: String
}

//let feeds:[Feed] = createFeedsList()

func createFeedsList() -> [Feed] {
    var feeds:[Feed] = []
    
    for _ in 0...3 {
        feeds.append(createFeed())
    }
    
    return feeds
}

func createAttachmentsList() -> [Attachment] {
    
    var listOfAttachments:[Attachment] = []
    
    outer:for n in 0...Int.random(in: 0..<1) {
        
        switch AttachmentType.allCases[Int.random(in: 0..<AttachmentType.allCases.count)] {
        
        case .AUDIO:
            if n > 0 {
                break outer
            }
//            listOfAttachments.append(createAudioAttachment())
            listOfAttachments.append(createVideoAttachment())
            break
        case .GIF:
            listOfAttachments.append(createVideoAttachment())
        case.IMAGE:
            listOfAttachments.append(createVideoAttachment())
        case.VIDEO:
            listOfAttachments.append(createVideoAttachment())
        case.YOUTUBE:
            if n > 0 {
                break outer
            }
            listOfAttachments.append(createVideoAttachment())
            break outer
        }
        
    }
    
    return listOfAttachments
}


fileprivate func createFeed() -> Feed {
    
    let shared = Bool.random()
    
    return Feed(
        id: UUID.init(),
        title: Lorem.fullName,
        interest: "Personal",
        content: Lorem.tweet,
        time: "Yesterday",
        attachments: createAttachmentsList(),
        og: createOG(),
        sharedFeed: createSharedFeed(),
        type: shared ? .SHARED : .NORMAL,
        imageUrl: URL(string: "https://picsum.photos/\(Int.random(in: 200...300))")!
    )
    
    
}

fileprivate func createSharedFeed() -> Feed {
    return Feed(id: UUID.init(), title: Lorem.fullName, interest: "Personal", content: "#abstract #art #abstractart #envywear #PleaseForgiveMe #abstracters_anonymous #abstract_buff #abstraction #instagood #creative #artsy #beautiful #photooftheday #abstracto #stayabstract #instaabstract", time: "Yesterday", attachments: createAttachmentsList(), og: createOG(), sharedFeed: nil, type: .NORMAL, imageUrl: URL(string: "https://picsum.photos/\(Int.random(in: 200...300))")!)
}

fileprivate func createImageAttachment() -> Attachment {
    return Attachment(id: UUID.init(), type: AttachmentType.IMAGE,
                      url: "https://picsum.photos/\(Int.random(in: 480...720))",
                      thumb: "")
}

fileprivate func createOG() -> OG {
    return OG(
        url: "https://picsum.photos",
        title: Lorem.title,
        description: Lorem.paragraphs(5...10),
        image: "https://picsum.photos/\(Int.random(in: 480...720))"
    )
}

fileprivate func createVideoAttachment() -> Attachment {
    let index = Int.random(in: 0..<listvideo.count)
    return Attachment(
        id: UUID.init(), type: AttachmentType.VIDEO,
        url: listvideo[index],
        thumb: "https://picsum.photos/\(Int.random(in: 480...720))"
    )
}

fileprivate func createAudioAttachment() -> Attachment {
    return Attachment(
        id: UUID.init(), type: AttachmentType.AUDIO,
        url: "audio.mp3",
        thumb: "https://picsum.photos/\(Int.random(in: 480...720))"
    )
}

fileprivate func createGIFAttachment() -> Attachment {
    let index = Int.random(in: 0..<listgif.count)
    return Attachment(
        id: UUID.init(), type: AttachmentType.GIF,
        url: listgif[index],
        thumb: "https://picsum.photos/\(Int.random(in: 480...720))"
    )
}

fileprivate func createYoutubeAttachment() -> Attachment {
    let index = Int.random(in: 0..<listyoutube.count)
    return Attachment(
        id: UUID.init(), type: AttachmentType.YOUTUBE,
        url: listyoutube[index],
        thumb: "https://picsum.photos/\(Int.random(in: 480...720))"
    )
}

fileprivate var listvideo:[String] = [
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"
]

fileprivate var listgif:[String] = [
    "https://i.gifer.com/5IPv.gif",
    "https://i.gifer.com/YNXo.gif",
    "https://i.gifer.com/V5NL.gif",
    "https://i.gifer.com/31Kl.gif",
    "https://i.gifer.com/td5.gif"
]

fileprivate var listyoutube:[String] = [
    "Wj1yyGQmW2c",
    "8joSb3BQsFw",
    "T-LAJ0Y7lsw",
    "b4KfgMFp0nU"
]

extension Feed {
    func attributedStringForTitle(withSize size:CGFloat) -> NSAttributedString {
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor.darkGray,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: size)
        ]
        return NSAttributedString(string: title, attributes: attributes)
    }
    func attributedStringForInterest(withSize size:CGFloat) -> NSAttributedString {
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor.darkGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)
        ]
        return NSAttributedString(string: interest, attributes: attributes)
    }
    func attributedStringForOGTitle(withSize size:CGFloat) -> NSAttributedString {
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: size)
        ]
        return NSAttributedString(string: og?.title ?? "", attributes: attributes)
    }
    
    func attributedStringForOGDescription(withSize size:CGFloat) -> NSAttributedString {
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor.darkGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)
        ]
        return NSAttributedString(string: og?.description ?? "", attributes: attributes)
    }
    func attributedStringForContent(withSize size:CGFloat) -> NSAttributedString {
        
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor.darkGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: size),
        ]
        
        let attrStr = NSMutableAttributedString(string: content)
        attrStr.addAttributes(attributes, range: NSRange(location: 0, length: attrStr.string.count))
        
        let searchPattern = "#\\w+"
        var ranges: [NSRange] = [NSRange]()

        let regex = try! NSRegularExpression(pattern: searchPattern, options: [])
        ranges = regex.matches(in: attrStr.string, options: [], range: NSMakeRange(0, attrStr.string.count)).map {$0.range}

        for range in ranges {
            attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: range.location, length: range.length))
        }

        return attrStr
    }
    
    func attributedStringForDate(withSize size:CGFloat) -> NSAttributedString {
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor.darkGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)
        ]
        return NSAttributedString(string: time, attributes: attributes)
    }
}
