//
//  LoopViewControllerCollectionViewController.m
//  网易新闻
//
//  Created by ake on 16/3/13.
//  Copyright © 2016年 ake. All rights reserved.
//

#import "LoopViewController.h"
#import "LoopViewModel.h"
#import "LoopViewCell.h"

@interface LoopViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *loopViewArr;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation LoopViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
   
    //cell 是从 storyboard 中加载的 , 系统会自动注册sb 加载的了  , 这里不能注册, 重复注册dequeue 不到 cell 会自动根据.m 文件alloc 一个新的 cell返回 , 而不是从 storyboard 加载 . 所以 storyboard 里面的自定义信息丢失了.
   //[self.collectionView registerClass:[LoopViewCell class] forCellWithReuseIdentifier:@"loopView"];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [LoopViewModel loopViewModelSuccess:^(NSArray *destArr){
        self.loopViewArr = destArr;
        [self.collectionView reloadData];
    }];
    
    self.flowLayout.itemSize=self.collectionView.bounds.size;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumLineSpacing=0;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.loopViewArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
     LoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"loopView" forIndexPath:indexPath];
    cell.model = self.loopViewArr[indexPath.item];
    return cell;
}
@end
