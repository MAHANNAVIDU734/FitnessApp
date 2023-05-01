
import Foundation

import UIKit

class CustomButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    private func setLayout() {
        backgroundColor = UIColor(named: "button_color")
        layer.cornerRadius = frame.height / 2
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

}
