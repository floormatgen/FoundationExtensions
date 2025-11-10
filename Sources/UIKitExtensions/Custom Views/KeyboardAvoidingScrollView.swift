#if canImport(UIKit)
import UIKit

/// A `UIScrollView` that avoids the keyboard
@objc(UIEKeyboardAvoidingScrollView) @MainActor
@available(iOS 11.0, tvOS 11.0, visionOS 1.0, *)
open class KeyboardAvoidingScrollView: UIScrollView {
    
    
    // MARK: - Scroll Behaviour
    
    @objc(UIEKeyboardAvoidingScrollViewScrollBehaviour)
    public enum ScrollBehavior: UInt8 {
        case all
        case horizontal
        case vertical
        case none
    }
    
    @objc
    open var scrollBehavior: ScrollBehavior = .all {
        didSet {
            switch scrollBehavior {
            case .all:
                restrictHorizontalConstraint.isActive   = false
                restrictVerticalConstraint.isActive     = false
            case .horizontal:
                restrictHorizontalConstraint.isActive   = false
                restrictVerticalConstraint.isActive     = true
            case .vertical:
                restrictHorizontalConstraint.isActive   = true
                restrictVerticalConstraint.isActive     = false
            case .none:
                restrictHorizontalConstraint.isActive   = true
                restrictVerticalConstraint.isActive     = true
            }
        }
    }
    
    private var restrictHorizontalConstraint: NSLayoutConstraint!
    private var restrictVerticalConstraint: NSLayoutConstraint!
    
    private func configureScrollBehaviour() {
        restrictHorizontalConstraint    = self.contentLayoutGuide.widthAnchor.constraint(equalTo: self.frameLayoutGuide.widthAnchor)
        restrictVerticalConstraint      = self.contentLayoutGuide.heightAnchor.constraint(equalTo: self.frameLayoutGuide.heightAnchor)
    }
    
    
    // MARK: - Configuration
    
    public convenience init(frame: CGRect = .zero, scrollBehavior: ScrollBehavior) {
        self.init(frame: frame)
        self.scrollBehavior = scrollBehavior
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        configureScrollBehaviour()
    }
    
}


#if canImport(SwiftUI) && DEBUG

import SwiftUI

@available(iOS 17.0, *)
#Preview {
    let view = KeyboardAvoidingScrollView()
    return view
}


#endif // canImport(SwiftUI) && DEBUG
#endif // canImport(UIKit)
