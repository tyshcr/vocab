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
        
        print("1) Create new file")
        print("2) Run Quiz")
        
        let selection = readLine()!
        
        switch Int(selection)! {
        case 1:
            createFile()
        case 2:
            runQuiz()
        default:
            menu()
        }
    }

    func createFile() {
        print("Enter the name for this vocab list")
        let filename = readLine()!
        
        let path = directory() + "/" + filename + ".txt"
       
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
        
        menu()
    }

    func runQuiz() {
        print("Running quiz...")
        // get list of files
        // let user choose a file
        // choose randomly from words in file
        
        do {
            // Get the directory contents urls (including subfolders urls)

            let directoryContents = try FileManager.default.contentsOfDirectory(atPath: directory())
            print(directoryContents)
            
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
