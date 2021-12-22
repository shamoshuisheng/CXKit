//
//  CXWebView.h
//  CXKit
//
//  Created by hntnet on 2021/12/15.
//

#import <UIKit/UIKit.h>
#import "BAKit_WebView.h"
#import "CXWebViewModel.h"
#import "CXTools.h"
NS_ASSUME_NONNULL_BEGIN

@interface CXWebView : UIView

@property(nonatomic, strong) CXWebViewModel *model;
@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, assign) CGFloat cell_height;
@property(nonatomic, copy) void (^WebLoadFinish)(CGFloat cell_h);

@end

NS_ASSUME_NONNULL_END
