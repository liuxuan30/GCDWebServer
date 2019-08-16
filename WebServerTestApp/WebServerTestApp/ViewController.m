//
//  ViewController.m
//  WebServerTestApp
//
//  Created by Xuan Liu on 2019/8/6.
//  Copyright © 2019 xuanliu. All rights reserved.
//

#import "ViewController.h"
#import <GCDWebServers/GCDWebServers.h>

@interface ViewController () {
    GCDWebServer* _webServer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // Create server
    _webServer = [[GCDWebServer alloc] init];

    [_webServer addHandlerForMethod:@"GET" path:@"/sync" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse * _Nullable(__kindof GCDWebServerRequest * _Nonnull request) {
        return [GCDWebServerDataResponse responseWithHTML:@"<html><body><p>Hello Sync World</p></body></html>"];
    }];

    [_webServer addHandlerForMethod:@"GET" path:@"/async" requestClass:[GCDWebServerRequest class] asyncProcessBlock:^(__kindof GCDWebServerRequest * _Nonnull request, GCDWebServerCompletionBlock  _Nonnull completionBlock) {
        completionBlock([GCDWebServerDataResponse responseWithHTML:@"<html><body><p>Hello Async World</p></body></html>"]);
    }];

    [_webServer startWithPort:8080 bonjourName:nil];
}


@end
