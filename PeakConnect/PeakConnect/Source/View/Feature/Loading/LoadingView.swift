//
//  LoadingView.swift
//  PeakConnect
//
//  Created by 강민성 on 6/2/25.
//

import UIKit
import Then
import SnapKit
import ImageIO

class LoadingView: UIView {
    
    private let gifImageView = UIImageView() // GIF 애니메이션 뷰
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupGif()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupGif()
    }
    
    private func setupView() {
        backgroundColor = .background
        
        addSubview(gifImageView)
        
        gifImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.height.equalTo(150) // 원하는 크기로 조정
        }
    }
    
    private func setupGif() {
        guard let gifUrl = Bundle.main.url(forResource: "LoadingImage", withExtension: "gif"),
              let gifData = try? Data(contentsOf: gifUrl),
              let source = CGImageSourceCreateWithData(gifData as CFData, nil) else {
            print("GIF 파일 로드 실패")
            return
        }
        
        var images: [UIImage] = []
        var duration: Double = 0
        
        let frameCount = CGImageSourceGetCount(source)
        for i in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: cgImage))
                
                let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [CFString: Any]
                if let gifProperties = properties?[kCGImagePropertyGIFDictionary] as? [CFString: Any],
                   let delayTime = gifProperties[kCGImagePropertyGIFDelayTime] as? Double {
                    duration += delayTime
                }
            }
        }
        
        gifImageView.image = UIImage.animatedImage(with: images, duration: duration)
        gifImageView.contentMode = .scaleAspectFit
    }
}
