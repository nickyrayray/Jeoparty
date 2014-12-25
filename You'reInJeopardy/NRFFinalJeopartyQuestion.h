//
//  NRFFinalJeopartyQuestion.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 8/11/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFQuestion.h"

@interface NRFFinalJeopartyQuestion : NRFQuestion

@property (strong, nonatomic) NSString *category; //The FJ category shown before contestants place wagers

-(id)init;
-(id)initWithQuestion:(NSString *)question andCategory:(NSString *)category andAnswer:(NSString *)answer;

//Method used in edit mode. Returns true if isFinished in the superclass returns true and category is not blank.
-(BOOL)finalJeopartyQuestionIsFinished;

@end
