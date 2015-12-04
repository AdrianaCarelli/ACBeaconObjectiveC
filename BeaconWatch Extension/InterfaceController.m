//
//  InterfaceController.m
//  BeaconWatch Extension
//
//  Created by Adriana Carelli on 29/09/15.
//  Copyright © 2015 Adriana Carelli. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    //use our group user defaults
    NSUserDefaults *defaults = [[NSUserDefaults alloc]
                                initWithSuiteName:@"it.midapp.beacon"];
    
    NSString *name = [defaults objectForKey:@"NAME_BEACON"];
    NSString *region = [defaults objectForKey:@"NAME_REGION"];
    
    if (![name isEqualToString:@""]&& name!=nil) {
        self.labelBeaconName.text =name;
    }else{
        self.labelBeaconName.text=@"";
    }
    
    if(![region isEqualToString:@""] && region!=nil){
        self.labelBeaconRegion.text=region;
    }else{
        self.labelBeaconRegion.text=@"";
    }

}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



