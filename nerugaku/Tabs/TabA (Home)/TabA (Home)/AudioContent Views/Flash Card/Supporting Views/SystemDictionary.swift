//
//  SystemDictionary.swift
//  nerugaku
//
//  Created by Shunsuke Takagi on 9/24/20.
//  Copyright © 2020 Shunsuke Takagi. All rights reserved.
//

import SwiftUI
import Combine
import WebKit

// MARK: - WebView.swift

//struct WebView: UIViewRepresentable {
//    var loadUrl:String
//
//    func makeUIView(context: Context) -> WKWebView {
//        return WKWebView()
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        uiView.load(URLRequest(url: URL(string: loadUrl)!))
//    }
//}


// MARK: - ContentView
struct SystemDictionary: View {
    
    @ObservedObject var webViewStore = WebViewStore()
//    検索する単語
    @State var word: String
    
    var body: some View {
        NavigationView {
            WebView(webView: webViewStore.webView)
                .navigationBarTitle(Text(verbatim: webViewStore.webView.title ?? ""), displayMode: .inline)
                .navigationBarItems(trailing: HStack {
                    Button(action: goBack) {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                    }.disabled(!webViewStore.webView.canGoBack)
                    Button(action: goForward) {
//                        Text(self.audioContent.phrases[(word)]!.english)
                        Image(systemName: "chevron.right")
                            .imageScale(.large)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                    }.disabled(!webViewStore.webView.canGoForward)
                })
        }.onAppear {
//            検索する単語をもらってくる
            self.webViewStore.webView.load(URLRequest(url: URL(string: "https://ejje.weblio.jp/content/" + word)!))
        }
//        .onDisappear {
//            word = word
//        }
    }
    
    func goBack() {
        webViewStore.webView.goBack()
    }
    
    func goForward() {
        webViewStore.webView.goForward()
    }
}

struct SystemDictionary_Previews: PreviewProvider {
    static var previews: some View {
//        "test"をもらえる場合、testの結果を表示する
        SystemDictionary(word: "test")
    }
}



public class WebViewStore: ObservableObject {
  @Published public var webView: WKWebView {
    didSet {
      setupObservers()
    }
  }
  
  public init(webView: WKWebView = WKWebView()) {
    self.webView = webView
    setupObservers()
  }
  
  private func setupObservers() {
    func subscriber<Value>(for keyPath: KeyPath<WKWebView, Value>) -> NSKeyValueObservation {
      return webView.observe(keyPath, options: [.prior]) { _, change in
        if change.isPrior {
          self.objectWillChange.send()
        }
      }
    }
    // Setup observers for all KVO compliant properties
    observers = [
      subscriber(for: \.title),
      subscriber(for: \.url),
      subscriber(for: \.isLoading),
      subscriber(for: \.estimatedProgress),
      subscriber(for: \.hasOnlySecureContent),
      subscriber(for: \.serverTrust),
      subscriber(for: \.canGoBack),
      subscriber(for: \.canGoForward)
    ]
  }
  
  private var observers: [NSKeyValueObservation] = []
  
  deinit {
    observers.forEach {
      // Not even sure if this is required?
      // Probably wont be needed in future betas?
      $0.invalidate()
    }
  }
}

/// A container for using a WKWebView in SwiftUI
public struct WebView: View, UIViewRepresentable {
  /// The WKWebView to display
  public let webView: WKWebView
  
  public typealias UIViewType = UIViewContainerView<WKWebView>
  
  public init(webView: WKWebView) {
    self.webView = webView
  }
  
  public func makeUIView(context: UIViewRepresentableContext<WebView>) -> WebView.UIViewType {
    return UIViewContainerView()
  }
  
  public func updateUIView(_ uiView: WebView.UIViewType, context: UIViewRepresentableContext<WebView>) {
    // If its the same content view we don't need to update.
    if uiView.contentView !== webView {
      uiView.contentView = webView
    }
  }
}

/// A UIView which simply adds some view to its view hierarchy
public class UIViewContainerView<ContentView: UIView>: UIView {
  var contentView: ContentView? {
    willSet {
      contentView?.removeFromSuperview()
    }
    didSet {
      if let contentView = contentView {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
          contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
          contentView.topAnchor.constraint(equalTo: topAnchor),
          contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
      }
    }
  }
}
