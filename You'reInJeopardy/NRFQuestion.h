//
//  NRFQuestion.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/10/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

/* This class is responsible for keeping track of properties
 * related to Jeoparty questions for the model. */

#import <Foundation/Foundation.h>

@interface NRFQuestion : NSObject<NSCopying, NSCoding>

@property (strong, nonatomic) NSString *question;
@property (strong, nonatomic) NSString *answer;
@property (nonatomic) int value; //how much the question is worth in the game
@property (nonatomic) BOOL chosen; //flag indicating whether or not the question has been chosen


- (id)init;
- (id)initQuestion:(NSString *)question withValue:(int)value andAnswer:(NSString *)answer;
- (id)initWithValue:(int)value;

//Method used in edit mode to determine if all fields of a question have been completed.
- (BOOL)isFinished;

@end
