//
//  ImageViewStyleManager.swift
//  MobileHostess
//
//  Created by Tristan Wolf on 2017-05-08.
//  Copyright © 2017 Tristan Wolf. All rights reserved.
//

import Foundation
import UIKit

public class ImageViewStyleManager: UIImageView {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width/2
    }
}
