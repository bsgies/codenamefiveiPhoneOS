//
//  LanguageKit+CSV.swift
//  LanguageKit
//
//  Created by Gary Law on 5/3/2018.
//

import Foundation

extension String {
    
    var unescapeCSVQuote:String {
        if let first = self.first,
            let last = self.last ,
            first == "\"" && last == "\"" {
            
            
            let range = self.index(after: self.startIndex) ..< self.index(before: self.endIndex)
            return String(self[range])
        }
        return self
    }
}

extension LanguageKit {
    
    
    func parseCSV(sourceString:String) -> [[String]] {
        
        
        let string = sourceString.replacingOccurrences(of: "\r\n", with: "\n")


        var data:[[String]] = []
        let rows = splitString(string: string, separator: "\n")
        
        for row in rows {
            var rowData:[String] = []
            let columns = splitString(string: row, separator: ",")
            
            for column in columns {
                rowData += [column.unescapeCSVQuote]
            }
            
            data += [rowData]
            
        }
        
        return data
    }
    

    func splitString(string: String, separator: String) -> [String] {
        
        
        let splited = string.components(separatedBy: separator)
        var finals:[String] = []
        
        for string in splited {
            
            var currentWord = string
            
            if let lastWord = finals.last,
                isWordSplitedAfterSeparator(string: lastWord) == true {
                
                //If the word is split after separator, mean it's originally from the same column
                currentWord = lastWord + separator + currentWord
                finals.removeLast()
            }
            
            finals.append(currentWord)

        }
        
        
        return finals
    }
    
    func isWordSplitedAfterSeparator(string: String) -> Bool {
        if string.components(separatedBy: "\"").count % 2 == 0 {
            return true
        }
        return false
    }
    
}
