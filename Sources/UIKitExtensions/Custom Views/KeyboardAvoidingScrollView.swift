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
    
    
    // MARK: - Keyboard Avoidance

#if !os(tvOS)
    
    @available(tvOS, unavailable)
    @objc(UIEKeyboardAvoidingScrollViewKeyboardBehaviour)
    public enum KeyboardBehaviour: UInt8 {
        case notificationBased
//        case constraintBased
    }

    @objc
    @available(tvOS, unavailable)
    open var preferredKeyboardBehaviour: KeyboardBehaviour = .notificationBased {
        didSet {
            updatePreferredKeyboardBehaviour()
        }
    }

    @available(tvOS, unavailable)
    private func updatePreferredKeyboardBehaviour() {
        let center = NotificationCenter.default
        switch preferredKeyboardBehaviour {
        case .notificationBased:
            if !registeredForKeyboardNotifications {
                center.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
                center.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
                registeredForKeyboardNotifications = true
            }
//        case .constraintBased:
//            guard #available(iOS 15.0, tvOS 15.0, visionOS 1.0, *) else { return }
//            if registeredForKeyboardNotifications {
//                center.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//                center.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//                registeredForKeyboardNotifications = false
//            }
        }
    }
    
    private var registeredForKeyboardNotifications: Bool = false
    
    private var contentHeightOffset: CGFloat = 0 {
        didSet {
            self.contentInset.bottom += (contentHeightOffset - oldValue)
        }
    }
    
    @available(tvOS, unavailable)
    @objc private func keyboardWillShow(_ notification: Notification) {
        let screen = notification.object as? UIScreen
        guard let userInfo = notification.userInfo,
              let keyboardFrameEnd = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let convertedKeyboardFrameEnd: CGRect
        if let screen = screen {
            convertedKeyboardFrameEnd = screen.coordinateSpace.convert(keyboardFrameEnd, to: self)
        } else {
            convertedKeyboardFrameEnd = keyboardFrameEnd
        }
        
        let viewIntersection = self.bounds.intersection(convertedKeyboardFrameEnd)
        guard !viewIntersection.isEmpty else { return }
        
        contentHeightOffset = self.bounds.maxY - viewIntersection.minY
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        contentHeightOffset = 0
    }
    
    private func configureKeyboardAvoidance() {
        updatePreferredKeyboardBehaviour()
    }
    
#endif // !os(tvOS)

    
    // MARK: - Configuration
    
    public convenience init(
        frame: CGRect = .zero,
        scrollBehavior: ScrollBehavior = .all
    ) {
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
#if !os(tvOS)
        configureKeyboardAvoidance()
#endif
    }
    
}


#if canImport(SwiftUI) && DEBUG

import SwiftUI

@available(iOS 17.0, tvOS 17.0, *)
#Preview {
    let view = KeyboardAvoidingScrollView()
    return view
}


#endif // canImport(SwiftUI) && DEBUG
#endif // canImport(UIKit)
