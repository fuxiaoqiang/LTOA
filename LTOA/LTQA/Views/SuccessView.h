//
//  SuccessView.h
//  LTQA
//
//  Created by 付晓强 on 16/10/14.
//  Copyright © 2016年 付晓强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SuccessViewDelegate <NSObject>

- (void)refresh;

@end

@interface SuccessView : UIView

@property (nonatomic,assign) id<SuccessViewDelegate>delegate;

@end
