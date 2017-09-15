//
//  ViewController.m
//  AnimationTest
//
//  Created by Damon on 2017/9/7.
//  Copyright © 2017年 Myscoop. All rights reserved.
//

#import "ViewController.h"
#import "Animation2ViewController.h"


@interface ViewController ()<UIScrollViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

{
    CGFloat headHeight;
}
@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UIScrollView *scrollview;
@property (nonatomic, strong)UICollectionView *collection;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    headHeight = self.view.frame.size.height;
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollview.backgroundColor = [UIColor whiteColor];
    scrollview.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*2);
    scrollview.pagingEnabled = YES;
    scrollview.delegate = self;
    [self.view addSubview:scrollview];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc ]init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(100, 100);
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height ) collectionViewLayout:layout];
    collection.delegate =self;
    collection.dataSource = self;
    collection.backgroundColor = [UIColor whiteColor];
    [scrollview addSubview:collection];
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    self.collection = collection;
    self.scrollview = scrollview;
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, headHeight/2 - 80/2 + 20, self.view.bounds.size.width-40,headHeight-80)];
    _imgView.image = [UIImage imageNamed:@"2"];
    _imgView.backgroundColor = [UIColor blueColor];
    [scrollview addSubview:self.imgView];
    _imgView.layer.anchorPoint = CGPointMake(0.5, 1);
    scrollview.contentOffset = CGPointMake(0, self.view.bounds.size.height);
    
    
    self.collection.frame = CGRectMake(0,self.view.bounds.size.height/2  , self.view.bounds.size.width, self.view.bounds.size.height );
    self.collection.layer.anchorPoint = CGPointMake(0.5, 0);//锚点与frame相关联 对应设置
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView != self.collection) {
        CGFloat offsetX = scrollView.contentOffset.y;
        if (offsetX!= 0) {
            CGFloat angle =  M_PI_2 * offsetX / headHeight;
            _imgView.layer.transform = [self transformRotationWithAngle:angle];
            if (offsetX != self.view.bounds.size.height) {//设置contentoffset的时候 禁止转
                angle =  M_PI_2 * (offsetX-self.view.bounds.size.height) / headHeight;
                self.collection.layer.transform = [self transformRotationWithAngle_collection:angle];
            }
        }
    }
}
- (CATransform3D)transformRotationWithAngle:(CGFloat)angle {
    CATransform3D rotation3DIdentity = CATransform3DIdentity;
    rotation3DIdentity.m34 = - 0.4 / 500;
    CATransform3D rotateTransform = CATransform3DRotate(rotation3DIdentity, angle, 1, 0, 0);
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, (headHeight-80)/2);
    return CATransform3DConcat(rotateTransform, transform);
}
- (CATransform3D)transformRotationWithAngle_collection:(CGFloat)angle {
    CATransform3D rotation3DIdentity = CATransform3DIdentity;
    rotation3DIdentity.m34 = - 0.4 / 500;
    CATransform3D rotateTransform = CATransform3DRotate(rotation3DIdentity, angle, 1, 0, 0);
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, (headHeight-80)/2);
    return CATransform3DConcat(rotateTransform, transform);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, cell.bounds.size.width-20, cell.bounds.size.width - 20)];
    lab.backgroundColor = [UIColor redColor];
    [cell addSubview:lab];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 60;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Animation2ViewController *vc = [[Animation2ViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
