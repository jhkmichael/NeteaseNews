//
//  LoopViewCell.m
//  网易新闻
//
//  Created by ake on 16/3/17.
//  Copyright © 2016年 ake. All rights reserved.
//

#import "LoopViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation LoopViewCell
-(void)setModel:(LoopViewModel *)model{
    if(model==nil){
        return;
    }
    _model=model;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_model.imgsrc] placeholderImage:[UIImage imageNamed:@"img_03"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //加载网络图片完成, 系统会自动回调此 block , (系统方法不用我们手动回调)
        NSLog(@"cell 图片指向改变成功");
    }];
    
}

@end
