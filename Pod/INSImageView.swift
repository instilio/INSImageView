//
//  INSImageView.swift
//
//  Created by Patrick on 9/12/2015.
//  Copyright © 2015 instil. All rights reserved.
//

import UIKit

public class INSImageView: UIImageView {
    
    // MARK: - Public Properties
    
    // Use this to access the intended 'image' and `highlightedImage` properties.
    // Due to the way INSImageView is implemented, the 'image' and `highlightedImage` properties will always return nil.
    var originalImage: UIImage?            { return imageView.image }
    var originalHighlightedImage: UIImage? { return imageView.highlightedImage }
    
    // MARK: - Private Properties
    
    private let imageView = UIImageView()
    
    // MARK: - Initializers
    
    public init() {
        super.init(image: nil, highlightedImage: nil)
        setup()
    }
    
    public override init(image: UIImage?) {
        super.init(image: image, highlightedImage: nil)
        setup()
    }
    
    public override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addSubview(imageView)
    }
    
    // MARK: - When to Relayout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutImageView()
    }
    
    public override var contentMode: UIViewContentMode {
        didSet { layoutImageView() }
    }
    
    // MARK: - Manipulating Private imageView
    
    private func layoutImageView() {
        
        switch contentMode {
        case .ScaleAspectFit:  layoutAspectFit()
        case .ScaleAspectFill: layoutAspectFill()
        case .ScaleToFill:     layoutFill()
        case .Redraw:          break;
        case .Center:          layoutCenter()
        case .Top:             layoutTop()
        case .Bottom:          layoutBottom()
        case .Left:            layoutLeft()
        case .Right:           layoutRight()
        case .TopLeft:         layoutTopLeft()
        case .TopRight:        layoutTopRight()
        case .BottomLeft:      layoutBottomLeft()
        case .BottomRight:     layoutBottomRight()
        }
    }
    
    private func imageToBoundsWidthRatio(image: UIImage) -> CGFloat {
        return image.size.width / bounds.size.width
    }
    
    private func imageToBoundsHeightRatio(image: UIImage) -> CGFloat {
        return image.size.height / bounds.size.height
    }
    
    private func layoutAspectFit() {
        
        let image = imageView.image!
        let widthRatio = imageToBoundsWidthRatio(image)
        let heightRatio = imageToBoundsHeightRatio(image)
        
        if widthRatio > heightRatio {
            let size = CGSize(width: image.size.width / widthRatio, height: image.size.height / widthRatio)
            imageViewBoundsToSize(imageView, size: size)
        } else {
            let size = CGSize(width: image.size.width / heightRatio, height: image.size.height / heightRatio)
            imageViewBoundsToSize(imageView, size: size)
        }
        
        centerImageView(imageView)
    }
    
    private func layoutAspectFill() {
        
        let image = imageView.image!
        let widthRatio = imageToBoundsWidthRatio(image)
        let heightRatio = imageToBoundsHeightRatio(image)
        
        if (widthRatio > heightRatio) {
            let size = CGSize(width: image.size.width / heightRatio, height: image.size.height / heightRatio)
            imageViewBoundsToSize(imageView, size: size)
        } else {
            let size = CGSize(width: image.size.width / widthRatio, height: image.size.height / widthRatio)
            imageViewBoundsToSize(imageView, size: size)
        }
        
        centerImageView(imageView)
    }
    
    private func layoutFill() {
        let size = CGSize(width: bounds.size.width, height: bounds.size.height)
        imageViewBoundsToSize(imageView, size: size)
    }
    
    private func layoutCenter() {
        imageViewBoundsToImageSize(imageView)
        centerImageView(imageView)
    }
    
    private func layoutTop() {
        imageViewBoundsToImageSize(imageView)
        let point = CGPoint(x: bounds.size.width / 2, y: imageView.image!.size.height / 2)
        centerImageViewToPoint(imageView, point: point)
    }
    
    private func layoutBottom() {
        imageViewBoundsToImageSize(imageView)
        let point = CGPoint(x: bounds.size.width / 2, y: bounds.size.height - imageView.image!.size.height / 2)
        centerImageViewToPoint(imageView, point: point)
    }
    
    private func layoutLeft() {
        imageViewBoundsToImageSize(imageView)
        let point = CGPoint(x: imageView.image!.size.width / 2, y: bounds.size.height / 2)
        centerImageViewToPoint(imageView, point: point)
    }
    
    private func layoutRight() {
        imageViewBoundsToImageSize(imageView)
        let point = CGPoint(x: bounds.size.width - imageView.image!.size.width / 2, y: bounds.size.height / 2)
        centerImageViewToPoint(imageView, point: point)
    }
    
    private func layoutTopLeft() {
        imageViewBoundsToImageSize(imageView)
        let image = imageView.image!
        let point = CGPoint(x: image.size.width / 2, y: image.size.height / 2)
        centerImageViewToPoint(imageView, point: point)
    }
    
    private func layoutTopRight() {
        imageViewBoundsToImageSize(imageView)
        let image = imageView.image!
        let point = CGPoint(x: bounds.size.width - image.size.width / 2, y: image.size.height / 2)
        centerImageViewToPoint(imageView, point: point)
    }
    
    private func layoutBottomLeft() {
        imageViewBoundsToImageSize(imageView)
        let image = imageView.image!
        let point = CGPoint(x: image.size.width / 2, y: bounds.size.height - image.size.height / 2)
        centerImageViewToPoint(imageView, point: point)
    }
    
    private func layoutBottomRight() {
        imageViewBoundsToImageSize(imageView)
        let image = imageView.image!
        let point = CGPoint(x: bounds.size.width - image.size.width / 2, y: bounds.size.height - image.size.height / 2)
        centerImageViewToPoint(imageView, point: point)
    }
    
    private func centerImageViewToPoint(imageView: UIImageView, point: CGPoint) {
        imageView.center = point
    }
    
    private func imageViewBoundsToImageSize(imageView: UIImageView) {
        imageViewBoundsToSize(imageView, size: imageView.image!.size)
    }
    
    private func imageViewBoundsToSize(imageView: UIImageView, size: CGSize) {
        imageView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    private func centerImageView(imageView: UIImageView) {
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        imageView.center = center
    }
    
    // MARK: - Forwarding (Swift doesn't support forwardInvocation :c)
    
    public override var image: UIImage? {
        get { return nil }
        set { imageView.image = newValue }
    }
    
    public override var highlightedImage: UIImage? {
        get { return nil }
        set { imageView.highlightedImage = newValue }
    }
    
    public override var animationImages: [UIImage]? {
        get { return imageView.animationImages }
        set { imageView.animationImages = newValue }
    }
    
    public override var highlightedAnimationImages: [UIImage]? {
        get { return imageView.highlightedAnimationImages }
        set { imageView.highlightedAnimationImages = newValue }
    }
    
    public override var animationDuration: NSTimeInterval {
        get { return imageView.animationDuration }
        set { imageView.animationDuration = newValue }
    }
    
    public override var animationRepeatCount: Int {
        get { return imageView.animationRepeatCount }
        set { imageView.animationRepeatCount = newValue }
    }
    
    public override var highlighted: Bool {
        get { return imageView.highlighted }
        set { imageView.highlighted = newValue }
    }
    
    public override var tintColor: UIColor! {
        get { return imageView.tintColor }
        set { imageView.tintColor = newValue }
    }
    
    public override func startAnimating() {
        imageView.startAnimating()
    }
    
    public override func stopAnimating() {
        imageView.stopAnimating()
    }
    
    public override func isAnimating() -> Bool {
        return imageView.isAnimating()
    }
}
