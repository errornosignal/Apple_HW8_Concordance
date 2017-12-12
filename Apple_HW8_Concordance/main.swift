//
//  main.swift
//  Apple_HW8_Concordance
//
//  Created by Reid Nolan on 12/9/17.
//  Copyright © 2017 Reid Nolan. All rights reserved.
//

import Foundation

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

func readFileByLine(inFile: fstream, book: [String]) {
    var line: String = ""
    var lineCount: Int = 0
    
    while (getline(inFile, line)) {
        book.push_back(line)
        lineCount += 1
    }
}

func displayBook(book: [String]) {
    print("\\\\begininng of file\\\\")
    for i in book {
        print((i + 1) + "| " + book[i])
    }
    print("\\\\end of file\\\\")
}

func vecDelete(vecToDelete: [String]) {
    vecToDelete.erase(vecToDelete.begin(), vecToDelete.end())
    vector<string>().swap(vecToDelete)
}

func vecDelete(vecToDelete: [Word]) {
    vecToDelete.erase(vecToDelete.begin(), vecToDelete.end())
    vector<Word>().swap(vecToDelete)
}

func vecDelete(vecToDelete: [Int]) {
    vecToDelete.erase(vecToDelete.begin(), vecToDelete.end())
    vector<int>().swap(vecToDelete)
}

func vecDelete(vecToDelete: [[Int]]) {
    vecToDelete.erase(vecToDelete.begin(), vecToDelete.end())
    vector<vector<int>>().swap(vecToDelete)
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

func displayCleaningMemory() {
        print("Cleaning up memory...")
}

func displayExitingProgram() {
        print("Exiting program...")
        print("Press [Enter] to exit.")
}

//main
var word: Word //create new object instance
var concordance: Concordance //create new object instance

var book: [String] = [] //create array to store contents of input file
var fileToOpen: String = "" //variable for input file selection

displayProgramHeader() //display program header

while (true) //loop until user quits
{
    var mainMenuChoice: String = "" //variable for main menu selection
    
    displayMainMenu()
    
    var mainMenuChoiceGood: Bool = false //set loop condition, get user input until valid
    while (!mainMenuChoiceGood) {
        let validMainInput: [String] = [ "0", "1", "2", "3", "4", "5" ] //create vector with menu options
        
        mainMenuChoice = getConsoleInput_string(prompt: mainMenuSelectionPrompt()) //get user input and set to variable
        
        if (find(begin(validMainInput), end(validMainInput), mainMenuChoice) != end(validMainInput)) { //match user input against vector contents
            mainMenuChoiceGood = true //set loop condition to true to exit
        } else {/*do nothing*/ }
        
        vecDelete(validMainInput) //empty vector
    }
    
    if (mainMenuChoice == "1") {
        //READ A TEXT FILE INTO MEMORY
        inFile: fstream //create new input file
        fileToOpen = getConsoleInput_string(fileSelectionPrompt()) //get user input and set to variable
        
        size_t found: Int = fileToOpen.find_last_of(".") //display error on invalid file name
        while(found == string::npos) {
            displayInvalidFileName()
            break
        }
        
        inFile.open(fileToOpen)
        
        while (!inFile && found != string::npos) { //if file not opened and file name is valid
            displayNoInputFile(fileToOpen: fileToOpen) //display failed to open input file message
            break
        }
        
        while (inFile) { //if input file is open
            if (!book.isEmpty) { //check vector for existing content
                displayCleaningMemory()
                vecDelete(book) //empty vector
                vecDelete(word.wordList) //empty vector
                vecDelete(concordance.wordInFile) //empty vector
                vecDelete(concordance.lineNumbers) //empty vector
                vecDelete(concordance.lineNumbersList) //empty vector
            }
            else {/*do nothing*/ }
            
            displayLoadingFile(fileToOpen: fileToOpen)
            readFileByLine(inFile, book)
            inFile.close()
            displayLoadedFile(fileToOpen: fileToOpen)
        }
    }
    else if (mainMenuChoice == "2") { //VIEW THE CURRENT TEXT FILE
        if (!book.isEmpty) { //check vector for existing content
            displayBook(book: book)
        } else {
            displayNoDataExists()
        }
    }
    else if (mainMenuChoice == "3") { //CREATE CONCORDANCE FOR THE CURRENT TEXT FILE
        if (!book.isEmpty) {//verify vector has existing content
            displayCreatingConcordance()
            word.parseOutWords(word, book, word.wordList) //format words and add property values to object
            
            displaySortingWords()
            concordance.sortWords(word: word, wordList: word.wordList) //sort word objects in list by word and then line number
            
            displayMatchingWords()
            concordance.matchWords(wordList: word.wordList, wordInFile: concordance.wordInFile, lineNumbers: concordance.lineNumbers, lineNumbersList: concordance.lineNumbersList) //ignore duplicate words, but keep line numbers
            
            displayConcordanceCreated()
        } else {
            displayNoDataExists()
        }
    }
    else if (mainMenuChoice == "4") { //VIEW THE CURRENT CONCORDANCE
        if (!concordance.wordInFile.isEmpty) { //check vector for existing content
            concordance.showConcordance(wordInFile: concordance.wordInFile, lineNumbers: concordance.lineNumbers, lineNumbersList: concordance.lineNumbersList) //output concordance to console
        } else {
            displayNoConcordance()
        }
        
        //Concordance::showConcordance(concordance.wordInFile, concordance.lineNumbers, concordance.lineNumbersList); //output concordance to console
    }
    else if (mainMenuChoice == "5") { //SAVE THE CURRENT CONCORDANCE TO DISK
        if (!Concordance.wordInFile.isEmpty) { //check vector for existing content
            ofstream outFile: ofstream //create new output file
            
            size_t lastIndex = fileToOpen.find_last_of(".") //strinp off file extension
            let rawName: String = fileToOpen.substr(0, lastIndex)
            let outputFileName: String = "[\(rawName)]_concordance.txt" //set output file name
            
            outFile.open(outputFileName)
            
            while (!outFile) { //if output is not file open
                displaySaveToDiskFailed()
                break
            }
            while (outFile) { //if output file open
                displaySavingToDisk()
                Concordance.saveConcordance(concordance.wordInFile, concordance.lineNumbers, concordance.lineNumbersList, outFile) //output concordance to file
                outFile.close()
                displaySavedToDisk(outputFileName: outputFileName)
                break
            }
        } else {
            displayNoConcordance()
        }
    } else {
        //EXIT CONCORDANCE.EXE
        displayCleaningMemory()
        break
    }
}

vecDelete(book) //empty vector
vecDelete(word.wordList) //empty vector
vecDelete(concordance.wordInFile) //empty vector
vecDelete(concordance.lineNumbers) //empty vector
vecDelete(concordance.lineNumbersList) //empty vector

displayExitingProgram() //display exiting program status message and prompt for confirmation before exit
