//
//  InterfaceController.h
//  BeaconWatch Extension
//
//  Created by Adriana Carelli on 29/09/15.
//  Copyright © 2015 Adriana Carelli. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *labelBeaconName;


@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *labelBeaconRegion;



@end
