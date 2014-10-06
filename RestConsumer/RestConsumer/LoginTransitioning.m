//
//  AnmimatedPopOverTransitioning.m
//  PicaDay
//
//  Created by Christophe Dellac on 6/10/14.
//  Copyright (c) 2014 Christophe Dellac. All rights reserved.
//

#import "LoginTransitioning.h"
#import "MainViewController.h"
#import "ViewController.h"

@implementation LoginTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.35f;
}

-(void)executePresentationAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *inView = [transitionContext containerView];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
 
    CGSize originalSize = toVC.view.frame.size;
    
    if ([toVC isKindOfClass:[ViewController class]])
        [toVC.view setFrame:CGRectMake(0, originalSize.height + 50, originalSize.width, originalSize.height)];
    else
        [toVC.view setFrame:CGRectMake(toVC.view.frame.size.width, 0, toVC.view.frame.size.width, toVC.view.frame.size.height)];
    toVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);

    [UIView animateWithDuration:.2f animations:^{
        fromVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.90, 0.90);
    } completion:^(BOOL finished) {
         [UIView animateWithDuration:.1f animations:^{
             fromVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);
         } completion:^(BOOL finished) {
             [inView insertSubview:toVC.view belowSubview:fromVC.view];
             [UIView animateWithDuration:0.65f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                 toVC.view.center = CGPointMake(originalSize.width / 2, [UIApplication sharedApplication].keyWindow.frame.size.height / 2);
                 if ([toVC isKindOfClass:[ViewController class]])
                     fromVC.view.center = CGPointMake(originalSize.width / 2, -originalSize.height / 2);
                 else
                     fromVC.view.center = CGPointMake(-originalSize.width / 2,  originalSize.height / 2);

             } completion:^(BOOL finished) {
                 [UIView animateWithDuration:0.35f animations:^{
                     toVC.view.transform = CGAffineTransformIdentity;
                 } completion:^(BOOL finished) {
                     fromVC.view.transform = CGAffineTransformIdentity;
                     [transitionContext completeTransition:YES];
                 }];
             }];
         }];
    }];
    
}

-(void)executeDismissalAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    [toVC.view setHidden:YES];
    CGSize originalSize = fromVC.view.frame.size;
    if (![fromVC isKindOfClass:[MainViewController class]])
        [toVC.view setFrame:CGRectMake(0, -toVC.view.frame.size.height - 50, fromVC.view.frame.size.width, fromVC.view.frame.size.height)];
    else
        [toVC.view setFrame:CGRectMake(-toVC.view.frame.size.width - 50, 0, fromVC.view.frame.size.width, fromVC.view.frame.size.height)];

    toVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);
    
    [UIView animateWithDuration:.2f animations:^{
        fromVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.90, 0.90);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.1f animations:^{
            fromVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);
        } completion:^(BOOL finished) {
            [toVC.view setHidden:NO];
            [UIView animateWithDuration:.35f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                toVC.view.center = CGPointMake(originalSize.width / 2, originalSize.height / 2);
                fromVC.view.center = CGPointMake(originalSize.width * 1.5, originalSize.height / 2);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.35f animations:^{
                    toVC.view.transform = CGAffineTransformIdentity;

                } completion:^(BOOL finished) {
                    fromVC.view.transform = CGAffineTransformIdentity;
                    [transitionContext completeTransition:YES];
                }];
            }];
        }];
    }];
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    if(self.isPresenting){
        [self executePresentationAnimation:transitionContext];
    }
    else{
        [self executeDismissalAnimation:transitionContext];
    }
    return;
}

@end
