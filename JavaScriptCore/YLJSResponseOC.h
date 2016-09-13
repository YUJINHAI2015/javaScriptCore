//
//  YLJSResponseOC.h
//  UMTest
//
//  Created by yiLian on 16/8/16.
//  Copyright © 2016年 YJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcDelegate <JSExport>
// myViewController里面实现
- (void)jsCallOC;
- (void)getCall:(NSString*)getValue;
/// ViewController里面实现
- (void)jsForWeiXinLogin:(NSString *)callString; // 微信登录
- (void)jsForWeiXinPay:(NSString *)callString; // 微信支付
@end