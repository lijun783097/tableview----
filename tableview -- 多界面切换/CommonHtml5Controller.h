//
//  CommonHtml5Controller.h
//  MicroTown
//
//  Created by microtown on 16/8/10.
//  Copyright © 2016年 Microtown  微镇商票宝. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>

@interface CommonHtml5Controller : UIViewController

@property (nonatomic, strong) UIWebView *commonWebView;

@property (nonatomic, strong) JSContext *jsContext;

//非MTCommonHtml5Type的情况，直接传URL过来
@property (nonatomic, copy) NSString *htmlUrl;

//金城银行 传NSData过来
@property (nonatomic, strong) NSData *htmlData;

//分享链接
@property (nonatomic, copy) NSString *shareUrlStr;


@end
