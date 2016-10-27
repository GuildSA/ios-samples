//
//  ViewController.swift
//  FirebaseChat
//
//  Created by Kevin Harris on 10/13/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// Don't forget to add a server-side Authentication provider for "Email/Password"
// to YOUR app's Authentication settings in the Firebase Dashboard! Otherwise,
// you'll be unable to create new users using an email and password.
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
class ViewController: JSQMessagesViewController {
    
    // In a real app, CHAT_SESSION_ID would be set to some unique object id that maps
    // to a private chat session involving two chatters.
    let CHAT_SESSION_ID = "xyz"
    
    var imagePicker = UIImagePickerController()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var messages = [JSQMessage]()
    
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    
    var databaseRef: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    
    var chatMessagesDict = [String:FIRDataSnapshot]()
    var chatSessionHandle: FIRDatabaseHandle!

    var userIsTypingRef: FIRDatabaseReference!
    var usersTypingQuery: FIRDatabaseQuery!
    fileprivate var localTyping = false
    
    var isTyping: Bool {
        get {
            return localTyping
        }
        set {
            localTyping = newValue
            userIsTypingRef.setValue(newValue)
        }
    }
    
    fileprivate func observeTyping() {
        
        let typingIndicatorRef = databaseRef.child("typingIndicator").child(CHAT_SESSION_ID)
        userIsTypingRef = typingIndicatorRef.child(self.senderId)
        userIsTypingRef.onDisconnectRemoveValue()
        
        usersTypingQuery = typingIndicatorRef.queryOrderedByValue().queryEqual(toValue: true)
        
        usersTypingQuery.observe(.value) { (data: FIRDataSnapshot!) in
            
            if data.childrenCount == 1 && self.isTyping {
                // Don't show the indicator if the only one typing is us!
                return
            }
            
            // Are there others typing?
            self.showTypingIndicator = data.childrenCount > 0
            self.scrollToBottom(animated: true)
        }
    }
    
    func isSimulator() -> Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return true
        #else
            return false
        #endif
    }
    
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
        
        self.title = "FirebaseChat"
        
        // In a real app, the senderId and senderDisplayNamewould would be set to 
        // some unique object id that maps to the user. For demo purposes, we will 
        // set the senderId and senderDisplayName based on whether or not we're 
        // running the app on a simulator or a device. This allows us to run one 
        // instance of the app on the simulator and one on a device so we can chat 
        // with ourselves for testing purposes.
        if isSimulator() {
            self.senderId = "simulator"
            self.senderDisplayName = "Sim";
        } else {
            self.senderId = "device"
            self.senderDisplayName = "Dev";
        }
        
        // Disable avatars
        self.collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        self.collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        // Setup bubble styling.
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        outgoingBubbleImageView = bubbleImageFactory?.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
        incomingBubbleImageView = bubbleImageFactory?.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
        
        self.automaticallyScrollsToMostRecentMessage = true
        
        self.collectionView?.reloadData()
        self.collectionView?.layoutIfNeeded()
        
        //
        // Firebase Setup...
        //
        
        configureDatabase()
        configureStorage()
        observeTyping()
    }
    
    deinit {
        self.databaseRef.child("chatSessions").child(CHAT_SESSION_ID).removeObserver(withHandle: chatSessionHandle)
    }
    
    override func textViewDidChange(_ textView: UITextView) {
        
        super.textViewDidChange(textView)
        
        // If the text is not empty, the user is typing!
        isTyping = textView.text != ""
    }
    
    // MARK: Firebase
    
    func configureDatabase() {
        
        self.databaseRef = FIRDatabase.database().reference()
        
        // Get all the current chat messages.
        
        self.databaseRef.child("chatSessions").child(CHAT_SESSION_ID).observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            
            guard let strongSelf = self else { return }
            
            // Add every chat message to the dictionary that doesn't already exist.
            for child in snapshot.children {
                
                let chat = child as! FIRDataSnapshot
                
                if strongSelf.chatMessagesDict[chat.key] == nil {
                    strongSelf.chatMessagesDict[chat.key] = chat
                }
            }
            
            // Sort the existing chat messages by their date timestamps.
            let sortedChats = Array(strongSelf.chatMessagesDict).sorted(by: {
                
                let chatMessage1 = ($0.value).value as! [String: Any]
                let chatMessage2 = ($1.value).value as! [String: Any]
                
                let date1 = chatMessage1["timeStamp"] as? Int
                let date2 = chatMessage2["timeStamp"] as? Int
                
                return date1! < date2!
            })
            
            // Add the chats in the correct order!
            for chat in sortedChats {
                
                strongSelf.addMessage(fromSnapshot: (strongSelf.chatMessagesDict[chat.key])!)
            }
            
            // Listen for new chat messages.
            strongSelf.chatSessionHandle = strongSelf.databaseRef.child("chatSessions").child((strongSelf.CHAT_SESSION_ID)).observe(.childAdded, with: { [weak self] (snapshot) -> Void in
                
                guard let strongSelf = self else { return }
                
                // Add the new chat message if it doesn't already exist in the dictionary.
                if strongSelf.chatMessagesDict[snapshot.key] == nil {
                    strongSelf.chatMessagesDict[snapshot.key] = snapshot
                    strongSelf.addMessage(fromSnapshot: snapshot)
                }
            })
            
        }) { (error) in
            
            print(error.localizedDescription)
        }
    }
    
    func addMessage(fromSnapshot: FIRDataSnapshot) {
        
        let chatMessage = fromSnapshot.value as! [String: Any]
        
        let name = chatMessage["name"] as? String
        let text = chatMessage["text"] as? String
        let senderId = chatMessage["senderId"] as? String
        let timeStamp = chatMessage["timeStamp"] as! Int
        
        if chatMessage["imageUrl"] != nil {
            
            if let imageUrl = chatMessage["imageUrl"] as? String {
                
                let photoMediaItem = JSQPhotoMediaItem()
                
                let message = JSQMessage(senderId: senderId,
                                         senderDisplayName: name,
                                         date: Date.init(timeIntervalSince1970: Double(timeStamp)/1000.0),
                                         media: photoMediaItem)
                
                self.messages.append(message!)
                
                FIRStorage.storage().reference(forURL: imageUrl).data(withMaxSize: INT64_MAX){ (data, error) in
                    
                    if let error = error {
                        print("Error downloading imageUrl: \(error)")
                        return
                    }
                    
                    let image = UIImage.init(data: data!)
                    
                    photoMediaItem.image = image
                    
                    // Make sure the media bubble's tail faces the correct direction.
                    photoMediaItem.appliesMediaViewMaskAsOutgoing = self.senderId == senderId;

                    self.finishReceivingMessage()
                }
            }
            
        } else if chatMessage["lat"] != nil {
            
            if let lat = chatMessage["lat"] as? Double, let long = chatMessage["long"] as? Double {
                
                let location = CLLocation(latitude: lat, longitude: long)
                    
                let locationMediaItem = JSQLocationMediaItem()
                
                locationMediaItem.setLocation(location) {
                    self.collectionView!.reloadData()
                }
                
                let message = JSQMessage(senderId: self.senderId, displayName: self.senderDisplayName, media: locationMediaItem)
                
                self.messages.append(message!)
                
                self.finishReceivingMessage()
            }
            
        } else {

            let message = JSQMessage(senderId: senderId,
                                     senderDisplayName: name,
                                     date: Date.init(timeIntervalSince1970: Double(timeStamp)/1000.0),
                                     text: text)
            
            self.messages.append(message!)
            
            self.finishReceivingMessage()
        }
    }
    
    func configureStorage() {
        
        // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        // For the call to FIRApp.defaultApp()?.options.storageBucket to work correctly
        // you'll need to download the "GoogleService-Info.plist" file that belongs to
        // your Firebase app from the Firebase dashboard and add it to the Xcode project.
        // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        let storageUrl = FIRApp.defaultApp()?.options.storageBucket
        storageRef = FIRStorage.storage().reference(forURL: "gs://" + storageUrl!)
    }
    
    func sendChatMessageToFirebase(withData data: [String: Any]) {
        
        self.databaseRef.child("chatSessions").child(CHAT_SESSION_ID).childByAutoId().setValue(data)
        
        self.finishSendingMessage()
    }
    
    // MARK: JSQMessages CollectionView DataSource
    
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
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForMessageBubbleTopLabelAt indexPath: IndexPath) -> CGFloat {
        
        // iOS7 style sender name labels.
        let currentMessage = self.messages[indexPath.item]
        
        if currentMessage.senderId == self.senderId {
            return 0.0
        }
        
        if indexPath.item - 1 > 0 {
            let previousMessage = self.messages[indexPath.item - 1]
            if previousMessage.senderId == currentMessage.senderId {
                return 0.0
            }
        }
        
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    
    // MARK: JSQMessagesViewController Text
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        let data: [String:Any] = [
            "name": "\(self.senderDisplayName!)",
            "text": text,
            "senderId": self.senderId!,
            "timeStamp": [".sv": "timestamp"]] // The server will replace this with a timestamp based on the server's time.
        
        self.sendChatMessageToFirebase(withData: data)
        
        isTyping = false
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
                
                let data: [String:Any] = [
                    "name": self.senderDisplayName!,
                    "senderId": self.senderId!,
                    "lat": currentLocation.coordinate.latitude,
                    "long": currentLocation.coordinate.longitude,
                    "timeStamp": [".sv": "timestamp"]] // The server will replace this with a timestamp based on the server's time.
                
                self.sendChatMessageToFirebase(withData: data)
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
        
        // If the user picked an image, convert it into a .jpg of lower quality for storage.
        let imageData = UIImageJPEGRepresentation(image, 0.8)
        
        // Create a unique name for it so we don't override any other pics.
        let imagePath = "\(self.senderId!)/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
        
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        // Store the image data in Firebase Storage.
        self.storageRef.child(imagePath).put(imageData!, metadata: metadata) { [weak self] (metadata, error) in
                
                if let error = error {
                    print("Error uploading image: \(error)")
                    return
                }
                
                guard let strongSelf = self else { return }
                
                // If we were succesful in storing the image in Firebase Storage,
                // get the URL of the stored image and post a new chat message that 
                // references it.
                
                let imageUrl: String = strongSelf.storageRef.child((metadata?.path)!).description
                
                let data: [String:Any] = [
                    "name": strongSelf.senderDisplayName!,
                    "senderId": strongSelf.senderId!,
                    "imageUrl": imageUrl,
                    "timeStamp": [".sv": "timestamp"]] // The server will replace this with a timestamp based on the server's time.
                
                self?.sendChatMessageToFirebase(withData: data)
        }
        
        picker.dismiss(animated: true, completion: { () -> Void in
            
        })
    }
}


