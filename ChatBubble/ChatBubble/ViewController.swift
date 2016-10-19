//
//  ViewController.swift
//  ChatBubble
//
//  Created by Sauvik Dolui on 02/09/15.
//  Copyright (c) 2015 Innofied Solution Pvt. Ltd. All rights reserved.
//
//  Chat bubble art provided by Melissa Phillips:
//  https://www.linkedin.com/in/melissanicolephillips
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet var messageComposingView: UIView!
    @IBOutlet weak var messageCointainerScroll: UIScrollView!
    @IBOutlet weak var buttomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var selectedImage: UIImage?
    var lastChatBubbleY: CGFloat = 10.0
    var internalPadding: CGFloat = 8.0
    var lastMessageType: ChatBubbleOwner?
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.addTarget(self, action: #selector(ViewController.textFieldChanged(textField:)), for: UIControlEvents.editingChanged)
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        sendButton.isEnabled = false
        
        textField.backgroundColor = UIColor.white
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 14.0
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
        
        self.addKeyboardNotifications()
        
        //
        // Load a fake chat session...
        //
        
        let chatBubbleData1 = ChatBubbleData(text: "Hey Grumpy!", image: nil, date: Date(), type: .other)
        addChatBubble(chatBubbleData1)
        
        let chatBubbleData2 = ChatBubbleData(text: "ughhhhh WHAT!?", image: nil, date: Date(), type: .mine)
        addChatBubble(chatBubbleData2)
        
        let chatBubbleData3 = ChatBubbleData(text: "If you're happy and you know it....", image: UIImage(named: "lil_bub.jpg"), date: Date(), type: .other)
        addChatBubble(chatBubbleData3)
        
        let chatBubbleData4 = ChatBubbleData(text: "... keep it to yourself.", image: UIImage(named: "grumpy.jpg"), date: Date(), type: .mine)
        addChatBubble(chatBubbleData4)
        
        let chatBubbleData5 = ChatBubbleData(text: "He he he he...", image: nil, date: Date(), type: .other)
        addChatBubble(chatBubbleData5)
        
        let chatBubbleData6 = ChatBubbleData(text: "☠️☠️☠️☠️☠️☠️☠️", image: nil, date: Date(), type: .mine)
        addChatBubble(chatBubbleData6)
        
        self.messageCointainerScroll.contentSize = CGSize(width: messageCointainerScroll.frame.width, height: lastChatBubbleY + internalPadding)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldChanged(textField: UITextField) {
        
        if textField.text == "" {
            sendButton.isEnabled = false
        } else {
            sendButton.isEnabled = true
        }
    }
    
    func addKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        
        var info = (notification as NSNotification).userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.buttomLayoutConstraint.constant = keyboardFrame.size.height

            }, completion: { (completed: Bool) -> Void in
                    self.moveToLastMessage()
        }) 
    }
    
    func keyboardWillHide(_ notification: Notification) {
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.buttomLayoutConstraint.constant = 0.0
            }, completion: { (completed: Bool) -> Void in
                self.moveToLastMessage()
        }) 
    }
    
    @IBAction func sendButtonClicked(_ sender: AnyObject) {
        
        self.addRandomTypeChatBubble()
        textField.resignFirstResponder()
    }
    
    @IBAction func cameraButtonClicked(_ sender: AnyObject) {
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func addRandomTypeChatBubble() {
        
        let bubbleData = ChatBubbleData(text: textField.text, image: selectedImage, date: Date(), type: getRandomChatDataType())
        addChatBubble(bubbleData)
    }
    
    func addChatBubble(_ data: ChatBubbleData) {
        
        let padding:CGFloat = lastMessageType == data.type ? internalPadding/3.0 :  internalPadding
        let chatBubble = ChatBubble(data: data, startY:lastChatBubbleY + padding)
        self.messageCointainerScroll.addSubview(chatBubble)
        
        lastChatBubbleY = chatBubble.frame.maxY
        
        self.messageCointainerScroll.contentSize = CGSize(width: messageCointainerScroll.frame.width, height: lastChatBubbleY + internalPadding)
        self.moveToLastMessage()
        lastMessageType = data.type
        textField.text = ""
        sendButton.isEnabled = false
    }
    
    func moveToLastMessage() {

        if messageCointainerScroll.contentSize.height > messageCointainerScroll.frame.height {
            let contentOffSet = CGPoint(x: 0.0, y: messageCointainerScroll.contentSize.height - messageCointainerScroll.frame.height)
            self.messageCointainerScroll.setContentOffset(contentOffSet, animated: true)
        }
    }
    
    func getRandomChatDataType() -> ChatBubbleOwner {
        
        return ChatBubbleOwner(rawValue: Int(arc4random() % 2))!
    }
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        // Prevent Horizontal Scrolling in UIScrollView
        scrollView.contentOffset.x = 0
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Send button on keybaord clicked.
        textField.resignFirstResponder()
        self.addRandomTypeChatBubble()
        
        return true
    }
}

extension ViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: { () -> Void in
            
        })
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let bubbleData = ChatBubbleData(text: textField.text, image: chosenImage, date: Date(), type: getRandomChatDataType())
        
        addChatBubble(bubbleData)
        
        picker.dismiss(animated: true, completion: { () -> Void in
            
        })
    }
}

