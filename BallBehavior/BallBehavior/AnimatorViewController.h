//
//  AnimatorViewController.h
//  BallBehavior
//
//  Created by huangxiong on 7/27/15.
//  Copyright (c) 2015 New_Life. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kGravityType = 0,
    kCollisionType,
    kAttachmentType,
    kSnapType,
    kPushType,
} AnimatorType;

@interface AnimatorViewController : UIViewController

@property (nonatomic, assign) AnimatorType animatorType;

@end
