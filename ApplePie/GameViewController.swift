//
//  GameViewController.swift
//  ApplePie
//
//  Created by TIEGO Ouedraogo on 1/22/19.
//  Copyright © 2019 TIEGO Ouedraogo. All rights reserved.
//“ word-guessing game, each player has a limited number of turns to guess the letters in a word. Each incorrect guess results in an apple falling off the tree. The player wins by guessing the word correctly before all the apples are gone.

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var listOfWords: [String] = [
        "buccaneer",
        "swift",
        "glorious",
        "incandescent",
        "bug",
        "program"
    ];
    //“The score label uses simple string interpolation to combine totalWins and totalLosses into a single string. Since each of the tree images are named "Tree X", where X is the number of moves remaining, you can use string interpolation once more to construct the image name”

    let incorrectMovesAllowed: Int = 7;
    var currentGame: Game!;
    
    var totalWins: Int = 0 {
        didSet {
            newRound();
        }
    }
    
    var totalLosses: Int = 0 {
        didSet {
            newRound();
        }
    }
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!    
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newRound()
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        sender.isEnabled = false
        
        //print("button was pressed")
        let letterString = sender.title(for: .normal)!
        //“be much easier to compare everything(letters) in lowercase,
        //and then convert it from a String to a Character.”
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateUI()//“this will handle the interface updates,”
    }
    
    //Begin First Round
    func newRound() {
        //“collection, and set incorrectMovesRemaining to the number of moves you allow, stored in incorrectMovesAllowed.
        if !listOfWords.isEmpty {
            let newWord: String = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining:
                incorrectMovesAllowed, guessedLetters: [Character]());
            enableLetterButtons(true);
            updateUI();//“this will handle the interface updates,”
            
            enableLetterButtons(false);
        } else {
        }
    }
    
    //“update the interface to reflect the new game. ”
    
    func updateUI() {
        let letters: [String] = currentGame.formattedWord.map {String($0)}
        //“joined(separator:) that operates on an array of strings. This function concatenates the collection of strings into one string, separated by a given value.”
        let wordWithSpacing: String = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing;
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    //“checks the game state to see if a win or loss has occurred, and if so, update totalWins and totalLosses. Create a method called updateGameState that will perform this work, and call it after each button press instead of calling updateUI().
    func updateGameState() {
        //“When incorrectMovesRemaining reaches 0, totalLosses should be incremented, and a new round should begin.”
        if currentGame.incorrectMovesRemaining == 0 { //“game is lost if incorrectMovesRemaining reaches 0.”
            totalLosses += 1 //     “lost, and if the current game's word property is equal to the formattedWord “ When it does, increment totalLosses. You can determine that a game has been won if the player has not yet ”
            
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1 //“If a game has not been won or lost yet, then the player should be allowed to continue guessing, and the interface should be updated.
        
        } else {
            updateUI()//“this will handle the interface updates,”
        }
    }
    //“It takes a Bool as an argument, and it uses the parameter to enable or disable the collection of buttons by looping through them.
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable;
        }
    }
}
