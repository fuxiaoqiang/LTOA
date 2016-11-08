//
//  FailViewController.m
//  LTQA
//
//  Created by 付晓强 on 16/10/14.
//  Copyright © 2016年 付晓强. All rights reserved.
//

#import "FailViewController.h"
#import "FailView.h"
#import "FXQScan.h"
#import "LTTWHttpRequest.h"
#import <AdSupport/AdSupport.h>
@interface FailViewController ()<FXQSacnDelegate,FailViewDelegate>
{
    FXQScan *scan;
}

@end

@implementation FailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
}

- (void)viewDidAppear:(BOOL)animated{
    AVAuthorizationStatus authorizationStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authorizationStatus) {
        case AVAuthorizationStatusNotDetermined:{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        scan = [[FXQScan alloc] initWithFrame:self.view.frame];
                        scan.delegate = self;
                        [self.view addSubview:scan];
                        [scan start];
                    });
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self openAuthCamera];
                    });
                }
            }];
            break;
        }
            
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied: {
            [self openAuthCamera];
            break;
        }
            
        case AVAuthorizationStatusAuthorized:{
            //获得权限
            scan = [[FXQScan alloc] initWithFrame:self.view.frame];
            scan.delegate = self;
            [self.view addSubview:scan];
            [scan start];
            break;
        }
        default:
            break;
    }

    
}

- (void)sendMessageWithString:(NSString *)str{
    NSLog(@"%@",str);
    NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    if ([[idfa substringToIndex:6] isEqualToString:@"000000"]||!idfa) {
        FailView *failView = [[FailView alloc] initWithFrame:self.view.bounds];
        failView.delegate = self;
        [self.view addSubview:failView];
    }else{
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             idfa,@"code", nil];
        [[LTTWHttpRequest shareInstance] synGetRequest:str dict:dic callback:^(NSInteger code, id content) {
            NSDictionary *dic = (NSDictionary *)content;
            if (code == 200) {
                
            }else if(code == 101){
                [self back];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:[dic objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [alert dismissViewControllerAnimated:YES completion:nil];
                }];
                [alert addAction:cancel];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            }else{
                 [self back];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请求失败" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [alert dismissViewControllerAnimated:YES completion:nil];
                }];
                [alert addAction:cancel];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                
            }
        }];
    }

}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backHome{

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)openAuthCamera{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"未获得相机访问权限" message:@"请在设置－隐私－相机中打开访问权限" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self back];
        
        if ([[UIDevice currentDevice].systemName floatValue]<10) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"]];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}


@end
