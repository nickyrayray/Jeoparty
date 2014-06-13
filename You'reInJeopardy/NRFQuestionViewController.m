//
//  NRFQuestionViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/13/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFQuestionViewController.h"

@interface NRFQuestionViewController ()

@property (strong, nonatomic) NRFQuestion *question;
@property (weak, nonatomic) IBOutlet UIButton *questionDisplay;


@end

@implementation NRFQuestionViewController

- (id)initWithQuestion:(NRFQuestion *)question
{
    self = [super initWithNibName:@"NRFQuestionViewController" bundle:nil];
    if (self) {
        self.question = question;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.questionDisplay setTitle:self.question.question forState:UIControlStateNormal];
    
}

- (IBAction)questionAnswered:(id)sender {
    
    [self.delegate questionViewController:self didFinishWithQuestion:self.question];
    
}


@end
