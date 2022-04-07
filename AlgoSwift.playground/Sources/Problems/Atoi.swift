/**
 *  AlgoSwift
 *  Copyright (c) Daniel Munoz 2022
 *  Licensed under the MIT license (see LICENSE file)
 */

import Foundation

extension Solution {
    /**
     Solution for the String to Integer (atoi) problem.
     Difficulty: Medium
     Time Complexity: O(N)
     Space Complexity: O(N)

     - Parameter string: The string to convert
     - Returns: Converted Int value
     - Note: LeetCode Problem 8
     */
    public func myAtoi(_ string: String) -> Int {
        guard !string.isEmpty else { return 0 }

        // Converting to Array given that subscript(_:) is unavailable for String
        // Check the Helpers.swift file to see a possible subscript implementation
        let string = Array(string)
        var currentNumber = 0
        var isPositive = true
        var index = 0

        // Ignoring whitespaces
        // Valid whitespaces can only appear at the beginning of the string
        while index < string.count && string[index] == " " {
            index += 1
        }

        // Checking for a plus/minus sign
        if index < string.count && string[index] == "-" {
            isPositive = false
            index += 1
        } else if index < string.count && string[index] == "+" {
            index += 1
        }

        // Parsing the number
        for digitIndex in index..<string.count {
            let currentChar = string[digitIndex]
            // Converting Character -> Int
            guard let parsedNumber = Int(String(currentChar)) else  { break }

            // Validating currentNumber to avoid underflow/overflow
            if currentNumber > Int32.max / 10 || (currentNumber == Int32.max / 10 && parsedNumber > Int32.max % 10) {
                // in case of underflow/overflow, we clamp the returned value to Int32 limit
                return isPositive ? Int(Int32.max) : Int(Int32.min)
            }
            // Constructing the numer with the parsed character
            currentNumber = currentNumber * 10 + parsedNumber
        }
        return isPositive ? currentNumber : currentNumber * -1
    }
}

extension Solution {
    public func testAtoi() {
        // Simplest case
        testAtoi(string: "371", expectedResult: 371)

        // Valid whitespaces at the beginning
        testAtoi(string: "  371", expectedResult: 371)

        // Valid sign before the number
        testAtoi(string: "  -371", expectedResult: -371)

        // Ignoring characters after parsed digits
        testAtoi(string: "   -371abc 123", expectedResult: -371)

        // Overflow
        testAtoi(string: "1234567890123", expectedResult: Int(Int32.max))

        // Underflow
        testAtoi(string: "-1234567890123", expectedResult: Int(Int32.min))

        // Invalid character at the beginning
        testAtoi(string: "a371", expectedResult: 0)

        // Empty String
        testAtoi(string: "", expectedResult: 0)
    }

    private func testAtoi(string: String, expectedResult: Int) {
        let result = Solution().myAtoi(string)
        assert(
            result == expectedResult,
            "Error: Input: \"\(string)\" | Expected: \(expectedResult) | Result: \(result)"
        )
        print("atoi - Converted \"\(string)\" to: \(result)")
    }
}
