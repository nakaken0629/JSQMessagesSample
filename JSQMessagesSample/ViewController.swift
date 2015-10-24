//
//  ViewController.swift
//  JSQMessagesSample
//
//  Created by 中垣 健志 on 2015/10/22.
//  Copyright © 2015年 itvirtuoso. All rights reserved.
//

import UIKit

class ViewController: JSQMessagesViewController {
    private var messages = [JSQMessage]()
    private var incomingBubble: JSQMessagesBubbleImage!
    private var outgoingBubble: JSQMessagesBubbleImage!
    private var incomingAvatar: JSQMessagesAvatarImage!
    private var outgoingAvatar: JSQMessagesAvatarImage!

    override func viewDidLoad() {
        print("execute viewDidLoad")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.senderId = "1"
        self.senderDisplayName = "user1"
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        self.incomingBubble = bubbleFactory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
        self.outgoingBubble = bubbleFactory.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
        self.incomingAvatar = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "man1"), diameter: 64)
        self.outgoingAvatar = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "man2"), diameter: 64)
        
        self.messages.append(JSQMessage(senderId: "1", displayName: "user1", text: "メロスは激怒した。"))
        self.messages.append(JSQMessage(senderId: "2", displayName: "user2", text: "必ず、かの邪智暴虐（じゃちぼうぎゃく）の王を除かなければならぬと決意した。"))
        self.messages.append(JSQMessage(senderId: "2", displayName: "user2", text: "メロスには政治がわからぬ。"))
        self.messages.append(JSQMessage(senderId: "2", displayName: "user2", text: "メロスは、村の牧人である。"))
        self.messages.append(JSQMessage(senderId: "1", displayName: "user1", text: "笛を吹き、羊と遊んで暮して来た。"))
        self.messages.append(JSQMessage(senderId: "1", displayName: "user1", text: "けれども邪悪に対しては、人一倍に敏感であった。"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        print("execute collectionView:messageDataForItemAtIndexPath")
        return self.messages[indexPath.item]
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        print("execute collectionView:messageBubbleImageDataForItemAtIndexPath")
        return self.messages[indexPath.item].senderId == self.senderId ? self.outgoingBubble : self.incomingBubble
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        print("execute collectionView:avatarImageDataForItemAtIndexPath")
        return self.messages[indexPath.item].senderId == self.senderId ? self.outgoingAvatar : self.incomingAvatar
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count = \(self.messages.count)")
        return self.messages.count
    }
}

