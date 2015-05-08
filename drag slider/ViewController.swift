//
//  ViewController.swift
//  BullsEye
//
//  Created by zhaoxuyi on 15/4/26.
//  Copyright (c) 2015年 zhaoxuyi. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

class ViewController: UIViewController
{
    
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    var audioPlayer: AVAudioPlayer!
    var currentValue = 50
    var targetValue = 0
    var score = 0
    var round = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        playBgMusic()
        startNewGame()
        updateLabels()
        //set style of slider
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState:  .Normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        
        //let trackLeftResizable = trackLeftImage.resizableImageWithCapInsets(insets)
        
        //slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")
        
        //let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
        
        //slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert()
    {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        var title: String
        if difference == 0
        {
            title = "unbelievable！你可以买彩票去了！额外奖励100分数！"
            points += 100
            
        
        }
        else if difference < 5
        {
            title = "貌似还不错！来，赏50分"
            points += 50
        }
        else if difference < 10
        {
            title = "可以嘛～"
        }else {title = "就这水平你还敢来玩耍。。？"}
        
        score += points
        let message = "大侠，你的得分是：\(points)"
        
        //let message = "滑动条的数值是: \(currentValue)"
                     //+ "\n目标数值是: \(targetValue)"
                     //+ "\n差值是: \(difference)"
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .Alert)
        let action = UIAlertAction(title: "爱卿辛苦了",
                                   style: .Default,
                                        handler:
                                        {
                                        action in
                                        self.startNewRound()
                                        self.updateLabels()
                                        }
                                   )
        alert.addAction(action)
        presentViewController(alert,animated: true, completion: nil)
    }
    @IBAction func sliderMoved(slider: UISlider)
    {
            // println("滑动条的当前数值是: \(slider.value)") 
            currentValue = lroundf(slider.value)
    
    }
    @IBAction func startOver()
    {
        startNewGame()
        updateLabels()
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
    }
    func startNewRound()
    {
                round += 1
                targetValue = 1 + Int(arc4random_uniform(100))
                currentValue = 50
                slider.value = Float(currentValue)
    }
    func startNewGame()
                {
                    score = 0
                    round = 0
                    startNewRound()
                }
    func updateLabels()
    {
                    targetLabel.text = String (targetValue)
                    scoreLabel.text = String(score)
                    roundLabel.text = String(round)
    }
    func playBgMusic()
    {
        let musicPath = NSBundle.mainBundle().pathForResource("bgmusic", ofType: "mp3")
        let url = NSURL(fileURLWithPath: musicPath!)
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: nil)
        audioPlayer.numberOfLoops = -1
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
                
    
}

