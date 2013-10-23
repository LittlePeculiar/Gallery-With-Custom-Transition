//
//  ShrinkDismissAnimationController.m
//  LAFitness
//
//  Created by Gina Mullins on 10/15/13.
//  Copyright (c) 2013 Fitness International LLC. All rights reserved.
//

#import "ShrinkDismissAnimationController.h"

@implementation ShrinkDismissAnimationController


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    
    // obtain the container view
    UIView *containerView = [transitionContext containerView];
    
    // set initial state
    toViewController.view.frame = finalFrame;
    toViewController.view.alpha = 0.5;
    
    // add the view
    [containerView addSubview:toViewController.view];
    [containerView sendSubviewToBack:toViewController.view];
    
    // Determine the intermediate and final frame for the from view
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect shrunkenFrame = CGRectInset(fromViewController.view.frame, fromViewController.view.frame.size.width/4, fromViewController.view.frame.size.height/4);
    CGRect fromFinalFrame = CGRectOffset(shrunkenFrame, 0, screenBounds.size.height);
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // create a snapshot
    UIView *intermediateView = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    intermediateView.frame = fromViewController.view.frame;
    [containerView addSubview:intermediateView];
    
    // remove the real view
    [fromViewController.view removeFromSuperview];
    
    // animate with keyframes
    [UIView animateKeyframesWithDuration:duration
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
                                     [UIView addKeyframeWithRelativeStartTime:0.0
                                                             relativeDuration:0.5
                                                                   animations:^{
                                                                       intermediateView.frame = shrunkenFrame;
                                                                       toViewController.view.alpha = 0.5;
                                                                   }];
                                     [UIView addKeyframeWithRelativeStartTime:0.5
                                                             relativeDuration:0.5
                                                                   animations:^{
                                                                       intermediateView.frame = fromFinalFrame;
                                                                       toViewController.view.alpha = 1.0;
                                                                   }];
                                 }
                              completion:^(BOOL finished) {
                                  // remove the intermediate view
                                  [intermediateView removeFromSuperview];
                                  [transitionContext completeTransition:YES];
                              }];
}

@end
