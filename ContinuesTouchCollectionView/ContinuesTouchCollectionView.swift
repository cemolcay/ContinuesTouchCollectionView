//
//  ContinuesTouchCollectionView.swift
//  ContinuesTouchCollectionView
//
//  Created by Cem Olcay on 21.08.2018.
//  Copyright © 2018 cemolcay. All rights reserved.
//

import UIKit

class ContinuesTouchCollectionView: UICollectionView {
  var lock: Bool = false {
    didSet {
      isScrollEnabled = !lock
    }
  }

  private var highlightedCells = [UICollectionViewCell]() {
    didSet {
      print("highlighted: \(highlightedCells.map({ indexPath(for: $0)?.item }))")
    }
  }
  private var firstHiglightedCells = [UICollectionViewCell]() {
    didSet {
      print("first: \(firstHiglightedCells.map({ indexPath(for: $0)?.item }))")
    }
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)

    // Add first highlighted cells
    for touch in touches {
      let location = touch.location(in: self)
      if let indexPath = indexPathForItem(at: location),
        let cell = cellForItem(at: indexPath) {
        if !firstHiglightedCells.contains(cell) {
          firstHiglightedCells.append(cell)
          highlightedCells.append(cell)
        }
      }
    }
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    var unhighlightingCells = [UICollectionViewCell]()

    for touch in touches {
      let location = touch.location(in: self)
      if let indexPath = indexPathForItem(at: location),
        let cell = cellForItem(at: indexPath) {

        // Highlight new cell
        if !highlightedCells.contains(cell) {
          highlightedCells.append(cell)
          if !firstHiglightedCells.contains(cell) {
            cell.isHighlighted = true
            delegate?.collectionView?(self, didHighlightItemAt: indexPath)
          }
        }
      }

      // Unhighlighting cells
      for cell in highlightedCells {
        if cell.frame.contains(location),
          let index = unhighlightingCells.index(of: cell) {
          unhighlightingCells.remove(at: index)
        } else if !cell.frame.contains(location) {
          unhighlightingCells.append(cell)
        }
      }
    }

    // Unhighlight cells
    for cell in unhighlightingCells {
      if !firstHiglightedCells.contains(cell),
        let indexPath = indexPath(for: cell) {
        cell.isHighlighted = false
        delegate?.collectionView?(self, didUnhighlightItemAt: indexPath)
      }
    }

    highlightedCells = highlightedCells.filter({ !unhighlightingCells.contains($0) })

//    guard lock == true,
//      let touchLocation = touches.first?.location(in: self),
//      let cell = visibleCells.filter({ $0.frame.contains(touchLocation) }).first,
//      let newIndexPath = indexPath(for: cell),
//      cell != highlightedCell,
//      let oldCell = highlightedCell,
//      let oldIndexPath = indexPath(for: oldCell)
//      else { return }
//
//    // Unselect old cell
//    if highlightedCell != firstHiglightedCell {
//      highlightedCell?.isHighlighted = false
//      delegate?.collectionView?(self, didUnhighlightItemAt: oldIndexPath)
//    }
//
//    // Select new cell
//    if cell != firstHiglightedCell {
//      cell.isHighlighted = true
//      delegate?.collectionView?(self, didHighlightItemAt: newIndexPath)
//    }
//
//    // Set new highlighed cell
//    highlightedCell = cell
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)

    for touch in touches {
      let location = touch.location(in: self)
      if let indexPath = indexPathForItem(at: location),
        let cell = cellForItem(at: indexPath) {
        if !firstHiglightedCells.contains(cell),
          let index = highlightedCells.index(of: cell) {
          highlightedCells.remove(at: index)
          cell.isHighlighted = false
          delegate?.collectionView?(self, didUnhighlightItemAt: indexPath)
        } else if let firstHighlightedIndex = firstHiglightedCells.index(of: cell),
          let highlightedIndex = highlightedCells.index(of: cell) {
          firstHiglightedCells.remove(at: firstHighlightedIndex)
          highlightedCells.remove(at: highlightedIndex)
        }
      }
    }

//    guard lock == true,
//      let cell = highlightedCell,
//      let cellIndexPath = indexPath(for: cell)
//      else { return }
//
//    if cell != firstHiglightedCell {
//      cell.isHighlighted = false
//      delegate?.collectionView?(self, didUnhighlightItemAt: cellIndexPath)
//    }
//
//    highlightedCell = nil
//    firstHiglightedCell = nil
  }

  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)

    for touch in touches {
      let location = touch.location(in: self)
      if let indexPath = indexPathForItem(at: location),
        let cell = cellForItem(at: indexPath) {
        if !firstHiglightedCells.contains(cell),
          let index = highlightedCells.index(of: cell) {
          highlightedCells.remove(at: index)
          cell.isHighlighted = false
          delegate?.collectionView?(self, didUnhighlightItemAt: indexPath)
        } else if let firstHighlightedIndex = firstHiglightedCells.index(of: cell),
          let highlightedIndex = highlightedCells.index(of: cell) {
          firstHiglightedCells.remove(at: firstHighlightedIndex)
          highlightedCells.remove(at: highlightedIndex)
        }
      }
    }

//    guard lock == true,
//      let cell = highlightedCell,
//      let cellIndexPath = indexPath(for: cell)
//      else { return }
//
//    if cell != firstHiglightedCell {
//      cell.isHighlighted = false
//      delegate?.collectionView?(self, didUnhighlightItemAt: cellIndexPath)
//    }
//
//    highlightedCell = nil
//    firstHiglightedCell = nil
  }
}
