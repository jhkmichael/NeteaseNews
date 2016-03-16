//
//  LoopViewControllerCollectionViewController.m
//  网易新闻
//
//  Created by ake on 16/3/13.
//  Copyright © 2016年 ake. All rights reserved.
//

#import "LoopViewController.h"
#import "LoopViewModel.h"

@interface LoopViewController ()<UICollectionViewDataSource ,UICollectionViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic ,assign)NSInteger currentIndex;

@property (nonatomic,strong)NSArray* loopViewArr;

@end

@implementation LoopViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    //要使用 scrollView的 didScroll 方法 ,
    self.collectionView.delegate=self;
    self.collectionView.scrollEnabled=NO;
    
//    // 创建轻扫手势对象11
//    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe:)];
//    // 设置轻扫方向 默认向右
//    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
//    [self.collectionView addGestureRecognizer:leftSwipe];
//    leftSwipe.delegate=self;
//    
////     创建向右轻扫手势对象12
//    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
////    rightSwipe
//    [self.collectionView addGestureRecognizer:rightSwipe];
//    rightSwipe.delegate=self;

//    //创建拖拽手势21
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPan:)];
    [self.collectionView addGestureRecognizer:pan];
//    [pan requireGestureRecognizerToFail:leftSwipe];
//    [pan requireGestureRecognizerToFail:rightSwipe];
    
}

#pragma mark - 手势识别方法

/**
 *  向左轻扫回调方法
 */
- (void)leftSwipe:(UISwipeGestureRecognizer *)swipe {
    if(self.currentIndex==3){
        return;
    }else{
        self.currentIndex++;
    }
    
    //    [UIView animateWithDuration:1 animations:^{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:0 animated:YES];
    //改变大小
    //        UICollectionViewCell *cellOne =self.collectionView.subviews[0];
    //        cellOne.transform = CGAffineTransformScale(cellOne.transform, 1, 1.2);
    //         }];
    
    
}


/**
 *  向右轻扫回调方法
 */
- (void)rightSwipe:(UISwipeGestureRecognizer *)swipe{
    if(self.currentIndex==0){
        return;
    }
    self.currentIndex--;
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:0 animated:YES];
    NSLog(@"向右扫");
    
}


-(void)didPan:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:pan.view];
    for (UICollectionViewCell *CELL in self.collectionView.subviews) {
        CELL.transform = CGAffineTransformMakeTranslation(point.x, 0);
    }
    
    //    self.collectionView.transform = CGAffineTransformMakeTranslation(-point.x,-50);
    
    CGPoint velocity = [pan velocityInView:pan.view];
    
    NSLog(@"拖拽速度=%@",NSStringFromCGPoint(velocity));
    
    //计算速度 , 然后加锁, 防止一次加速重复进来
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(ABS(velocity.x)>=1500&&velocity.x<0){
            [self leftSwipe:nil];
        }else if(ABS(velocity.x)>=1500&&velocity.x>0){
            [self rightSwipe:nil];
        }
    });
    
    if(ABS(velocity.x)<1500){
        onceToken = 0;
    }
    
    
    
    if(pan.state == UIGestureRecognizerStateEnded) {
        // 清空transform
        [UIView animateWithDuration:0.4 animations:^{
            for (UICollectionViewCell *CELL in self.collectionView.subviews) {
                CELL.transform = CGAffineTransformIdentity;
            }
//            self.collectionView.transform = CGAffineTransformIdentity;
//            NSLog(@"%@",[NSThread currentThread]);
//            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:0 animated:YES];
        }];
    }
    
    NSLog(@"拖拽了%@",NSStringFromCGPoint(point));
}



-(void)viewDidAppear:(BOOL)animated{
    self.flowLayout.itemSize=CGSizeMake(self.collectionView.bounds.size.width-100, self.collectionView.bounds.size.height-100);
     self.collectionView.contentInset = UIEdgeInsetsMake(50, 50, 50, 50);
//    self.collectionView.contentOffset = CGPointMake(-50, 0);
    [LoopViewModel loopViewModelWithSuccess:^(NSArray *destArr){
        _loopViewArr = destArr;
        //获取到数据 , 刷新 itemCell
        [self.collectionView reloadData];
    }];
    
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.loopViewArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
//    cell.bounds= [UIScreen mainScreen].bounds;
    //不能直接该 cell 的大小, 因为这不会同步阿迪到 collectionView 的 flowLayout 里面的 ,
    
    return cell;
}





@end
