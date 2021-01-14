//
//  Conductor.swift
//  AudioPlayerExample
//
//  Created by Matt Pfeiffer on 1/14/21.
//

import Foundation
import AVFoundation
import AudioKit



class Conductor : ObservableObject{
    
    /// Single shared data model
    static let shared = Conductor()
    
    /// Audio engine instance
    let engine = AudioEngine()
    
    /// Audio track player
    var player: AudioPlayer
    
    /// Will store audio file
    var file : AVAudioFile!
    
    /// limiter to prevent excessive volume at the output - just in case, it's the music producer in me :)
    let outputLimiter : PeakLimiter
    
    init() {
        
        // make audio play through speakers - just to make it loud
        do{
            try AudioKit.Settings.session.setCategory(.playAndRecord, options: .defaultToSpeaker)
        } catch{
            assert(false, error.localizedDescription)
        }
        
        // sets the path for the file
        let url = URL(fileURLWithPath: Bundle.main.resourcePath! + "/track.mp3")
        do{
            // creates the audio file
            file = try AVAudioFile(forReading: url)
        } catch{
            fatalError("Couldn't find your audio track")
        }
        // gives the audio file to the player
        player = AudioPlayer(file: file)!
        
        // route the player to the limiter (you must always route the audio chain to AudioKit.output)
        outputLimiter = PeakLimiter(player)
        
        // set the limiter as the last node in our audio chain
        engine.output = outputLimiter
        
        // Start AudioKit Engine and then the player
        do{
            try engine.start()
            player.play()
        }
        catch{
            assert(false, error.localizedDescription)
        }
        
    }
    
}
