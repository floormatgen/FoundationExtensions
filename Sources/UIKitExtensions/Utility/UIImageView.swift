#if canImport(UIKit)
import UIKit


extension UIImageView {
    
    /// Creates a `self` constraint for the `image` aspect ratio
    ///
    /// This is a convenience method to create a layout constraint in order to fit the current image.
    ///
    /// - Parameter allowedRatioRange:
    ///     The maximum and minimum range allowed. `nil` represents no minimum or maximum.
    /// - Parameter relation:
    ///     The equality between the width and height.
    /// - Parameter multiplier:
    ///     A multiplier for the constraint. This is multipled with the clamped ratio in the constraint.
    /// - Parameter constant:
    ///     A flat amount to add to the constraint. This serves as the constant for the constraint.
    ///
    /// - Returns:
    ///     A new `NSLayoutConstraint` or `nil` if the `UIImageView` lacks an image
    ///
    @inlinable
    @available(iOS 6.0, tvOS 9.0, visionOS 1.0, *)
    public func constraintForImageAspectRatio(
        allowedRatioRange: ClosedRange<CGFloat>? = nil,
        relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1.0,
        constant: CGFloat = 0.0
    ) -> NSLayoutConstraint? {
        guard let image = image else { return nil }
        
        let size = image.size
        var ratio = size.width / size.height
        
        if let allowedRatioRange = allowedRatioRange {
            if ratio < allowedRatioRange.lowerBound {
                ratio = allowedRatioRange.lowerBound
            } else if ratio > allowedRatioRange.upperBound {
                ratio = allowedRatioRange.upperBound
            }
        }
        
        return NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: relation,
            toItem: self,
            attribute: .height,
            multiplier: ratio * multiplier,
            constant: constant
        )
    }
    
}

#endif // canImport(UIKit)
