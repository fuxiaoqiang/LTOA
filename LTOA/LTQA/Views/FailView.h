//
//  FailView.h
//  LTQA
//
//  Created by 付晓强 on 16/10/14.
//  Copyright © 2016年 付晓强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FailViewDelegate <NSObject>

- (void)back;

@end

@interface FailView : UIView

@property (nonatomic,assign) id<FailViewDelegate>delegate;


@end
