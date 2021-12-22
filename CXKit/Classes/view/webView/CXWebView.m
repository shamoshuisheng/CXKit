//
//  CXWebView.m
//  CXKit
//
//  Created by hntnet on 2021/12/15.
//

#import "CXWebView.h"
@interface CXWebView()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic, strong) WKWebViewConfiguration *webConfig;

@end

@implementation CXWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    self.frame = frame;
    
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.webView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

}


- (void)setModel:(CXWebViewModel *)model
{
    _model = model;
    
    if (self.model.height == 100)
    {
        
        if (_model.urlStr) {
            if (_model.isLocal) {
                NSData *data = [NSData dataWithContentsOfFile:_model.urlStr];
                [self.webView loadData:data  MIMEType:@"application/vnd.openxmlformats-officedocument.wordprocessingml.document" characterEncodingName:@"UTF-8" baseURL:nil];

                
            }else{
                [self.webView ba_web_loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_model.urlStr]]];
            }
          
        }else{
            NSArray *arrP = [CXFounctionTool getAllRangeOfSubString:@"<p>" inString:self.model.content];
            for (NSValue *value in arrP) {
                NSRange range = [value rangeValue];
                [self.model.content stringByReplacingCharactersInRange:range withString:@"<div>"];
            }
            NSArray *arr = [CXFounctionTool getAllRangeOfSubString:@"</p>" inString:self.model.content];
            for (NSValue *value in arr) {
                NSRange range = [value rangeValue];
                [self.model.content stringByReplacingCharactersInRange:range withString:@"</div>"];
            }
            
            NSString *header = @"<head><style>img{width:100% !important}</style></head>";
            self.model.content  = [NSString stringWithFormat:@"%@%@",header,self.model.content];
            
                [self.webView ba_web_loadHTMLString:self.model.content];

           
        }
    }
}

- (WKWebView *)webView
{
    CXWeakSelf(self)
    if (!_webView)
    {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.webConfig];
        _webView = [WKWebView new];
        _webView.ba_web_isAutoHeight = YES;
        //  添加 WKWebView 的代理，注意：用此方法添加代理
        
        [_webView ba_web_initWithDelegate:weakself.webView uIDelegate:weakself.webView];
        
        _webView.backgroundColor = BAKit_Color_Yellow_pod;
        _webView.userInteractionEnabled = YES;
        _webView.navigationDelegate = self;
        self.webView.ba_web_getCurrentHeightBlock = ^(CGFloat currentHeight) {

            weakself.cell_height = currentHeight;
//            NSLog(@"html 高度2：%f", currentHeight);

            if (weakself.WebLoadFinish)
            {
                weakself.WebLoadFinish(weakself.cell_height);
            };
        };

        
        [self addSubview:_webView];
    }
    return _webView;
}

- (WKWebViewConfiguration *)webConfig
{
    if (!_webConfig) {
        
        // 创建并配置WKWebView的相关参数
        // 1.WKWebViewConfiguration:是WKWebView初始化时的配置类，里面存放着初始化WK的一系列属性；
        // 2.WKUserContentController:为JS提供了一个发送消息的通道并且可以向页面注入JS的类，WKUserContentController对象可以添加多个scriptMessageHandler；
        // 3.addScriptMessageHandler:name:有两个参数，第一个参数是userContentController的代理对象，第二个参数是JS里发送postMessage的对象。添加一个脚本消息的处理器,同时需要在JS中添加，window.webkit.messageHandlers.<name>.postMessage(<messageBody>)才能起作用。
        
        _webConfig = [[WKWebViewConfiguration alloc] init];
        _webConfig.allowsInlineMediaPlayback = YES;
        
        //        _webConfig.allowsPictureInPictureMediaPlayback = YES;
        
        // 通过 JS 与 webView 内容交互
        // 注入 JS 对象名称 senderModel，当 JS 通过 senderModel 来调用时，我们可以在WKScriptMessageHandler 代理中接收到
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        //        [userContentController addScriptMessageHandler:self name:@"BAShare"];
        _webConfig.userContentController = userContentController;
        
        // 初始化偏好设置属性：preferences
        _webConfig.preferences = [WKPreferences new];
        // The minimum font size in points default is 0;
        _webConfig.preferences.minimumFontSize = 80;
        // 是否支持 JavaScript
        _webConfig.preferences.javaScriptEnabled = YES;
        // 不通过用户交互，是否可以打开窗口
        _webConfig.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    }
    return _webConfig;
}



#pragma mark ===========webViewDelegate===============
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //加载完成后，关闭等待
  
    [CXManager hideAlert];
    //修改字体大小 200%
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'" completionHandler:nil];
    
    
    //    //修改字体颜色  #9098b8
//    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#ff0000'" completionHandler:nil];

//    //修改图片大小
//    [ webView evaluateJavaScript:@"var script = document.createElement('script');"
//     "script.type = 'text/javascript';"
//     "script.text = \"function ResizeImages() { "
//     "var myimg,oldwidth;"
//    "var maxwidth = 100%;" // WKWebView中显示的图片宽度
//     "for(i=0;i <document.images.length;i++){"
//     "myimg = document.images[i];"
//     "oldwidth = myimg.width;"
//     "myimg.width = maxwidth;"
//     "}"
//     "}\";"
//     "document.getElementsByTagName('head')[0].appendChild(script);ResizeImages();" completionHandler:nil];
//


}

-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    //内容开始返回时显示加载中。。。
    [CXManager showLoading];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [MBManager hideAlert];
//    });
    
}



-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [CXManager hideAlert];
}


-(void)viewDidDisappear:(BOOL)animated{
    [CXManager hideAlert];
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction preferences:(WKWebpagePreferences *)preferences decisionHandler:(void (^)(WKNavigationActionPolicy, WKWebpagePreferences * _Nonnull))decisionHandler
API_AVAILABLE(ios(13.0)){
    
//    NSLog(@"f1----");
  
//    NSString * urlStr = [NSString stringWithFormat:@"%@",navigationAction.request.URL];
//    NSLog(@"当前跳转地址：%@",urlStr);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow,preferences);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}



// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
 NSString * urlStr = navigationResponse.response.URL.absoluteString;
// NSLog(@"当前跳转地址：%@",urlStr);
 //允许跳转
 decisionHandler(WKNavigationResponsePolicyAllow);
 //不允许跳转
 //decisionHandler(WKNavigationResponsePolicyCancel);
}


-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
//    NSLog(@"frameInfo------%@",frameInfo);
    if (![frameInfo isMainFrame]) {
//        NSLog(@"navigationAction.request.URL.relativeString---%@",navigationAction.request.URL.relativeString);
        NSString *urlString = navigationAction.request.URL.relativeString;
        if ([urlString rangeOfString:self.model.filterStr].location != NSNotFound && [urlString rangeOfString:@"?"].location != NSNotFound) {
            NSMutableDictionary *paramDic = [CXFounctionTool getURLParamWithUrlString:urlString];
            if ([paramDic objectForKey:self.model.idType]) {

                
            }

        }
        else{
            [CXManager showBriefAlert:@"链接错误，联系管理员"];
        }
    }
    return nil;
}


-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSURL *URL = navigationAction.request.URL;
//    NSLog(@"--------------%@",URL);
    NSString *scheme = [URL scheme];
    
    if ([scheme isEqualToString:@"tel"]) {
    NSString *resourceSpecifier = [URL resourceSpecifier];
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", resourceSpecifier];
    /// 防⽌iOS 10及其之后，拨打电话系统弹出框延迟出现
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    });
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}






- (void)dealloc
{
    [BAKit_NotiCenter removeObserver:self];
}


@end
