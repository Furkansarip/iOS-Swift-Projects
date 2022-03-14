//
//  ViewController.swift
//  CatchTheSwiftLogo
//
//  Created by Furkan Sarı on 13.03.2022.
//

import UIKit

class ViewController: UIViewController {
    var timerForImage = Timer()
    var timer = Timer()
    var counter = 10
    var score=0
    var highScore:Int = 0
    let newScore = UserDefaults.standard.integer(forKey: "highscore")
    var swiftLogoArray=[UIImageView]()
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var swiftImage: UIImageView!
    @IBOutlet weak var swiftImage2: UIImageView!
    @IBOutlet weak var swiftImage3: UIImageView!
    @IBOutlet weak var swiftImage4: UIImageView!
    @IBOutlet weak var swiftImage5: UIImageView!
    @IBOutlet weak var swiftImage6: UIImageView!
    @IBOutlet weak var swiftImage7: UIImageView!
    @IBOutlet weak var swiftImage8: UIImageView!
    @IBOutlet weak var swiftImage9: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.text = "Score : \(score)"
        timerLabel.text="Time : \(counter)"
        
        
        swiftImage.isUserInteractionEnabled=true
        swiftImage2.isUserInteractionEnabled=true
        swiftImage3.isUserInteractionEnabled=true
        swiftImage4.isUserInteractionEnabled=true
        swiftImage5.isUserInteractionEnabled=true
        swiftImage6.isUserInteractionEnabled=true
        swiftImage7.isUserInteractionEnabled=true
        swiftImage8.isUserInteractionEnabled=true
        swiftImage9.isUserInteractionEnabled=true
        
        let imageClicked = UITapGestureRecognizer(target: self, action: #selector(swiftPoint))
        let image2Clicked = UITapGestureRecognizer(target: self, action: #selector(swiftPoint))
        let image3Clicked = UITapGestureRecognizer(target: self, action: #selector(swiftPoint))
        let image4Clicked = UITapGestureRecognizer(target: self, action: #selector(swiftPoint))
        let image5Clicked = UITapGestureRecognizer(target: self, action: #selector(swiftPoint))
        let image6Clicked = UITapGestureRecognizer(target: self, action: #selector(swiftPoint))
        let image7Clicked = UITapGestureRecognizer(target: self, action: #selector(swiftPoint))
        let image8Clicked = UITapGestureRecognizer(target: self, action: #selector(swiftPoint))
        let image9Clicked = UITapGestureRecognizer(target: self, action: #selector(swiftPoint))
        
        swiftImage.addGestureRecognizer(imageClicked)
        swiftImage2.addGestureRecognizer(image2Clicked)
        swiftImage3.addGestureRecognizer(image3Clicked)
        swiftImage4.addGestureRecognizer(image4Clicked)
        swiftImage5.addGestureRecognizer(image5Clicked)
        swiftImage6.addGestureRecognizer(image6Clicked)
        swiftImage7.addGestureRecognizer(image7Clicked)
        swiftImage8.addGestureRecognizer(image8Clicked)
        swiftImage9.addGestureRecognizer(image9Clicked)
        
        highScoreLabel.text="Highscore : \(newScore)"
        
        swiftLogoArray = [swiftImage,swiftImage2,swiftImage3,swiftImage4,swiftImage5,swiftImage6,swiftImage7,swiftImage8,swiftImage9]
        timerForImage=Timer.scheduledTimer(timeInterval: 0.5, target:self, selector: #selector(randomImage), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        for swiftLogo in swiftLogoArray{
            swiftLogo.isHidden=true
        }
        
        
        
        
    }
    @objc func timerFunc(){
        
        
        timerLabel.text="Time : \(counter)"
        counter -= 1
        if counter==0{
            timerLabel.text="Time's Over!"
            if score >= highScore{
                highScore=score
                if highScore > newScore{
                    highScoreLabel.text="Highscore : \(highScore)"
                    UserDefaults.standard.set(highScore,forKey: "highscore")
                }

                timer.invalidate()
                timerForImage.invalidate()
                alertFunc()
            }
        }
        
    }
    @objc func randomImage(){
        for swiftLogo in swiftLogoArray{
            swiftLogo.isHidden=true
        }
        let random = Int(arc4random_uniform(UInt32(swiftLogoArray.count - 1)))
        swiftLogoArray[random].isHidden=false
        
        
    }
    @objc func swiftPoint(){
        
        score += 1
        scoreLabel.text="Score : \(score)"
    }
    func alertFunc() {
        let alert = UIAlertController(title: "Game Over!", message: "Time's up!", preferredStyle: UIAlertController.Style.alert)
        let quitButton=UIAlertAction(title: "Quit", style: UIAlertAction.Style.default) { UIAlertAction in
            exit(0)
        }
        let replayButton=UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self] UIAlertAction in
            self.score=0
            self.counter=10
            timerLabel.text="Time : \(counter)"
            scoreLabel.text="Score : \(score)"
            timerForImage=Timer.scheduledTimer(timeInterval: 0.5, target:self, selector: #selector(randomImage), userInfo: nil, repeats: true)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
            
        }
        
        alert.addAction(quitButton)
        alert.addAction(replayButton)
        self.present(alert, animated: true, completion: nil)
    }


}

