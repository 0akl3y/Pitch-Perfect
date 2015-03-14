//
//  AudioEffectsPlayer.swift
//  Pitch Perfect
//
//  Created by Johannes Eichler on 12.03.15.
//  Copyright (c) 2015 Nigemizu. All rights reserved.
//

import UIKit
import AVFoundation

class AudioEffectsPlayer: NSObject {
    
    var audioEngine : AVAudioEngine!
    var effectsPlayer : AVAudioPlayerNode?
    
    var filePathURL: NSURL!
    var audioFile: AVAudioFile?
    
    
    init(filePathURL: NSURL) {
        self.filePathURL = filePathURL
        self.audioEngine = AVAudioEngine()
        self.audioFile = AVAudioFile(forReading: self.filePathURL, error: nil)
        
    }
    
    func resetAudioEngine() -> Void {
        
        self.audioEngine.stop()
        self.audioEngine.reset()
        
        self.effectsPlayer = AVAudioPlayerNode()
        self.effectsPlayer!.volume = 1.0
    
    }
 
    
    func playPitchedAudio(withPitch:Float) -> Void {
        
        
        self.resetAudioEngine()
        
        var timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = withPitch
        
        self.audioEngine.attachNode(effectsPlayer)
        self.audioEngine.attachNode(timePitch)
        
        self.audioEngine.connect(effectsPlayer, to: timePitch, format: nil)
        self.audioEngine.connect(timePitch, to: audioEngine!.outputNode, format: nil)
        
        
        self.effectsPlayer!.scheduleFile(self.audioFile, atTime: nil, completionHandler: nil)
        self.audioEngine.startAndReturnError(nil)
        
        
        self.effectsPlayer!.play()
        
    }
    
    func playAudioEcho() -> Void {
        
        self.resetAudioEngine()
        
        var echoEffect = AVAudioUnitDelay()
        var delay: NSTimeInterval = 0.3
        
        
        echoEffect.delayTime = delay
        
        self.audioEngine.attachNode(self.effectsPlayer)
        self.audioEngine.attachNode(echoEffect)
        
        
        self.audioEngine.connect(self.effectsPlayer, to: echoEffect, format: nil)
        self.audioEngine.connect(echoEffect, to: self.audioEngine.outputNode, format: nil)
        
        
        self.effectsPlayer!.scheduleFile(self.audioFile, atTime: nil, completionHandler: nil)
        
        self.audioEngine.startAndReturnError(nil)
        
        self.effectsPlayer!.play()
    
    
    }
    
    
    func stop() -> Void {
        
        if(self.effectsPlayer != nil && self.effectsPlayer!.playing)
            
        {
            self.effectsPlayer!.stop()
        }
        
    
    }
    

}
