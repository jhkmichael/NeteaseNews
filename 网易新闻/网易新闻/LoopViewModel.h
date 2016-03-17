//
//  loopView.h
//  网易新闻
//
//  Created by ake on 16/3/13.
//  Copyright © 2016年 ake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoopViewModel : NSObject
@property (nonatomic ,copy)NSString* title;
@property (nonatomic ,copy)NSString* imgsrc;


//模型三个标准方法
+(void)loopViewModelSuccess:(void (^)(NSArray * desArr))successs;
+(instancetype)loopViewWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;
@end
