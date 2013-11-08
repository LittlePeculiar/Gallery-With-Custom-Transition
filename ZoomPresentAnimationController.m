//
//  ZoomPresentAnimationController.m
//  LAFitness
//
//  Created by Gina Mullins on 10/15/13.
//  Copyright (c) 2013 Fitness International LLC. All rights reserved.
//

#import "ZoomPresentAnimationController.h"

@implementation ZoomPresentAnimationController

// specifies the length of the transition animation
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // determine the new position for the view to pop from
    float posX = self.touchPoint.x+50;
    float posY = self.touchPoint.y+50;
    
    //UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    // set the toViewController to start
    toViewController.view.transform = CGAffineTransformMakeScale(0, 0);
    [container addSubview:toViewController.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // animate with keyframes
    [UIView animateKeyframesWithDuration:duration
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
                                     [UIView addKeyframeWithRelativeStartTime:0.0
                                                             relativeDuration:0.5
                                                                   animations:^{
                                                                       toViewController.view.transform = CGAffineTransformMakeScale(0.00001, 0.00001);
                                                                       toViewController.view.frame = CGRectMake(posX, posY, toViewController.view.frame.size.width, toViewController.view.frame.size.height);
                                                                       
                                                                   }];
                                     [UIView addKeyframeWithRelativeStartTime:0.5
                                                             relativeDuration:0.5
                                                                   animations:^{
                                                                       toViewController.view.transform = CGAffineTransformIdentity;
                                                                       toViewController.view.frame = CGRectMake(0, 0, toViewController.view.frame.size.width, toViewController.view.frame.size.height);
                                                                       
                                                                   }];
                                 }
                              completion:^(BOOL finished) {
                                  // remove the intermediate view
                                  [transitionContext completeTransition:finished];
                              }];
}


@end
