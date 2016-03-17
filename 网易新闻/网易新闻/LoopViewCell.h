//
//  LoopViewCell.h
//  网易新闻
//
//  Created by ake on 16/3/17.
//  Copyright © 2016年 ake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoopViewModel.h"

@interface LoopViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (nonatomic,strong)LoopViewModel *model;

//重写 model , 自动给 cell 加图片
-(void)setModel:(LoopViewModel *)model;

@end
