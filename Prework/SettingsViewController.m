//
//  SettingsViewController.m
//  Prework
//
//  Created by Vincent Lai on 6/11/15.
//  Copyright (c) 2015 Vincent Lai. All rights reserved.
//

#import "SettingsViewController.h"
#import "tipViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultSetting;
- (IBAction)changeDefaultSetting:(id)sender;
- (void)setDefaultSetting;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefaultSetting];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)changeDefaultSetting:(id)sender {
    NSInteger defaultPercent = self.defaultSetting.selectedSegmentIndex;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:defaultPercent forKey:@"getDefaultSetting"];
    [defaults synchronize];
    
}

- (void)setDefaultSetting {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger defaultValue = [defaults integerForKey:@"getDefaultSetting"];
    self.defaultSetting.selectedSegmentIndex = defaultValue;
    
}
@end
