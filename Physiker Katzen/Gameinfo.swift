//
//  Gameinfos.swift
//  Physiker Katzen
//
//  Created by Volker Schering on 15.05.23.
//

import Foundation

protocol GameinfoDelegate {
   func gameinfoMovesChanged(moves: Int)
   func gameinfoSecondsChanged(seconds: Int)
   func gameinfoReset()
}

class Gameinfo {
   
   private init() {
      self.moves = 0
      self.seconds = 0
   }
   
   static let shared: Gameinfo = { return Gameinfo() }()
   
   var delegate: GameinfoDelegate?
   var timer: Timer?
   
   var moves: Int {
      didSet {
         print("Moves: \(moves)")
         if (moves == 1) {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(oneSecTimer), userInfo: nil, repeats: true)
         }
         delegate?.gameinfoMovesChanged(moves: moves)
      }
   }
   var seconds: Int {
      didSet {
         print("Seconds: \(seconds)")
         delegate?.gameinfoSecondsChanged(seconds: seconds)
      }
   }
   
   @objc private func oneSecTimer() {
      print("OneSecTimer fired")
      seconds += 1
   }

   // MARK: -
   
   func stop() {
      timer?.invalidate()
   }
   
   func reset() {
      moves = 0
      seconds = 0
      delegate?.gameinfoReset()
   }
   
   // MARK: -
   
   func secondsFormatted() -> String {
      // "0:00:02"
      return Duration.seconds(seconds).formatted()
   }
   
}
