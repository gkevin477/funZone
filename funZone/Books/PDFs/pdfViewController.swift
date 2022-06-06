//
//  pdfViewController.swift
//  funZone
//
//  Created by admin on 6/4/22.
//

import UIKit
import PDFKit

class pdfViewController: UIViewController{
    
    //views
    let pdfView = PDFView()
    public var book: String = ""
    
    @IBOutlet weak var viewLayout: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(pdfView)
        // Document
        guard let url = Bundle.main.url(forResource: book, withExtension: "pdf") else{
            return
        }
        
        guard let document = PDFDocument(url: url) else{
            return
        }
        
        pdfView.document = document
        pdfView.autoScales = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pdfView.frame = view.bounds
    }
    
}
