//
//  HomePageContainerVC.swift
//  Newly
//
//  Created by Ikmal Azman on 04/11/2021.
//

import UIKit
import Lottie

class HomePageContainerVC: UIViewController {

    @IBOutlet var animationView: AnimationView!
    
    static let identifier = "HomePageContainerVC"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLottieView()
        animationView.play()
    }
    
    func configureLottieView(loopMode : LottieLoopMode = .loop, animationSpeed : CGFloat = 0.5, contentMode : UIView.ContentMode = .scaleAspectFill) {
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        animationView.contentMode = contentMode
    }
    


}
