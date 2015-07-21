//
//  ViewController.m
//  UIGravityDemo
//
//  Created by huangxiong on 15/7/16.
//  Copyright (c) 2015年 New_Life. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollisionBehaviorDelegate>

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(50, 0, 50, 100)];
    view.backgroundColor = [UIColor cyanColor];
    view.transform = CGAffineTransformMakeRotation(M_PI_4);
    [self.view addSubview: view];
    
    UIView *collisionView = [[UIView alloc] initWithFrame: CGRectMake(100, 500, 50, 50)];
    collisionView.backgroundColor = [UIColor redColor];
    [self.view addSubview: collisionView];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView: self.view];
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems: @[view]];
    [gravityBehavior setAngle: M_PI / 2];
    [gravityBehavior setMagnitude: 10];
//    gravityBehavior.gravityDirection = CGVectorMake(0.91, -0);
    [_animator addBehavior: gravityBehavior];
    
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems: @[view, collisionView, _gravityView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    collisionBehavior.collisionDelegate = self;
    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    [_animator addBehavior: collisionBehavior];
    

//    gravityBehavior
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p {
    
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier {
    
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 {
    
}

@end
