//
//  ViewController.swift
//  Spinner
//
//  Created by Brando Flores on 12/10/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var boardImage: UIImageView!
    @IBOutlet weak var leftImage: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var rightImage: UILabel!
    var randomFloat: Float = 0.00
    @IBOutlet weak var spinButton: UIButton!
    var player: AVAudioPlayer?
    
    private var animator: UIViewPropertyAnimator?
    var isSpinning: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        boardImage.layer.borderWidth = 2
        boardImage.layer.masksToBounds = false
        boardImage.layer.borderColor = UIColor.black.cgColor
        boardImage.layer.cornerRadius = boardImage.frame.height/2
        boardImage.clipsToBounds = true
        leftImage.alpha = 0.10
        rightImage.alpha = 0.10
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        setButton()
        leftImage.alpha = 0.1
        rightImage.alpha = 0.1
        randomFloat = Float.random(in: 1..<1.5)
        print(randomFloat)
        //1.35
        let timer = Timer.scheduledTimer(timeInterval: TimeInterval(randomFloat), target: self, selector: #selector(setButton), userInfo: nil, repeats: false)
        stopSpin()
    }
    
    @objc private func spin() {
        if !spinButton.isEnabled {
            let randomInt = Int.random(in: 0..<4)
            
            if randomFloat > 1.35 {
                print("play slow")
                switch randomInt {
                case 0:
                    playSound(soundFileName: "slowSpin1")
                default:
                    playSound(soundFileName: "slowSpin1")
                }
            }
            else {
                print("play fast")
                switch randomInt {
                case 0:
                    playSound(soundFileName: "spin1")
                case 1:
                    playSound(soundFileName: "spin2")
                default:
                    playSound(soundFileName: "spin3")
                }
            }
        }
        let transform = arrowImage.layer.presentation()!.transform
        arrowImage.layer.removeAllAnimations()
        arrowImage.layer.transform = transform
        
    }
    
    private func flashLeftRight() {
        
    }
    
    private func setLeftRight() {
        let randomInt = Int.random(in: 0...1)
        switch randomInt {
        case 0:
            leftImage.alpha = 1.0
        case 1:
            rightImage.alpha = 1.0
        default:
            print("Unable to set state")
        }
    }
    
    @objc private func stopSpin() {
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.byValue = 10 * CGFloat.pi
        rotate.duration = 1
        rotate.repeatCount = .greatestFiniteMagnitude
        arrowImage.layer.add(rotate, forKey: nil)
        
    }
    
    @objc private func setButton() {
        spinButton.isEnabled = !spinButton.isEnabled
        spin()
        setLeftRight()
        //playSound(soundFileName: "simonSound")
    }
    
    private func playSound(soundFileName: String) {
        guard let url = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
}
