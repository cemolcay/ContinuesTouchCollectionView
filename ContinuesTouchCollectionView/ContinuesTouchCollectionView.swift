//
//  ContinuesTouchCollectionView.swift
//  ContinuesTouchCollectionView
//
//  Created by Cem Olcay on 21.08.2018.
//  Copyright © 2018 cemolcay. All rights reserved.
//

import UIKit

extension UITouch {
  /// Returns touch id in string format.
  public var touchID: String {
    return String(format: "%p", self)
  }
}

/// Informs touch state changes.
public protocol ContinuesTouchCollectionViewCellDelegate: class {
  /// Gets called when a cell is started touching.
  ///
  /// - Parameter cell: The cell started touching.
  func continuesTouchCollectionViewCellDidStartTouching(_ cell: ContinuesTouchCollectionViewCell)

  /// Gets called when a cell is stopped touching.
  ///
  /// - Parameter cell: The cell stopped touching.
  func continuesTouchCollectionViewCellDidStopTouching(_ cell: ContinuesTouchCollectionViewCell)
}

/// The custom collection view cell type for working with `ContinuesTouchCollectionView`. You can
open class ContinuesTouchCollectionViewCell: UICollectionViewCell {
  /// Delegate that informs about touch state changes.
  public weak var delegate: ContinuesTouchCollectionViewCellDelegate?

  /// Assigned touch id if cell is being touched.
  fileprivate var touchID: String? {
    didSet {
      isTouching = touchID != nil
    }
  }

  /// Returns true if cell is currently touching.
  open var isTouching: Bool = false {
    didSet {
      if isTouching {
        delegate?.continuesTouchCollectionViewCellDidStartTouching(self)
      } else {
        delegate?.continuesTouchCollectionViewCellDidStopTouching(self)
      }
    }
  }
}

/// Custom collection view that responds multiple touches of `ContinuesTouchCollectionViewCell`s.
open class ContinuesTouchCollectionView: UICollectionView {
  /// Currently touching cells.
  public private(set) var touchingCells = [ContinuesTouchCollectionViewCell]()

  /// Scroll locking mechanisim for enabling the multiple touch on cells.
  open var isLocked: Bool = false {
    didSet {
      isScrollEnabled = !isLocked
    }
  }

  open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)

    for touch in touches {
      let location = touch.location(in: self)
      if let indexPath = indexPathForItem(at: location),
        let cell = cellForItem(at: indexPath) as? ContinuesTouchCollectionViewCell,
        !cell.isTouching {
        cell.touchID = touch.touchID
        touchingCells.append(cell)
      }
    }
  }

  open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    var untouchingCells = [ContinuesTouchCollectionViewCell]()

    for touch in touches {
      let location = touch.location(in: self)

      if let indexPath = indexPathForItem(at: location),
        let cell = cellForItem(at: indexPath) as? ContinuesTouchCollectionViewCell,
        !cell.isTouching {

        if let untouchingCell = touchingCells.filter({ $0.touchID == touch.touchID }).first {
          untouchingCells.append(untouchingCell)
        }

        cell.touchID = touch.touchID
        touchingCells.append(cell)
      }
    }

    untouchingCells.forEach({ $0.touchID = nil })
    touchingCells = touchingCells.filter({ !untouchingCells.contains($0) })
  }

  open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    var untouchingCells = [ContinuesTouchCollectionViewCell]()

    for touch in touches {
      if let untouchingCell = touchingCells.filter({ $0.touchID == touch.touchID }).first {
        untouchingCells.append(untouchingCell)
      }
    }

    untouchingCells.forEach({ $0.touchID = nil })
    touchingCells = touchingCells.filter({ !untouchingCells.contains($0) })
  }

  open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)
    var untouchingCells = [ContinuesTouchCollectionViewCell]()

    for touch in touches {
      if let untouchingCell = touchingCells.filter({ $0.touchID == touch.touchID }).first {
        untouchingCells.append(untouchingCell)
      }
    }

    untouchingCells.forEach({ $0.touchID = nil })
    touchingCells = touchingCells.filter({ !untouchingCells.contains($0) })
  }
}
