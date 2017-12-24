//
//  CardViewController.swift
//  Psychic
//
//  Created by Hassan Ahmed on 2017-12-24.
//  Copyright © 2017 luminix. All rights reserved.
//

import UIKit
import GameplayKit

class CardViewController: UIViewController {

    weak var delegate: ViewController!
    
    var frontImageView: UIImageView!
    var backImageView: UIImageView!
    
    var isCorrect = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.bounds = CGRect(x: 0, y: 0, width: 100, height: 140)
        frontImageView = UIImageView(image: UIImage(named: "cardBack"))
        backImageView = UIImageView(image: UIImage(named: "cardBack"))
        
        view.addSubview(frontImageView)
        view.addSubview(backImageView)
        
        frontImageView.isHidden = true
        backImageView.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            self.backImageView.alpha = 1
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
        backImageView.isUserInteractionEnabled = true
        backImageView.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func cardTapped() {
        delegate.cardTapped(self)
    }
    

    @objc func wasntTapped() {
        UIView.animate(withDuration: 0.7) {
            self.view.transform = CGAffineTransform(scaleX: 0.00001, y: 0.00001)
            self.view.alpha = 0
        }
    }

    func wasTapped() {
        UIView.transition(with: view, duration: 0.7, options: [.transitionFlipFromRight], animations: { [unowned self] in
            self.backImageView.isHidden = true
            self.frontImageView.isHidden = false
        })
    }
    
    @objc func wiggle() {
        if GKRandomSource.sharedRandom().nextInt(upperBound: 4) == 1 {
            UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: {
                self.backImageView.transform = CGAffineTransform(scaleX: 1.01, y: 1.01)
            }) { _ in
                self.backImageView.transform = CGAffineTransform.identity
            }
            
            perform(#selector(wiggle), with: nil, afterDelay: 8)
        } else {
            perform(#selector(wiggle), with: nil, afterDelay: 2)
        }
    }
}
