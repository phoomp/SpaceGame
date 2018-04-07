//
//  Randomizer.swift
//  SpaceGame
//
//  Created by Phoom Punpeng on 7/4/18.
//  Copyright © 2018 Phoom Punpeng. All rights reserved.
//

import Foundation
import UIKit

class Helper: NSObject {
    func randomBetweenTwoNumbers(firstNumber : CGFloat ,  secondNumber : CGFloat) -> CGFloat{
        return CGFloat(arc4random_uniform(640))
    }
}

