//
//  INSImageView.swift
//
//  Created by Patrick on 9/12/2015.
//  Copyright © 2015 instil. All rights reserved.
//

import UIKit

public class INSImageView: UIImageView {
    
    // MARK: - Public Properties
    
    // Use this to access the intended 'image' property
    // Due to the way PBImageView is implemented, the 'image' property will always return nil.
    var originalImage: UIImage? {
        get {
            return imageView.image
        }
    }
    
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
        if imageView.image == nil {
            imageView.image = super.image
        }
        super.image = nil
        addSubview(imageView)
    }
    
    // MARK: - When to Relayout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutImageView()
    }
    
    public override var contentMode: UIViewContentMode {
        didSet {
            layoutImageView()
        }
    }
    
    // MARK: - Manipulating Private imageView
    
    private func layoutImageView() {
        
        let imageView = self.imageView
        
        switch contentMode {
            
        case .ScaleAspectFit:
            layoutAspectFit(imageView)
            break;
            
        case .ScaleAspectFill:
            layoutAspectFill(imageView)
            break;
            
        case .ScaleToFill:
            layoutFill(imageView)
            break;
            
        case .Redraw:
            break;
            
        case .Center:
            layoutCenter(imageView)
            break;
            
        case .Top:
            layoutTop(imageView)
            break;
            
        case .Bottom:
            layoutBottom(imageView)
            break;
            
        case .Left:
            layoutLeft(imageView)
            break;
            
        case .Right:
            layoutRight(imageView)
            break;
            
        case .TopLeft:
            layoutTopLeft(imageView)
            break;
            
        case .TopRight:
            layoutTopRight(imageView)
            break;
            
        case .BottomLeft:
            layoutBottomLeft(imageView)
            break;
            
        case .BottomRight:
            layoutBottomRight(imageView)
            break;
        }
    }
    
    private func imageToBoundsWidthRatio(image: UIImage) -> CGFloat {
        return image.size.width / bounds.size.width
    }
    
    private func imageToBoundsHeightRatio(image: UIImage) -> CGFloat {
        return image.size.height / bounds.size.height
    }
    
    private func layoutAspectFit(imageView: UIImageView) {
        
        guard let image = imageView.image else {
            return
        }
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
    
    private func layoutAspectFill(imageView: UIImageView) {
        
        guard let image = imageView.image else {
            return
        }
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
    
    private func layoutFill(imageView: UIImageView) {
        let size = CGSize(width: bounds.size.width, height: bounds.size.height)
        imageViewBoundsToSize(imageView, size: size)
    }
    
    private func layoutCenter(imageView:UIImageView) {
        imageViewBoundsToImageSize(imageView)
        centerImageView(imageView)
    }
    
    private func layoutTop(imageView: UIImageView) {
        guard let image = imageView.image else {
            return
        }
        imageViewBoundsToImageSize(imageView)
        let point = CGPoint(x: bounds.size.width / 2, y: image.size.height / 2)
        centerImageViewToPoint(imageView, point: point)
    }
    
    private func layoutBottom(imageView: UIImageView) {
        guard let image = imageView.image else {
            return
        }
        imageViewBoundsToImageSize(imageView)
        let point = CGPoint(x: bounds.size.width / 2, y: bounds.size.height - image.size.height / 2)
        centerImageViewToPoint(imageView, point: point)
    }
    
    private func layoutLeft(imageView: UIImageView) {
        guard let image = imageView.image else {
            return
        }
        imageViewBoundsToImageSize(imageView)
        let point = CGPoint(x: image.size.width / 2, y: bounds.size.height / 2)
        centerImageViewToPoint(imageView, point: point)
    }
    
    private func layoutRight(imageView: UIImageView) {
        guard let image = imageView.image else {
            return
        }
        imageViewBoundsToImageSize(imageView)
        let point = CGPoint(x: bounds.size.width - image.size.width / 2, y: bounds.size.height / 2)
        centerImageViewToPoint(imageView, point: point)
    }
    
    private func layoutTopLeft(imageView: UIImageView) {
        guard let image = imageView.image else {
            return
        }
        imageViewBoundsToImageSize(imageView)
        let point = CGPoint(x: image.size.width / 2, y: image.size.height / 2)
        centerImageViewToPoint(imageView, point: point)
    }
    
    private func layoutTopRight(imageView: UIImageView) {
        guard let image = imageView.image else {
            return
        }
        imageViewBoundsToImageSize(imageView)
        let point = CGPoint(x: bounds.size.width - image.size.width / 2, y: image.size.height / 2)
        centerImageViewToPoint(imageView, point: point)
    }
    
    private func layoutBottomLeft(imageView: UIImageView) {
        guard let image = imageView.image else {
            return
        }
        imageViewBoundsToImageSize(imageView)
        let point = CGPoint(x: image.size.width / 2, y: bounds.size.height - image.size.height / 2)
        centerImageViewToPoint(imageView, point: point)
    }
    
    private func layoutBottomRight(imageView: UIImageView) {
        guard let image = imageView.image else {
            return
        }
        imageViewBoundsToImageSize(imageView)
        let point = CGPoint(x: bounds.size.width - image.size.width / 2, y: bounds.size.height - image.size.height / 2)
        centerImageViewToPoint(imageView, point: point)
    }
    
    private func updateImageViewToLeft(imageView: UIImageView) {
        
        guard let image = imageView.image else {
            return
        }
        imageViewBoundsToImageSize(imageView)
        centerImageViewToPoint(imageView, point: CGPoint(x: image.size.width / 2, y: bounds.size.height / 2))
    }
    
    private func updateImageViewToRight(imageView: UIImageView) {
        guard let image = imageView.image else {
            return
        }
        imageViewBoundsToImageSize(imageView)
        centerImageViewToPoint(imageView, point: CGPoint(x: bounds.size.width - image.size.width / 2, y: bounds.size.height / 2))
    }
    
    private func centerImageViewToPoint(imageView: UIImageView, point: CGPoint) {
        imageView.center = point
    }
    
    private func imageViewBoundsToImageSize(imageView: UIImageView) {
        guard let image = imageView.image else {
            return
        }
        imageViewBoundsToSize(imageView, size: image.size)
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
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    
    public override var highlightedImage: UIImage? {
        get {
            return imageView.highlightedImage
        }
        set {
            imageView.highlightedImage = newValue
        }
    }
    
    public override var animationImages: [UIImage]? {
        get {
            return imageView.animationImages
        }
        set {
            imageView.animationImages = newValue
        }
    }
    
    public override var highlightedAnimationImages: [UIImage]? {
        get {
            return imageView.highlightedAnimationImages
        }
        set {
            imageView.highlightedAnimationImages = newValue
        }
    }
    
    public override var animationDuration: NSTimeInterval {
        get {
            return imageView.animationDuration
        }
        set {
            imageView.animationDuration = newValue
        }
    }
    
    public override var animationRepeatCount: Int {
        get {
            return imageView.animationRepeatCount
        }
        set {
            imageView.animationRepeatCount = newValue
        }
    }
    
    public override var highlighted: Bool {
        get {
            return imageView.highlighted
        }
        set {
            imageView.highlighted = newValue
        }
    }
    
    public override var tintColor: UIColor! {
        get {
            return imageView.tintColor
        }
        set {
            imageView.tintColor = newValue
        }
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
