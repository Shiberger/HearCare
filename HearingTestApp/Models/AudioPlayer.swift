//
//  AudioPlayer.swift
//  HearingTestApp
//
//  Created by Hannarong Kaewkiriya on 2/2/2568 BE.
//

import AVFoundation

class AudioPlayer {
    let engine = AVAudioEngine()
    let player = AVAudioPlayerNode()

    init() {
        engine.attach(player)
        engine.connect(player, to: engine.mainMixerNode, format: nil)
        try? engine.start()
    }

    func playTone(frequency: Float, amplitude: Float) {
        let sampleRate = Float(engine.mainMixerNode.outputFormat(forBus: 0).sampleRate)
        let duration: Float = 1.0 // seconds
        let frameCount = UInt32(duration * sampleRate)

        let buffer = AVAudioPCMBuffer(pcmFormat: player.outputFormat(forBus: 0), frameCapacity: frameCount)!
        buffer.frameLength = frameCount

        let channels = Int(buffer.format.channelCount)
        for channel in 0..<channels {
            if let samples = buffer.floatChannelData?[channel] {
                for frame in 0..<Int(frameCount) {
                    let time = Float(frame) / sampleRate
                    let value = sinf(2.0 * .pi * frequency * time) * amplitude
                    samples[frame] = value
                }
            }
        }

        player.scheduleBuffer(buffer, at: nil, options: [], completionHandler: nil)
        player.play()
    }

    func stopTone() {
        player.stop()
    }
}
