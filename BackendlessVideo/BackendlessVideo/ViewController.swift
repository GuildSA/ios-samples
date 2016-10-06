//
//  ViewController.swift
//  BackendlessVideo
//
//  Created by Kevin Harris on 10/06/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, IMediaStreamerDelegate {
    
    @IBOutlet var publishBtn: UIButton!
    @IBOutlet var playbackBtn: UIButton!
    @IBOutlet var stopMediaBtn: UIButton!
    @IBOutlet var swapCameraBtn: UIButton!
    @IBOutlet var preView: UIView!
    @IBOutlet var playbackView: UIImageView!
    @IBOutlet var streamNameTextField: UITextField!
    @IBOutlet var netActivity: UIActivityIndicatorView!
    @IBOutlet weak var videoModeSegment: UISegmentedControl!
    @IBOutlet weak var publishOptionsSegment: UISegmentedControl!
    
    var isLive = false
    
    var backendless = Backendless.sharedInstance()
    var publisher: MediaPublisher?
    var player: MediaPlayer?
    let VIDEO_TUBE = "Default"
    
    enum VideoMode {
        
        case recordAndPlayback
        case liveStream
        case viewStream
    }
    
    var currentVideoMode: VideoMode = .recordAndPlayback
    
    enum PublishOptions {
        
        case videoPlusAudio
        case videoOnly
        case audioOnly
    }
    
    var currentPublishOptions: PublishOptions = .videoPlusAudio
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        streamNameTextField.addTarget(self, action: #selector(textFieldChanged(textField:)), for: UIControlEvents.editingChanged)
        
        self.publishBtn.isEnabled = false
        self.playbackBtn.isEnabled = false
        self.swapCameraBtn.isEnabled = false
        self.stopMediaBtn.isEnabled = false
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
            
            switch currentVideoMode {
                
                case .recordAndPlayback:
                    
                    playbackBtn.isEnabled = true
                    publishBtn.isEnabled = true
                    
                case .liveStream:

                    playbackBtn.isEnabled = false
                    publishBtn.isEnabled = true
                    
                case .viewStream:
                    
                    playbackBtn.isEnabled = true
                    publishBtn.isEnabled = false
            }
        }
    }
    
    @IBAction func onSwitchCamerasBtn(_ sender: UIButton) {
        
        publisher?.switchCameras()
    }
    
    @IBAction func videoModeChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            currentVideoMode = .recordAndPlayback
        } else if sender.selectedSegmentIndex == 1 {
            currentVideoMode = .liveStream
        } else if sender.selectedSegmentIndex == 2 {
            currentVideoMode = .viewStream
        }
        
        refreshUI()
    }
    
    @IBAction func publishOptionsChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            currentPublishOptions = .videoPlusAudio
        } else if sender.selectedSegmentIndex == 1 {
            currentPublishOptions = .videoOnly
        } else if sender.selectedSegmentIndex == 2 {
            currentPublishOptions = .audioOnly
        }
    }
    
    func refreshUI() {
        
        streamNameTextField.isEnabled = true
        videoModeSegment.isEnabled = true
        publishOptionsSegment.isEnabled = true
        
        switch currentVideoMode {
            
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
                } else {
                    publishBtn.isEnabled = true
                }
                
                playbackBtn.isEnabled = false
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

        netActivity.startAnimating()
    }
    
    @IBAction func onRecordBtn(_ sender: UIButton) {
        
        var options: MediaPublishOptions
        
        if isLive {
            options = MediaPublishOptions.liveStream(self.preView) as! MediaPublishOptions
        } else {
            options = MediaPublishOptions.recordStream(self.preView) as! MediaPublishOptions
        }
        
        switch currentPublishOptions {
                
            case .videoPlusAudio:
                
                options.orientation = .portrait
                
                //options.resolution = RESOLUTION_LOW         // 144x192px (landscape) & 192x144px (portrait)
                options.resolution = RESOLUTION_CIF         // 288x352px (landscape) & 352x288px (portrait)
                //options.resolution = RESOLUTION_MEDIUM      // 360x480px (landscape) & 480x368px (portrait)
                //options.resolution = RESOLUTION_VGA         // 480x640px (landscape) & 640x480px (portrait)
                //options.resolution = RESOLUTION_HIGH        // 720x1280px (landscape) & 1280x720px (portrait)
                
                options.content = AUDIO_AND_VIDEO
                
            case .videoOnly:

                options.orientation = .portrait
                options.resolution = RESOLUTION_CIF
                options.content = ONLY_VIDEO
        
            case .audioOnly:
                
                options.content = ONLY_AUDIO
        }
        
        publisher = backendless?.mediaService.publishStream(streamNameTextField.text, tube: VIDEO_TUBE, options: options, responder: self)

        publishBtn.isEnabled = false
        playbackBtn.isEnabled = false
        streamNameTextField.isEnabled = false
        videoModeSegment.isEnabled = false
        publishOptionsSegment.isEnabled = false
        
        netActivity.startAnimating()
    }
    
    // MARK: UITextFieldDelegate protocol methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    // MARK: IMediaStreamerDelegate protocol methods to handle stream state changes and errors
    
    public func streamStateChanged(_ sender: Any!, state: Int32, description: String!) {
        
        switch state {
            
            case 0: //CONN_DISCONNECTED
                
                stopMedia()
            
            case 1: break //CONN_CONNECTED
            
            case 2: //CONN_CREATED
                
                stopMediaBtn.isEnabled = true
                
            case 3: //STREAM_PLAYING
                

                if self.publisher != nil {
                    
                    if description != "NetStream.Publish.Start" {
                        stopMedia()
                        return
                    }
                    
                    swapCameraBtn.isEnabled = true
                    netActivity.stopAnimating()
                }
                
                if self.player != nil {
                    
                    if description == "NetStream.Play.StreamNotFound" {
                        stopMedia()
                        return
                    }
                    
                    if description != "NetStream.Play.Start" {
                        return
                    }
                    
                    MPMediaData.routeAudioToSpeaker()
                    
                    preView.isHidden = true
                    playbackView.isHidden = false
                    
                    netActivity.stopAnimating()
                }
                
                return
                
            case 4: //STREAM_PAUSED
                
                //if description == "NetStream.Play.StreamNotFound" {
                //}
                
                stopMedia()
            
            default:
                print("streamStateChanged unhandled state: \(state)");
                return
        }
    }
    
    func streamConnectFailed(_ sender: Any!, code: Int32, description: String!) {
        
        print("<IMediaStreamerDelegate> streamConnectFailed: \(code) = \(description)");
        
        stopMedia()
    }
}

