import Foundation


extension NSExpression {
    
    /// Creates a new expression with the provided function
    ///
    /// This should be preferred over `NSExpression.init(forFunction:arguments:)`
    /// which uses strings and a argument array. This is because it is much easier to make mistakes
    /// with a selector string and array.
    ///
    /// - Parameter function:
    ///     An ``Foundation/NSExpression/Function`` representing the expression
    ///
    @inlinable
    @available(iOS 3.0, macOS 10.4, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
    public convenience init(forFunction function: NSExpression.Function) {
        switch function {
        case .average(let array):
            self.init(forFunction: "average:", arguments: array)
        case .sum(let array):
            self.init(forFunction: "sum:", arguments: array)
        case .count(let array):
            self.init(forFunction: "count:", arguments: array)
        case .min(let array):
            self.init(forFunction: "min:", arguments: array)
        case .max(let array):
            self.init(forFunction: "max:", arguments: array)
        case .median(let array):
            self.init(forFunction: "median:", arguments: array)
        case .mode(let array):
            self.init(forFunction: "mode:", arguments: array)
        case .stddev(let array):
            self.init(forFunction: "stddev:", arguments: array)
        case .add(let base, let amount):
            self.init(forFunction: "add:to:", arguments: [ base, amount ])
        case .from(let base, let amount):
            self.init(forFunction: "from:subtract:", arguments: [ base, amount ])
        case .multiply(let base, let amount):
            self.init(forFunction: "multiply:by:", arguments: [ base, amount ])
        case .divide(let base, let amount):
            self.init(forFunction: "divide:by:", arguments: [ base, amount ])
        case .modulus(let base, let amount):
            self.init(forFunction: "modulus:by:", arguments: [ base, amount ])
        case .sqrt(let number):
            self.init(forFunction: "sqrt:", arguments: [ number ])
        case .log(let number):
            self.init(forFunction: "log:", arguments: [ number ])
        case .ln(let number):
            self.init(forFunction: "ln:", arguments: [ number ])
        case .raise(let base, let power):
            self.init(forFunction: "raise:toPower:", arguments: [ base, power ])
        case .exp(let number):
            self.init(forFunction: "exp:", arguments: [ number ])
        case .ceiling(let number):
            self.init(forFunction: "ceiling:", arguments: [ number ])
        case .abs(let number):
            self.init(forFunction: "abs:", arguments: [ number ])
        case .trunc(let number):
            self.init(forFunction: "trunc:", arguments: [ number ])
        case .random:
            self.init(forFunction: "random", arguments: [])
        case .randomBounded(let bound):
            self.init(forFunction: "random:", arguments: [ bound ])
        case .now:
            self.init(forFunction: "now", arguments: [])
        case .floor(let number):
            self.init(forFunction: "floor:", arguments: [ number ])
        case .uppercase(let stringExpression):
            self.init(forFunction: "uppercase:", arguments: [ stringExpression ])
        case .lowercase(let stringExpression):
            self.init(forFunction: "lowercase:", arguments: [ stringExpression ])
        case .bitwiseAnd(let base, let number):
            self.init(forFunction: "bitwiseAnd:with:", arguments: [ base, number ])
        case .bitwiseOr(let base, let number):
            self.init(forFunction: "bitwiseOr:with:", arguments: [ base, number ])
        case .bitwiseXor(let base, let number):
            self.init(forFunction: "bitwiseXor:with:", arguments: [ base, number ])
        case .leftshift(let base, let number):
            self.init(forFunction: "leftshift:by:", arguments: [ base, number ])
        case .rightshift(let base, let number):
            self.init(forFunction: "rightshift:by:", arguments: [ base, number ])
        case .onesComplement(let base):
            self.init(forFunction: "onesComplement:", arguments: [ base ])
        case .noindex(let base):
            self.init(forFunction: "noindex:", arguments: [ base ])
        }
    }
    
    
    /// A representation of functions that `NSExpression` supports
    ///
    /// For function information see `NSExpression.init(forFunction:arguments:)`
    @available(iOS 3.0, macOS 10.4, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
    public enum Function {

        // MARK: Since OSX 10.4

        @available(iOS 3.0, macOS 10.4, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case average([NSExpression])

        @available(iOS 3.0, macOS 10.4, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case sum([NSExpression])

        @available(iOS 3.0, macOS 10.4, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case count([NSExpression])

        @available(iOS 3.0, macOS 10.4, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case min([NSExpression])

        @available(iOS 3.0, macOS 10.4, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case max([NSExpression])
        
        // Variadic Convenience Methods
        
        @available(iOS 3.0, macOS 10.4, tvOS 9.0, visionOS 1.0, watchOS 2.0, *) @inlinable
        public static func average(_ expressions: NSExpression...) -> Self { .average(expressions) }
        
        @available(iOS 3.0, macOS 10.4, tvOS 9.0, visionOS 1.0, watchOS 2.0, *) @inlinable
        public static func sum(_ expressions: NSExpression...) -> Self { .sum(expressions) }
        
        @available(iOS 3.0, macOS 10.4, tvOS 9.0, visionOS 1.0, watchOS 2.0, *) @inlinable
        public static func count(_ expressions: NSExpression...) -> Self { .count(expressions) }
        
        @available(iOS 3.0, macOS 10.4, tvOS 9.0, visionOS 1.0, watchOS 2.0, *) @inlinable
        public static func min(_ expressions: NSExpression...) -> Self { .min(expressions) }

        @available(iOS 3.0, macOS 10.4, tvOS 9.0, visionOS 1.0, watchOS 2.0, *) @inlinable
        public static func max(_ expressions: NSExpression...) -> Self { .max(expressions) }
        
        // MARK: Since OSX 10.5

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case median([NSExpression])

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case mode([NSExpression])

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case stddev([NSExpression])

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case add(NSExpression, to: NSExpression)

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case from(NSExpression, subtract: NSExpression)

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case multiply(NSExpression, by: NSExpression)

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case divide(NSExpression, by: NSExpression)

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case modulus(NSExpression, by: NSException)

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case sqrt(NSExpression)

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case log(NSExpression)

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case ln(NSExpression)

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case raise(NSExpression, toPower: NSExpression)

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case exp(NSExpression)

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case ceiling(NSExpression)

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case abs(NSExpression)

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case trunc(NSExpression)

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case random

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case randomBounded(NSExpression)

        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case now
        
        // Variadic Convenience Methods
        
        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        public static func median(_ expressions: NSExpression...) -> Self { .median(expressions) }
        
        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        public static func mode(_ expressions: NSExpression...) -> Self { .mode(expressions) }
        
        @available(iOS 3.0, macOS 10.5, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        public static func stddev(_ expressions: NSExpression...) -> Self { .stddev(expressions) }

        // MARK: Since iOS 3.0 (Assuming OSX 10.6)

        @available(iOS 3.0, macOS 10.6, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case floor(NSExpression)

        @available(iOS 3.0, macOS 10.6, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case uppercase(NSExpression)

        @available(iOS 3.0, macOS 10.6, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case lowercase(NSExpression)

        @available(iOS 3.0, macOS 10.6, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case bitwiseAnd(NSExpression, with: NSExpression)

        @available(iOS 3.0, macOS 10.6, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case bitwiseOr(NSExpression, with: NSExpression)

        @available(iOS 3.0, macOS 10.6, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case bitwiseXor(NSExpression, with: NSExpression)

        @available(iOS 3.0, macOS 10.6, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case leftshift(NSExpression, by: NSExpression)

        @available(iOS 3.0, macOS 10.6, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case rightshift(NSExpression, by: NSExpression)

        @available(iOS 3.0, macOS 10.6, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case onesComplement(NSExpression)

        @available(iOS 3.0, macOS 10.6, tvOS 9.0, visionOS 1.0, watchOS 2.0, *)
        case noindex(NSExpression)

    }

}
