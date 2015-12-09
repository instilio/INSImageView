# INSImageView
[![Version](https://img.shields.io/cocoapods/v/INSImageView.svg?style=flat)](http://cocoapods.org/pods/INSImageView)
[![License](https://img.shields.io/cocoapods/l/INSImageView.svg?style=flat)](http://cocoapods.org/pods/INSImageView)
[![Platform](https://img.shields.io/cocoapods/p/INSImageView.svg?style=flat)](http://cocoapods.org/pods/INSImageView)

## Description
A UIImageView that allows for animations between UIViewContentModes through the use of UIView block-based animations e.g. UIView.animateWithDuration...

## Compatibility
Tested with iOS8 and iOS9

## Usage
```
imageView.contentMode = .ScaleAspectFit

UIView.animateWithDuration(1,
    animations: {
      self.imageView.contentMode = .ScaleAspectFill
    }
)
```

## Contact
Patrick, patbdev@gmail.com

## License
PBImageView is available under the MIT license. See the LICENSE file for more info.
