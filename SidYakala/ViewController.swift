//
//  ViewController.swift
//  SidYakala
//
//  Created by Fırat İlhan on 18.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var counter = 0
    var score = 0
    var hideTimer = Timer()
    var HighScore = 0
    var sidArray = [UIImageView]()
    
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var sid1: UIImageView!
    @IBOutlet weak var sid2: UIImageView!
    @IBOutlet weak var sid3: UIImageView!
    @IBOutlet weak var sid4: UIImageView!
    @IBOutlet weak var sid5: UIImageView!
    @IBOutlet weak var sid6: UIImageView!
    @IBOutlet weak var sid7: UIImageView!
    @IBOutlet weak var sid8: UIImageView!
    @IBOutlet weak var sid9: UIImageView!
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let storedHighScore = UserDefaults.standard.object(forKey: "HighScore")
        if storedHighScore == nil {
            HighScore = 0
            highScoreLabel.text = "HighScore: \(HighScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            HighScore = newScore
            highScoreLabel.text = "HighScore: \(HighScore)"
        }

    }
    
    @objc func hideSid(){
        
        for sid in sidArray{
            sid.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(sidArray.count - 1)))
        sidArray[random].isHidden = false
    }
    
    @objc func increaseScore() {
        
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
           
            timer.invalidate()
            hideTimer.invalidate()
            self.buttonLabel.isHidden = false
            
            for sid in sidArray{
                sid.isHidden = true
            }
            
            if self.score > self.HighScore {
                self.HighScore = self.score
                highScoreLabel.text = "HighScore: \(self.HighScore)"
                UserDefaults.standard.set(self.HighScore, forKey: "HighScore") //veritabanına kaydediyoruz.
            }
            
            let alert = UIAlertController(title: "Süre Bitti", message: "Tekrar Oynamak İster misin?", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Tamam", style: .default) { (UIAlertAction) in
                self.sidiGor() }
            let replayButton = UIAlertAction(title: "Tekrar Oyna", style: .default) { (UIAlertAction) in
                self.tekrarOyna()
            }

            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func startButton(_ sender: Any) {
       
        if score > 0 {
            self.tekrarOyna()
        } else {
            self.ilkOyun()
        }
    }
    
    func tekrarOyna() {
        
        self.buttonLabel.isHidden = true
        self.score = 0
        self.scoreLabel.text = "Score: \(self.score)"
        self.counter = 30
        self.timeLabel.text = String(self.counter)
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
        self.hideTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.hideSid), userInfo: nil, repeats: true)
        
    }
    
    func ilkOyun() {
        
        buttonLabel.isHidden = true
        counter = 30
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(hideSid), userInfo: nil, repeats: true)
        
        sid1.isUserInteractionEnabled = true
        sid2.isUserInteractionEnabled = true
        sid3.isUserInteractionEnabled = true
        sid4.isUserInteractionEnabled = true
        sid5.isUserInteractionEnabled = true
        sid6.isUserInteractionEnabled = true
        sid7.isUserInteractionEnabled = true
        sid8.isUserInteractionEnabled = true
        sid9.isUserInteractionEnabled = true
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        sid1.addGestureRecognizer(recognizer1)
        sid2.addGestureRecognizer(recognizer2)
        sid3.addGestureRecognizer(recognizer3)
        sid4.addGestureRecognizer(recognizer4)
        sid5.addGestureRecognizer(recognizer5)
        sid6.addGestureRecognizer(recognizer6)
        sid7.addGestureRecognizer(recognizer7)
        sid8.addGestureRecognizer(recognizer8)
        sid9.addGestureRecognizer(recognizer9)
        sidArray = [sid1,sid2,sid3, sid4, sid5, sid6, sid7, sid8, sid9]
    }
    
    func sidiGor() {
        
        for sid in sidArray{
            sid.isHidden = false
        }
        timer.invalidate()
        
    }
}

