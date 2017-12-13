////
////  Word.swift
////  Apple_HW8_Concordance
////
////  Created by Reid Nolan on 12/11/17.
////  Copyright © 2017 Reid Nolan. All rights reserved.
////
//
//import Foundation
//
//var wordString: [String] = []
//
////Word struct
//struct Word {
//    //struct variables
//    var wordItself: String
//    var frequency: Int
//    var lineNumber: Int
//    
//    init (wordItself: String = "",
//          frequency: Int = 0,
//          lineNumber: Int = 0) {
//        
//        self.wordItself = wordItself
//        self.frequency = frequency
//        self.lineNumber = lineNumber
//    }
//    
//    var wordList: [Word] = []
//    //var wordString: [String] = []
//    //wordList = [Word]()
//    
//
//    //setters
//    mutating func setWordItself(nextWord: String) {
//        self.wordItself = nextWord
//    }
//    mutating func setLineNumber(j: Int) {
//        self.lineNumber = j
//    }
//
//    //getters
//    func getWordItself() -> String {
//        return wordItself
//    }
//    func getLineNumber() -> Int {
//        return lineNumber
//    }
//}
//
//    //other struct functions
//    func parseOutWords(book: inout [String], wordList: inout [Word]) {
//        var stringToAdd: String = ""
//        var word: Word = Word()
//        for (i, _) in book.enumerated() {                                              //loop through lines elements in array
//            if (!book[i].isEmpty) {                                                    //test for content
//                
//                var str1 = book[i]
//                //print(str1)
//                str1 = str1.trimmingCharacters(in: .controlCharacters)
//                //print(str1)
//                wordString = str1.components(separatedBy: " ")
//                word.setLineNumber(j: i + 1)
//                for word in wordString{
//                    stringToAdd = word.trimmingCharacters(in: .punctuationCharacters).lowercased()
//                    setWordItself(nextWord: stringToAdd)
//                    print(getWordItself())
//                    print(word.getLineNumber())
//                    wordList.append(word.wordItself: word.getWordItself(), frequency: 0, lineNumber: word.getLineNumber()))
//            
//                
//                
////                //wordString = wordString.replacingOccurrences(of: "è", with: "e", options: .literal, range: nil)
////                //wordString = String(describing: wordString.
////                print("wordString = \(wordString)")
////                print(wordString[0])
////                print(wordString[1])
////
//////                var bookLine = String(book[i]
//////                wordString = bookLine.components(separatedBy: .whitespaces).filter{ !$0.isEmpty };
//////                for (i, line) in wordString.enumerated() {
//////                    let lineNumber = i + 1 // We do this because the array is 0 based, but that's not how books work.
//////                    line.words.forEach { word in
//////                        if var index = concordance[word] {
//////                            index.append(lineNumber)
//////                            concordance.updateValue(index, forKey: word)
//////                        } else {
//////                            concordance[word] = [lineNumber]
//////                        }
//////                    }
//////                }
////
////
////                for word in wordString{
////                    print(word)
////                }
////
////                //wordString = wordString.trimmingCharacters(in: .punctuationCharacters)
////
////                if (!wordString.isEmpty) {                                 //checks for non-empty string
////
////                    if (!wordString.isEmpty) {                             //checks for non-empty string
////                        //
////                        //wordString = String(wordString.lowercased())               //converts string to lowercase
////                        //for word in wordString {
////                            //setWordItself(nextWord: wordString)           //set string value to word object
////                            setLineNumber(j: i + 1) //set line number value to word object
////                            print("getWordItself(): \(getWordItself())")
////                            print("getLineNumber(): \(getWordItself())")
////                            print("word: \(word)")
////                            wordList.append(Word(wordItself: getWordItself(), frequency: 0, lineNumber: getLineNumber()))
//
//                       // } //else { /*doNothing()*/ }
//                    //} else { /*doNothing() */ }
//                }
//            //} else { /*doNothing()*/ }
//            }
//        }
//    }
//
//    func handleAccentedChar(wordString: String) -> String {           //specifically for the accented French characters in Sherlock.txt
//        let newString = wordString.replacingOccurrences(of: "è", with: "e", options: .literal, range: nil)
//        
//        print("accented: \(newString)")
//        return newString
//    }
//
//    func removeLeadingPunct(wordString: String) -> String {
//        var trimmed =  wordString.trimmingCharacters(in: NSCharacterSet.punctuationCharacters).trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
//        trimmed = trimmed.trimmingCharacters(in: NSCharacterSet.controlCharacters)
//        print("trimmed: \(trimmed)")
//        return trimmed
//    }
//
//    func removeTrailingPunct(wordString: String) -> String {
//        let trimmed =  wordString.trimmingCharacters(in: NSCharacterSet.punctuationCharacters)
//        print("trimmed: \(trimmed)")
//        return trimmed
//    }
//
////extension String {
////
////    subscript (i: Int) -> Character {
////        return self[index(startIndex, offsetBy: i)]
////    }
////
////    subscript (i: Int) -> String {
////        return String(self[i] as Character)
////    }
////
////    subscript (r: Range<Int>) -> String {
////        let start = index(startIndex, offsetBy: r.lowerBound)
////        let end = index(startIndex, offsetBy: r.upperBound)
////        return String(self[Range(start ..< end)])
////    }
////}
//
//
//extension Word: Equatable {
//    static func ==(lhs: Word, rhs: Word) -> Bool {
//        return (lhs.wordItself, lhs.lineNumber) == (rhs.wordItself, rhs.lineNumber)
//    }
//}
//
//extension Word: Comparable {
//    static func <(lhs: Word, rhs: Word) -> Bool {
//        return (lhs.wordItself, lhs.lineNumber) < (rhs.wordItself, rhs.lineNumber)
//    }
//}
//
