//
//  ActiveView.m
//  LTQA
//
//  Created by 付晓强 on 16/10/13.
//  Copyright © 2016年 付晓强. All rights reserved.
//

#import "ActiveView.h"

@interface ActiveView ()
{
    UITextField *_nameField;
    UITextField *_oaField;
    
}
@property (nonatomic,retain)UIView *tempView;
@end

@implementation ActiveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self displayView];
    }
    return self;
}

- (void)displayView{
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:self.frame];
    bgImage.image = [UIImage imageNamed:@"bg_activation"];
    [self addSubview:bgImage];
    
    UIImageView *logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_longtu"]];
    
    logoImage.frame = CGRectMake(0, 0, 161*W, 45*H);
    logoImage.center = CGPointMake(self.frame.size.width/2, self.frame.size.height*1.5/10);
    [self addSubview:logoImage];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 130, 320*W, 296*H)];
    bgView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height*5/10);
    [self addSubview:bgView];
    self.tempView = bgView;
    UIImageView *activeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320*W, 296*H)];
    UIImage *bg = [UIImage imageNamed:@"bg_dialog"];
    
    activeImage.image = [bg stretchableImageWithLeftCapWidth:bg.size.width/2 topCapHeight:bg.size.height/2];
    [bgView addSubview:activeImage];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(49*W, 55*H, 100*W, 20*H)];
    nameLabel.text = @"如何绑定设备？";
    [nameLabel sizeToFit];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = RGBA(23, 23, 26, 1);
    [bgView addSubview:nameLabel];
    
    UILabel *nameLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(49*W, 88*H, 100*W, 20*H)];
    nameLabel1.text = @"1.请登录您的内网OA";
    [nameLabel1 sizeToFit];
    nameLabel1.font = [UIFont systemFontOfSize:16];
    nameLabel1.textColor = RGBA(70, 70, 76, 1);
    [bgView addSubview:nameLabel1];
    
    UILabel *nameLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(49*W, 120*H, 100*W, 20*H)];
    nameLabel2.text = @"2.请在个人信息页面进行扫码绑定";
    [nameLabel2 sizeToFit];
    nameLabel2.font = [UIFont systemFontOfSize:16];
    nameLabel2.textColor = RGBA(70, 70, 76, 1);
    [bgView addSubview:nameLabel2];
    
    UIImageView *input1 = [[UIImageView alloc] initWithFrame:CGRectMake(41.5*W, 155*H, 237*W, 1*H)];
    UIImage *image = [UIImage imageNamed:@"dividing"];
    
    input1.image = image;
    [bgView addSubview:input1];
    
    UIButton *activeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    activeBtn.frame = CGRectMake(60.5*W, 173*H, 199*W, 44*H);
    UIImage *btnImage = [UIImage imageNamed:@"btn_red"];
    [activeBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [activeBtn setImage:[UIImage imageNamed:@"saoyisao"] forState:UIControlStateNormal];
    [activeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [activeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [activeBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [activeBtn addTarget:self action:@selector(activeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:activeBtn];
//
//    UILabel *oaLabel = [[UILabel alloc] initWithFrame:CGRectMake(40*W, 115*H, 100*W, 20*H)];
//    oaLabel.text = @"OA用户名";
//    oaLabel.font = [UIFont systemFontOfSize:13];
//    oaLabel.textColor = RGBA(70, 70, 70, 1);
//    [bgView addSubview:oaLabel];
//    
//    UIImageView *input2 = [[UIImageView alloc] initWithFrame:CGRectMake(33*W, 138*H, 254*W, 40*H)];
//    input2.image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
//    [bgView addSubview:input2];
//    
//    UIButton *activeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    activeBtn.frame = CGRectMake(33*W, 196*H, 254*W, 44*H);
//    UIImage *btnImage = [UIImage imageNamed:@"btn_red"];
//    [activeBtn setBackgroundImage:[btnImage stretchableImageWithLeftCapWidth:btnImage.size.height topCapHeight:btnImage.size.height] forState:UIControlStateNormal];
//    [activeBtn setTitle:@"激活" forState:UIControlStateNormal];
//    [activeBtn addTarget:self action:@selector(activeBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:activeBtn];
//    
//    
//    UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(40*W, 66*H, 254*W, 40*H)];
//    
//    NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"请输入您的姓名" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName,RGBA(164, 166, 179, 1),NSForegroundColorAttributeName, nil]];
//    nameField.attributedPlaceholder = string;
//    nameField.delegate = self;
//    _nameField = nameField;
//    [bgView addSubview:nameField];
//    
//    UITextField *oaField = [[UITextField alloc] initWithFrame:CGRectMake(40*W, 138*H, 254*W, 40*H)];
//    oaField.tag = 1;
//    NSAttributedString *oaString = [[NSAttributedString alloc] initWithString:@"请输入您的OA用户名" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName,RGBA(164, 166, 179, 1),NSForegroundColorAttributeName, nil]];
//    oaField.attributedPlaceholder = oaString;
//    oaField.delegate = self;
//    _oaField = oaField;
//    [bgView addSubview:oaField];

}

- (void)activeBtnClick{
//    NSLog(@"name=%@,oaName=%@",_nameField.text,_oaField.text);
//    if (_nameField.text.length == 0) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"姓名不能为空" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//        [alert addAction:action];
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
//        return;
//    }
//    if (_oaField.text.length == 0) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"姓名不能为空" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//        [alert addAction:action];
//        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
//        return;
//    }
    
    [self.delegate sendName:_nameField.text withOAName:_oaField.text];

}

//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    if (textField.tag == 1) {
//
//        [UIView animateWithDuration:0.5 animations:^{
//           self.tempView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height*5/10-30);
//        }];
//    }
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if (textField.tag == 1) {
//        
//        [UIView animateWithDuration:0.5 animations:^{
//            self.tempView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height*5/10);
//        }];
//    }
//}
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    if ([string isEqualToString:@" "]) {
//        return NO;
//    }
//    return YES;
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [_nameField resignFirstResponder];
//    [_oaField resignFirstResponder];
//}


@end
