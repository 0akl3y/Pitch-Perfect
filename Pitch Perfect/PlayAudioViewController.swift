//
//  PlayAudioViewController.swift
//  Pitch Perfect
//
//  Created by Johannes Eichler on 08.03.15.
//  Copyright (c) 2015 Nigemizu. All rights reserved.
//

import UIKit
import AVFoundation

class PlayAudioViewController: UIViewController {
    
    var audioFile: RecordedAudio!
    var fileURL: NSURL?
    
    var audioEffectsPlayer: AudioEffectsPlayer!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(self.audioFile.filePathURL != nil){
            
            
            self.fileURL = self.audioFile.filePathURL
            audioEffectsPlayer = AudioEffectsPlayer(filePathURL: fileURL!)
        }
        
        else {
            
            println("Could not find filepath \(fileURL)")
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func playSlow(sender: UIButton) {
        
        audioEffectsPlayer.playAudio(0.5)
        
    }
    
    
    @IBAction func playFast(sender: UIButton) {
        
        audioEffectsPlayer.playAudio(2.0)
        
    }
    
    @IBAction func playChipmunked(sender: UIButton) {
        
        audioEffectsPlayer.playPitchedAudio(1000)
        
    }
    
    @IBAction func playVader(sender: UIButton) {
        
        audioEffectsPlayer.playPitchedAudio(-1000)
    }
    
    
    
    @IBAction func playEcho(sender: UIButton) {
        
        audioEffectsPlayer.playAudioEcho()
        
    }
    
    

    @IBAction func stopAllAudio(sender: UIButton) {
        
        audioEffectsPlayer.stop()
        
        
    }
    
    


}
