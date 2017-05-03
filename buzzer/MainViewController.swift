//
//  ViewController.swift
//  buzzer
//
//  Created by Alan Scarpa on 5/2/17.
//  Copyright © 2017 The Scarpa Group. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {

    var buzzingAudioPlayer = AVAudioPlayer()
    var cuttingAudioPlayer = AVAudioPlayer()
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAudioPlayer()
    }
    
    private func setUpAudioPlayer() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            buzzingAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "buzzSound", ofType: "wav")!))
            buzzingAudioPlayer.numberOfLoops = -1
            cuttingAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "clipperCutting", ofType: "wav")!))
            cuttingAudioPlayer.numberOfLoops = -1
        } catch {
            present(UIAlertController.createSimpleAlert(withTitle: "Sound Error", message: error.localizedDescription), animated: true, completion: nil)
        }
        buzzingAudioPlayer.prepareToPlay()
        cuttingAudioPlayer.prepareToPlay()
    }

    @IBAction func buzzerButtonTapped(_ sender: Any) {
        if buzzingAudioPlayer.isPlaying {
            buzzingAudioPlayer.stop()
        } else {
            buzzingAudioPlayer.currentTime = 0
            buzzingAudioPlayer.play()
        }
    }
    
    @IBAction func buzzButtonLongPressHeld(_ sender: AnyObject) {
        if sender.state == .began, buzzingAudioPlayer.isPlaying {
            cuttingAudioPlayer.play()
        } else if sender.state == .ended {
            cuttingAudioPlayer.stop()
        }
    }


}

