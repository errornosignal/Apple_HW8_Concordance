//
//  main.swift
//  Apple_HW8_Concordance
//
//  Created by Reid Nolan on 12/9/17.
//  Copyright © 2017 Reid Nolan. All rights reserved.
//

import Foundation

var book: [String] = [] //create array to store contents of input file
var wordInFile: [String] =  []

struct Word {
    var wordItself: String //{
//        set { self.wordItself = wordItself }
//        get { return self.wordItself }
   // }
    var frequency: Int //{
//        set { self.frequency = frequency }
//        get { return self.frequency }
   // }
    var lineNumber: Int //{
//        set { self.lineNumber = lineNumber}
//        get { return self.lineNumber}
    //}
    
    init (wordItself: String = "",
          frequency: Int = 0,
          lineNumber: Int = 0) {
        
        self.wordItself = wordItself
        self.frequency = frequency
        self.lineNumber = lineNumber
    }
    
    //getters
    func getWordItself() -> String {
        return wordItself
    }
    func getLineNumber() -> Int {
        return lineNumber
    }
    
    class Point {
        private var _x: Int = 0             // _x -> backingX
        var x: Int {
            set { _x = 2 * newValue }
            get { return _x / 2 }
        }
    }
    
    
    
}

var word: Word = Word()
var wordList: [Word] = []

//validateStringInput
func getConsoleInput_string(prompt: String) -> String {
    while (true) {
        print(prompt)
        let userInput = readLine()!
        if(!userInput.isEmpty) {
            return userInput
        } else {
            print("Error! No Input.")
        }
    }
}

func displayBook(book: [String]) {
    print("\\\\begininng of file\\\\")
    for (i, _) in book.enumerated() {
        print((i + 1), "| ", (book[i]))
    }
    print("\\\\end of file\\\\")
}

func displayProgramHeader() {
    print("// Reid_Nolan_HW8_[Concordance].cpp\n")
}

func displayMainMenu() {
        print("---------------Main Menu---------------")
        print("1. Select a text file to load into memory.")
        print("2. View the current text file with line numbers.")
        print("3. Create concordance for the current text file.")
        print("4. View the current concordance.")
        print("5. Save the current concordance to disk.")
        print("0. Exit Concordance.exe.")
}

func mainMenuSelectionPrompt() -> String {
    return "Make a selection>"
}

func fileSelectionPrompt() -> String {
    return "Enter name of file to open>"
}

func displayLoadingFile(fileToOpen: String) {
    print("Loading \(fileToOpen) into memory..")
}

func displayLoadedFile(fileToOpen:String) {
    print("Successfully loaded \(fileToOpen) into memory...")
}

func displayNoInputFile(fileToOpen: String) {
    print("Error! \(fileToOpen) could not be opened.")
    print("-Ensure that \(fileToOpen) has been placed in the current")
    print(" working directory and is not open in another program.")
}

func displayInvalidFileName() {
    print("Error! Invaid file name.")
}

func displayNoConcordance() {
    print("Error! No concordance currently exists.")
}

func displayCreatingConcordance() {
    print("Creating concordance...")
}

func displaySortingWords() {
    print("Sorting contents...")
}

func displayMatchingWords() {
    print("Matching words...")
}

func displayConcordanceCreated() {
    print("Concordance created successfully.")
}

func displayNoDataExists() {
    print("Error! No data currently stored in memory.")
}

func displaySavingToDisk() {
    print("Saving concordance to disk...")
}

func displaySavedToDisk(outputFileName: String) {
    print("Concordance successfully written to \(outputFileName).")
}

func displaySaveToDiskFailed() {
    print("Error! Concordance could not be saved to disk.")
}

func displayExitingProgram() {
        print("Exiting..")
}

func maxLineLength(wordInFile: [String]) -> Int { //users sizeLess struct
    let num = wordInFile.max()!.count //get length of longest word in array
    return num
}

func matchWords(wordList: inout [Word], wordInFile: inout [String], lineNumbers: inout [Int], lineNumbersList: inout [[Int]]) {
    for (i, _) in wordList.enumerated() { //loop through words in array
        if (i < wordList.count - 1) { //leave the last element alone...for now
            if (wordList[i].getWordItself() == wordList[i + 1].getWordItself()) { //check if word matches next word
                lineNumbers.append(wordList[i].getLineNumber()) //if word matches the next, only get line number and append to vector
                continue
            } else {
                wordInFile.append(wordList[i].getWordItself()) //if word does not match the next word, get word aad line number and append to vector
                lineNumbers.append(wordList[i].getLineNumber())
                lineNumbersList.append(lineNumbers) //append line numbers for each word to another 2-d vector
                //arrayDelete(lineNumbers) //reset line number array for next iteration
            }
        } else if (i == (wordList.count-1)) {//now we can take care of that last element
            if (wordList[i].getWordItself() == wordList[i - 1].getWordItself()) { //if last word does matches the previous
                wordInFile.append(wordList[i].getWordItself()) //if word matches the previous word, get word aad line number and append to vector
                lineNumbers.append(wordList[i].getLineNumber())
                lineNumbersList.append(lineNumbers) //append line numbers for each word to another 2-d vector
                //arrayDelete(lineNumbers) //reset line number vector before leaving the function
            } else {/*doNothing()*/}
        } else {/*doNothing()*/ }
    }
}

func showConcordance(wordInFile: [String], lineNumbers: [Int], lineNumbersList: [[Int]]) {
    let firstColumnHeader: String = "Words" //define first column header
    let secondColumnheader: String = "Count" //define third column header
    let thirdColumnheader: String = "Line Numbers" //define second column header
    let columnBreak: String = " | " //define column break
    let elementDelim: String = ", " //define element delimiter
    let maxQty: Int = 10 //set max qty for second column output
    let columnBreakLength: Int = columnBreak.count //get length of column break string
    var longestWordLength: Int = maxLineLength(wordInFile: wordInFile) //get length of longest word in vector
    
    if (firstColumnHeader.count > maxLineLength(wordInFile: wordInFile)) { //set width of first column accordingly
        longestWordLength = firstColumnHeader.count
    } else { /*doNothing()*/ }
    
    print("\\\\beginning of output\\\\")
    print("\(longestWordLength)\(firstColumnHeader)\(columnBreak)\(secondColumnheader.count+1)\(secondColumnheader)\(columnBreak)\(thirdColumnheader)") //format column headers
    
    for (i, _) in wordInFile.enumerated() { //loop through vector for output
        print("\(longestWordLength)\(wordInFile[i])\(columnBreak)\(lineNumbersList[i].count)\("x")\(columnBreak)") //set width of word colum to longest word length
        for (j, _) in lineNumbersList.enumerated() { //loop thorough line number list
            if (j < lineNumbersList[i].count - 1) { //for all but last line number in list
                if (j >= 10 && j % maxQty == 0) { //format second column width by quantity
                    print()
                    print("\(longestWordLength)\(columnBreakLength * 2)\(secondColumnheader.count + 1) + \(" ")") //for shifting over line numbers to the right
                } else { /*doNothing()*/ }
                print("\(lineNumbersList[i][j]) + \(elementDelim)") //add delimiters between elements
            } else { //for last element in vector
                if (j >= 10 && j % maxQty == 0) { //format second column width by quantity
                    print()
                    print("\(longestWordLength)\(columnBreakLength * 2)\(secondColumnheader.count + 1) + \(" ")") //for shifting over line numbers to the right
                } else { /*doNothing()*/ }
                print(lineNumbersList[i][j]) //no delimiter for last element
            }
            print()
        }
        print("\\\\end of output\\\\")
    }
}

//    func saveConcordance(wordInFile: [String], lineNumbers: [Int], lineNumbersList: [[Int]], ofstream &outFile) -> Concordance {
//        let firstColumnHeader: String = "Words" //define first column header
//        let secondColumnheader: String = "Count" //define third column header
//        let thirdColumnheader: String = "Line Numbers" //define second column header
//        let columnBreak: String = " | " //define column break
//        let elementDelim: String = ", " //define element delimiter
//        let maxQty: Int = 10 //set max qty for second column output
//        var columnBreakLength: Int = columnBreak.count //get length of column break string
//        var longestWordLength: Int = maxLineLength(wordInFile: wordInFile) //get length of longest word in vector
//
//        if (firstColumnHeader.count > maxLineLength(wordInFile: wordInFile)) { //set width of first column accordingly
//            longestWordLength = firstColumnHeader.count
//        } else { /*doNothing()*/ }
//
//        outFile << endl << left << "\\\\beginning of file\\\\" << endl
//        outFile << setw(longestWordLength) << firstColumnHeader << columnBreak << setw(secondColumnheader.length() + 1) << secondColumnheader << columnBreak << thirdColumnheader << right << endl //format column headers
//
//        for i in wordInFile { //loop through vector for output
//            outFile << setw(longestWordLength) << wordInFile[i] << columnBreak << setw(secondColumnheader.length()) << lineNumbersList[i].size() << "x" << columnBreak //set width of word colum to longest word length
//            for j in lineNumbersList[i] { //loop thorough line number list
//                //cout << setw(0); //reset output width
//                if (j < lineNumbersList[i].size() - 1) { //for all but last line number in list
//                    if (j >= 10 && j % maxQty == 0) { //format second column width by quantity
//                        outFile << endl
//                        outFile << setw(longestWordLength + (columnBreakLength * 2) + secondColumnheader.length() + 1) << " " //for shifting over line numbers to the right
//                    } else { /*doNothing()*/ }
//                    outFile << lineNumbersList[i][j] << elementDelim //add delimiters between elements
//                } else {//for last element in vector
//                    if (j >= 10 && j % maxQty == 0) { //format second column width by quantity
//                        outFile << endl;
//                        outFile << setw(longestWordLength + (columnBreakLength * 2) + secondColumnheader.length() + 1) << " " //for shifting over line numbers to the right
//                    } else {/*doNothing()*/ }
//                    outFile << lineNumbersList[i][j] //no delimiter for last element
//                }
//            }
//            outFile << endl
//        }
//        outFile << left << "\\\\end of file\\\\"
//    }
//}

//main
displayProgramHeader() //display program header
var lineNumbersList: [[Int]] = []

while (true) //loop until user quits
{
    var fileToOpen: String = "" //variable for input file selection
    var lineNumbers: [Int] = []
    var wordString: [String] = []
    var wordList: [Word] = []

    displayMainMenu()
    var mainMenuChoice: String = "" //variable for main menu selection
    var mainMenuChoiceGood: Bool = false //set loop condition, get user input until valid
    
    while (!mainMenuChoiceGood) {
        let validMainInput: Set = [ "0", "1", "2", "3", "4", "5" ] //create set with menu options
        mainMenuChoice = getConsoleInput_string(prompt: mainMenuSelectionPrompt()) //get user input and set to variable
        if (validMainInput.contains(mainMenuChoice)) { //match user input against set contents
            mainMenuChoiceGood = true //set loop condition to true to exit
        } else {/*do nothing*/ }
        
        ////arrayDelete(validMainInput) //empty array - NOT NEEDED FOR SWIFT
    }
    
    if (mainMenuChoice == "1") {
        ////READ A TEXT FILE INTO MEMORY
        
        //var inFile: InputStream //create new input stream
       
        //get path for data file, attempt to read, and start splitting rows into city properties
         fileToOpen = getConsoleInput_string(prompt: fileSelectionPrompt()) //get user input and set to variable
        
        do{
            if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fullPath = path.appendingPathComponent(fileToOpen)
                let contents = try String(contentsOf: fullPath, encoding: .utf8)
                
                displayLoadingFile(fileToOpen: fileToOpen)
                book = contents.components(separatedBy: "\n")
                
                displayLoadedFile(fileToOpen: fileToOpen)
            }
        } catch {
            let msgStr1 = String(format:"Error processing ~/Documents/%@. Terminating...", fileToOpen)
            print(msgStr1)
        }
    }
        
    else if (mainMenuChoice == "2") { //VIEW THE CURRENT TEXT FILE
        if (book.count > 0) { //check vector for existing content
            displayBook(book: book)
        } else {
            displayNoDataExists()
        }
    }
    else if (mainMenuChoice == "3") { //CREATE CONCORDANCE FOR THE CURRENT TEXT FILE
        if (book.count > 0) {//verify vector has existing content
            displayCreatingConcordance()
            var stringToAdd: String = ""
            //var newWord: Word = Word()
            for (i, _) in book.enumerated() {                                              //loop through lines elements in array
                if (!book[i].isEmpty) {                                                    //test for content
                    var str1 = book[i]
                    //print(str1)
                    str1 = str1.trimmingCharacters(in: .controlCharacters)
                    //print(str1)
                    wordString = str1.components(separatedBy: " ")
                    for e in wordString{
                        stringToAdd = e.trimmingCharacters(in: .punctuationCharacters).lowercased()
                        let newWord: Word = Word(wordItself: stringToAdd, frequency: 0, lineNumber: i + 1)
                        wordList.append(newWord)
                    }
                }
            }
            
            displaySortingWords()
            
            let sortedArray: [String] = wordInFile.sorted()
            wordInFile = sortedArray
            
            print("postSorted = \(wordInFile)")
            
            displayMatchingWords()
            
            for (i, _) in wordList.enumerated() { //loop through words in array
                    if (i < wordList.count - 1) { //leave the last element alone...for now
                        if (wordList[i].getWordItself() == wordList[i + 1].getWordItself()) { //check if word matches next word
                            lineNumbers.append(wordList[i].getLineNumber()) //if word matches the next, only get line number and append to vector
                            continue
                        } else {
                            wordInFile.append(wordList[i].getWordItself()) //if word does not match the next word, get word aad line number and append to vector
                            lineNumbers.append(wordList[i].getLineNumber())
                            lineNumbersList.append(lineNumbers) //append line numbers for each word to another 2-d vector
                            //arrayDelete(lineNumbers) //reset line number array for next iteration
                        }
                    } else if (i == (wordList.count-1)) {//now we can take care of that last element
                        if (wordList[i].getWordItself() == wordList[i - 1].getWordItself()) { //if last word does matches the previous
                            wordInFile.append(wordList[i].getWordItself()) //if word matches the previous word, get word aad line number and append to vector
                            lineNumbers.append(wordList[i].getLineNumber())
                            lineNumbersList.append(lineNumbers) //append line numbers for each word to another 2-d vector
                            //arrayDelete(lineNumbers) //reset line number vector before leaving the function
                        } else {/*doNothing()*/}
                    } else {/*doNothing()*/ }
            }
            displayConcordanceCreated()
        } else {
        displayNoDataExists()
        }
    }
    else if (mainMenuChoice == "4") { //VIEW THE CURRENT CONCORDANCE
        print("wordInFile = \(wordInFile)")
        if (!wordInFile.isEmpty) { //check array for existing content
            let firstColumnHeader: String = "Words" //define first column header
            let secondColumnheader: String = "Count" //define third column header
            let thirdColumnheader: String = "Line Numbers" //define second column header
            let columnBreak: String = " | " //define column break
            //let elementDelim: String = ", " //define element delimiter
            //let maxQty: Int = 10 //set max qty for second column output
            //let columnBreakLength: Int = columnBreak.count //get length of column break string
            var longestWordLength: Int = maxLineLength(wordInFile: wordInFile) //get length of longest word in vector
        
            if (firstColumnHeader.count > maxLineLength(wordInFile: wordInFile)) { //set width of first column accordingly
                longestWordLength = firstColumnHeader.count
            } else { /*doNothing()*/ }
        
            print("\\\\beginning of output\\\\")
            print("\(firstColumnHeader)\(columnBreak)\(secondColumnheader)\(columnBreak)\(thirdColumnheader)") //format column headers
        
            for var i in 0..<(wordInFile.count) { //loop through vector for output
                print("\(wordInFile[i])\(" ")\(lineNumbersList[i].count)\("x ")", terminator: "") //set width of word colum to longest word length
                for j in 0..<(lineNumbersList.count){ //loop thorough line number list
                        //print(lineNumbersList[i][j]) //no delimiter for last element
                }
            }
            print("\\\\end of output\\\\")
        } else {
            displayNoConcordance()
        }

        //showConcordance(wordInFile: wordInFile, lineNumbers: [lineNumbers], lineNumbersList: lineNumbersList) //output concordance to console
    }
//    else if (mainMenuChoice == "5") { //SAVE THE CURRENT CONCORDANCE TO DISK
//        if (!concordance.wordInFile.isEmpty) { //check vector for existing content
//            ofstream outFile: ofstream //create new output file
//
//            size_t lastIndex: Int = fileToOpen.find_last_of(".") //strinp off file extension
//            let rawName: String = fileToOpen.substr(0, lastIndex)
//            let outputFileName: String = "[\(rawName)]_concordance.txt" //set output file name
//
//            outFile.open(outputFileName)
//
//            while (!outFile) { //if output is not file open
//                displaySaveToDiskFailed()
//                break
//            }
//            while (outFile) { //if output file open
//                displaySavingToDisk()
//                concordance.saveConcordance(concordance.wordInFile, concordance.lineNumbers, concordance.lineNumbersList, outFile) //output concordance to file
//                outFile.close()
//                displaySavedToDisk(outputFileName: outputFileName)
//                break
//            }
//        } else {
//            displayNoConcordance()
//        }
//    }
    else if (mainMenuChoice == "0") {
        //EXIT CONCORDANCE
        displayExitingProgram()
        exit(1)
    }
}
