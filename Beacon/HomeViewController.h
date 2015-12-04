//
//  ViewController.h
//  Beacon
//
//  Created by Adriana Carelli on 29/09/15.
//  Copyright © 2015 Adriana Carelli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HomeViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic)  UILocalNotification *notification;
@property (strong, nonatomic)  CLBeacon *beacon;
@property (assign, nonatomic) CLLocationAccuracy accuracy;
@property (assign, nonatomic) BOOL detailAlreadyOpen;
@property CLProximity lastProximity;


@end


