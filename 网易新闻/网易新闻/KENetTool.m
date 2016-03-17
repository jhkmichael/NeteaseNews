//
//  KENetTool.m
//  网易新闻
//
//  Created by ake on 16/3/13.
//  Copyright © 2016年 ake. All rights reserved.
//

/**
 *  网络单例工具:
   
    分析: 实质是 NSURLOperation 或者 NSURLSession 的单例对象 , 都用一个单例对象管理网络请求 (前者是 send , 后者是task , 都有 url 和 request).
    注意: 本方法用第三方的对象 , AFHTTPSessionManager , 封装了 session 的 , 
             创建这个单例对象好处是 , 第三方框架的方法太好用了 , 这个封装类的单例对象 , 外面使用起来更爽 . 
    疑问:
            其实就是 AFN 框架中的 manager ? 为什么还要创建这个单例对象呢? 因为可以在 这个对象内部 添加一部分自定义的域名 , 外界方法只要添加需要的一部分网址就可以了.
 */

#import "KENetTool.h"

@implementation KENetTool

/**
 *  动手脚: 添加 baseURL , 就是统一的公司域名
        原理: 在AFHTTPSessionManager 对象的网络请求方法中 ,
                request 的封装是 :
                NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
                所以,request 中的 URL 是用 NSURL 方法拼接而成的 ,  第三方对象预设 self.baseURL 这个属性了 , 所以这里填统一的公司域名就行了, 只要设一次就万事大吉 , 当然 ,这需要和后台沟通 , 数据的网址不需要写公司域名了
 */


//注意啦,netTool自定义对象类是AFHTTPSessionManager的子类

+(instancetype)netTool{
    static KENetTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //公司的域名 , 设置一次就行 ,
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        instance = [[KENetTool alloc]initWithBaseURL:baseURL];
    });
    return instance;
}
@end
