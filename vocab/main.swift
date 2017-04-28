#!/usr/bin/swift

import Foundation

class vocabQuiz {
    
    func menu() {
        print("1) Create new file")
        print("2) Run Quiz")
        
        let selection = readLine()!
        clearScreen()
        
        if selection == "1" {
            createFile()
        } else {
            runQuiz()
        }
    }

    func createFile() {
        let dirs: [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)

        let dir = dirs[0] //documents directory
        let path = dir + "/vocab.txt"
       
        var spanish: String = ""
        var english: String = ""
        var dictionary: [String:String] = [:]
        
        while spanish != "exit" {
            print("Enter Spanish Word:", terminator: "")
            spanish = readLine()!
            if spanish != "exit" {
                print("Enter English Word:", terminator: "")
                english = readLine()!
                dictionary[spanish] = english
            }
            clearScreen()
        }
        
        var string: String = ""
        for (spn, eng) in dictionary {
           string += spn + "," + eng + "\n"
        }
        
        do {
            try string.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("err")
        }

    }

    func runQuiz() {
        print("Running quiz...")
        //reading
        //    let text2 = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
        //    print(text2!)
    }

    func clearScreen() {
        let clearScreen = Process()
        clearScreen.launchPath = "/usr/bin/clear"
        clearScreen.arguments = []
        clearScreen.launch()
    }
}

let quiz = vocabQuiz()
quiz.menu()
