//
//  NRFTransitionDisplayViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 10/19/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFTransitionDisplayViewController.h"

@interface NRFTransitionDisplayViewController ()

@property int transitionType;
@property (strong, nonatomic) NSString *transitionMessage;

@end

@implementation NRFTransitionDisplayViewController

-(id)initWithTransitionType:(int)transitionType andMessage:(NSString *)transitionMessage{
    
    self = [super init];
    if(self){
        self.transitionType = transitionType;
        self.transitionMessage = transitionMessage;
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *questionButton;
    questionButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 984, 728)];
    [questionButton setTitle:self.transitionMessage forState:UIControlStateNormal];
    [questionButton addTarget:self action:@selector(transitionAcknowledged:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:questionButton];
    
}

-(void)transitionAcknowledged:(id)sender
{
    [self.delegate transitionDisplayViewControllerDidFinishDisplayingWithType:self.transitionType];
}

@end
