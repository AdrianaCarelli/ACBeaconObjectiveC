//
//  DetailBeaconViewController.h
//  Beacon
//
//  Created by Adriana Carelli on 29/09/15.
//  Copyright © 2015 Adriana Carelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface DetailBeaconViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *labelNomeBeacon;

@property (weak, nonatomic) IBOutlet UILabel *labelNomeRegione;

@property (strong, nonatomic)CLBeacon *beacon;

@end
