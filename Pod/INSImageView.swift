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
        guard let image = imageView.image else { return }
        let widthRatio = imageToBoundsWidthRatio(image)
        let heightRatio = imageToBoundsHeightRatio(image)
        imageViewBoundsToSize(CGSize(width: image.size.width / max(widthRatio, heightRatio), height: image.size.height / max(widthRatio, heightRatio)))
        centerImageView()
    }
    
    private func layoutAspectFill() {
        guard let image = imageView.image else { return }
        let widthRatio = imageToBoundsWidthRatio(image)
        let heightRatio = imageToBoundsHeightRatio(image)
        imageViewBoundsToSize(CGSize(width: image.size.width /  min(widthRatio, heightRatio), height: image.size.height / min(widthRatio, heightRatio)))
        centerImageView()
    }
    
    private func layoutFill() {
        imageViewBoundsToSize(CGSize(width: bounds.size.width, height: bounds.size.height))
    }
    
    private func layoutCenter() {
        imageViewBoundsToImageSize()
        centerImageView()
    }
    
    private func layoutTop() {
        guard let image = imageView.image else { return }
        imageViewBoundsToImageSize()
        centerImageViewToPoint(CGPoint(x: bounds.size.width / 2, y: image.size.height / 2))
    }
    
    private func layoutBottom() {
        guard let image = imageView.image else { return }
        imageViewBoundsToImageSize()
        centerImageViewToPoint(CGPoint(x: bounds.size.width / 2, y: bounds.size.height - image.size.height / 2))
    }
    
    private func layoutLeft() {
        guard let image = imageView.image else { return }
        imageViewBoundsToImageSize()
        centerImageViewToPoint(CGPoint(x: image.size.width / 2, y: bounds.size.height / 2))
    }
    
    private func layoutRight() {
        guard let image = imageView.image else { return }
        imageViewBoundsToImageSize()
        centerImageViewToPoint(CGPoint(x: bounds.size.width - image.size.width / 2, y: bounds.size.height / 2))
    }
    
    private func layoutTopLeft() {
        guard let image = imageView.image else { return }
        imageViewBoundsToImageSize()
        centerImageViewToPoint(CGPoint(x: image.size.width / 2, y: image.size.height / 2))
    }
    
    private func layoutTopRight() {
        guard let image = imageView.image else { return }
        imageViewBoundsToImageSize()
        centerImageViewToPoint(CGPoint(x: bounds.size.width - image.size.width / 2, y: image.size.height / 2))
    }
    
    private func layoutBottomLeft() {
        guard let image = imageView.image else { return }
        imageViewBoundsToImageSize()
        centerImageViewToPoint(CGPoint(x: image.size.width / 2, y: bounds.size.height - image.size.height / 2))
    }
    
    private func layoutBottomRight() {
        guard let image = imageView.image else { return }
        imageViewBoundsToImageSize()
        centerImageViewToPoint(CGPoint(x: bounds.size.width - image.size.width / 2, y: bounds.size.height - image.size.height / 2))
    }
    
    private func centerImageViewToPoint(point: CGPoint) {
        imageView.center = point
    }
    
    private func imageViewBoundsToImageSize() {
        guard let image = imageView.image else { return }
        imageViewBoundsToSize(image.size)
    }
    
    private func imageViewBoundsToSize(size: CGSize) {
        imageView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    private func centerImageView() {
        imageView.center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
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
