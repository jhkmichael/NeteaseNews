//
//  KENetTool.h
//  网易新闻
//
//  Created by ake on 16/3/13.
//  Copyright © 2016年 ake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface KENetTool : AFHTTPSessionManager
+(instancetype)netTool;
@end
