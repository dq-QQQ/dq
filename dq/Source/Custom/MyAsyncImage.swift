//
//  CustomAsyncImage.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/09/09.
//
// MyAsyncImage is designed following the structure of AsyncImage.
//
// AsyncImage can use after iOS 15.0.
// If you test or release for iOS 14.0 or earlier, Use MyAsyncImage.
//
// @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
// public struct AsyncImage<Content> : View where Content : View
/// Loads and displays an image from the specified URL.
///
/// Until the image loads, SwiftUI displays a default placeholder. When
/// the load operation completes successfully, SwiftUI updates the
/// view to show the loaded image. If the operation fails, SwiftUI
/// continues to display the placeholder. The following example loads
/// and displays an icon from an example server:
///
///     AsyncImage(url: URL(string: "https://example.com/icon.png"))
///     MyAsyncImage(url: URL(string: "https://example.com/icon.png"))

import Foundation
import SwiftUI

public enum MyAsyncImagePhase {
    /// No image is loaded.
    case empty

    /// An image succesfully loaded.
    case success(Image)

    /// An image failed to load with an error.
    case failure(Error)

    /// The loaded image, if any.
    /// If this value isn't `nil`, the image load operation has finished,
    /// and you can use the image to update the view. You can use the image
    /// directly, or you can modify it in some way. For example, you can add
    /// a ``Image/resizable(capInsets:resizingMode:)`` modifier to make the
    /// image resizable.
    public var image: Image? {
        switch self {
        case .empty, .failure:
            return nil
        case .success(let image):
            return image
        }
    }

    /// The error that occurred when attempting to load an image, if any.
    public var error: Error? {
        switch self {
        case .empty, .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

public struct MyAsyncImage<Content> : View where Content : View {
    private let url: URL?
    private let content: (MyAsyncImagePhase) -> Content
    
    // In AsyncImage, There are scale and transaction additionally. Explanation below
    //  scale: The scale to use for the image. The default is `1`. Set a
    ///     different value when loading images designed for higher resolution
    ///     displays. For example, set a value of `2` for an image that you
    ///     would name with the `@2x` suffix if stored in a file on disk.
    // transaction: The transaction to use when the phase changes.
    // In MyAsyncImage, i think scale and transaction isn't needed.
    // always image will be framed and image's phase never changed.
    
    //     AsyncImage(url: URL(string: "https://example.com/icon.png"))
    //
    /// - Parameters:
    ///   - url: The URL of the image to display.
    public init(url: URL?) where Content == Image {
        self.url = url
        self.content = { $0.image ?? Image("") }
    }
    
    //     AsyncImage(url: URL(string: "https://example.com/icon.png")) { image in
    //         image.resizable(resizingMode: .tile)
    //     } placeholder: {
    //         Color.green
    //     }
    ///
    /// - Parameters:
    ///   - url: The URL of the image to display.
    ///   - content: A closure that takes the loaded image as an input, and
    ///     returns the view to show. You can return the image directly, or
    ///     modify it as needed before returning it.
    ///   - placeholder: A closure that returns the view to show until the
    ///     load operation completes successfully.
    public init<I, P>(url: URL?,
                      @ViewBuilder content: @escaping (Image) -> I,
                      @ViewBuilder placeholder: @escaping () -> P) where Content == _ConditionalContent<I, P>, I : View, P : View {
        self.url = url
        self.content = { phase -> _ConditionalContent<I, P> in
            if let image = phase.image {
                return ViewBuilder.buildEither(first: content(image))
            } else {
                return ViewBuilder.buildEither(second: placeholder())
            }
        }
    }

    public var body: some View {
            ContentBody(url: url, content: content)
    }
}

private struct ContentBody<Content: View>: View {
    @State var phase: MyAsyncImagePhase = .empty
    private let url: URL?
    private let content: (MyAsyncImagePhase) -> Content
    
    init(url: URL?, @ViewBuilder content: @escaping (MyAsyncImagePhase) -> Content) {
        self.url = url
        self.content = content
    }

    var body: some View {
        content(phase)
            .onAppear {
                task(url: url)
            }
    }
    
    func task(url: URL?) {
        guard let url = url else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.phase = .failure(error)
                    return
                }
                self.phase = self.image(from: data)
                        .map{ MyAsyncImagePhase.success($0) }
                        ?? .empty
            }
        }
        .resume()
    }

    private func image(from data: Data?) -> Image? {
        return data
            .flatMap { UIImage(data: $0) }
            .map(Image.init(uiImage:))
    }
}
