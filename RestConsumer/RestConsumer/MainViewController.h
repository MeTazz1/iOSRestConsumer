//
//  MainViewController.h
//  RestConsumer
//
//  Created by Christophe Dellac on 10/6/14.
//  Copyright (c) 2014 Christophe Dellac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDSideBarController.h"

@interface MainViewController : UIViewController <CDSideBarControllerDelegate, UITableViewDataSource, UITableViewDelegate>
{
    CDSideBarController *_sideBar;
    NSMutableArray *_ratings;
}

@end
