//
//  LTTWHttpRequest.h
//  LTAppPlusTW
//
//  Created by LongTuGame on 16/2/23.
//  Copyright © 2016年 LongTuGame. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^requestCallback)(NSInteger code, id content);

@interface LTTWHttpRequest : NSObject

+(id)shareInstance;

-(void)synGetRequest:(NSString *)newurl dict:(NSDictionary *)dict callback:(requestCallback)callback;

-(void)synPostRequest:(NSString *)newurl dict:(NSDictionary *)dict callback:(requestCallback)callback;

-(void)asynGetRequest:(NSString *)newurl callback:(requestCallback)callback;

-(void)asynPostRequest:(NSString *)newurl dict:(NSDictionary *)dict callback:(requestCallback)callback;

@end
