//
//  SuccessView.m
//  LTQA
//
//  Created by 付晓强 on 16/10/14.
//  Copyright © 2016年 付晓强. All rights reserved.
//

#import "SuccessView.h"

@implementation SuccessView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(240, 246, 250, 1);
        [self displayView];
    }
    return self;
}

- (void)displayView{
    UIImageView *sucImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"prompt_success"]];
    sucImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height*3.5/15);
    [self addSubview:sucImageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"申请成功";
    label.textColor = RGBA(51, 51, 51, 1);
    label.font = [UIFont boldSystemFontOfSize:19];
    label.center = CGPointMake(self.frame.size.width/2, self.frame.size.height*3.8/10);
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 30)];
    tipLabel.text = @"请您耐心等待激活";
    tipLabel.textColor = RGBA(102, 102, 102, 1);
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height*4.4/10);
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tipLabel];
    
    UIButton *activeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    activeBtn.frame = CGRectMake(33, 196, 68, 36);
    UIImage *btnImage = [UIImage imageNamed:@"btn_blue"];
    activeBtn.center = CGPointMake(self.frame.size.width/2, self.frame.size.height*5.2/10);
    [activeBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [activeBtn setTitle:@"刷新" forState:UIControlStateNormal];
    activeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [activeBtn addTarget:self action:@selector(activeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:activeBtn];
}

- (void)activeBtnClick{
    [self.delegate refresh];
}

@end
