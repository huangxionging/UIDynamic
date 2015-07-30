//
//  AnimatorViewController.m
//  BallBehavior
//
//  Created by huangxiong on 7/27/15.
//  Copyright (c) 2015 New_Life. All rights reserved.
//

#import "AnimatorViewController.h"
#import "BallView.h"

@interface AnimatorViewController ()

// 装 UIDynamicBehavior 类
@property (nonatomic, strong) NSMutableArray *animatorDynamic;

@property (nonatomic, strong) UIDynamicAnimator *animator;


@end

@implementation AnimatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView: self.view];
    _animatorDynamic = [[NSMutableArray alloc] init];
    
    [self settingBalls];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setGravityBehavior {
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    [_animatorDynamic addObject: gravity];
    [_animator addBehavior: gravity];;
    
}

- (void) settingBalls {
    switch (_animatorType) {
        case kGravityType: {
            [self setGravityBehavior];
            
            for (NSInteger index = 0; index < 5; ++index) {
                BallView *ball = [[BallView alloc] initWithFrame: CGRectMake(index * 50 + 50, 100, 40, 40)];
                [self.view addSubview: ball];
                
                [[_animatorDynamic firstObject] addItem: ball];
            }
            break;
        }
        
        case kCollisionType: {
            [self setGravityBehavior];
            
             for (NSInteger index = 0; index < 5; ++index) {
                BallView *ball = [[BallView alloc] initWithFrame: CGRectMake(index * 50 + 50, 100, 40, 40)];
                [self.view addSubview: ball];
                UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems: @[ball]];
                [[_animatorDynamic firstObject] addItem: ball];
                [collisionBehavior addItem: ball];
                collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
                [_animator addBehavior: collisionBehavior];
            }
            
            
            
            break;
        }
            
        case kAttachmentType: {
            UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] init];
            collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
            [_animator addBehavior: collisionBehavior];
            for (NSInteger index = 0; index < 6; ++index) {
                BallView *ball = [[BallView alloc] initWithFrame: CGRectMake(index * 50 + 10, 100, 40, 40)];
                [self.view addSubview: ball];
                ball.tag = 100 + index;
                
               
                
                if (index != 0) {
                    UIView *front = [self.view viewWithTag: index + 99];
                    UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem: ball attachedToItem: front];
                    // 震动频率
                    attachment.frequency = 1;
                    
                    // 熨平动画峰值
                 //   attachment.damping = 100;
                    [_animator addBehavior: attachment];
                }
                else {
                    UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem: ball attachedToAnchor: ball.center];
//                    [_animatorDynamic addObject: attachment];
                    [_animator addBehavior: attachment];
                    [ball addGestureRecognizer: [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(ballMove:)]];
                }
                
                
                [collisionBehavior addItem: ball];
//                [collisionBehavior addItem: ball];
                
                
            }
            
            
            
            break;
        }
            
            
        case kSnapType: {
            
            UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] init];
            collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
            [_animator addBehavior: collisionBehavior];
            
            for (NSInteger index = 0; index < 6; ++index) {
                BallView *ball = [[BallView alloc] initWithFrame: CGRectMake(index * 50 + 40, 100, 40, 40)];
                [self.view addSubview: ball];
                ball.tag = 100 + index;
                
                if (index != 0) {
                    UIView *front = [self.view viewWithTag: index + 99];
                    UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem: ball attachedToItem: front];
                    // 震动频率
                    attachment.frequency = 1;
                    
                    // 熨平动画峰值
                    //   attachment.damping = 100;
                    [_animator addBehavior: attachment];
                }
                else {
                    
                    [ball addGestureRecognizer: [[UIPanGestureRecognizer alloc] initWithTarget:self action: @selector(ballSnap:)]];
                    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem: ball snapToPoint: ball.center];
                    snap.damping = 0.75f;
                    [_animatorDynamic addObject: snap];
                    [_animator addBehavior: snap];
                }
               
                [collisionBehavior addItem: ball];
            }
            break;
        }
            
        case kPushType: {
            UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] init];
            collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
            [_animator addBehavior: collisionBehavior];
            
            for (NSInteger index = 0; index < 6; ++index) {
                BallView *ball = [[BallView alloc] initWithFrame: CGRectMake(index * 50 + 40, 100, 40, 40)];
                [self.view addSubview: ball];
                ball.tag = 100 + index;
                
                if (index != 0) {
                    UIView *front = [self.view viewWithTag: index + 99];
                    UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem: ball attachedToItem: front];
                    // 震动频率
                    attachment.frequency = 1;
                    
                    // 熨平动画峰值
                    //   attachment.damping = 100;
                    [_animator addBehavior: attachment];
                }
                else {
                    
                    [ball addGestureRecognizer: [[UIPanGestureRecognizer alloc] initWithTarget:self action: @selector(ballPush:)]];
                    
                }
                
                [collisionBehavior addItem: ball];
            }
            break;
        }
        default:
            break;
    }
}

- (void) ballMove: (UIPanGestureRecognizer *) gesture{
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint gesturePoint = [gesture locationInView: self.view];
        gesture.view.center = gesturePoint;
        [_animator.behaviors[1] setAnchorPoint: gesturePoint];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded) {
        [_animator removeBehavior: _animator.behaviors[1]];
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems: @[[self.view viewWithTag: 100]]];
        [gesture.view removeGestureRecognizer: gesture];
        [_animator addBehavior: gravity];
    }
    
}

#pragma mark--- 吸附
- (void) ballSnap: (UIPanGestureRecognizer *)gesture {
    CGPoint gesturePoint = [gesture locationInView: self.view];
   // gesture.view.center = gesturePoint;
    
    
    if ([_animatorDynamic lastObject] != nil){
        [self.animator removeBehavior: [_animatorDynamic lastObject]];
        [_animatorDynamic removeLastObject];
    }
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem: gesture.view snapToPoint: gesturePoint];
    snapBehavior.damping = 0.5f;  //剧列程度
    [_animatorDynamic addObject: snapBehavior];
    [_animator addBehavior: snapBehavior];
}

- (void) ballPush: (UIPanGestureRecognizer *)gesture {
    
    if ([[_animator.behaviors lastObject] isKindOfClass: [UIPushBehavior class]] == YES) {
        [_animator removeBehavior: [_animator.behaviors lastObject]];
    }
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems: @[gesture.view] mode: UIPushBehaviorModeInstantaneous];
    
    CGPoint gesturePoint = [gesture translationInView: self.view];
    
    CGFloat angle = atan2(gesturePoint.x, gesturePoint.y);
    
    CGFloat distance = sqrt(gesturePoint.x * gesturePoint.x + gesturePoint.y * gesturePoint.y);
    
    [pushBehavior setAngle: angle magnitude: distance / 100.0];
    
    [_animator addBehavior: pushBehavior];
}


@end
