//
//  ViewController.m
//  Beacon
//
//  Created by Adriana Carelli on 29/09/15.
//  Copyright © 2015 Adriana Carelli. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailBeaconViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSUUID *beaconUUID = [[NSUUID alloc] initWithUUIDString: @"ACFD065E-C3C0-11E3-9BBE-1A514932AC01"];
    NSString *beaconIdentifier = @"BlueBeacon Mini";
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID: beaconUUID identifier:beaconIdentifier];
    beaconRegion.notifyOnEntry=YES;
    beaconRegion.notifyOnExit=YES;
    beaconRegion.notifyEntryStateOnDisplay=YES;
    //    [self.locationManager startMonitoringForRegion:beaconRegion];
    
    
    //Create Location manager instance and handle authorisation for iOS8
    self.locationManager = [[CLLocationManager alloc] init];
    
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    //Set delegate and then start monitoring for regions, ranging the beacons and updating locations
    self.locationManager.delegate = self;
    //    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    [self.locationManager requestStateForRegion:beaconRegion];
    [self.locationManager startMonitoringForRegion:beaconRegion];
    
    
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
    [self.locationManager startUpdatingLocation];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    self.detailAlreadyOpen=false;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    [self.locationManager requestStateForRegion:region];
}

-(void)sendLocalNotificationWithMessage:(NSString*)message {
    
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.alertBody = message;
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons: (NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    
    //Send through the beacon array to teh view controiller and refresh the table
    
    
    //Set up Notifications when in Background
    NSString *message = @"";
    if(beacons.count > 0) {
        CLBeacon *nearestBeacon = beacons.firstObject;
        NSLog(@"The beacon nearest is:%f", nearestBeacon.accuracy);
        NSLog(@"The last proximity is:%ld", (long)self.lastProximity);
        
        
        
        if(nearestBeacon.proximity == self.lastProximity || nearestBeacon.proximity == CLProximityUnknown) {
            return;
        }
        
        
        
        self.lastProximity = nearestBeacon.proximity;
        self.accuracy = nearestBeacon.accuracy;
        
        switch(nearestBeacon.proximity) {
            case CLProximityFar:
                message = @"You are far away from the beacon";
                break;
            case CLProximityNear:{
                message = @"You are near the beacon";
                if(!self.detailAlreadyOpen){
                    self.detailAlreadyOpen=true;
                    DetailBeaconViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"detailBeacon"];
                    vc.beacon = nearestBeacon;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
            }
                break;
            case CLProximityImmediate:{
                message = @"You are in the immediate proximity of the beacon";
                if(!self.detailAlreadyOpen){
                    self.detailAlreadyOpen=true;
                    DetailBeaconViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"detailBeacon"];
                    vc.beacon = nearestBeacon;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
                //                                NSString* stringBeacon =[NSString stringWithFormat:@"Sei vicino al beacon: %@", nearestBeacon.proximityUUID.UUIDString];
                //                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BEACON"
                //                                                                                message:stringBeacon
                //                                                                               delegate:self
                //                                                                      cancelButtonTitle:@"OK"
                //                                                                      otherButtonTitles:nil];
                //                                [alert show];
            }
                break;
                
            case CLProximityUnknown:
                return;
        }
    } else {
        message = @"No beacons are nearby";
    }
    
    NSLog(@"%@", message);
    [self sendLocalNotificationWithMessage:message];
}



-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    [manager startRangingBeaconsInRegion:(CLBeaconRegion*)region];
    [self.locationManager startUpdatingLocation];
    
    NSLog(@"You entered the region .");
    [self sendLocalNotificationWithMessage:@"You entered the region."];
}



-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    [manager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
    [self.locationManager stopUpdatingLocation];
    
    NSLog(@"You exited the region.");
    [self sendLocalNotificationWithMessage:@"You exited the region."];
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(nullable CLRegion *)region withError:(NSError *)error{
    NSLog(@" monitoringDidFailForRegion L'errore è: %@", error.description);
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    if(state == CLRegionStateInside) {
        NSLog(@"locationManager didDetermineState INSIDE for %@", region.identifier);
        [self sendLocalNotificationWithMessage:@"Sei dentro la regione."];
    }
    else if(state == CLRegionStateOutside) {
        NSLog(@"locationManager didDetermineState OUTSIDE for %@", region.identifier);
        [self sendLocalNotificationWithMessage:@"Sei fuori dalla regione."];
    }
    else {
        NSLog(@"locationManager didDetermineState OTHER for %@", region.identifier);
        [self sendLocalNotificationWithMessage:@"Regione non identificata"];
    }
    
}


@end
