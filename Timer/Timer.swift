//Copyright © 2017 ADjQ. All rights reserved.

import Foundation

protocol ATimerProtocol {
  func timeRemainingOnTimer(_ timer: ATimer, timeRemaining: TimeInterval)
  func timerHasFinished(_ timer: ATimer)
}

class ATimer {

  var timer: Timer? = nil
  var startTime: Date?
  var duration: TimeInterval = 360
  var elapsedTime: TimeInterval = 0

  var isStopped: Bool {
    return timer == nil && elapsedTime == 0
  }
  var isPaused: Bool {
    return timer == nil && elapsedTime > 0
  }

  var delegate: ATimerProtocol?

  dynamic func timerAction() {
    guard let startTime = startTime else {
      return
    }

    elapsedTime = -startTime.timeIntervalSinceNow

    let secondsRemaining = (duration - elapsedTime).rounded()

    if secondsRemaining <= 0 {
      resetTimer()
      delegate?.timerHasFinished(self)
    } else {
      delegate?.timeRemainingOnTimer(self, timeRemaining: secondsRemaining)
    }
  }

  func startTimer() {
    startTime = Date()
    elapsedTime = 0

    timer = Timer.scheduledTimer(timeInterval: 1,
                                 target: self,
                                 selector: #selector(timerAction),
                                 userInfo: nil,
                                 repeats: true)
    timerAction()
  }

  func resumeTimer() {
    startTime = Date(timeIntervalSinceNow: -elapsedTime)

    timer = Timer.scheduledTimer(timeInterval: 1,
                                 target: self,
                                 selector: #selector(timerAction),
                                 userInfo: nil,
                                 repeats: true)
    timerAction()
  }

  func stopTimer() {
    timer?.invalidate()
    timer = nil

    timerAction()
  }

  func resetTimer() {
    timer?.invalidate()
    timer = nil

    startTime = nil
    duration = 360
    elapsedTime = 0
    
    timerAction()
  }
  
}
