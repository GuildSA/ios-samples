//
//  ViewController.swift
//  JSQMessagesDemo
//
//  Created by Kevin Harris on 10/21/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ViewController: JSQMessagesViewController {

    var imagePicker = UIImagePickerController()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var messages = [JSQMessage]()
    
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        //
        // UIImagePickerController Setup...
        //
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        //
        // CLLocationManager Setup...
        //
        
        locationManager.requestWhenInUseAuthorization() // For use in foreground
        //locationManager.requestAlwaysAuthorization()    // For use in background
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        }
        
        //
        // JSQMessagesViewController Setup...
        //
        
        self.title = "JSQMessagesDemo"
        
        // Set the senderId and senderDisplayName of the local chatter.
        self.senderId = "grumpy";
        self.senderDisplayName = "Grumpy Cat";
        
        // Disable avatars
        self.collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        self.collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        // Setup bubble styling.
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        outgoingBubbleImageView = bubbleImageFactory?.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
        incomingBubbleImageView = bubbleImageFactory?.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
        
        self.automaticallyScrollsToMostRecentMessage = true

        //
        // Load a fake chat session...
        //

        addMessage(senderId: "lilbub", displayName: "Lil' Bub", text: "Hey Grumpy!")
        
        addImage(senderId: "lilbub", displayName: "Lil' Bub", imageName: "lil_bub")

        addMessage(senderId: self.senderId, displayName: self.senderDisplayName, text: "ughhhhh WHAT!?")
        
        addMessage(senderId: "lilbub", displayName: "Lil' Bub", text: "If you're happy and you know it....")
        
        addImage(senderId: self.senderId, displayName: self.senderDisplayName, imageName: "grumpy")
        
        addMessage(senderId: self.senderId, displayName: self.senderDisplayName, text: "... keep it to yourself.")

        addMessage(senderId: "lilbub", displayName: "Lil' Bub", text: "He he he he...")

        addMessage(senderId: self.senderId, displayName: self.senderDisplayName, text: "☠️☠️☠️☠️☠️☠️☠️")
        
        finishReceivingMessage()
    }

    func isSimulator() -> Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return true
        #else
            return false
        #endif
    }
    
    func addMessage(senderId: String, displayName: String, text: String) {
        
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        
        messages.append(message!)
    }
    
    func addImage(senderId: String, displayName: String, imageName: String) {
        
        let photoMediaItem = JSQPhotoMediaItem(image: UIImage.init(named: imageName))
        
        // Make sure the media bubble's tail faces the correct direction.
        photoMediaItem?.appliesMediaViewMaskAsOutgoing = self.senderId == senderId;
        
        let message = JSQMessage(senderId: senderId, displayName: displayName, media: photoMediaItem)
        
        self.messages.append(message!)
    }
    
    func addImage(senderId: String, displayName: String, image: UIImage) {
        
        let photoMediaItem = JSQPhotoMediaItem(image: image)
        
        // Make sure the media bubble's tail faces the correct direction.
        photoMediaItem?.appliesMediaViewMaskAsOutgoing = self.senderId == senderId;
        
        let message = JSQMessage(senderId: senderId, displayName: displayName, media: photoMediaItem)
        
        self.messages.append(message!)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = messages[(indexPath as NSIndexPath).item]
        
        if let textView = cell.textView  {
            if message.senderId == senderId {
                textView.textColor = UIColor.white
            } else {
                textView.textColor = UIColor.black
            }
        }
        
        return cell
    }
    
    // MARK: JSQMessagesViewController Text
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        addMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        
        finishReceivingMessage()
    }
    
    // MARK: JSQMessagesViewController Media
    
    override func didPressAccessoryButton(_ sender: UIButton) {
        
        self.inputToolbar.contentView!.textView!.resignFirstResponder()
        
        let sheet = UIAlertController(title: "Media messages", message: nil, preferredStyle: .actionSheet)
        
        let photoAction = UIAlertAction(title: "Send photo", style: .default) { (action) in
            
            // Launch the image picker.
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let locationAction = UIAlertAction(title: "Send location", style: .default) { (action) in
            
            // Request the user's current location.
            
            if self.isSimulator() {
                
                let alertController = UIAlertController(title: "Location Warning",message: "You can not send your current location from the simulator.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                self.locationManager.requestLocation()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        sheet.addAction(photoAction)
        sheet.addAction(locationAction)
        sheet.addAction(cancelAction)
        
        self.present(sheet, animated: true, completion: nil)
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if currentLocation == nil {
            
            if let location = locations.first {
                
                currentLocation = location

                let locValue = manager.location
                
                let locationMediaItem = JSQLocationMediaItem()
                
                locationMediaItem.setLocation(locValue) {
                    
                    self.collectionView!.reloadData()
                    self.currentLocation = nil
                }
                
                let message = JSQMessage(senderId: self.senderId, displayName: self.senderDisplayName, media: locationMediaItem)
                
                self.messages.append(message!)
                
                self.finishReceivingMessage()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: { () -> Void in
            
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as! UIImage? else { return }
        
        addImage(senderId: self.senderId, displayName: self.senderDisplayName, image: image)
        
        finishReceivingMessage()

        picker.dismiss(animated: true, completion: { () -> Void in
            
        })
    }
}
