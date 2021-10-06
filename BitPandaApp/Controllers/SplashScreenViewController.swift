//
//  SplashScreenViewController.swift
//  BitPandaApp
//
//  Created by Sergi Exposito on 3/10/21.
//

import UIKit
import Lottie

class SplashScreenViewController: UIViewController {

    
    @IBOutlet weak var viewAnimation: UIView!
    
    private var progressBar: AnimationView?
    private var progress = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      }
    
    private func configureViews(){
        progressBar = .init(name: "animation")
        progressBar?.frame = viewAnimation.bounds
        progressBar?.contentMode = .scaleAspectFit
        progressBar?.loopMode = .loop
        self.progressBar?.play(toProgress: CGFloat(1))
        
        if let loadingAnimation = progressBar{
            viewAnimation.addSubview(loadingAnimation)
        }
    }
    
    private func loadData(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.performSegue(withIdentifier: "FROM_SPLASH_TO_MAIN", sender: nil)
        }
    }

        
    
    
    
}
