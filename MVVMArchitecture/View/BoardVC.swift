//
//  BoardVC.swift
//  MVVMArchitecture
//
//  Created by Tejas Patel on 24/10/23.
//

import UIKit

//Chess Game
//https://github.com/nicklockwood/Chess

class BoardVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet weak var colWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let deviceWidth = UIScreen.main.bounds.size.width
        let cellWidth = floor(deviceWidth / 8)
        let collectionViewWidth = 8 * cellWidth
        self.colWidthConstraint.constant = collectionViewWidth
        colView.delegate = self
        colView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colView.dequeueReusableCell(withReuseIdentifier: "unique", for: indexPath)
        
        let chessRow = indexPath.row / 8
        if chessRow % 2 == 0 {
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.white
            }else{
                cell.backgroundColor = UIColor.black
            }
        } else{
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.black
            }else{
                cell.backgroundColor = UIColor.white
            }
        }
        
        return cell
    }
}

//struct ChessboardView: View {
//    @State private var matrixSizeText = ""
//    @State private var matrixSize = 0
//
//    var body: some View {
//        VStack {
//            TextField("Enter matrix size", text: $matrixSizeText, onCommit: {
//                if let size = Int(matrixSizeText) {
//                    matrixSize = size
//                }
//            })
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//            .padding()
//
//            if matrixSize > 0 {
//                ForEach(0..<matrixSize, id: \.self) { row in
//                    HStack {
//                        ForEach(0..<matrixSize, id: \.self) { column in
//                            Rectangle()
//                                .frame(width: 50, height: 50)
//                                .foregroundColor(.blue)
//                        }
//                    }
//                }
//            }
//        }
//        .padding()
//    }
//}
