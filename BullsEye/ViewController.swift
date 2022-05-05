//
//  ViewController.swift
//  BullsEye
//
//  Created by Алексей Моторин on 29.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var totalScore: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var randomValue: UILabel!
    @IBOutlet var overStartButton: UIButton!
    
    var score = 0
    var currentValue = 0
    var targerValue = 0
    var roundNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        targerValue = Int.random(in: 1...100)
        startOver()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImaheHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImaheHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftReziebale = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftReziebale, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightReziebale = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightReziebale, for: .normal)
    }

    @IBAction func showAlert() {
        let difference = abs(targerValue - currentValue)
        var points = 100 - difference
        var tittle: String = " "
        switch difference {
        case 0:
            tittle = "Идеально!\n + 100 очков"
            points += 100
        case 1:
            tittle = "Ты был так близок!\n + 50 очков"
            points += 50
        case 2...29:
            tittle = "Почти получилось!"
        case 30...79:
            tittle = "Ты можешь лучше!"
        case 80...99:
            tittle =  "Ну такое..."
        default:
            break
        }
        
        let message = "Загадано \(targerValue)\n Ваше число: \(currentValue)\n Вы заработали: \(points)"
        
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in self.startNewRound()
        } )
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        score += points
        
    }
        
    func changeSlider() {
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }
 
    @IBAction func sliderMoved(_ sender: Any) {
        changeSlider()
    }
    
    func updateValue() {
        randomValue.text = String(targerValue)
        totalScore.text = String(score)
        roundLabel.text = String(roundNumber)
    }
    
    func startNewRound() {
        targerValue = Int.random(in: 1...100)
        currentValue = Int(slider.value)
        roundNumber += 1
        updateValue()
    }
    
    
    @IBAction func startOver() {
        score = 0
        roundNumber = 0
        startNewRound()
    }
    
}

