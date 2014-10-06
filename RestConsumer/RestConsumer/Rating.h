//
//  Rating.h
//  RestConsumer
//
//  Created by Christophe Dellac on 10/6/14.
//  Copyright (c) 2014 Christophe Dellac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rating : NSObject

@property (nonatomic) int id;
@property (nonatomic, strong) NSString *author;
@property (nonatomic) int authorid;
@property (nonatomic, strong) NSString *date;
@property (nonatomic) int placeid;
@property (nonatomic, strong) NSString *comment;

@end
