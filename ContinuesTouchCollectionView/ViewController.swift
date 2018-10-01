//
//  ViewController.swift
//  ContinuesTouchCollectionView
//
//  Created by Cem Olcay on 21.08.2018.
//  Copyright © 2018 cemolcay. All rights reserved.
//

import UIKit

class ExampleCell: ContinuesTouchCollectionViewCell {
  static let cellReuseIdentifier = "exampleCell"
  @IBOutlet var label: UILabel?

  override func prepareForReuse() {
    label?.text = nil
  }

  override var isTouching: Bool {
    didSet {
      backgroundColor = isTouching ? .lightGray : .darkGray
    }
  }
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ContinuesTouchCollectionViewCellDelegate {
  @IBOutlet weak var collectionView: ContinuesTouchCollectionView?
  @IBOutlet weak var lockSegmentedControl: UISegmentedControl?

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView?.delaysContentTouches = false
    collectionView?.dataSource = self
    collectionView?.delegate = self
  }

  @IBAction func lockSegmentControlValueChanged(sender: UISegmentedControl) {
    collectionView?.isLocked = sender.selectedSegmentIndex == 0
  }

  // MARK: UICollectionViewDataSource

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExampleCell.cellReuseIdentifier, for: indexPath) as? ExampleCell else { fatalError() }
    cell.label?.text = "\(indexPath.item)"
    cell.delegate = self
    return cell
  }

  // MARK: ContinuesTouchCollectionViewCellDelegate

  func continuesTouchCollectionViewCellDidStartTouching(_ continuesToucCollectionViewCell: ContinuesTouchCollectionViewCell) {
    guard let indexPath = collectionView?.indexPath(for: continuesToucCollectionViewCell) else { return }
    print("select \(indexPath.item)")
  }

  func continuesTouchCollectionViewCellDidStopTouching(_ continuesToucCollectionViewCell: ContinuesTouchCollectionViewCell) {
    guard let indexPath = collectionView?.indexPath(for: continuesToucCollectionViewCell) else { return }
    print("deselect \(indexPath.item)")
  }
}
