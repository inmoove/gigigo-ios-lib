import UIKit

public struct TextStyle {
    let font: UIFont
    let foregroundColor: UIColor
    let backgroundColor: UIColor
    let isStrikedThrough: Bool
    let isUnderlined: Bool
    let letterSpacing: CGFloat?
    
    public init(font: UIFont,
                 foregroundColor: UIColor = .black,
                 backgroundColor: UIColor = .clear,
                 isStrikedThrough: Bool = false,
                 isUnderlined: Bool = false,
                 letterSpacing: CGFloat? = nil) {
        self.font = font
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.isStrikedThrough = isStrikedThrough
        self.isUnderlined = isUnderlined
        self.letterSpacing = letterSpacing
    }
}
