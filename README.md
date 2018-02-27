# swift-project-architecture

打造一个 iOS 项目的初始模版，新项目可以直接套用。

## 工程结构

```sh
.
└── SwiftArchitecture # 项目目录
    ├── AppDelegate.swift
    ├── Assets.xcassets # 资源文件目录
    ├── Common # 公共数据目录
    ├── Models # 实体目录
    ├── Services # 数据操作目录
    ├── Scenes # 场景目录
    │   └── Main # 具体场景目录
    │       └── MainViewController.swift
    └── Utils # 工具目录
```

## 功能概要

- CocoaPod 依赖管理
- 明确工程结构
- SwiftLint

## 诊断

### 编译警告

在 `Built Setting` 的 `Other Swift Flags` 中添加 `-warnings-as-errors`，作用是把所有的警告当作错误来处理。不需要的话删掉添加的设置即可。

### 静态分析器

> 电脑性能不够或者嫌慢可以关掉（不推荐）

在 `Built Setting` 的 `Static Analyzer` 中，开启 `Analyze during 'Build'` 设置，让每次编译时都运行浅层的代码分析。同时将 `Mode of Analysis for 'Analyze'` 设置为 `Shallow`，`Mode of Analysis for 'Build'` 设置为 `Deep`。

## TODO

- [ ] 添加 Fastlane
- [ ] 添加统计框架
- [ ] 添加日志记录组件

## 参考

- [iOS Good Practices](https://github.com/futurice/ios-good-practices)
- [Clean Swift Architecture](https://clean-swift.com/clean-swift-ios-architecture)
- [SwiftLint](https://github.com/realm/SwiftLint)
- [Swift Code Naming](https://swift.org/documentation/api-design-guidelines/)


