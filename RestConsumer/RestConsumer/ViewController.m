//
//  ViewController.m
//  RestConsumer
//
//  Created by Christophe Dellac on 10/5/14.
//  Copyright (c) 2014 Christophe Dellac. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
#import "LoginTransitioning.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view viewWithTag:1].layer.cornerRadius = 5.0f;
    [self.view viewWithTag:2].layer.cornerRadius = 69.0f;
    [self.view viewWithTag:1].backgroundColor = [UIColor colorWithRed:.8f green:.8f blue:.8f alpha:0.75];
    [self.view viewWithTag:2].backgroundColor = [UIColor colorWithRed:.8f green:.8f blue:.8f alpha:0.75];
    [self.view viewWithTag:3].layer.cornerRadius = 59.0f;
    [self.view viewWithTag:3].clipsToBounds = YES;
    [self.view viewWithTag:3].layer.masksToBounds = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onGoClick
{
    MainViewController *mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    mainView.transitioningDelegate = self;
    mainView.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:mainView animated:YES completion:nil];
}

#pragma mark -
#pragma mark - Custom transition

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    LoginTransitioning *controller = [LoginTransitioning new];
    controller.isPresenting = YES;
    return controller;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    LoginTransitioning *controller = [LoginTransitioning new];
    controller.isPresenting = NO;
    return controller;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}


@end
