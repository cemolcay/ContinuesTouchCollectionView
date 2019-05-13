#
#  Be sure to run `pod spec lint ContinuesTouchCollectionView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "ContinuesTouchCollectionView"
  spec.version      = "0.0.2"
  spec.summary      = "A collection view subview for handling multiple touch on cells."
  spec.swift_version = "5.0"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
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
                   DESC

  spec.homepage     = "https://github.com/cemolcay/ContinuesTouchCollectionView"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  spec.license      = "MIT"
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "cemolcay" => "ccemolcay@gmail.com" }
  # Or just: spec.author    = "cemolcay"
  # spec.authors            = { "cemolcay" => "ccemolcay@gmail.com" }
  # spec.social_media_url   = "https://twitter.com/cemolcay"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # spec.platform     = :ios
  spec.platform     = :ios, "9.0"

  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "https://github.com/cemolcay/ContinuesTouchCollectionView.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  spec.source_files  = "ContinuesTouchCollectionView/ContinuesTouchCollectionView.swift"
  # spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
