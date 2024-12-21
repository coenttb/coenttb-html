# coenttb-html

`coenttb-html` extends [coenttb/swift-html](https://www.github.com/coenttb/swift-html) with additional functionality and integrations for HTML, Markdown, Email, and printing HTML to PDF.

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

This package is currently in active development and is subject to frequent changes. Features and APIs may change without prior notice until a stable release is available.

## FAQ

**How do I use the HTML & CSS DSL?**

See the [swift-html github repository](https://www.github.com/coenttb/swift-html) for more details on how to use the `swift-html` DSL.

**Can I use this with existing Swift web frameworks like Vapor?**

Yes, you can! Conform your HTMLDocument to AsyncResponseEncodable to serve it through Vapor. See [coenttb-com-server](https://www.github.com/coenttb/coenttb-com-server) for an example implementation.

## Related Projects

* [coenttb/pointfree-html](https://www.github.com/coenttb/swift-css): A Swift DSL for type-safe HTML forked from [pointfreeco/swift-html](https://www.github.com/pointfreeco/swift-html) and updated to the version on [pointfreeco/pointfreeco](https://github.com/pointfreeco/pointfreeco).
* [coenttb/swift-css](https://www.github.com/coenttb/swift-css): A Swift DSL for type-safe CSS.
* [coenttb/swift-html](https://www.github.com/coenttb/swift-html): A Swift DSL for type-safe HTML & CSS, integrating [swift-css](https://www.github.com/coenttb/swift-css) and [coenttb/pointfree-html](https://www.github.com/coenttb/pointfree-html).
* [coenttb/swift-web](https://www.github.com/coenttb/swift-web): Modular tools to simplify web development in Swift forked from  [pointfreeco/swift-web](https://www.github.com/pointfreeco/swift-web), and updated for use in [coenttb/coenttb-web](https://www.github.com/coenttb/coenttb-web).
* [coenttb/coenttb-web](https://www.github.com/coenttb/coenttb-web): A collection of features for your Swift server, with integrations for Vapor.
* [coenttb/coenttb-com-server](https://www.github.com/coenttb/coenttb-com-server): The backend server for coenttb.com, written entirely in Swift and powered by [Vapor](https://www.github.com/vapor/vapor) and [coenttb-web](https://www.github.com/coenttb/coenttb-web).
* [coenttb/swift-languages](https://www.github.com/coenttb/swift-languages): A cross-platform translation library written in Swift.

## Installation

You can add `coenttb-html` to an Xcode project by including it as a package dependency:

Repository URL: https://github.com/coenttb/coenttb-html

For a Swift Package Manager project, add the dependency in your Package.swift file:
```
dependencies: [
  .package(url: "https://github.com/coenttb/coenttb-html", branch: "main")
]
```

## Feedback is much appreciated!

If you’re working on your own Swift project, feel free to learn, fork, and contribute.

Got thoughts? Found something you love? Something you hate? Let me know! Your feedback helps make this project better for everyone. Open an issue or start a discussion—I’m all ears.

> [Subscribe to my newsletter](http://coenttb.com/en/newsletter/subscribe)
>
> [Follow me on X](http://x.com/coenttb)
> 
> [Link on Linkedin](https://www.linkedin.com/in/tenthijeboonkkamp)


## License

This project is licensed under the **GNU Affero General Public License v3.0 (AGPL-3.0)**.  
You are free to use, modify, and distribute this project under the terms of the AGPL-3.0.  
For full details, please refer to the [LICENSE](LICENSE) file.

### Commercial Licensing

A **Commercial License** is available for organizations or individuals who wish to use this project without adhering to the terms of the AGPL-3.0 (e.g., to use it in proprietary software or SaaS products).  

For inquiries about commercial licensing, please contact **info@coenttb.com**.
