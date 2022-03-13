//
//  ViewController.swift
//  CatchTheSwiftLogo
//
//  Created by Furkan Sarı on 13.03.2022.
//

import UIKit

class ViewController: UIViewController {
    var timer = Timer()
    var counter = 10
    var score=0
    var highScore:Int = 0
    let newScore = UserDefaults.standard.integer(forKey: "highscore")
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var swiftImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scoreLabel.text = "Score : \(score)"
        timerLabel.text="Time : \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        swiftImage.isUserInteractionEnabled=true
        let imageClicked = UITapGestureRecognizer(target: self, action: #selector(swiftPoint))
        swiftImage.addGestureRecognizer(imageClicked)
        
        highScoreLabel.text="Highscore : \(newScore)"
        
        
        
        
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
                alertFunc()
            }
            
            
            
        }
        
        
        
    }
    @objc func swiftPoint(){
        
        score += 1
        scoreLabel.text="Score : \(score)"
    }
    func alertFunc() {
        let alert = UIAlertController(title: "Game Over!", message: "Time's up!", preferredStyle: UIAlertController.Style.alert)
        let quitButton=UIAlertAction(title: "Quit", style: UIAlertAction.Style.default, handler: nil)
        let replayButton=UIAlertAction(title: "Replay", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(quitButton)
        alert.addAction(replayButton)
        self.present(alert, animated: true, completion: nil)
    }


}

