//
//  Animation2ViewController.m
//  AnimationTest
//
//  Created by Damon on 2017/9/14.
//  Copyright © 2017年 Myscoop. All rights reserved.
//

#import "Animation2ViewController.h"



@interface Animation2ViewController ()
{
    UIImageView *imgView1;
    UIImageView *imgView2;
    UIImageView *imgView3;
    UIImageView *imgView4;
    UIImageView *imgView5;
    UIImageView *imgView6;

    int offset;
    CGPoint lastPoint;
    
    UIView *bgview;
}
@property(nonatomic, strong) NSMutableArray *array;
@property(nonatomic, strong) NSMutableArray *array2;

@end

@implementation Animation2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.backgroundColor = [UIColor blueColor];
    bt.frame = CGRectMake(20, 20, 50, 50);
    [bt addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    bgview = view;
    
    CATransform3D subTransform = CATransform3DIdentity;
    subTransform.m34 = -1 / 500.0;
    subTransform = CATransform3DRotate(subTransform, M_PI_4 / 2, 1, 0, 0);
    subTransform = CATransform3DRotate(subTransform, M_PI_4 / 2, 0, 1, 0);
    view.layer.sublayerTransform = subTransform;
    
    
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 50);
    [self addTransform:1 transform:transform parentView:view];
    
    transform = CATransform3DMakeTranslation(50, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addTransform:2 transform:transform parentView:view];
    
    transform = CATransform3DMakeTranslation(0, -50, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addTransform:3 transform:transform parentView:view];
    
    transform = CATransform3DMakeTranslation(0, 50, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addTransform:4 transform:transform parentView:view];
    
    transform = CATransform3DMakeTranslation(-50, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addTransform:5 transform:transform parentView:view];
    
    transform = CATransform3DMakeTranslation(0, 0, -50);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addTransform:6 transform:transform parentView:view];
    

}
- (void)addTransform:(int)index transform:(CATransform3D)transform parentView:(UIView *)parentView
{
    UIView *one = [self setSubviews:index];
    [parentView addSubview:one];
    one.layer.transform = transform;
}

- (UIView *)setSubviews:(int)index{
    NSLog(@"index:%d",index);
    NSString *imgname = [NSString stringWithFormat:@"%d_bac",index];
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    imgView.image = [UIImage imageNamed:imgname];
    return imgView;
}

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform{
    UIView *face = self.array[index];
    [bgview addSubview:face];
    face.layer.transform = transform;
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self.view];
    
    NSLog(@"point :%@",NSStringFromCGPoint(currentLocation));
    if (lastPoint.x > currentLocation.x) {
        offset += 5;
    }else{
        offset -= 5;
    }

//    CATransform3D perspective = CATransform3DIdentity;
//    perspective.m34 = -1.0 / 500.0;
//    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
//    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
//    bgview.layer.sublayerTransform = perspective;

    CGFloat angle =  M_PI_2 * offset / bgview.bounds.size.width;
    //imgView1.layer.transform = [self transformRotationWithAngle:angle];
    bgview.layer.sublayerTransform = [self transformRotationWithAngle:angle];
    lastPoint = currentLocation;
}
/*
 
 UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
 view.backgroundColor = [UIColor whiteColor];
 [self.view addSubview:view];
 self.diveView = view;
 
 CATransform3D subTransform = CATransform3DIdentity;
 subTransform.m34 = -1 / 500.0;
 subTransform = CATransform3DRotate(subTransform, M_PI_4 / 2, 1, 0, 0);
 subTransform = CATransform3DRotate(subTransform, M_PI_4 / 2, 0, 1, 0);
 view.layer.sublayerTransform = subTransform;
 
 
 CATransform3D transform = CATransform3DMakeTranslation(0, 0, 50);
 [self addTransform:1 transform:transform parentView:view];
 
 transform = CATransform3DMakeTranslation(50, 0, 0);
 transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
 [self addTransform:2 transform:transform parentView:view];
 
 transform = CATransform3DMakeTranslation(0, -50, 0);
 transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
 [self addTransform:3 transform:transform parentView:view];
 
 transform = CATransform3DMakeTranslation(0, 50, 0);
 transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
 [self addTransform:4 transform:transform parentView:view];
 
 transform = CATransform3DMakeTranslation(-50, 0, 0);
 transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
 [self addTransform:5 transform:transform parentView:view];
 
 transform = CATransform3DMakeTranslation(0, 0, -50);
 transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
 [self addTransform:6 transform:transform parentView:view];
 
 
 - (void)addTransform:(int)index transform:(CATransform3D)transform parentView:(UIView *)parentView
 {
 UIView *one = [self setSubviews:index];
 [parentView addSubview:one];
 one.layer.transform = transform;
 }
 
 - (UIView *)setSubviews:(int)index
 {
 UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
 aView.backgroundColor = [UIColor redColor];
 aView.layer.borderColor = [UIColor blackColor].CGColor;
 aView.layer.borderWidth = 1.0;
 
 UILabel *label = ({
 label = [[UILabel alloc] initWithFrame:CGRectMake(25, 25, 50, 50)];
 label.text = [NSString stringWithFormat:@"%d", index];
 label.textAlignment = NSTextAlignmentCenter;
 label.textColor = [UIColor blackColor];
 label.font = [UIFont systemFontOfSize:20];
 label;
 });
 [aView addSubview:label];
 return  aView;
 }
 */
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
- (CATransform3D)transformRotationWithAngle:(CGFloat)angle {
    CATransform3D rotation3DIdentity = CATransform3DIdentity;
    rotation3DIdentity.m34 = - 1 / 500;
    CATransform3D rotateTransform = CATransform3DRotate(rotation3DIdentity, angle, 1, 1, 0);
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 50);
    return CATransform3DConcat(rotateTransform, transform);
}
- (void)btnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
