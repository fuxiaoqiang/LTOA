//
//  LTTWHttpRequest.m
//  LTAppPlusTW
//
//  Created by LongTuGame on 16/2/23.
//  Copyright © 2016年 LongTuGame. All rights reserved.
//

#import "LTTWHttpRequest.h"

#import "AFNetworking.h"

static LTTWHttpRequest *httpRequest = nil;


@implementation LTTWHttpRequest

+(id)shareInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (httpRequest == nil) {
            httpRequest = [[LTTWHttpRequest alloc] init];
        }
    });
    
    return httpRequest;

}

-(instancetype)init
{
    if (httpRequest == nil) {
        httpRequest = [super init];
    }
    
    return httpRequest;
}

- (void)synGetRequest:(NSString *)newurl dict:(NSDictionary *)dict callback:(requestCallback)callback
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSURLSessionDataTask *task = [manager GET:newurl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSDictionary *responseDict = (NSDictionary *)responseObject;
        if ([[responseObject objectForKey:@"status"] integerValue] == 1) {
            callback(200,responseDict);
        }else{
            callback(101,responseDict);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(1,@"获取错误");
    }];
    
    [task resume];
}

-(void)synPostRequest:(NSString *)newurl dict:(NSDictionary *)dict callback:(requestCallback)callback
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLSessionDataTask *task = [manager POST:newurl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        callback([[responseDict objectForKey:@"code"] integerValue],responseDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(1,@"请求超时");
    }];
    
    [task resume];
}

-(void)asynGetRequest:(NSString *)newurl callback:(requestCallback)callback
{
    NSOperationQueue *httpRequestQueue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *httpRequestOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"%@",[NSThread currentThread]);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSURLSessionDataTask *task = [manager GET:newurl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            callback(200,responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            callback(1,@"获取错误");
        }];
        
        [task resume];
    }];
    
    [httpRequestQueue addOperation:httpRequestOperation];
    
   
}

-(void)asynPostRequest:(NSString *)newurl dict:(NSDictionary *)dict callback:(requestCallback)callback
{
    NSOperationQueue *httpRequestQueue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *httpRequestOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"%@",[NSThread currentThread]);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSURLSessionDataTask *task = [manager POST:newurl parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *responseDict = (NSDictionary *)responseObject;
            callback([[responseDict objectForKey:@"code"] integerValue],responseDict);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            callback(1,@"请求超时");
        }];
        
        
        
        [task resume];
    }];
    
    [httpRequestQueue addOperation:httpRequestOperation];
}

@end
