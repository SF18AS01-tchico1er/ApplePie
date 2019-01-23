//
//  Game.swift
//  ApplePie
//
//  Created by TIEGO Ouedraogo on 1/22/19.
//  Copyright © 2019 TIEGO Ouedraogo. All rights reserved.
//

import Foundation
import UIKit
struct Game {
    let word: String;
    var incorrectMovesRemaining: Int;
    //“tracking of the selected letters”
    var guessedLetters: [Character];
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter);
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1;
        }
    }
    //compute property
    //“Begin with an empty string variable”
    //“Loop through each character of word.
    //If the character is in guessedLetters, convert it to a string, then append the letter onto the variable.
   // Otherwise, append _ onto the variable.”
    
    var formattedWord: String {
        var guessedWord: String = "";
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)";
            } else {
                guessedWord += "_";
            }
        }
        return guessedWord;
    }
};





