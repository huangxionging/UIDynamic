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
@property (nonatomic, strong) UIView *collisionView;
@property (nonatomic, strong) UIView *myview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView: self.view];
    _myview = [[UIView alloc] initWithFrame: CGRectMake(50, 100, 50, 100)];
    _myview.backgroundColor = [UIColor cyanColor];
    _myview.transform = CGAffineTransformMakeRotation(M_PI_4);
    [self.view addSubview: _myview];
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems: @[_myview]];
    [gravityBehavior setAngle: M_PI / 2];
    [gravityBehavior setMagnitude: 10];
    //    gravityBehavior.gravityDirection = CGVectorMake(0.91, -0);
    [_animator addBehavior: gravityBehavior];
    
    _collisionView = [[UIView alloc] initWithFrame: CGRectMake(100, 30, 50, 50)];
    _collisionView.backgroundColor = [UIColor redColor];
    [self.view addSubview: _collisionView];
    
    
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems: @[_myview, _collisionView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
//    collisionBehavior.collisionDelegate = self;
    collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
    [_animator addBehavior: collisionBehavior];
    
    UIAttachmentBehavior *attachmentBehavior =[[UIAttachmentBehavior alloc] initWithItem:_myview attachedToItem: _collisionView];
    [_collisionView addGestureRecognizer: [[UIPanGestureRecognizer alloc] initWithTarget:self action: @selector(handleCollisionGesture:)]];
    
    [_animator addBehavior: attachmentBehavior];
    
    _attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem: _collisionView attachedToAnchor: _collisionView.center];
    
    [_animator addBehavior: _attachmentBehavior];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) handleCollisionGesture: (UIPanGestureRecognizer *)gesture {
    
    CGPoint gesturePoint = [gesture locationInView: self.view];
    gesture.view.center = gesturePoint;
    [_attachmentBehavior setAnchorPoint: gesturePoint];
//    if (gesture.state == UIGestureRecognizerStateBegan) {
//        _attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem: _collisionView attachedToAnchor: gesturePoint];
//        [_attachmentBehavior setLength: 5];
//        
//        [_animator addBehavior: _attachmentBehavior];
//    }
//    else if (gesture.state == UIGestureRecognizerStateChanged) {
//        [_attachmentBehavior setAnchorPoint: gesturePoint];
//    }
//    else if (gesture.state == UIGestureRecognizerStateEnded) {
//        [_animator removeBehavior: _attachmentBehavior];
//    }

}


@end
