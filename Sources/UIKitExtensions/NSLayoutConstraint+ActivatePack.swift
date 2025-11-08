#if canImport(UIKit)
import UIKit


extension NSLayoutConstraint {
    
    @inlinable @inline(__always)
    @available(iOS 6.0, tvOS 9.0, visionOS 1.0, *)
    public func activate<each C: NSLayoutConstraint>(_ constraints: repeat each C) {
        for c in repeat each constraints {
            c.isActive = true
        }
    }
    
    @inlinable @inline(__always)
    @available(iOS 6.0, tvOS 9.0, visionOS 1.0, *)
    public func deactivate<each C: NSLayoutConstraint>(_ constraints: repeat each C) {
        for c in repeat each constraints {
            c.isActive = false
        }
    }
    
}

#endif // canImport(UIKit)
