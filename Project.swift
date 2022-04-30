import ProjectDescription
import ProjectDescriptionHelpers

func makeFrameworkTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
    let sources = Target(name: name,
        platform: platform,
        product: .framework,
        bundleId: "dev.geonu.PerformanceDisplay\(name)",
        infoPlist: .default,
        sources: ["Targets/\(name)/Sources/**"],
        resources: [],
        dependencies: dependencies
    )
    let tests = Target(name: "\(name)Tests",
        platform: platform,
        product: .unitTests,
        bundleId: "dev.geonu.PerformanceDisplay\(name)Tests",
        infoPlist: .default,
        sources: ["Targets/\(name)/Tests/**"],
        resources: [],
        dependencies: [.target(name: name)]
    )
    return [sources, tests]
}

func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
    let platform: Platform = platform
    let infoPlist: [String: InfoPlist.Value] = [
        "CFBundleShortVersionString": "1.0",
        "CFBundleVersion": "1",
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen"
        ]

    let mainTarget = Target(
        name: name,
        platform: platform,
        product: .app,
        bundleId: "dev.geonu.PerformanceDisplay",
        infoPlist: .extendingDefault(with: infoPlist),
        sources: ["Targets/\(name)/Sources/**"],
        resources: ["Targets/\(name)/Resources/**"],
        dependencies: dependencies,
        settings: .settings(
            base: .init().automaticCodeSigning(devTeam: "BZJWM2U93W"),
            configurations: [
                .debug(
                    name: "Debug",
                    settings: [
                        "OTHER_LDFLAGS": "-ObjC"
                    ]
                ),
                .release(
                    name: "Release",
                    settings: [
                        "OTHER_LDFLAGS": "-ObjC"
                    ]
                )
            ]
        )
    )

    let testTarget = Target(
        name: "\(name)Tests",
        platform: platform,
        product: .unitTests,
        bundleId: "dev.geonu.PerformanceDisplayTests",
        infoPlist: .default,
        sources: ["Targets/\(name)/Tests/**"],
        dependencies: [.target(name: "\(name)")]
    )
    return [mainTarget, testTarget]
}

let project: Project = .init(
    name: "PerformanceDisplay",
    organizationName: "I4E1",
    targets: [
        makeAppTargets(name: "Application", platform: .iOS, dependencies: [
            .target(name: "Presentation"),
            .target(name: "Data")
        ]),
        makeFrameworkTargets(name: "Presentation", platform: .iOS, dependencies: [
            .target(name: "Domain"),
            .external(name: "SnapKit"),
            .external(name: "RxKingfisher"),
            .external(name: "RxDataSources"),
            .external(name: "RxCocoa")
        ]),
        makeFrameworkTargets(name: "Domain", platform: .iOS, dependencies: [
            .target(name: "Utility")
        ]),
        makeFrameworkTargets(name: "Data", platform: .iOS, dependencies: [
            .target(name: "Domain"),
            .external(name: "RxAlamofire")
        ]),
        makeFrameworkTargets(name: "Utility", platform: .iOS, dependencies: [
            .external(name: "RxSwift"),
            .external(name: "RxRelay"),
            .external(name: "Swinject")
        ])
    ].flatMap { $0 }
)
