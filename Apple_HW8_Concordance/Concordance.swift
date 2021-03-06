////
////  Concordance.swift
////  Apple_HW8_Concordance
////
////  Created by Reid Nolan on 12/11/17.
////  Copyright © 2017 Reid Nolan. All rights reserved.
////
//
//import Foundation
//
////struct Concordance {
////    var word: Word
////
////    init(word: Word) {
////    }
////}
////
//////    struct sizeLess { //for maxLineLength function
//////        template<class T> bool operator()(T const &a, T const &b) const {//struct for maxLineLength
//////        return a.size() < b.size()
//////        }
//////    }
//
//func maxLineLength(wordInFile: [String]) -> Int { //users sizeLess struct
//    var str = wordInFile.max() //get length of longest word in array
//    print("str = \(String(describing: str))")
//    if(str == nil) {
//        str = "0"
//    }
//    return str!.count
//}
//
//func matchWords(wordList: inout [Word], wordInFile: inout [String], lineNumbers: inout [Int], lineNumbersList: inout [[Int]]) {
//    for (i, word) in wordList.enumerated() { //loop through words in array
//        if (i < wordList.count - 1) { //leave the last element alone...for now
//            if (wordList[i].getWordItself() == wordList[i + 1].getWordItself()) { //check if word matches next word
//                lineNumbers.append(wordList[i].getLineNumber()) //if word matches the next, only get line number and append to vector
//                continue
//            } else {
//                wordInFile.append(wordList[i].getWordItself()) //if word does not match the next word, get word aad line number and append to vector
//                lineNumbers.append(wordList[i].getLineNumber())
//                lineNumbersList.append(lineNumbers) //append line numbers for each word to another 2-d vector
//                //arrayDelete(lineNumbers) //reset line number array for next iteration
//            }
//        } else if (i == (wordList.count-1)) {//now we can take care of that last element
//            if (wordList[i].getWordItself() == wordList[i - 1].getWordItself()) { //if last word does matches the previous
//                wordInFile.append(wordList[i].getWordItself()) //if word matches the previous word, get word aad line number and append to vector
//                lineNumbers.append(wordList[i].getLineNumber())
//                lineNumbersList.append(lineNumbers) //append line numbers for each word to another 2-d vector
//                //arrayDelete(lineNumbers) //reset line number vector before leaving the function
//            } else {/*doNothing()*/}
//        } else {/*doNothing()*/ }
//    }
//}
//
//func showConcordance(wordInFile: [String], lineNumbers: [Int], lineNumbersList: [[Int]]) {
//    let firstColumnHeader: String = "Words" //define first column header
//    let secondColumnheader: String = "Count" //define third column header
//    let thirdColumnheader: String = "Line Numbers" //define second column header
//    let columnBreak: String = " | " //define column break
//    let elementDelim: String = ", " //define element delimiter
//    let maxQty: Int = 10 //set max qty for second column output
//    let columnBreakLength: Int = columnBreak.count //get length of column break string
//    var longestWordLength: Int = maxLineLength(wordInFile: wordInFile) //get length of longest word in vector
//    
//    if (firstColumnHeader.count > maxLineLength(wordInFile: wordInFile)) { //set width of first column accordingly
//        longestWordLength = firstColumnHeader.count
//    } else { /*doNothing()*/ }
//    
//    print("\\\\beginning of output\\\\")
//    print("\(longestWordLength)\(firstColumnHeader)\(columnBreak)\(secondColumnheader.count+1)\(secondColumnheader)\(columnBreak)\(thirdColumnheader)") //format column headers
//    
//    for (i, _) in wordInFile.enumerated() { //loop through vector for output
//        print("\(longestWordLength)\(wordInFile[i])\(columnBreak)\(lineNumbersList[i].count)\("x")\(columnBreak)") //set width of word colum to longest word length
//        for (j, _) in lineNumbersList.enumerated() { //loop thorough line number list
//            if (j < lineNumbersList[i].count - 1) { //for all but last line number in list
//                if (j >= 10 && j % maxQty == 0) { //format second column width by quantity
//                    print()
//                    print("\(longestWordLength)\(columnBreakLength * 2)\(secondColumnheader.count + 1) + \(" ")") //for shifting over line numbers to the right
//                } else { /*doNothing()*/ }
//                print("\(lineNumbersList[i][j]) + \(elementDelim)") //add delimiters between elements
//            } else { //for last element in vector
//                if (j >= 10 && j % maxQty == 0) { //format second column width by quantity
//                    print()
//                    print("\(longestWordLength)\(columnBreakLength * 2)\(secondColumnheader.count + 1) + \(" ")") //for shifting over line numbers to the right
//                } else { /*doNothing()*/ }
//                print(lineNumbersList[i][j]) //no delimiter for last element
//            }
//            print()
//        }
//        print("\\\\end of output\\\\")
//    }
//}
//
////    func saveConcordance(wordInFile: [String], lineNumbers: [Int], lineNumbersList: [[Int]], ofstream &outFile) -> Concordance {
////        let firstColumnHeader: String = "Words" //define first column header
////        let secondColumnheader: String = "Count" //define third column header
////        let thirdColumnheader: String = "Line Numbers" //define second column header
////        let columnBreak: String = " | " //define column break
////        let elementDelim: String = ", " //define element delimiter
////        let maxQty: Int = 10 //set max qty for second column output
////        var columnBreakLength: Int = columnBreak.count //get length of column break string
////        var longestWordLength: Int = maxLineLength(wordInFile: wordInFile) //get length of longest word in vector
////
////        if (firstColumnHeader.count > maxLineLength(wordInFile: wordInFile)) { //set width of first column accordingly
////            longestWordLength = firstColumnHeader.count
////        } else { /*doNothing()*/ }
////
////        outFile << endl << left << "\\\\beginning of file\\\\" << endl
////        outFile << setw(longestWordLength) << firstColumnHeader << columnBreak << setw(secondColumnheader.length() + 1) << secondColumnheader << columnBreak << thirdColumnheader << right << endl //format column headers
////
////        for i in wordInFile { //loop through vector for output
////            outFile << setw(longestWordLength) << wordInFile[i] << columnBreak << setw(secondColumnheader.length()) << lineNumbersList[i].size() << "x" << columnBreak //set width of word colum to longest word length
////            for j in lineNumbersList[i] { //loop thorough line number list
////                //cout << setw(0); //reset output width
////                if (j < lineNumbersList[i].size() - 1) { //for all but last line number in list
////                    if (j >= 10 && j % maxQty == 0) { //format second column width by quantity
////                        outFile << endl
////                        outFile << setw(longestWordLength + (columnBreakLength * 2) + secondColumnheader.length() + 1) << " " //for shifting over line numbers to the right
////                    } else { /*doNothing()*/ }
////                    outFile << lineNumbersList[i][j] << elementDelim //add delimiters between elements
////                } else {//for last element in vector
////                    if (j >= 10 && j % maxQty == 0) { //format second column width by quantity
////                        outFile << endl;
////                        outFile << setw(longestWordLength + (columnBreakLength * 2) + secondColumnheader.length() + 1) << " " //for shifting over line numbers to the right
////                    } else {/*doNothing()*/ }
////                    outFile << lineNumbersList[i][j] //no delimiter for last element
////                }
////            }
////            outFile << endl
////        }
////        outFile << left << "\\\\end of file\\\\"
////    }
////}

