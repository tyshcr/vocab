#!/usr/bin/swift

import Foundation

class vocabQuiz {
    
    init() {
        createDirectory()
        menu()
    }
    
    func createDirectory() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataPath = documentsDirectory.appendingPathComponent("vocab")
        
        do {
            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print("Error creating directory: \(error.localizedDescription)")
        }
    }
    
    func directory() -> String {
        let dirs: [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        
        let dir = dirs[0] + "/vocab" //documents directory
        return dir
    }
    
    func menu() {
        
        print("# MAIN MENU #")
        print("[1] Create new file")
        print("[2] Run Quiz")
        
        let selection = readLine()!
        
        guard let intSelection = Int(selection) else {
            menu()
            return
        }
        
        switch intSelection {
        case 1:
            createFile()
        case 2:
            runQuiz()
        default:
            menu()
        }
    }

    func createFile() {
        print("# CREATE NEW VOCAB LIST #")
        print("Enter the name for this vocab list")
        let filename = readLine()!
        
        let path = directory() + "/" + filename + ".txt"
       
        var spanish: String = ""
        var english: String = ""
        var output: String = ""
        
        while spanish != "exit" {
            print("# CREATE WORD #")
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
        
        menu()
    }

    func runQuiz() {
        
        // get list of files
        // let user choose a file
        // choose randomly from words in file
        
        do {
            // Get the directory contents urls (including subfolders urls)

            let directoryContents = try FileManager.default.contentsOfDirectory(atPath: directory())

            print("# CHOOSE QUIZ FILE #")
            var i = 1
            for file in directoryContents {
                print("[\(i)] \(file)")
                i += 1
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
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
