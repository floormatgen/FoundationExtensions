import Testing

import Foundation
@testable import FoundationExtensions


extension NSExpressionTests {
    
    @Suite
    struct FunctionTests {
        
        
        // MARK: - Collection Functions
        
        @Test("average:", arguments: FunctionTests.testNumberCollections)
        func testAverage(_ arguments: [NSNumber]) throws {
            let function = NSExpression(forFunction: .average(NSExpression(forConstantValue: arguments)))
            try #require(function.function == "average:")
            guard !arguments.isEmpty else { return }
            let result = try #require(function.expressionValue(with: nil, context: nil) as? Double)
            #expect(result == doubleSum(arguments) / Double(arguments.count))
        }
        
        @Test("sum:", arguments: FunctionTests.testNumberCollections)
        func testSum(_ arguments: [NSNumber]) throws {
            let function = NSExpression(forFunction: .sum(NSExpression(forConstantValue: arguments)))
            try #require(function.function == "sum:")
            let result = try #require(function.expressionValue(with: nil, context: nil) as? Double)
            #expect(result == doubleSum(arguments))
        }
        
        @Test("count:", arguments: FunctionTests.testNumberCollections)
        func testCount(_ arguments: [NSNumber]) throws {
            let function = NSExpression(forFunction: .count(NSExpression(forConstantValue: arguments)))
            try #require(function.function == "count:")
            let result = try #require(function.expressionValue(with: nil, context: nil) as? Int)
            #expect(result == arguments.count)
        }
        
        @Test("min:", arguments: FunctionTests.testNumberCollections)
        func testMin(_ arguments: [NSNumber]) throws {
            let function = NSExpression(forFunction: .min(NSExpression(forConstantValue: arguments)))
            try #require(function.function == "min:")
            guard !arguments.isEmpty else { return }
            let result = try #require(function.expressionValue(with: nil, context: nil) as? Double)
            #expect(result == arguments.min(by: { $0.doubleValue < $1.doubleValue })?.doubleValue)
        }
        
        @Test("max:", arguments: FunctionTests.testNumberCollections)
        func testMax(_ arguments: [NSNumber]) throws {
            let function = NSExpression(forFunction: .max(NSExpression(forConstantValue: arguments)))
            try #require(function.function == "max:")
            guard !arguments.isEmpty else { return }
            let result = try #require(function.expressionValue(with: nil, context: nil) as? Double)
            #expect(result == arguments.max(by: { $0.doubleValue < $1.doubleValue })?.doubleValue)
        }
        
        @Test("median:", arguments: FunctionTests.testNumberCollections)
        func testMedian(_ arguments: [NSNumber]) throws {
            let function = NSExpression(forFunction: .median(NSExpression(forConstantValue: arguments)))
            try #require(function.function == "median:")
            guard !arguments.isEmpty else { return }
            let result = try #require(function.expressionValue(with: nil, context: nil) as? Double)
            let sortedArguments = arguments.sorted(by: { $0.doubleValue < $1.doubleValue })
            
            if sortedArguments.count % 2 == 0 {
                #expect(result == (sortedArguments[sortedArguments.count / 2 - 1].doubleValue + sortedArguments[sortedArguments.count / 2].doubleValue) / 2)
            } else {
                #expect(result == sortedArguments[sortedArguments.count / 2].doubleValue)
            }
        }
        
        @Test("mode:", arguments: FunctionTests.testNumberCollections)
        func testMode(_ arguments: [NSNumber]) throws {
            let function = NSExpression(forFunction: .mode(NSExpression(forConstantValue: arguments)))
            try #require(function.function == "mode:")
            guard !arguments.isEmpty else { return }
            let result = try #require(function.expressionValue(with: nil, context: nil) as? [NSNumber])
            
            var frequencies: [NSNumber: Int] = [:]
            for n in arguments { frequencies[n, default: 0] += 1 }
            
            var mode: [NSNumber] = []
            var maxFrequency = 0
            for (n, frequency) in frequencies {
                if frequency > maxFrequency {
                    maxFrequency = frequency
                    mode = [ n ]
                } else if frequency == maxFrequency {
                    mode.append(n)
                }
            }
            
            #expect(mode.contains(result))
        }
        
        @Test("stddev:", arguments: FunctionTests.testNumberCollections)
        func testStddev(_ arguments: [NSNumber]) throws {
            let function = NSExpression(forFunction: .stddev(NSExpression(forConstantValue: arguments)))
            try #require(function.function == "stddev:")
            guard !arguments.isEmpty else { return }
            let result = try #require(function.expressionValue(with: nil, context: nil) as? Double)
            
            let mean = doubleSum(arguments) / Double(arguments.count)
            let n = arguments.reduce(into: 0.0, { $0 += pow($1.doubleValue - mean, 2) })
            let d = Double(arguments.count) // Appears to be population stddev
            let variance = n / d
            let stddev = sqrt(variance)
            
            #expect(result == stddev)
        }
        
        static let testNumberCollections: [[NSNumber]] = [
            [ 1, 2, 3, 4, 5 ],
            [ 0, 0, 0, 0, 0 ],
            [ 81, 5, 67, 61, 69, 41 ],
            [ 42 ],
            [],
            [ -1, -2, -3, -4, -5 ],
            [ 1000000000000, 2000000000000 ],
            [ 0.1, 0.2 ],
            [ 1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5 ],
        ]
        
        func doubleSum(_ numbers: [NSNumber]) -> Double {
            return numbers.reduce(0.0, { $0 + $1.doubleValue })
        }
        
        
        // MARK: - Operator Functions
        
        @Test("add:to:", arguments: FunctionTests.numbers, FunctionTests.numbers)
        func testAdd(_ a: NSNumber, _ b: NSNumber) throws {
            let function = NSExpression(forFunction: .add(NSExpression(forConstantValue: a), to: NSExpression(forConstantValue: b)))
            try #require(function.function == "add:to:")
            let result = try #require(function.expressionValue(with: nil, context: nil) as? Double)
            #expect(result == a.doubleValue + b.doubleValue)
        }
        
        @Test("from:subtract:", arguments: FunctionTests.numbers, FunctionTests.numbers)
        func testSubtract(_ a: NSNumber, _ b: NSNumber) throws {
            let function = NSExpression(forFunction: .from(NSExpression(forConstantValue: a), subtract: NSExpression(forConstantValue: b)))
            try #require(function.function == "from:subtract:")
            let result = try #require(function.expressionValue(with: nil, context: nil) as? Double)
            #expect(result == a.doubleValue - b.doubleValue)
        }
        
        @Test("multiply:by:", arguments: FunctionTests.numbers, FunctionTests.numbers)
        func testMultiply(_ a: NSNumber, _ b: NSNumber) throws {
            let function = NSExpression(forFunction: .multiply(NSExpression(forConstantValue: a), by: NSExpression(forConstantValue: b)))
            try #require(function.function == "multiply:by:")
            let result = try #require(function.expressionValue(with: nil, context: nil) as? Double)
            #expect(result == a.doubleValue * b.doubleValue)
        }
        
        @Test("divide:by:", arguments: FunctionTests.numbers, FunctionTests.numbers)
        func testDivide(_ a: NSNumber, _ b: NSNumber) throws {
            let function = NSExpression(forFunction: .divide(NSExpression(forConstantValue: a), by: NSExpression(forConstantValue: b)))
            try #require(function.function == "divide:by:")
            let result = try #require(function.expressionValue(with: nil, context: nil) as? Double)
            #expect(result == a.doubleValue / b.doubleValue)
        }
        
        static let numbers: [NSNumber] = [
            1.0, 2.0, 5.0,
            3.5, 2.25,
            NSNumber(value: 6.0 / 7.0),
            1000000000000.0,
        ]
        
    }
    
}
