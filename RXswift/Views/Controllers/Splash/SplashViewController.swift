//
//  SplashViewController.swift
//  RXswift
//
//  Created by william torres dias dos santos on 17/05/23.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
         // 1. Set animation content mode
         view.backgroundColor = .darkBackground
         animationView.contentMode = .scaleAspectFit

         // 2. Set animation loop mode

         animationView.loopMode = .loop

         // 3. Adjust animation speed

         animationView.animationSpeed = 0.5

         // 4. Play animation
         animationView.play()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.animationView.stop()
            self.navigationController?.pushViewController(AuthViewController(), animated: true)
        }
    }

}
