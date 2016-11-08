//
//  FailView.m
//  LTQA
//
//  Created by 付晓强 on 16/10/14.
//  Copyright © 2016年 付晓强. All rights reserved.
//

#import "FailView.h"

@implementation FailView

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
    UIImageView *sucImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"prompt_bulb"]];
    sucImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height*3.8/15);
    [self addSubview:sucImageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    label.text = @"您的设备无法激活";
    label.textColor = RGBA(51, 51, 51, 1);
    label.font = [UIFont boldSystemFontOfSize:19];
    label.center = CGPointMake(self.frame.size.width/2, self.frame.size.height*4.5/10);
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    tipLabel.numberOfLines = 0;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"请在 设置->隐私->广告 中关闭限制广告追踪后再试" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName,RGBA(102, 102, 102, 1),NSForegroundColorAttributeName,style,NSParagraphStyleAttributeName, nil]];
    
    [str setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName,RGBA(28, 87, 255, 1),NSForegroundColorAttributeName, nil] range:NSMakeRange(3, 10)];
    
    tipLabel.attributedText = str;
    //tipLabel.text = @"请在 设置->隐私->广告 中关闭限制广告追踪后再试";
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height*5.2/10);
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tipLabel];

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(33, 196, self.frame.size.width/3, 44);
    UIImage *btnImage = [UIImage imageNamed:@"btn_blue"];
    backBtn.center = CGPointMake(self.frame.size.width/2, self.frame.size.height*6.3/10);
    [backBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
}

- (void)backBtnClick{
    [self.delegate back];
}
@end
