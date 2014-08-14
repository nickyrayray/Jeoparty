//
//  NRFQuestion.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRFQuestion : NSObject<NSCopying, NSCoding>

@property (strong, nonatomic) NSString *question;
@property (strong, nonatomic) NSString *answer;
@property (nonatomic) int value;
@property (nonatomic) BOOL chosen;


-(id)init;
- (id)initQuestion:(NSString *)question withValue:(int)value andAnswer:(NSString *)answer;
- (id)initWithValue:(int)value;
- (BOOL)isFinished;

@end
