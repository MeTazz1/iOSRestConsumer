//
//  MainViewController.m
//  RestConsumer
//
//  Created by Christophe Dellac on 10/6/14.
//  Copyright (c) 2014 Christophe Dellac. All rights reserved.
//

#import "MainViewController.h"
#import <RestKit/RestKit.h>
#import "Rating.h"

@interface MainViewController ()

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *imageList = @[[UIImage imageNamed:@"menuChat.png"], [UIImage imageNamed:@"menuUsers.png"], [UIImage imageNamed:@"menuMap.png"], [UIImage imageNamed:@"menuClose.png"]];
    _sideBar = [[CDSideBarController alloc] initWithImages:imageList];
    _sideBar.delegate = self;
    
    self.tableView.delegate = self;

    [self configureRestKit];
    [self loadRatings];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_sideBar insertMenuButtonOnView:self.view atPosition:CGPointMake(self.view.frame.size.width - 70, 50)];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _ratings.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ratingCell" forIndexPath:indexPath];
    Rating *rating = _ratings[indexPath.row];
    
    ((UILabel*)[cell viewWithTag:1]).text = [NSString stringWithFormat:@"By : %@", rating.author];
    ((UILabel*)[cell viewWithTag:2]).text = rating.date;
    ((UILabel*)[cell viewWithTag:3]).text = rating.comment;
    return cell;
}

#pragma mark - RestKit

- (void)configureRestKit
{
    NSURL *baseURL = [NSURL URLWithString:@"http://ratemyplacerestapi.herokuapp.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    RKObjectMapping *ratingMapping = [RKObjectMapping mappingForClass:[Rating class]];
    NSDictionary *mappingDictionary = @{@"id": @"id",
                                        @"author": @"author",
                                        @"authorid": @"authorid",
                                        @"date": @"date",
                                        @"comment": @"comment",
                                        @"placeid": @"placeid"
                                        };
    [ratingMapping addAttributeMappingsFromDictionary:mappingDictionary];
    
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *getresponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:ratingMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/api/Ratings/"
                                                keyPath:@""
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    RKResponseDescriptor *putresponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:ratingMapping
                                                 method:RKRequestMethodPUT
                                            pathPattern:@"/api/Ratings/"
                                                keyPath:@""
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objectManager addResponseDescriptor:getresponseDescriptor];
    [objectManager addResponseDescriptor:putresponseDescriptor];
}

- (NSNumber*)getMaxId
{
    int maxId = 0;
    for (Rating *rating in _ratings)
    {
        if (rating.id > maxId)
            maxId = rating.id;
    }
    return [NSNumber numberWithInt:maxId + 1];
}

- (void)insertRating
{
    NSDictionary *params =  @{@"id": [self getMaxId],
                              @"author": @"iOS",
                             @"authorid" : @4,
                             @"date": @"4:13 pm sur iOS",
                             @"placeid": @3,
                             @"comment": @"SA ROX DU PATE",
                              };
    Rating *newRating = [Rating new];
    newRating.id = [[self getMaxId] intValue];
    newRating.author = @"iOS";
    newRating.authorid = 3;
    newRating.date = @"4:13 pm sur iOS";
    newRating.placeid = 2;
    newRating.comment = @"SA ROX DU PATE";

   [[RKObjectManager sharedManager] putObject:newRating path:@"/api/Ratings/" parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
       NSLog(@"success");
       [_ratings addObject:newRating];
       [self.tableView reloadData];
   } failure:^(RKObjectRequestOperation *operation, NSError *error) {
       NSLog(@"Failed %@", error);
   }];
}

- (void)loadRatings
{
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/api/Ratings/"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  _ratings = mappingResult.array;
                                                  [self.tableView reloadData];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"What do you mean by 'there is no coffee?': %@", error);
                                              }];
}


#pragma mark -
#pragma mark - CDSideBarController delegate

- (void)menuButtonClicked:(int)index
{
    switch (index) {
        case 0:
            [self loadRatings];
            break;
        case 1:
            [self insertRating];
            break;
        case 3:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
            
        default:
            break;
    }
    // Execute what ever you want
}
@end
