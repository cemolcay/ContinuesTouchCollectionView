ContinuesTouchCollectionView
====

A collection view subview for handling multiple touch on cells.

Demo
----

![alt tag](https://github.com/cemolcay/ContinuesTouchCollectionView/raw/master/Demo.gif)


Install
----

``` ruby
pod 'ContinuesTouchCollectionView'
```

Requirements
----

* Swift 4.2+
* iOS 9.0+
 

Usage
----

* Create a `ContinuesTouchCollectionView` instance and populate `ContinuesTouchCollectionViewCell`s on it.  
* You can set `isLocked` property to true for disabling the scrolling on collection view and enabling multiple touches. 
* When you are populating your cells, set `ContinuesTouchCollectionViewCellDelegate` to the view controller you are working on.
* Get informed when your cells started or stopped being touched with the delegate methods.

``` swift
public protocol ContinuesTouchCollectionViewCellDelegate: class {
  func continuesTouchCollectionViewCellDidStartTouching(_ continuesToucCollectionViewCell: ContinuesTouchCollectionViewCell)
  func continuesTouchCollectionViewCellDidStopTouching(_ continuesToucCollectionViewCell: ContinuesTouchCollectionViewCell)
}
```

* You may also override `isTouching` property inside your cell class in order to make it responding highlight colors.
* Use `isTouching` instead of `isHihglighed` property.

``` swift
override var isTouching: Bool {
	didSet {
	  backgroundColor = isTouching ? .lightGray : .darkGray
	}
}
```

* Check out the example project for the implementation.

AppStore
----

This library is used in my app [ScaleBud](https://itunes.apple.com/us/app/scalebud-auv3-midi-keyboard/id1409125865?ls=1&mt=8) (iOS, AUv3) in the app store, check it out!
