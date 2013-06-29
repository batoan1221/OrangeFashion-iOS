//
//  BaseViewController.m
//  OrangeFashion
//
//  Created by Khang on 15/6/13.
//  Copyright (c) 2013 Khang. All rights reserved.
//

#import "BaseViewController.h"
#import "IIViewDeckController.h"

@interface BaseViewController() <IIViewDeckControllerDelegate>

- (void)rightButtonClicked;

@end

@implementation BaseViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // Nav left button
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"left-nav-button"] forState:UIControlStateNormal];
    [leftButton addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    
    leftButton.frame = CGRectMake(0, 0, 50, 40);
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    // Nav right button
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"Back" forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(0, 0, 44, 60);
    [rightButton addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventAllTouchEvents];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)rightButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end