//
//  SuccessViewController.m
//  LTQA
//
//  Created by 付晓强 on 16/10/14.
//  Copyright © 2016年 付晓强. All rights reserved.
//

#import "SuccessViewController.h"
#import "SuccessView.h"
#import "LTTWHttpRequest.h"
#import <AdSupport/AdSupport.h>
@interface SuccessViewController ()<SuccessViewDelegate>

@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SuccessView *successView = [[SuccessView alloc] initWithFrame:self.view.bounds];
    successView.delegate = self;
    [self.view addSubview:successView];
    
}

- (void)refresh{
    NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:idfa,@"code", nil];
    [[LTTWHttpRequest shareInstance] synGetRequest:OARefreshUrl dict:dic callback:^(NSInteger code, id content) {
        NSDictionary *dic = (NSDictionary *)content;
        if (code == 200) {
            UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
            NSURL *url = [NSURL URLWithString:OAUrl];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            [webView loadRequest:request];
            webView.scrollView.bounces = NO;
            [self.view addSubview:webView];
        }else if(code == 101){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:[dic objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请求失败" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
            
        }

    }];

}

@end
