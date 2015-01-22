//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Tejas Lagvankar on 1/22/15.
//  Copyright (c) 2015 Yahoo!. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;

- (int) loadDefaultTipIndex;
- (void) saveDefaultTipIndex:(int) index;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Settings";

    int savedIndex = self.loadDefaultTipIndex;

    if (savedIndex == 0) { // No default. Probably first run.
        savedIndex = 3;
        [self saveDefaultTipIndex:savedIndex];
    }

    self.defaultTipControl.selectedSegmentIndex = savedIndex - 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)loadDefaultTipIndex {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int intValue = [defaults integerForKey:@"default_tip_index"];
    return intValue;
}

- (void)saveDefaultTipIndex:(int)index {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:index forKey:@"default_tip_index"];
    [defaults synchronize];
}

- (IBAction)onSegmentSelectionChanged:(id)sender {
    [self saveDefaultTipIndex:(self.defaultTipControl.selectedSegmentIndex + 1)];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
