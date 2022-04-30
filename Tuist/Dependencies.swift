import ProjectDescription

let dependencies: Dependencies = .init(
    swiftPackageManager: [
        .remote(
            url: "https://github.com/ReactiveX/RxSwift.git",
            requirement: .upToNextMajor(from: "6.5.0")
        ),
        .remote(
            url: "https://github.com/RxSwiftCommunity/RxDataSources.git",
            requirement: .upToNextMajor(from: "5.0.2")
        ),
        .remote(
            url: "https://github.com/RxSwiftCommunity/RxAlamofire.git",
            requirement: .upToNextMajor(from: "6.1.2")
        ),
        .remote(
            url: "https://github.com/RxSwiftCommunity/RxKingfisher.git",
            requirement: .upToNextMajor(from: "2.1.0")
        ),
        .remote(
            url: "https://github.com/SnapKit/SnapKit.git",
            requirement: .upToNextMajor(from: "5.6.0")
        )
    ]
)
