//
//  ViewController.swift
//  Bullseye
//
//  Created by Tahmina on 21/06/23.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var guessingLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var rulesLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var whiteView: UIView!
    
    let gameManager = GameManager()


    override func viewDidLoad() {
        super.viewDidLoad()

        //CA Layer

        whiteView.layer.cornerRadius = 15
        whiteView.layer.borderWidth = 5
        whiteView.layer.borderColor = UIColor.white.cgColor

        //UI view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleButtonTap))
        let thumbImage = UIImage(named: "nub")
        slider.setThumbImage(thumbImage, for: .normal)

        rulesLabel.text = rulesLabel.text?.uppercased()
        updateLabels()
    }
     @IBAction func handleButtonTap(_ sender: Any) {
            print(slider.value)

            // Начисление баллов
            let selectedNumber = Int(slider.value)
            if selectedNumber == gameManager.guessingNumber {
                print("Вы угадали число")
                gameManager.score = gameManager.score + 100 // gameManager.score += 100 // -= /= *=
            } else if abs(gameManager.guessingNumber - selectedNumber) <= 10 {
                gameManager.score += 50
            } else {
                print("Попробуйте еще раз")
            }

            // Проверка на конец игры
            if gameManager.round < 10 {
                gameManager.nextRound()
            } else {
                showGameOverAlert()
            }

            updateLabels()
        }

        func updateLabels() {
            guessingLabel.text = String(gameManager.guessingNumber)
            roundLabel.text = String(gameManager.round)
            scoreLabel.text = String(gameManager.score)
        }

        func showGameOverAlert() {
            let myAlert = UIAlertController(title: "Game Over", message: "Заработанные очки: \(gameManager.score).\nНачать новую игру?", preferredStyle: .alert)

            let handler: ((UIAlertAction) -> Void)? = { action in
                print("стартуем новую игру")
                self.gameManager.startNewGame()
                self.updateLabels()
            }
            let action = UIAlertAction(title: "Начать", style: .default, handler:  handler)
            myAlert.addAction(action)

            let cancelAction = UIAlertAction(title: "Закончить игру", style: .cancel)
            myAlert.addAction(cancelAction)

            show(myAlert, sender: self)
        }
    }
