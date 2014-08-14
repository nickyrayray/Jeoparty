//
//  NRFFinalJeopartyQuestion.h
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 8/11/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFQuestion.h"

@interface NRFFinalJeopartyQuestion : NRFQuestion

@property (strong, nonatomic) NSString *category;

-(id)init;
-(BOOL)finalJeopartyQuestionIsFinished;

@end
