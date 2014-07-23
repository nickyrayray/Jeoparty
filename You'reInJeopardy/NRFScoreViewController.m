//
//  NRFScoreViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 7/22/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFScoreViewController.h"

@interface NRFScoreViewController ()

@property (weak, nonatomic) IBOutlet UILabel *contestantOneScore;
@property (weak, nonatomic) IBOutlet UITextView *contestantOneName;
@property (weak, nonatomic) IBOutlet UIButton *contestantOneScorePlus;
@property (weak, nonatomic) IBOutlet UIButton *contestantOneScoreMinus;

@property (weak, nonatomic) IBOutlet UILabel *contestantTwoScore;
@property (weak, nonatomic) IBOutlet UITextView *contestantTwoName;
@property (weak, nonatomic) IBOutlet UIButton *contestantTwoPlus;
@property (weak, nonatomic) IBOutlet UIButton *contestantTwoMinus;

@property (weak, nonatomic) IBOutlet UILabel *contestantThreeScore;
@property (weak, nonatomic) IBOutlet UITextView *contestantThreeName;
@property (weak, nonatomic) IBOutlet UIButton *contestantThreePlus;
@property (weak, nonatomic) IBOutlet UIButton *contestantThreeMinus;

@end

@implementation NRFScoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
