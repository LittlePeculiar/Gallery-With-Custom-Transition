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
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // determine the new position for the view to pop from
    float posX = [self positionX];
    float posY = [self positionY];
    
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

- (float)positionX
{
    float posX = 0;
    int max = 13;   // we currently have 13 pics
    
    // easy ones
    if (self.cellSelected == 0)
        return 50;
    else if (self.cellSelected == 1)
        return  160;
    else if (self.cellSelected == 2)
        return 270;
    else
    {
        // determine if cell is on the left
        for (int i = 3; i < max; i+=3)
        {
            if (i == self.cellSelected)
            {
                posX = 50;
                break;
            }
        }
        // determine if cell is in the middle
        for (int i = 4; i < max; i+=3)
        {
            if (i == self.cellSelected)
            {
                posX = 160;
                break;
            }
        }
        // determine if cell is on the right
        for (int i = 5; i < max; i+=3)
        {
            if (i == self.cellSelected)
            {
                posX = 270;
                break;
            }
        }
    }
    
    return posX;
}

- (float)positionY
{
    float posY = 0;
    
    // no need to be exact
    if (self.cellSelected <= 2)
        posY = 100;
    else if (self.cellSelected > 2 && self.cellSelected <= 5)
        posY = 250;
    else if (self.cellSelected > 5 && self.cellSelected <= 8)
        posY = 350;
    else if (self.cellSelected > 8 && self.cellSelected <= 11)
        posY = 450;
    else
        posY = 500;
    
    return posY;
}

@end
