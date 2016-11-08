//
//  FXQScan.h
//  Erweimasaomiao
//
//  Created by 付晓强 on 16/10/27.
//  Copyright © 2016年 付晓强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@protocol FXQSacnDelegate <NSObject>

- (void)sendMessageWithString:(NSString *)str;
- (void)backHome;
@end

@interface FXQScan : UIView

@property (nonatomic,assign) id<FXQSacnDelegate>delegate;
/*! 开始扫描*/
- (void)start;
/*! 结束扫描*/
- (void)stop;

@end
