//
//  ViewController.swift
//  BackendlessVideo
//
//  Created by Kevin Harris on 10/06/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var publishBtn: UIButton!
    @IBOutlet weak var playbackBtn: UIButton!
    @IBOutlet weak var stopMediaBtn: UIButton!
    @IBOutlet weak var swapCameraBtn: UIButton!
    @IBOutlet weak var preView: UIView!
    @IBOutlet weak var playbackView: UIImageView!
    @IBOutlet weak var streamNameTextField: UITextField!
    @IBOutlet weak var netActivity: UIActivityIndicatorView!
    @IBOutlet weak var videoModeSegment: UISegmentedControl!
    @IBOutlet weak var publishOptionsSegment: UISegmentedControl!
    @IBOutlet weak var resolutionSegment: UISegmentedControl!
    
    var isLive = false
    
    //options.resolution = RESOLUTION_LOW    // 144x192px (landscape) & 192x144px (portrait)
    //options.resolution = RESOLUTION_CIF    // 288x352px (landscape) & 352x288px (portrait)
    //options.resolution = RESOLUTION_MEDIUM // 360x480px (landscape) & 480x368px (portrait)
    //options.resolution = RESOLUTION_VGA    // 480x640px (landscape) & 640x480px (portrait)
    //options.resolution = RESOLUTION_HIGH   // 720x1280px (landscape) & 1280x720px (portrait)
    var resolution: MPVideoResolution = RESOLUTION_CIF
    
    var backendless = Backendless.sharedInstance()
    var publisher: MediaPublisher?
    var player: MediaPlayer?
    let VIDEO_TUBE = "Default"
    
    enum VideoMode {
        
        case recordAndPlayback
        case liveStream
        case viewStream
    }
    
    var selectedVideoMode: VideoMode = .recordAndPlayback
    
    enum PublishOptions {
        
        case videoPlusAudio
        case videoOnly
        case audioOnly
    }
    
    var selectedPublishOptions: PublishOptions = .videoPlusAudio
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        streamNameTextField.addTarget(self, action: #selector(textFieldChanged(textField:)), for: UIControlEvents.editingChanged)
        
        publishBtn.isEnabled = false
        playbackBtn.isEnabled = false
        swapCameraBtn.isEnabled = false
        stopMediaBtn.isEnabled = false
        
        resolutionSegment.selectedSegmentIndex = Int(resolution.rawValue)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        checkForBackendlessSetup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldChanged(textField: UITextField) {
        
        if streamNameTextField.text == "" {
            
            playbackBtn.isEnabled = false
            stopMediaBtn.isEnabled = false
            publishBtn.isEnabled = false
            swapCameraBtn.isEnabled = false
            
        } else {
            
            playbackBtn.isEnabled = true
            
            switch selectedVideoMode {
                
            case .recordAndPlayback:
                
                publishBtn.isEnabled = true
                
            case .liveStream:
                
                publishBtn.isEnabled = true
                
            case .viewStream:
                
                publishBtn.isEnabled = false
            }
        }
    }
    
    func checkForBackendlessSetup() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if appDelegate.APP_ID == "<replace-with-your-app-id>" || appDelegate.SECRET_KEY == "<replace-with-your-secret-key>" {
            
            let alertController = UIAlertController(title: "Backendless Error",
                                                    message: "To use this sample you must register with Backendless, create an app, and replace the APP_ID and SECRET_KEY in the AppDelegate with the values from your app's settings.",
                                                    preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title,message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onSwitchCamerasBtn(_ sender: UIButton) {
        
        publisher?.switchCameras()
    }
    
    @IBAction func videoModeChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            selectedVideoMode = .recordAndPlayback
        } else if sender.selectedSegmentIndex == 1 {
            selectedVideoMode = .liveStream
        } else if sender.selectedSegmentIndex == 2 {
            selectedVideoMode = .viewStream
        }
        
        refreshUI()
    }
    
    @IBAction func publishOptionsChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            selectedPublishOptions = .videoPlusAudio
        } else if sender.selectedSegmentIndex == 1 {
            selectedPublishOptions = .audioOnly
        } else if sender.selectedSegmentIndex == 2 {
            selectedPublishOptions = .videoOnly
        }
    }
    
    @IBAction func resolutionChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            resolution = RESOLUTION_LOW
        } else if sender.selectedSegmentIndex == 1 {
            resolution = RESOLUTION_CIF
        } else if sender.selectedSegmentIndex == 2 {
            resolution = RESOLUTION_MEDIUM
        } else if sender.selectedSegmentIndex == 3 {
            resolution = RESOLUTION_VGA
        } else if sender.selectedSegmentIndex == 4 {
            resolution = RESOLUTION_HIGH
        }
    }
    
    func refreshUI() {
        
        streamNameTextField.isEnabled = true
        videoModeSegment.isEnabled = true
        publishOptionsSegment.isEnabled = true
        resolutionSegment.isEnabled = true
        
        switch selectedVideoMode {
            
            case .recordAndPlayback:
                
                isLive = false
                
                if streamNameTextField.text == "" {
                    publishBtn.isEnabled = false
                    playbackBtn.isEnabled = false
                } else {
                    publishBtn.isEnabled = true
                    playbackBtn.isEnabled = true
                }
                
                swapCameraBtn.isEnabled = false
                stopMediaBtn.isEnabled = false
                
                preView.isHidden = false
                playbackView.isHidden = true
            
                publishBtn.setTitle("Record", for: .disabled)
                publishBtn.setTitle("Record", for: .normal)
                
            case .liveStream:
                
                isLive = true
                
                if streamNameTextField.text == "" {
                    publishBtn.isEnabled = false
                    playbackBtn.isEnabled = false
                } else {
                    publishBtn.isEnabled = true
                    playbackBtn.isEnabled = true
                }
                
                swapCameraBtn.isEnabled = false
                stopMediaBtn.isEnabled = false
                
                preView.isHidden = false
                playbackView.isHidden = true
            
                publishBtn.setTitle("Stream", for: .disabled)
                publishBtn.setTitle("Stream", for: .normal)
                
            case .viewStream:
                
                isLive = true
                
                publishBtn.isEnabled = false
                
                if streamNameTextField.text == "" {
                    playbackBtn.isEnabled = false
                } else {
                    playbackBtn.isEnabled = true
                }
                
                swapCameraBtn.isEnabled = false
                stopMediaBtn.isEnabled = false
                
                preView.isHidden = true
                playbackView.isHidden = false
            
                publishBtn.setTitle("Stream", for: .disabled)
                publishBtn.setTitle("Stream", for: .normal)
        }
    }
    
    @IBAction func onStopBtn(_ sender: UIButton) {
        
        stopMedia()
    }
    
    func stopMedia() {
        
        if publisher != nil {
            
            publisher?.disconnect()
            publisher = nil;
        }
        
        if player != nil {
            
            player?.disconnect()
            player = nil;
        }
        
        refreshUI()
        
        netActivity.stopAnimating()
    }
    
    @IBAction func onPlayBtn(_ sender: UIButton) {
        
        var options: MediaPlaybackOptions
        
        if isLive {
            options = MediaPlaybackOptions.liveStream(self.playbackView) as! MediaPlaybackOptions
        } else {
            options = MediaPlaybackOptions.recordStream(self.playbackView) as! MediaPlaybackOptions
        }
        
        options.orientation = .up
        options.isRealTime = isLive
        
        player = backendless?.mediaService.playbackStream(streamNameTextField.text, tube: VIDEO_TUBE, options: options, responder: self)
        
        publishBtn.isEnabled = false
        playbackBtn.isEnabled = false
        streamNameTextField.isEnabled = false
        videoModeSegment.isEnabled = false
        publishOptionsSegment.isEnabled = false
        resolutionSegment.isEnabled = false

        netActivity.startAnimating()
    }
    
    @IBAction func onRecordBtn(_ sender: UIButton) {
        
        var options: MediaPublishOptions
        
        if isLive {
            // Call liveStream to start a live stream that is NOT recorded to the server.
            //options = MediaPublishOptions.liveStream(self.preView) as! MediaPublishOptions
            
            // Call appendStream to start a live stream that is also recorded to the server for future play back.
            options = MediaPublishOptions.appendStream(self.preView) as! MediaPublishOptions
        } else {
            options = MediaPublishOptions.recordStream(self.preView) as! MediaPublishOptions
        }
        
        switch selectedPublishOptions {
                
            case .videoPlusAudio:
                
                options.orientation = .portrait
                options.resolution = resolution
                options.content = AUDIO_AND_VIDEO
            
            case .audioOnly:
            
                options.content = ONLY_AUDIO
            
            case .videoOnly:

                options.orientation = .portrait
                options.resolution = resolution
                options.content = ONLY_VIDEO
        }
        
        publisher = backendless?.mediaService.publishStream(streamNameTextField.text, tube: VIDEO_TUBE, options: options, responder: self)

        publishBtn.isEnabled = false
        playbackBtn.isEnabled = false
        streamNameTextField.isEnabled = false
        videoModeSegment.isEnabled = false
        publishOptionsSegment.isEnabled = false
        resolutionSegment.isEnabled = false
        
        netActivity.startAnimating()
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}

extension ViewController: IMediaStreamerDelegate {
    
    public func streamStateChanged(_ sender: Any!, state: Int32, description: String!) {
        
        print("<IMediaStreamerDelegate> streamStateChanged: \(state) = \(description!)");
        
        // TODO: Are there any docs on IMediaStreamerDelegate? Is there any enums we can use instead of integers?
        // This IMediaStreamerDelegate method is sometimes called from the main thread
        // and sometimes not. Since I'm unsure of which thread it will be called from
        // I'll play it safe and dispatch everything back to the main thread.
        
        switch state {
            
            case 0: // CONN_DISCONNECTED
                
                DispatchQueue.main.async {
                    self.stopMedia()
                }
                
            case 1: break // CONN_CONNECTED
                
            case 2: // CONN_CREATED
                
                DispatchQueue.main.async {
                    self.stopMediaBtn.isEnabled = true
                }
                
            case 3: // STREAM_PLAYING
                
                DispatchQueue.main.async {
                    
                    if self.publisher != nil {
                        
                        if description != "NetStream.Publish.Start" {
                            self.showAlert(title: "Backendless Error", message: "Failed to play the stream named: '\(self.streamNameTextField.text!)' on the server.")
                            self.stopMedia()
                            return
                        }
                        
                        self.swapCameraBtn.isEnabled = true
                        self.netActivity.stopAnimating()
                    }
                    
                    if self.player != nil {
                        
                        if description == "NetStream.Play.StreamNotFound" {
                            
                            if self.selectedVideoMode == .viewStream {
                                self.showAlert(title: "Backendless Error", message: "Could not find a live stream named: '\(self.streamNameTextField.text!)' on the server. Stream has possibly stopped broadcasting.")
                            } else {
                                self.showAlert(title: "Backendless Error", message: "Could not find a stream named: '\(self.streamNameTextField.text!)' on the server.")
                            }
                            
                            self.stopMedia()
                            return
                        }
                        
                        if description != "NetStream.Play.Start" {
                            return
                        }
                        
                        MPMediaData.routeAudioToSpeaker()
                        
                        self.preView.isHidden = true
                        self.playbackView.isHidden = false
                        
                        self.netActivity.stopAnimating()
                    }
                }
                
                return
                
            case 4: // STREAM_PAUSED
                
                DispatchQueue.main.async {
                    
                    if description == "NetStream.Play.StreamNotFound" {
                        self.showAlert(title: "Backendless Error", message: "Could not find a stream named: '\(self.streamNameTextField.text!)' on the server.")
                    }
                    
                    self.stopMedia()
                }
                
            default:
                print("streamStateChanged unhandled state: \(state)");
                return
        }
    }
    
    func streamConnectFailed(_ sender: Any!, code: Int32, description: String!) {
        
        print("<IMediaStreamerDelegate> streamConnectFailed: \(code) = \(description)");
        
        self.showAlert(title: "Backendless Error", message: "Failed to connect to the stream named: '\(self.streamNameTextField.text!)'.")
        
        stopMedia()
    }
}
