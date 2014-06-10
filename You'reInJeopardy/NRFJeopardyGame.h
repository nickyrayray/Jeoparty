//
//  NRFJeopardyGame.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRFJeopardyGame : NSObject

@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSMutableDictionary *questions;
@property (nonatomic) BOOL doubleJ;

-(id)initWithCategories:(NSArray *)categories forDoubleJ:(BOOL)doubleJ;

@end
