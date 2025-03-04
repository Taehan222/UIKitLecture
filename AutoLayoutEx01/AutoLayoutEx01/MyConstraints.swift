//
//  MyConstraints.swift
//  AutoLayoutEx01
//
//  Created by 윤태한 on 3/4/25.
//



import UIKit

class MyConstraints: NSObject {
    let view: UIView

    // Auto Layout Constraints 필드 추가
    let top: NSLayoutYAxisAnchor
    let bottom: NSLayoutYAxisAnchor
    let leading: NSLayoutXAxisAnchor
    let trailing: NSLayoutXAxisAnchor
    let left: NSLayoutXAxisAnchor
    let right: NSLayoutXAxisAnchor
    let centerX: NSLayoutXAxisAnchor
    let centerY: NSLayoutYAxisAnchor
    let width: NSLayoutDimension
    let height: NSLayoutDimension
    let safeTop: NSLayoutYAxisAnchor
    let safeBottom: NSLayoutYAxisAnchor
    let safeLeading: NSLayoutXAxisAnchor
    let safeTrailing: NSLayoutXAxisAnchor

    init(view: UIView) {
        self.view = view

        // 기본 Constraints
        self.top = view.topAnchor
        self.bottom = view.bottomAnchor
        self.leading = view.leadingAnchor
        self.trailing = view.trailingAnchor
        self.left = view.leftAnchor
        self.right = view.rightAnchor
        self.centerX = view.centerXAnchor
        self.centerY = view.centerYAnchor
        self.width = view.widthAnchor
        self.height = view.heightAnchor

        // Safe Area Constraints
        if let superview = view.superview {
            self.safeTop = superview.safeAreaLayoutGuide.topAnchor
            self.safeBottom = superview.safeAreaLayoutGuide.bottomAnchor
            self.safeLeading = superview.safeAreaLayoutGuide.leadingAnchor
            self.safeTrailing = superview.safeAreaLayoutGuide.trailingAnchor
        } else {
            self.safeTop = view.topAnchor
            self.safeBottom = view.bottomAnchor
            self.safeLeading = view.leadingAnchor
            self.safeTrailing = view.trailingAnchor
        }
    }
}

