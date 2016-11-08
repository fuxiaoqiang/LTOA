//
//  ViewController.m
//  LTQA
//
//  Created by 付晓强 on 16/10/13.
//  Copyright © 2016年 付晓强. All rights reserved.
//

#import "ViewController.h"
#import "SuccessViewController.h"
#import "FailViewController.h"
#import "ActiveView.h"
#import "LTTWHttpRequest.h"
#import <AdSupport/AdSupport.h>
#import "FXQScan.h"
@interface ViewController ()<ActiveViewDelegate>

@property (nonatomic,retain) ActiveView *activeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.activeView];
    self.activeView.delegate = self;
    
}

- (ActiveView *)activeView{
    if (!_activeView) {
       _activeView = [[ActiveView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _activeView;
}

- (void)viewDidAppear:(BOOL)animated{
    
}

- (void)sendName:(NSString *)name withOAName:(NSString *)oaName{
//    NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
//    if ([[idfa substringToIndex:6] isEqualToString:@"000000"]||!idfa) {
//        FailViewController *failVC = [[FailViewController alloc] init];
//        
//        [self presentViewController:failVC animated:YES completion:nil];
//    }else{
//        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                             oaName,@"id",
//                             name,@"name",
//                             idfa,@"code", nil];
//        [[LTTWHttpRequest shareInstance] synGetRequest:OAActiveUrl dict:dic callback:^(NSInteger code, id content) {
//            NSDictionary *dic = (NSDictionary *)content;
//            if (code == 200) {
//                SuccessViewController *sucVC = [[SuccessViewController alloc] init];
//                [self presentViewController:sucVC animated:YES completion:nil];
//            }else if(code == 101){
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:[dic objectForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                    [alert dismissViewControllerAnimated:YES completion:nil];
//                }];
//                [alert addAction:cancel];
//                [self presentViewController:alert animated:YES completion:nil];
//            }else{
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请求失败" preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    [alert dismissViewControllerAnimated:YES completion:nil];
//                }];
//                [alert addAction:cancel];
//                [self presentViewController:alert animated:YES completion:nil];
//
//            }
//        }];
//    }
    

        FailViewController *failVC = [[FailViewController alloc] init];
        [self presentViewController:failVC animated:YES completion:nil];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}


@end
