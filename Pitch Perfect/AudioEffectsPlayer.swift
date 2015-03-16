//
//  AudioEffectsPlayer.swift
//  Pitch Perfect
//
//  Created by Johannes Eichler on 12.03.15.
//  Copyright (c) 2015 Nigemizu. All rights reserved.
//
// This class handles all Pitch Perfect audio playback and audio effects

import UIKit
import AVFoundation

class AudioEffectsPlayer: NSObject {
    
    var audioEngine : AVAudioEngine!
    
    var audioPlayer: AVAudioPlayer!
    var effectsPlayer : AVAudioPlayerNode?
    
    var filePathURL: NSURL!
    var audioFile: AVAudioFile?
    
    
    
    init(filePathURL: NSURL) {
        
        //initate normal audio player
        
        
        var audio: AVAudioPlayer? = AVAudioPlayer(contentsOfURL: filePathURL, error: nil)
        audio!.enableRate = true
        self.audioPlayer = audio

        
        // initiate effects player
        
        self.filePathURL = filePathURL
        self.audioEngine = AVAudioEngine()
        self.audioFile = AVAudioFile(forReading: self.filePathURL, error: nil)
        
        
    }
        
    
    func playAudio(atRate:Float) -> Void {
        
        /*Play normal audio at the speed adjusted by "atRate"The range of values is 0.5 to 2.0**/
        
        if(self.audioPlayer != nil){
            
            self.resetAudioEngine()
            
            self.audioPlayer!.rate = atRate
            self.audioPlayer!.stop()
            self.audioPlayer?.currentTime = 0.0
            self.audioPlayer!.play()
            
        }
        
    }
    
    
    
    func resetAudioEngine() -> Void {
        
        /*Stops all audio and resets the AVAudioEngine instance to start with a new graph*/
        
        self.stop()
        self.audioEngine.stop()
        self.audioEngine.reset()
        
        self.effectsPlayer = AVAudioPlayerNode()
        self.effectsPlayer!.volume = 1.0
    
    }
 
    
    func playPitchedAudio(withPitch:Float) -> Void {
        
        /*Playback the audio with a pitch effect. "withPitch" adjusts the pitch level. The range of values is -2400 to 2400*/
        
        
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
        
        /*Playback the audio with an echo effect.*/
        
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
        /*Stop the playback of all audio*/
        
        
        // stop the effectsPlayer
        
        if(self.effectsPlayer != nil && self.effectsPlayer!.playing)
            
        {
            self.effectsPlayer!.stop()
        }
        
        // stop the normalAudioPlayer
        
        if(self.audioPlayer != nil && self.audioPlayer!.playing){
            
            self.audioPlayer!.stop()
        }
    
    }
    

}
