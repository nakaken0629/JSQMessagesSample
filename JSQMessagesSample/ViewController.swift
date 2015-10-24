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
        
//        self.incomingCellIdentifier = CustomMessagesCollectionViewCellIncoming.cellReuseIdentifier()
//        self.collectionView?.registerNib(CustomMessagesCollectionViewCellIncoming.nib(), forCellWithReuseIdentifier: self.incomingCellIdentifier)
//        self.outgoingCellIdentifier = CustomMessagesCollectionViewCellOutgoing.cellReuseIdentifier()
//        self.collectionView?.registerNib(CustomMessagesCollectionViewCellOutgoing.nib(), forCellWithReuseIdentifier: self.outgoingCellIdentifier)
//        self.collectionView?.registerNib(CustomMessagesCollectionViewCellOutgoing.nib(), forCellWithReuseIdentifier: self.outgoingCellIdentifier)

        self.incomingCellIdentifier = "CustomMessagesCollectionViewCellIncoming"
        self.collectionView?.registerNib(UINib(nibName: "CustomMessagesCollectionViewCellIncoming", bundle: NSBundle(forClass: self.dynamicType)), forCellWithReuseIdentifier: self.incomingCellIdentifier)
        self.outgoingCellIdentifier = "CustomMessagesCollectionViewCellOutgoing"
        self.collectionView?.registerNib(UINib(nibName: "CustomMessagesCollectionViewCellOutgoing", bundle: NSBundle(forClass: self.dynamicType)), forCellWithReuseIdentifier: self.outgoingCellIdentifier)
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        self.incomingBubble = bubbleFactory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
        self.outgoingBubble = bubbleFactory.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
        self.incomingAvatar = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "man1"), diameter: 64)
        self.outgoingAvatar = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "man2"), diameter: 64)
        
        self.messages.append(JSQMessage(senderId: "1", senderDisplayName: "user1", date: NSDate(), text: "メロスは激怒した。"))
        self.messages.append(JSQMessage(senderId: "2", senderDisplayName: "user2", date: NSDate(), text: "必ず、かの邪智暴虐（じゃちぼうぎゃく）の王を除かなければならぬと決意した。"))
        self.messages.append(JSQMessage(senderId: "2", senderDisplayName: "user2", date: NSDate(), text: "メロスには政治がわからぬ。"))
        self.messages.append(JSQMessage(senderId: "2", senderDisplayName: "user2", date: NSDate(), text: "メロスは、村の牧人である。"))
        self.messages.append(JSQMessage(senderId: "1", senderDisplayName: "user1", date: NSDate(), text: "笛を吹き、羊と遊んで暮して来た。"))
        self.messages.append(JSQMessage(senderId: "1", senderDisplayName: "user1", date: NSDate(), text: "けれども邪悪に対しては、人一倍に敏感であった。"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return self.messages[indexPath.item]
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        return self.messages[indexPath.item].senderId == self.senderId ? self.outgoingBubble : self.incomingBubble
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return self.messages[indexPath.item].senderId == self.senderId ? self.outgoingAvatar : self.incomingAvatar
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        return NSAttributedString(string: self.messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return CGFloat(30)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        let message = self.messages[indexPath.item]
        if message.senderId == self.senderId {
            let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! CustomMessagesCollectionViewCellOutgoing
            cell.timeLabel.text = formatter.stringFromDate(message.date)
            return cell
        } else {
            let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! CustomMessagesCollectionViewCellIncoming
            cell.timeLabel.text = formatter.stringFromDate(message.date)
            return cell
        }
    }
}

