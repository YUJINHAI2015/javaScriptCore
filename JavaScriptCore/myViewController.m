//
//  myViewController.m
//  JavaScriptCore
//
//  Created by yiLian on 16/9/13.
//  Copyright © 2016年 yilian. All rights reserved.
//

#import "myViewController.h"
#import "YLJSResponseOC.h"


@interface myViewController ()<UIWebViewDelegate,JSObjcDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *secondWebView;
@property (nonatomic, strong) JSContext        *jsContext;


@end

@implementation myViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.secondWebView loadRequest:request];
    // Do any additional setup after loading the view.
    
}

#pragma mark ---webViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.jsContext                  = [self.secondWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"yilian"]       = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception           = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };

}
#pragma mark -- JSObjcDelegate
- (void)jsCallOC{
    NSLog(@"jsCallOC 调用本地的代码");
}
- (void)getCall:(NSString *)getValue{
    NSLog(@"getCall%@",getValue);
}



@end
