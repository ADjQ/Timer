//Copyright © 2017 ADjQ. All rights reserved.

import Foundation

struct Preferences {

  var selectedTime: TimeInterval {
    get {
      let savedTime = UserDefaults.standard.double(forKey: "selectedTime")
      if savedTime > 0 {
        return savedTime
      }
      return 360
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "selectedTime")
    }
  }

}
