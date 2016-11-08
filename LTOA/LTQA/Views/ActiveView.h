//
//  ActiveView.h
//  LTQA
//
//  Created by 付晓强 on 16/10/13.
//  Copyright © 2016年 付晓强. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActiveViewDelegate <NSObject>

- (void)sendName:(NSString *)name withOAName:(NSString *)oaName;

@end

@interface ActiveView : UIView<UITextFieldDelegate>

@property (nonatomic,assign) id<ActiveViewDelegate>delegate;

@end
