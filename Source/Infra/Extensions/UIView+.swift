//
//  UIView.swift
//  Learning
//
//  Created by Yasir Khan on 11/23/15.
//  Copyright © 2015 LinkedIn. All rights reserved.
//

import Foundation
import UIKit

public enum Edge {
    case top, bottom, left, right
}

extension UIView {
    /**
     DEPRECATED: Use addAsSubviewWithAnchorConstraints.

     - Parameter view: The parent view for the current view.
     */
    func addAsSubview(toContainer view: UIView) {
        autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        frame = view.bounds
        view.addSubview(self)
        layoutIfNeeded()
    }

    /**
     Adds the current view as a child of a parent view passed in with anchor constraints.

     - Parameter view: The parent view for the current view.
     */
    func addAsSubviewAndPinEdges(toContainer view: UIView) {

        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        if let superview = superview {
            pinEdgesToEdges(ofView: superview)
        }
    }

    func removeAllSubviews() {
        for subView in subviews {
            subView.removeFromSuperview()
        }
    }
}

// MARK: - UIView + Style
extension UIView {

    private enum LayerIdentifier {
        static let gradient = "gradient"
        static let colorOverlay = "color-overlay"
    }

    func applyDropShadow(color: CGColor, offsetWidth: CGFloat, offsetHeight: CGFloat, opacity: Float, radius: CGFloat) {

        layer.shadowColor = color
        layer.shadowOffset = CGSize(width: offsetWidth, height: offsetHeight)
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }

    /**
     Applies a gradient layer to the current view. The gradient layers frame will not autoresize when autolayout changes.
     If you need the frame to be up to date use GradientView instead.
     */
    func applyGradient(_ colors: [CGColor], removeExisting: Bool = false) {

        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors
        gradient.name = LayerIdentifier.gradient

        if removeExisting {
            removeGradient()
        }
        layer.insertSublayer(gradient, at: 0)
    }

    /**
     Removes the gradient layer from the current view.
     */
    func removeGradient() {
        layer.sublayers?.filter({ $0.name == LayerIdentifier.gradient }).first?.removeFromSuperlayer()
    }

    /**
     Applies a solid color overlay layer to the current view.
     */
    func applyColorOverlay(_ color: CGColor, removeExisting: Bool = false) {

        let overlay = CALayer()
        overlay.frame = bounds
        overlay.backgroundColor = color
        overlay.name = LayerIdentifier.colorOverlay

        if removeExisting {
            removeColorOverlay()
        }
        layer.insertSublayer(overlay, at: 0)
    }

    /**
     Removes the color overlay layer from the current view.
     */
    func removeColorOverlay() {
        layer.sublayers?.filter({ $0.name == LayerIdentifier.colorOverlay }).first?.removeFromSuperlayer()
    }
}

// MARK: - UIView + Nib
extension UIView {
    /**
     Load UIView from nib

     - Parameters bundle: bundle
     - Returns: class instance of given UIView
     */
    class func loadFromNib<T: UIView>(_ type: T.Type, bundle: Bundle? = nil) -> T? {

        guard let view = UINib(nibName: String(describing: T.self), bundle: bundle).instantiate(withOwner: self, options: nil).first as? T else {
            // LoggerFactory.commonLogger.errorMessage("Failed to load \(String(T)) from nib.")
            return nil
        }
        return view
    }
}

// MARK: - UIView + Geometry
extension UIView {

    /**
     Setter and getter for origin.x value of view's frame
     */
    public var left: CGFloat {
        get {
            return frame.minX
        }
        set {
            frame = frame.offsetBy(dx: newValue - frame.minX, dy: 0)
        }
    }

    /**
     Setter and getter for origin.x + size.width value of view's frame
     It does not change the width
     */
    public var right: CGFloat {
        get {
            return frame.maxX
        }
        set {
            left = newValue - frame.width
        }
    }

    /**
     Setter and getter for origin.y value of view's frame
     */
    public var top: CGFloat {
        get {
            return frame.minY
        }
        set {
            frame = frame.offsetBy(dx: 0, dy: newValue - frame.minY)
        }
    }

    /**
     Setter and getter for origin.y + size.height value of view's frame
     It does not change the height
     */
    public var bottom: CGFloat {
        get {
            return frame.maxY
        }
        set {
            top = newValue - frame.height
        }
    }

    /**
     Setter and getter for size.width value of view's frame
     Does not change left value but automatically changes right value
     */
    public var width: CGFloat {
        get {
            return frame.width
        }
        set {
            if width != newValue {
                frame.size.width = newValue
            }
        }
    }

    /**
     Setter and getter for size.height value of view's frame
     Does not change top value but automatically changes bottom value
     */
    public var height: CGFloat {
        get {
            return frame.height
        }
        set {
            if height != newValue {
                frame.size.height = newValue
            }
        }
    }

    /**
     Setter and getter for size of the view's frame
     */
    public var size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }
}

// MARK: - UIView + Animations
extension UIView {

    /**
     Perform basic fade-in animation, with given delay, if view is not already visible.
     */
    public func fadeIn(_ delay: TimeInterval = 0, completion: ((Bool) -> Void)? = nil) {

        if self.alpha == 0 || self.isHidden {
            UIView.animate(
                withDuration: 0.2,
                delay: delay,
                options: [],
                animations: {
                    self.alpha = 1
                    self.isHidden = false
            },
                completion: { (completed) in
                    completion?(completed)
            })
        }
    }

    /**
     Perform basic fade-out animation, with given delay, if the view is visible.
     */
    public func fadeOut(_ delay: TimeInterval = 0, completion: ((Bool) -> Void)? = nil) {

        if self.alpha != 0 || !self.isHidden {
            UIView.animate(
                withDuration: 0.2,
                delay: delay,
                options: [],
                animations: {
                    self.alpha = 0
            },
                completion: { (completed) in
                    completion?(completed)
            })
        }
    }
}

// MARK: - UIView + Autolayout
extension UIView {

    public func pinEdgesToEdges(ofView view: UIView, excludeEdges: [Edge]? = nil) {

        var constraints = [NSLayoutConstraint]()

        if !(excludeEdges?.contains(.top) == true) {
            constraints.append(topAnchor.constraint(equalTo: view.topAnchor))
        }
        if !(excludeEdges?.contains(.left) == true) {
            constraints.append(leadingAnchor.constraint(equalTo: view.leadingAnchor))
        }
        if !(excludeEdges?.contains(.bottom) == true) {
            constraints.append(bottomAnchor.constraint(equalTo: view.bottomAnchor))
        }
        if !(excludeEdges?.contains(.right) == true) {
            constraints.append(trailingAnchor.constraint(equalTo: view.trailingAnchor))
        }
        NSLayoutConstraint.activate(constraints)
    }

    @available(iOS 11.0, *)
    public func pinEdgesToSafeArea(ofView view: UIView, excludeEdges: [Edge]? = nil) {

        var constraints = [NSLayoutConstraint]()

        if !(excludeEdges?.contains(.top) == true) {
            constraints.append(topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        }
        if !(excludeEdges?.contains(.left) == true) {
            constraints.append(leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        }
        if !(excludeEdges?.contains(.bottom) == true) {
            constraints.append(bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        }
        if !(excludeEdges?.contains(.right) == true) {
            constraints.append(trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        }
        NSLayoutConstraint.activate(constraints)
    }
}
