//
//  ZoomPresentAnimationController.h
//  LAFitness
//
//  Created by Gina Mullins on 10/15/13.
//  Copyright (c) 2013 Fitness International LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZoomPresentAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSInteger cellSelected;
@property (nonatomic, assign) CGPoint touchPoint;

@end
