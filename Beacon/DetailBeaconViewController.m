//
//  DetailBeaconViewController.m
//  Beacon
//
//  Created by Adriana Carelli on 29/09/15.
//  Copyright © 2015 Adriana Carelli. All rights reserved.
//

#import "DetailBeaconViewController.h"

@implementation DetailBeaconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"The beacon is:%@", self.beacon);
    if(self.beacon!=nil){
        self.labelNomeBeacon.text =self.beacon.proximityUUID.UUIDString;
        self.labelNomeRegione.text = self.beacon.description;
        NSUserDefaults *defaults = [[NSUserDefaults alloc]
                                    initWithSuiteName:@"it.midapp.beacon"];
        
        
        [defaults setObject:self.labelNomeBeacon.text forKey:@"NAME_BEACON"];
        [defaults setObject:self.labelNomeRegione.text forKey:@"NAME_REGION"];
        
        //synchronise
        [defaults synchronize];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
