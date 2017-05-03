//
//  ViewController.swift
//  buzzer
//
//  Created by Alan Scarpa on 5/2/17.
//  Copyright © 2017 The Scarpa Group. All rights reserved.
//

import UIKit
import AVFoundation

class BugViewController: UIViewController, AVAudioPlayerDelegate {
    
    var buzzingAudioPlayer = AVAudioPlayer()
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainButton: UIButton!
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainButton.layer.cornerRadius = 12
        setUpAudioPlayer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        returnToDefaultState()
    }
    
    // MARK: - AVAudioPlayer
    
    private func setUpAudioPlayer() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            buzzingAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "beeSound", ofType: "wav")!))
            buzzingAudioPlayer.numberOfLoops = -1
            buzzingAudioPlayer.delegate = self
        } catch {
            present(UIAlertController.createSimpleAlert(withTitle: "Sound Error", message: error.localizedDescription), animated: true, completion: nil)
        }
        buzzingAudioPlayer.prepareToPlay()
    }
    
    // MARK: - Actions
    
    @IBAction func buzzerButtonTapped(_ sender: Any) {
        if buzzingAudioPlayer.isPlaying {
            buzzingAudioPlayer.stop()
            mainImageView.image = UIImage(named: "bugOff")
            mainButton.setTitle("Tap to Buzz!", for: .normal)
        } else {
            buzzingAudioPlayer.currentTime = 0
            buzzingAudioPlayer.play()
            mainImageView.image = UIImage(named: "bugOn")
            mainButton.setTitle("Tap to Stop", for: .normal)
        }
    }
    
    // MARK: - Private
    
    private func returnToDefaultState() {
        buzzingAudioPlayer.stop()
        mainImageView.image = UIImage(named: "bugOff")
        mainButton.setTitle("Tap to Buzz!", for: .normal)
    }
    
}
