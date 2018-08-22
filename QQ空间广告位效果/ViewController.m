//
//  ViewController.m
//  QQ空间广告位效果
//
//  Created by zhYch on 2018/8/22.
//  Copyright © 2018年 zhaoyongchuang. All rights reserved.
//

#import "ViewController.h"

#define kSWidth [UIScreen mainScreen].bounds.size.width
#define kSHeight [UIScreen mainScreen].bounds.size.height


@interface ViewController () <UIScrollViewDelegate>

/** 画圆的layer  */
@property (nonatomic, strong) CAShapeLayer *circleLayer;

/** 路径  */
@property (nonatomic, strong) UIBezierPath *path;

/** imageView1  */
@property (nonatomic, strong) UIImageView *imageView1;



@end

@implementation ViewController

- (CAShapeLayer *)circleLayer {
    if (!_circleLayer) {
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.frame = self.imageView1.bounds;
        self.path = [UIBezierPath bezierPathWithOvalInRect:(CGRectMake(0, 0, 0, 0))];
        _circleLayer.path = self.path.CGPath;
    }
    return _circleLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:(CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 2);
    [self.view addSubview:scrollView];
    
    //下
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 400, kSWidth, 240))];
//    imageView1.backgroundColor = [UIColor redColor];
    self.imageView1 = imageView1;
    
    //上
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 400, kSWidth, 240))];
    imageView2.image = [UIImage imageNamed:@"456.jpg"];
    
    [scrollView addSubview:imageView1];
    [scrollView addSubview:imageView2];
    [scrollView insertSubview:imageView1 belowSubview:imageView2];
    
    imageView2.layer.mask = self.circleLayer;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //圆心 （图片的中心点）
    CGPoint center = CGPointMake(kSWidth, 240);
    //半径
    CGFloat radius = scrollView.contentOffset.y;
    if (radius < 0) {
        radius = 0;
    }
    
    self.path = [UIBezierPath bezierPathWithOvalInRect:(CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2))];
    _circleLayer.path = self.path.CGPath;
}


@end
