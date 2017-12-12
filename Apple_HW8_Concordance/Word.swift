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
    //struct variables
    var wordItself: String
    var frequency: Int
    var lineNumber: Int
    
    init (wordItself: String = "",
          frequency: Int = 0,
          lineNumber: Int = 0) {
        
        self.wordItself = wordItself
        self.frequency = frequency
        self.lineNumber = lineNumber
    }
    
    var wordList: [Word] = []
    var wordString: String = ""

    //setters
    mutating func setWordItself(nextWord: String) {
        self.wordItself = nextWord
    }
    mutating func setLineNumber(j: Int) {
        self.lineNumber = j
    }

    //getters
    func getWordItself() -> String {
        return wordItself
    }
    func getLineNumber() -> Int {
        return lineNumber
    }

    //other struct functions
    mutating func parseOutWords(word: Word, book: [String], wordList: [Word]) {
        for (i, _) in book.enumerated() {                             //loop through lines elements in vector
            if (!book[i].isEmpty) {                                            //test for content
                stringstream ss(book[i])                                       //declare and initialize local variables
                
                while (getline(ss, wordString, " ")) {                         //separate word in lines
                    self.handleAccentedChar(wordString: wordString)                 //handle the french in Sherlock.txt
                    if (!wordString.isEmpty) {                                 //checks for non-empty string
                        removeLeadingPunct(wordString: wordString)                  //recursively removes leading punctiation from string
                        if (!wordString.isEmpty) {                             //checks for non-empty string
                            self.removeTrailingPunct(wordString: wordString)        //recursively removes trailing punctiation
                            for (j, _) in wordString.enumerated() { //loops through string
                                wordString[j] = tolower(wordString[j])         //converts string to lower case
                            }
                            self.setWordItself(nextWord: wordString)                     //set string value to word object
                            setLineNumber(j: i + 1)                          //set line number value to word object
                            self.wordList.append(word)                           //add object to list
                        } else { /*doNothing()*/ }
                    }
                }
            } else { /*doNothing()*/ }
        }
    }

    func handleAccentedChar(wordString: String) {           //specifically for the accented French characters in Sherlock.txt
        for (j, e) in wordString.enumerated() {
            //loop through string elemets
            if let i = wordString.index(of: "è") { //if const char[2] 'è' is hit...
                let replacementE = "e"             //replace with "e"
                wordString = wordString[wordString.startIndex ..< wordString.endIndex.advancedBy(-1)] //...then, set to 'e'
                
                                                //...then, clear the addional char at the end
                wordString.count - 1                       //...finally, just to be sure
            } else { /*doNothing()*/ }
        }
    }

    func removeLeadingPunct(wordString: String) {
        if (!isalnum(wordString[0])){                             //if first char ispunct, the opposite of isalnum...
            String(wordString.removeFirst())                  //...then, remove that char
            if (!wordString.isEmpty && !isalnum(wordString[0])) { //if string is not empty and the first char is not punct...
                removeLeadingPunct(wordString: wordString)                    //...then, get recursive on it
            }
        } else { /*doNothing()*/ }
    }

    func removeTrailingPunct(wordString: String) {
        if (!isalnum(wordString[wordString.count - 1])) {                //if last char ispunct, the opposite of isalnum...
            String(wordString.removeFirst())                                          //...then, remove that char
            if (!wordString.isEmpty && !isalnum(wordString.count - 1)) { //if string is not empty and the last char is not punct...
                removeTrailingPunct(wordString: wordString)                 //...then, get recursive on it
            }
        } else { /*doNothing()*/ }
    }
}

//extension String {
//
//    subscript (i: Int) -> Character {
//        return self[index(startIndex, offsetBy: i)]
//    }
//
//    subscript (i: Int) -> String {
//        return String(self[i] as Character)
//    }
//
//    subscript (r: Range<Int>) -> String {
//        let start = index(startIndex, offsetBy: r.lowerBound)
//        let end = index(startIndex, offsetBy: r.upperBound)
//        return String(self[Range(start ..< end)])
//    }
//}


extension Word: Equatable {
    static func ==(lhs: Word, rhs: Word) -> Bool {
        return (lhs.wordItself, lhs.lineNumber) == (rhs.wordItself, rhs.lineNumber)
    }
}

extension Word: Comparable {
    static func <(lhs: Word, rhs: Word) -> Bool {
        return (lhs.wordItself, lhs.lineNumber) < (rhs.wordItself, rhs.lineNumber)
    }
}

