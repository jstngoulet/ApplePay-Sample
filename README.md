#       Apple Pay Sample Application
######  Last Updated March 14, 2019

## Introduction
This Sample application is meant to be used as an onboarding tool to new iOS developers at the company.
This tool is set to familiarize the new developer the structure of the live application, how we are manipulating data,
and includes extensive documentation regarding swift in general. Almost every line is documented in the custom classes to allow
for an easy onboarding experience (With the exception of the default AppDelegate as of late).

This project is to demonstrate the ability to learn swift, play around with some extremely basic Reactive Programming techniques, and how our Package Library works. Feel free to clone the project and play around with it to learn.

Upfront, one key difference in this project versus the production application (besides the code size) is also the MVVM architecture/ The Apple Pay Sample Application uses the standard MVC (Model View Controller) as the default as this is the simplest form to create an application that does not need to be extremely portable.

## App Purpose
The purpose of the application, in addition to what is noted in the introduction, is for a developer to see how easy it is to play around with advanced features as Apple Pay in an actual application. You may notice that there is not too much setup, and the language is a breeze to learn.

## Functionality
The application build is a Single View Application. There is not an icon nor launch image as those were not the purpose of this project. Feel free to add your own and submit a merge request ;).

The single view has a header, containing a title label and image, a product, containing a product image, title and description label, and a purchase button. This core functionality is set up similar to our production application.

## Swift Features Utilized
The application utilizes a variety of techniques from the Swift Language. Therein contain Protocols, Delegates, Inheritance, Extensions, global functions, structs, and more. Note that this sample application is a fry cry from what is available in the Swift language (it is extremely limited in functionality)

In addition to default language features, we are using Reactive Programming libraries such as RxSwift (RxCocoa is a subset of RxSwift) to create the relays and observables required. Learn more about RxSwift [here](https://github.com/ReactiveX/RxSwift). To follow a tutorial of basic RxSwift Features, a good tutorial may be found [here](https://medium.com/ios-os-x-development/learn-and-master-%EF%B8%8F-the-basics-of-rxswift-in-10-minutes-818ea6e0a05b).

## Package Manager
Many applications on iOS choose from the 3 primary package managers. While JavaScript may use npm, iOS Devlelopment uses one of the the following:
- [CocoaPods](https://cocoapods.org) - ( __We use this one__ )
- [Carthage](https://github.com/Carthage/Carthage)
- [Swift Package Manager](https://github.com/apple/swift-package-manager)

Note that it is common for developers to utilize a mixture of package managers, though the code base can get messy quickly. Swift Package Manager is relatively new, and does not necessarily have the same packages available. A brief discussion on whether or not to use Carthage of CocoaPods may be found [here](https://medium.com/xcblog/carthage-or-cocoapods-that-is-the-question-1074edaafbcb).

As a quick direction, this article is not 100% correct, but contains some of the generic differences. For example, the CocoaPod community has grown and this blogger may not know that there are tools to make these managers easier. As a direct example, deintragting cocoapods is now extremely easy with a tool called `deintegrate`. It is run by simply calling the command 'pod deintegrate' and is extremely helpful if yu are having difficulties adding a pod to your project. This tool can be found [here](https://github.com/CocoaPods/cocoapods-deintegrate)


## Documentation
For all swift projects at HyreCar, we are utilizing a tool called "Jazzy". This is an automatic documentation generator for Swift, that creates a website for your code-level documentation. Please document every function definition throughly, using the default xcode formatting, to ensure consistency. You may view this projects documentation [here](https://hyrecar-dev.gitlab.io/iOS/applepay-sample), or learn more about Jazzy [here](https://github.com/realm/jazzy).

Once jazzy is installed, you may run the generator (for this project) using the code below in terminal, in the directory where the workspace is stored.

```bash
jazzy \
  --clean \
  --author HyreCar \
  --theme fullwidth \
  --documentation=../*.md \
  --output ../public/docs \
  --min-acl internal
```

## Conclusion
As always, if you have any questions, or would like to learn more, reach out to the iOS team lead at Hyrecar by sending us an [email](mailto:tizzle@hyrecar.com). We would love to hear from you!
