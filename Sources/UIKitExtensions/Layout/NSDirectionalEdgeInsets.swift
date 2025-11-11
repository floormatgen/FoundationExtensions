#if canImport(UIKit)
import UIKit


extension NSDirectionalEdgeInsets {
    
    /// Creates edge insets all with the same inset
    ///
    /// - Parameter all:
    ///     The common inset for all 4 dimensions
    ///
    /// This is a convenience over calling
    /// `NSDirectionalEdgeInsets.init(top:leading:bottom:trailing:)`
    /// with the same values.
    @inlinable
    public init(all: CGFloat) {
        self.init(top: all, leading: all, bottom: all, trailing: all)
    }
    
}

#endif // canImport(UIKit)
