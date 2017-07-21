//
//  CommonHtml5Controller.m
//  MicroTown
//
//  Created by microtown on 16/8/10.
//  Copyright © 2016年 Microtown  微镇商票宝. All rights reserved.
//

#import "CommonHtml5Controller.h"
#import "MTWebProgressLayer.h"


@interface CommonHtml5Controller ()<UIWebViewDelegate>


@property (nonatomic, strong) MTWebProgressLayer *progressLayer;

@property (nonatomic, copy) NSString *page;

//返回按钮
@property (nonatomic, strong) UIBarButtonItem *backItem;
//关闭按钮
@property (nonatomic, strong) UIBarButtonItem *closeItem;
//H5可不可以返回上一页
@property (nonatomic, assign) BOOL isCanGoBack;

@end

@implementation CommonHtml5Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //初始化webView
    [self commonWebViewInitialize];
    
    //进度条初始化
    [self progressLayerInitialize];

//    [self addLeftButton];
    
}

#pragma mark - 登录成功事件
- (void)logginAction:(NSNotification *)notification {
    
    
//    NSMutableURLRequest *request = [self.commonWebView.request copy];
//    
//   request = [self addHPPTHeaderFieldWith:request];
    
    [_commonWebView reload];
}


/**
 *  webView初始化
 */
- (void)commonWebViewInitialize {
    
    self.commonWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];

    self.commonWebView.delegate = self;
    [self.view addSubview:_commonWebView];
    
    NSString *path = @"";
    
    if (self.htmlData) {
        
       NSString *htmlStr = [[NSString alloc] initWithData:self.htmlData encoding:NSUTF8StringEncoding];
        [_commonWebView loadHTMLString:htmlStr baseURL:nil];
    }
    
    if (self.htmlUrl) {
        
        path = self.htmlUrl;
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
        
        [_commonWebView loadRequest:request];
    }
//    path = @"http://192.168.2.99:5080/microtown/wap";

//    path = @"http://192.168.1.105:8080/microtown/appPage/newLoginActivity.jsp";
//    path = @"http://192.168.1.105:8080/microtown/web?W=W0703";
    
    
//    request = [self addHPPTHeaderFieldWith:request];

}

/**
 *  进度条初始化
 */
- (void)progressLayerInitialize {
    
    _progressLayer = [MTWebProgressLayer new];
    _progressLayer.frame = CGRectMake(0, 42, [UIScreen mainScreen].bounds.size.width, 2);
    [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_progressLayer startLoad];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    //注册JSContext
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"MicroTown"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue){
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    [_progressLayer finishedLoad];
    
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSString *urlStr = [webView.request.URL absoluteString];
    if ([urlStr rangeOfString:@"www.cnrisk.cn/appPage/jcWithdrawCB.jsp"].location != NSNotFound || [urlStr rangeOfString:@"www.microtown.cn/appPage/jcWithdrawCB.jsp"].location != NSNotFound || [urlStr rangeOfString:@"www.cnrisk.cn/appPage/jcRechargeCB.jsp"].location != NSNotFound || [urlStr rangeOfString:@"www.microtown.cn/appPage/jcRechargeCB.jsp"].location != NSNotFound) {
        
        [self.navigationItem setHidesBackButton:YES animated:YES];
        return;
    }
    
    //判断是否有上一层H5页面
    if (self.commonWebView.canGoBack) {
        
        //同时设置返回按钮和关闭按钮为导航栏左边的按钮
        self.navigationItem.leftBarButtonItems = @[self.backItem, self.closeItem];
    }
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_progressLayer finishedLoad];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSLog(@"%@",[request.URL absoluteString]);
    
//    NSString *ssss = [self.commonWebView stringByEvaluatingJavaScriptFromString: @"document.documentElement.innerHTML"];
//    NSLog(@"%@",ssss);
//    
//    NSLog(@"%@",request.allHTTPHeaderFields);
//    NSMutableURLRequest *mutableRequest = [request mutableCopy];
//    
//    NSArray *allKeys = [[mutableRequest allHTTPHeaderFields] allKeys];
//    NSLog(@"%@",allKeys);
//    BOOL isexit = NO;
//    for (NSString *keyStr in allKeys) {
//        if ([keyStr isEqualToString:@"mtclient"]) {
//            isexit = YES;
//            break;
//        }
//    }
//    
//    if (isexit) {
//        return YES;
//    } else {
//    
//        NSString *sessionId;
//        NSString *cookieSessionId;
//        NSString *mtdeviceid = [OpenUDID value] ? [OpenUDID value] : @"";
//        
//        if ([PersonalInfoManager sharedInstance].isLogin) {
//            sessionId = [PersonalInfoManager sharedInstance].sessionId;
//            cookieSessionId = [NSString stringWithFormat:@"JSESSIONID=%@;mtdeviceid=%@;mtclient=3;mtsessionid=%@",sessionId,mtdeviceid,sessionId];
//        } else {
//            sessionId = @"";
//            cookieSessionId = [NSString stringWithFormat:@"JSESSIONID=%@;mtdeviceid=%@;mtclient=3;mtsessionid=%@",sessionId,mtdeviceid,sessionId];
//        }
//        
//        [mutableRequest addValue:cookieSessionId forHTTPHeaderField:@"Cookie"];
//        [mutableRequest addValue:@"3" forHTTPHeaderField:@"mtclient"];
//        //获取当前设备
//        NSString *phoneName = [MTNetworking getCurrentDeviceModel];
//        NSLog(@"%@",phoneName);
//        //获取当前设备运行的系统
//        NSString *system = [[UIDevice currentDevice] systemVersion];
//        NSLog(@"%@",system);
//        //获取APP版本号
//        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//        NSLog(@"%@",app_Version);
//        [mutableRequest addValue:[NSString stringWithFormat:@"%@,%@,%@",phoneName,system,app_Version] forHTTPHeaderField:@"mtversionInfo"];
//        
//        request = [mutableRequest copy];
//    
//        [self.commonWebView loadRequest:request];
//
       return YES;
//   }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_progressLayer finishedLoad];
}

- (void)addLeftButton
{
    self.navigationItem.leftBarButtonItem = self.backItem;
}

//点击返回的方法
- (void)backNative
{
    //判断是否有上一层H5页面
    if (self.commonWebView.canGoBack) {
        //如果有则返回
        [self.commonWebView goBack];
        
    } else {
        [self closeNative];
    }
}

//关闭H5页面，直接回到原生页面
- (void)closeNative
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - init

- (UIBarButtonItem *)backItem
{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] init];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        //这是一张“<”的图片，可以让美工给切一张
        UIImage *image = [UIImage imageNamed:@"common_nav_back_n.png"];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backNative) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        //字体的多少为btn的大小
        [btn sizeToFit];
        //左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //让返回按钮内容继续向左边偏移-10，如果不设置的话，就会发现返回按钮离屏幕的左边的距离有点儿大，不美观
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        //    btn.frame = CGRectMake(0, 0, 40, 40);
        _backItem.customView = btn;
    }
    return _backItem;
}

- (UIBarButtonItem *)closeItem
{
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeNative)];
    }
    return _closeItem;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
