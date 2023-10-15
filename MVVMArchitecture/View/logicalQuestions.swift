//
//  logicalQuestions.swift
//  MVVMArchitecture
//
//  Created by Tejas Patel on 15/10/23.
//

import Foundation

var responseModel: Json4Swift_Base? = nil

func generateFibbonaciSeries(count: Int) -> [Int]{
    var n1 = 0, n2 = 1
    var finnonaciSeries = [n1, n2]
    for _ in 2..<count{
        let n3 = n1 + n2
        n1 = n2
        n2 = n3
        finnonaciSeries.append(n3)
    }
    return finnonaciSeries
}

func checkPalindrome(value: String) -> Bool{
    let comparevalue = value.replacingOccurrences(of: " ", with: "")
    let reverseString = value.replacingOccurrences(of: " ", with: "").reversed()
    if comparevalue == String(reverseString){
        return true
    }else{
        return false
    }
}

func swappingWithoutThirdVariable(a: Int, b: Int) -> [Int]{
    var a = a + b
    let b = a - b
    a = a - b
    return [a,b]
}

func nonEscapingFunction(completion: () -> Void){
    completion()
    print("First Step")
    print("Third Step")
}

func makeIncrementor(incrementValue: Int) -> () -> Int{
    var total = 0
    let incrementor: () -> Int = {
        total += incrementValue
        return total
    }
    return incrementor
}

func swapFirstandLastchar(originalString: String) -> String{
    var characters = Array(originalString)
    
    if characters.count >= 2{
        (characters[0],characters[characters.count-1]) = (characters[characters.count-1],characters[0])
    }
    return String(characters)
}

func separateArrays(array: [Any]){
    let intArray = array.filter{$0 is Int}
    let doubleArray = array.filter{$0 is Double}
    let stringArray = array.filter{$0 is String}
    print(intArray)
    print(doubleArray)
    print(stringArray)
}

func findNonDuplicateCharacters(actualString: String) -> (chara: Character, index: Int)?{
    // Create a dictionary to count character occurrences
    var charCount = [Character:Int]()
    
    // Iterate through the string and count character occurrences
    for character in actualString{
        if let count = charCount[character]{
            charCount[character] = count + 1
        }else{
            charCount[character] = 1
        }
    }
    // Iterate through the string again to find the first non-duplicate character
    for (index,character) in actualString.enumerated(){
        if let count = charCount[character], count == 1{
            return (character, index)// Found the first non-duplicate character and its index
        }
    }
    // If no non-duplicate character is found, return nil
    return nil
}

func callGetAPI(){
    let url = URL(string: "https://dummy.restapiexample.com/api/v1/employees")
    
    let task = URLSession.shared.dataTask(with: url!){(data, response, error) in
        let jsonDecoder = JSONDecoder()
        do{
            responseModel  = try jsonDecoder.decode(Json4Swift_Base.self, from: data!)
            print(responseModel)
        }catch{
            print("error")
        }
    }
    task.resume()
}
