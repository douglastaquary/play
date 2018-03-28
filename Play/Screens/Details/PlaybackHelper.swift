//
//  PlaybackHelper.swift
//  Play
//
//  Created by douglas taquary on 22/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import YoutubeSourceParserKit


struct PlaybackHelper {
    
    private enum PlaybackError: Error {
        case urlNotFound
    }
    
    fileprivate let youtubePath: URL = URL(string: "https://www.youtube.com/watch?v=")!
    
    let preferredTimeScale = Int32(NSEC_PER_SEC)
    
    let video: Video
    
    init(with video: Video) {
        self.video = video
    }
    
    private var moviePlayer: AVPlayerViewController = {
        let p = AVPlayerViewController()
       
        p.allowsPictureInPicturePlayback = true
        if #available(iOS 10.0, *){
            p.updatesNowPlayingInfoCenter = true
        }
        
        return p
    }()
    
    func play(from controller: UIViewController) {
        if let videoCompleteURL = URL(string: "https://www.youtube.com/watch?v=\(video.key)") {
            print("\n\(videoCompleteURL)")
            
            Youtube.h264videosWithYoutubeURL(youtubePath) { info, error in
                guard error == nil else {
                    DispatchQueue.main.async {
                        self.show(error!, from: controller)
                    }
                    return
                }
                
                if let _ = info?["url"] as? String {
                    DispatchQueue.main.async {
                        self.setupAndPlay(videoCompleteURL, from: controller)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.show(PlaybackError.urlNotFound, from: controller)
                    }
                }
            }
        }
    }
    
    private func show(_ error: Error, from controller: UIViewController) {
        let alert = UIAlertController(
            title: "Não foi possível reproduzir o vídeo",
            message: "Desculpe, não podemos exibir esse vídeo neste momento. Tente mais tarde.\n\(error)",
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    private func setupAndPlay(_ videoUrl: URL, from controller: UIViewController) {
        let player = AVPlayer(url: videoUrl)
        
        self.moviePlayer.player = player
        
        var timeObserver: Any!
        
        timeObserver = player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(5, preferredTimeScale), queue: nil) { time in
            guard let duration = player.currentItem?.duration else { return }
            
            let position = CMTimeGetSeconds(time)
            
            if position >= CMTimeGetSeconds(duration) - 30 {
                // reached end of video - 30 seconds: reset position
                UserDefaults.standard.set(position: -1, in: Int(self.video.id) ?? 0)
                player.removeTimeObserver(timeObserver)
            } else {
                // update position
                UserDefaults.standard.set(position: Float(position), in: Int(self.video.id) ?? 0)
            }
        }
        
        // position restoration
        
        let savedPosition = UserDefaults.standard.position(in: Int(self.video.id) ?? 0)
        
        if savedPosition > 0 {
            showContinuationOptions(with: player, position: savedPosition, from: controller)
        } else {
            showAndPlay(with: player, from: controller)
        }
    }
    
    private func showContinuationOptions(with player: AVPlayer, position: Float, from controller: UIViewController) {
        let message = NSLocalizedString("Deseja assistir desde o início ou continuar assistindo?", comment: "Do you want to watch from the begining or continue watching? - alert message")
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        
        let continueTitle: String
        
        if let timeStr = String(time: position) {
            let format = NSLocalizedString("Continuar Assistindo aos %@", comment: "Continue at HH:mm:ss - button title (continue watching video - time specified)")
            continueTitle = String(format: format, timeStr)
        } else {
            continueTitle = NSLocalizedString("Continuar Assistindo", comment: "Continue Watching - button title (continue watching video - time not specified)")
        }
        
        let continueAction = UIAlertAction(title: continueTitle, style: .default) { _ in
            player.seek(to: CMTimeMakeWithSeconds(Float64(position), self.preferredTimeScale))
            self.showAndPlay(with: player, from: controller)
        }
        
        let restartTitle = NSLocalizedString("Assistir Desde o Início", comment: "Watch from the begining - button title (watch video form the begining)")
        let restartAction = UIAlertAction(title: restartTitle, style: .default) { _ in
            self.showAndPlay(with: player, from: controller)
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Cancel"), style: .cancel, handler: nil)
        
        alert.addAction(continueAction)
        alert.addAction(restartAction)
        alert.addAction(cancelAction)
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    private func showAndPlay(with player: AVPlayer, from controller: UIViewController) {
        controller.present(self.moviePlayer, animated: true) {
            player.play()
        }
    }
}
