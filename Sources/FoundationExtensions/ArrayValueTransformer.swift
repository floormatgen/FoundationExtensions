#if canImport(Darwin)
import Foundation


/// Adds the capability for a `ValueTransformer` to work on arrays
///
/// This is a convenience protocol when a Value Transformer needs to work
/// with `NSPopUpButton` and `NSTableView` to provide a collection of elements.
///
/// For more information, see [Value Transformer Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ValueTransformers/ValueTransformers.html#//apple_ref/doc/uid/10000175i)
/// and [NSPopupButton Bindings with Value Transformer](https://stackoverflow.com/questions/12505764/nspopupbutton-bindings-with-value-transformer).
@objc(NSEArrayValueTransformer)
public protocol ArrayValueTransformer: NSObjectProtocol {
    
    /// The transformed value of an array of values
    ///
    /// The array should contain values of the type returned by
    /// `ValueTransformer.transformedValueClass()`
    @objc(transformedArrayValue:)
    func transformedArrayValue(_ array: [Any]) -> Any
    
}


extension ArrayValueTransformer where Self: ValueTransformer {
    
    func transformedArrayValue(_ array: [Any]) -> Any {
        var elements: [AnyObject] = []
        elements.reserveCapacity(array.count)
        for e in array { elements.append(self.transformedValue(e) as AnyObject) }
        return elements
    }
    
}

#endif // canImport(Darwin)
