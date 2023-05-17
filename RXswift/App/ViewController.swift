//
//  ViewController.swift
//  RXswift
//
//  Created by william torres dias dos santos on 26/04/23.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!

    override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
        animationView.contentMode = .scaleAspectFit

        animationView.loopMode = .loop

        animationView.animationSpeed = 0.5
        animationView.play()
   }

}

