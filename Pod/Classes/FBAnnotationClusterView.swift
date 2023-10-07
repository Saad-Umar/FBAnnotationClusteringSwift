//
//  FBAnnotationClusterView.swift
//  FBAnnotationClusteringSwift
//
//  Created by Robert Chen on 4/2/15.
//  Copyright (c) 2015 Robert Chen. All rights reserved.
//

import Foundation
import MapKit

public class FBAnnotationClusterView : MKAnnotationView {

	private var configuration: FBAnnotationClusterViewConfiguration
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

	private let countLabel: UILabel = {
		let label = UILabel()
		label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		label.textAlignment = .center
		label.backgroundColor = UIColor(named: "AppBlue")
		label.textColor = UIColor.white
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 2
		label.numberOfLines = 1
		label.baselineAdjustment = .alignCenters
		return label
	}()

	public override var annotation: MKAnnotation? {
		didSet {
			updateClusterSize()
		}
	}
    
    public convenience init(annotation: MKAnnotation?, reuseIdentifier: String?, configuration: FBAnnotationClusterViewConfiguration, image: UIImage?){
        self.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
		self.configuration = configuration
		self.setupView()
        self.imageView.image = image
    }

	public override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
		self.configuration = FBAnnotationClusterViewConfiguration.default()
		super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
		self.setupView()
	}

    required public init?(coder aDecoder: NSCoder) {
		self.configuration = FBAnnotationClusterViewConfiguration.default()
        super.init(coder: aDecoder)
		self.setupView()
    }
    
    private func setupView() {
		backgroundColor = UIColor.clear
		layer.borderColor = UIColor.clear.cgColor
        addSubview(imageView)
        imageView.addSubview(countLabel)
    }

	private func updateClusterSize() {
		if let cluster = annotation as? FBAnnotationCluster {

			let count = cluster.annotations.count
			let template = configuration.templateForCount(count: count)

			switch template.displayMode {
			case .Image(let imageName):
				//image = UIImage(named: imageName)
				break
			case .SolidColor(let sideLength, let color):
                imageView.backgroundColor = color
                backgroundColor	= .clear
				frame = CGRect(origin: frame.origin, size: CGSize(width: 60, height: 60))
				break
			} 

			layer.borderWidth = template.borderWidth
            if count <= 99 {
                countLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)//template.font
            } else if count > 99 && count <= 999 {
                countLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)//template.font
            } else if count > 999 {
                countLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)//template.font
            }
			countLabel.text = "\(count)"

			setNeedsLayout()
		}
	}

    override public func layoutSubviews() {
		super.layoutSubviews()
        imageView.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        imageView.layer.cornerRadius = 7
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
//        let fixedSize = CGSize(width: 20, height: 20)
//        let size = countLabel.sizeThatFits(fixedSize)
//        countLabel.frame = CGRect(x: bounds.width - 15, y: 5, width: size.width + 7 > 20 ? size.width + 7 : 20, height: 20)
//        countLabel.clipsToBounds = true
//        countLabel.layer.cornerRadius = 20/2
        countLabel.frame = imageView.bounds
		//layer.cornerRadius = 7//image == nil ? bounds.size.width / 2 : 0
    }
}
