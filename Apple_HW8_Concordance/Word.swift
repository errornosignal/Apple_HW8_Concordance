//
//  Word.swift
//  Apple_HW8_Concordance
//
//  Created by Reid Nolan on 12/11/17.
//  Copyright © 2017 Reid Nolan. All rights reserved.
//

import Foundation

//Word struct
struct Word {
    //class variables
    var wordItself: String?
    var frequency: Int?
    var lineNumber: Int?
    
    init (wordItself: String, frequency: Int, lineNumber: Int) {
        self.wordItself = wordItself
        self.frequency = frequency
        self.lineNumber = lineNumber
    }

    //setters
    mutating func setWordItself(nextWord: String) {
        wordItself = nextWord
    }
    mutating func setLineNumber(j: Int) {
        lineNumber = j
    }

    //getters
    func getWordItself() -> String {
        return wordItself!
    }
    func getLineNumber() -> Int {
        return lineNumber!
    }

    //other struct functions
    func parseOutWords(word: Word, book: [String], wordList: [Word])
    {
        for i in book {                             //loop through lines elements in vector
            if (!book[i].empty()) {                                            //test for contenct
                stringstream ss(book[i])                                       //declare and initialize local variables
                var wordString: String = ""
                while (getline(ss, wordString, " ")) {                         //separate word in lines
                    self.handleAccentedChar(wordString: wordString)                 //handle the french in Sherlock.txt
                    if (!wordString.empty()) {                                 //checks for non-empty string
                        removeLeadingPunct(wordString: wordString)                  //recursively removes leading punctiation from string
                        if (!wordString.empty()) {                             //checks for non-empty string
                            self.removeTrailingPunct(wordString: wordString)        //recursively removes trailing punctiation
                            for j in wordString { //loops through string
                                wordString[j] = tolower(wordString[j])         //converts string to lower case
                            }
                            word.setWordItself(wordString)                     //set string value to word object
                            word.setLineNumber(i + 1)                          //set line number value to word object
                            wordList.push_back(word)                           //add object to list
                        } else { /*doNothing()*/ }
                    }
                }
            } else { /*doNothing()*/ }
        }
    }

    func handleAccentedChar(wordString: String) {           //specifically for the accented French characters in Sherlock.txt
        for j in wordString {  //loop through string elemets
            if ((wordString[j] == -61)) {                   //if const char[2] 'è' is hit...
                wordString[j] = "e"                         //...then, set to 'e'
                wordString[j + 1] = " "                     //...then, clear the addional char at the end
                wordString.pop_back()                       //...finally, just to be sure
            } else { /*doNothing()*/ }
        }
    }

    func removeLeadingPunct(wordString: String) {
        if (!isalnum(wordString.first)){                             //if first char ispunct, the opposite of isalnum...
            wordString.erase(wordString.begin())                  //...then, remove that char
            if (!wordString.isEmpty 0 && !isalnum(wordString.first)) { //if string is not empty and the first char is not punct...
                removeLeadingPunct(wordString: wordString)                    //...then, get recursive on it
            }
        } else { /*doNothing()*/ }
    }

    func removeTrailingPunct(wordString: String) {
        if (!isalnum(wordString[wordString.count - 1])) {                //if last char ispunct, the opposite of isalnum...
            wordString.pop_back()                                           //...then, remove that char
            if (!wordString.isEmpty && !isalnum(wordString.count - 1)) { //if string is not empty and the last char is not punct...
                removeTrailingPunct(wordString: wordString)                 //...then, get recursive on it
            }
        } else { /*doNothing()*/ }
    }
}
