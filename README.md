# swift-project-architecture

打造一个 iOS 项目的初始模版，新项目可以直接套用。

## 工程结构

```sh
.
├── Configurations # 存放配置
└── SwiftArchitecture # 项目目录
    ├── AppDelegate.swift
    ├── Resources # 资源文件目录
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

在 `Targets - Built Settings` 的 `Other Swift Flags` 中添加 `-warnings-as-errors`，作用是把所有的警告当作错误来处理。不需要的话删掉添加的设置即可。

### 静态分析器

> 电脑性能不够或者嫌慢可以关掉（不推荐）

在 `Built Setting` 的 `Static Analyzer` 中，开启 `Analyze during 'Build'` 设置，让每次编译构建时都运行浅层的代码分析。同时将 `Mode of Analysis for 'Analyze'` 设置为 `Shallow`，`Mode of Analysis for 'Build'` 设置为 `Deep`。

## 编译配置

调整配置文件结构，在 `Configurations/Common.xcconfig` 中，进行通用配置。在其他配置文件中 `include` 通用配置与 `Pod` 配置，之后可以分别针对不同环境做出其他优化。

分别在不同的配置文件中添加了 `CONFIG_FLAG`，紧接着在 `Project - Build Settings - Other Swift Flags` 中添加 `-D${CONFIG_FLAG}`，`Targets - Built Settings` 的 `Other Swift Flags` 中添加 `$(inherited)`。

完成之后就可以做到在 `Constants.swift` 根据环境返回不同值了。

## TODO

- [ ] 添加 Fastlane
- [ ] 添加统计框架
- [ ] 添加日志记录组件

## 参考

- [iOS Good Practices](https://github.com/futurice/ios-good-practices)
- [Clean Swift Architecture](https://clean-swift.com/clean-swift-ios-architecture)
- [SwiftLint](https://github.com/realm/SwiftLint)
- [Swift Code Naming](https://swift.org/documentation/api-design-guidelines/)
- [用 xcconfig 文件配置 iOS 环境变量](https://www.jianshu.com/p/9b8bc8351223)

