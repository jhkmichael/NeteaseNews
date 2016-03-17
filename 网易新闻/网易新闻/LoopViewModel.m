//
//  loopView.m
//  网易新闻
//
//  Created by ake on 16/3/13.
//  Copyright © 2016年 ake. All rights reserved.
//

#import "LoopViewModel.h"
#import "KENetTool.h"

@implementation LoopViewModel

//异步网络加载, 成功后回调 success , (seccess 由 controller 那里完成 )
+(void)loopViewModelSuccess:(void (^)(NSArray * destArr))successs{
    //加载轮播器的网络数据 , 这里就用到自己创建的 单例网络工具类对象 来发送请求啦
    [[[KENetTool netTool] GET:@"ad/headline/0-4.html" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *loopViewTotalDict  = responseObject;
//        NSLog(@"%@",[loopViewTotalDict.keyEnumerator nextObject]);
        //获得字典第一个 key , headline_ad , 根据 key 得到对应的 array 值
         NSString *firstkey = [loopViewTotalDict.keyEnumerator nextObject];
        NSArray *dictArr = loopViewTotalDict[firstkey];
        
        NSMutableArray *destArr = [NSMutableArray arrayWithCapacity:dictArr.count];
        for (NSDictionary *dict in dictArr) {
            LoopViewModel *loopView = [[self alloc]initWithDict:dict];
            [destArr addObject:loopView];
        }
        //回调 success
        successs(destArr.copy);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@",error);
    }] resume];
    

}
+(instancetype)loopViewWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

//重写这个方法, 防止 KVC 对象没有对应的属性而报错
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}


@end
