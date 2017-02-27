//
//  ViewController.m
//  baidu
//
//  Created by shupengstar on 16/8/3.
//  Copyright © 2016年 YJH. All rights reserved.
//



#import "ViewController.h"
#import "YLJSResponseOC.h"


@interface ViewController ()<UIWebViewDelegate,JSObjcDelegate>
@property (weak, nonatomic) IBOutlet UIWebView             *loadWebView;
@property (nonatomic, strong) JSContext                    *jsContext;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    [self loadMainView];
}
#pragma mark - 加载主页
- (void)loadMainView{
    [self loadExamplePage:@"你们自己的网页" andWebView:self.loadWebView];
}
- (void)loadExamplePage:(NSString *)urlStr andWebView:(UIWebView *)webView{
    
    NSString *encodedString   = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url                = [NSURL URLWithString:encodedString];
    //    NSURLRequest *request     = [NSURLRequest requestWithURL:url];
    NSURLRequest *request     = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    
    NSURLCache *URLCache      = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:0 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.backgroundColor   = [UIColor clearColor];
    webView.opaque            = NO;
    [webView loadRequest:request];
}
#pragma mark ---webViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.jsContext                  = [self.loadWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
// 后台调用这个方法就可以回传信息
//    <script>
//         var call = function()
//         {
//             var callInfo = JSON.stringify({"github": "https://github.com/YUJINHAI2015/javaScriptCore"});
//             yilian.getCall(callInfo);
//         }
//    
//    </script>
    self.jsContext[@"yilian"]       = self; // 和后台约定好的字段
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception           = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}
#pragma mark - JSObjectDelegate
// 点击网页上的按钮，从服务器传回数据。
- (void)jsForWeiXinLogin:(NSString *)callString{
    NSLog(@"jsForWeiXinLogin:%@", callString);
  
}
// 微信支付
- (void)jsForWeiXinPay:(NSString *)callString{
    NSLog(@"jsForWeiXinPay:%@", callString);
}

@end
