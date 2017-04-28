#!/usr/bin/swift

import Foundation

class vocabQuiz {
    
    init() {
        menu()
    }
    
    func menu() {
        print("1) Create new file")
        print("2) Run Quiz")
        
        let selection = readLine()!
        
        if selection == "1" {
            self.createFile()
        } else {
            self.runQuiz()
        }
    }

    func createFile() {
        let dirs: [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)

        let dir = dirs[0] //documents directory
        let path = dir + "/vocab.txt"
       
        var spanish: String = ""
        var english: String = ""
        var output: String = ""
        
        while spanish != "exit" {
            print("Enter Spanish Word:", terminator: "")
            spanish = readLine()!
            if spanish != "exit" {
                print("Enter English Word:", terminator: "")
                english = readLine()!
                output += spanish + "," + english + "\n"
            }
        }
        
        do {
            try output.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
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

    func clearScreen(completion:@escaping (Bool) -> () ) {
        let clearScreen = Process()
        clearScreen.launchPath = "/usr/bin/clear"
        clearScreen.arguments = []
        clearScreen.terminationHandler = { task in completion(true) }
        clearScreen.launch()
    }
}

let _ = vocabQuiz()
//quiz.menu()
