//
//  Characters.swift
//  SimpsonBook
//
//  Created by Furkan Sarı on 22.03.2022.
//

import Foundation
import UIKit

class Characters{
    var name : String
    var clan : String
    var image : UIImage
    
    init(initName:String,initClan:String,initImage:UIImage) {
        name=initName
        clan=initClan
        image=initImage
    }
}
