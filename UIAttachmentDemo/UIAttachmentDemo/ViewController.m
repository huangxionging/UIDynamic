//
//  ViewController.m
//  UIAttachmentDemo
//
//  Created by huangxiong on 7/21/15.
//  Copyright (c) 2015 New_Life. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView: self.view];
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(50, 100, 50, 100)];
    view.backgroundColor = [UIColor cyanColor];
    view.transform = CGAffineTransformMakeRotation(M_PI_4);
    [self.view addSubview: view];
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems: @[view]];
    [gravityBehavior setAngle: M_PI / 2];
    [gravityBehavior setMagnitude: 10];
    //    gravityBehavior.gravityDirection = CGVectorMake(0.91, -0);
    [_animator addBehavior: gravityBehavior];
    
    UIView *collisionView = [[UIView alloc] initWithFrame: CGRectMake(100, 30, 50, 50)];
    collisionView.backgroundColor = [UIColor redColor];
    [self.view addSubview: collisionView];
    
    
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems: @[view, collisionView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
//    collisionBehavior.collisionDelegate = self;
    collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
    [_animator addBehavior: collisionBehavior];
    
    CGPoint center = CGPointMake(collisionView.center.x, collisionView.center.y);
    _attachmentBehavior =[[UIAttachmentBehavior alloc] initWithItem:view attachedToAnchor: center];
    [collisionView addGestureRecognizer: [[UIPanGestureRecognizer alloc] initWithTarget:self action: @selector(handleCollisionGesture:)]];
    
    [_animator addBehavior: _attachmentBehavior];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) handleCollisionGesture: (UIPanGestureRecognizer *)gesture {
    CGPoint gesturePoint = [gesture translationInView: self.view];

    UIView *collisionView = gesture.view;
    CGPoint center = CGPointMake(collisionView.center.x + gesturePoint.x, collisionView.center.y + gesturePoint.y);
    NSLog(@"%@", NSStringFromCGPoint(gesturePoint));
    gesture.view.center = center;
    
    [gesture setTranslation: center  inView: collisionView.superview];

    [_attachmentBehavior setAnchorPoint: gesturePoint];
    
    
  
    
 

}


@end
