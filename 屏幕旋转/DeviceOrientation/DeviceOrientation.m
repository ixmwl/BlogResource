//
//  DeviceOrientation.m
//  EpointiOSFrameV7
//
//  Created by 刘灿 on 2019/12/16.
//  Copyright © 2019 Epoint. All rights reserved.
//

#import "DeviceOrientation.h"
#import <CoreMotion/CoreMotion.h>

@interface DeviceOrientation () {
    
    CMMotionManager *_motionManager;
    UIInterfaceOrientation _direction;
    
}
@end
//sensitive 灵敏度
static const float sensitive = 0.77;

@implementation DeviceOrientation

- (instancetype)initWithDelegate:(id<DeviceOrientationDelegate>)delegate {
    self = [super init];
    if (self) {
        
        _delegate = delegate;
    }
    return self;
}
- (void)startMonitor {
    
    [self start];
}

- (void)stop {
    
    [_motionManager stopDeviceMotionUpdates];
}


//陀螺仪 每隔一个间隔做轮询
- (void)start{
    
    if (_motionManager == nil) {
        
        _motionManager = [[CMMotionManager alloc] init];
    }
    _motionManager.deviceMotionUpdateInterval = 1/40.f;
    if (_motionManager.deviceMotionAvailable) {
        
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue]
                                            withHandler: ^(CMDeviceMotion *motion, NSError *error){
                                                [self performSelectorOnMainThread:@selector(deviceMotion:) withObject:motion waitUntilDone:YES];
                                            }];
    }
}
- (void)deviceMotion:(CMDeviceMotion *)motion{
    
    double x = motion.gravity.x;
    double y = motion.gravity.y;
    if (y < 0 ) {
        if (fabs(y) > sensitive) {
            if (_direction != UIInterfaceOrientationPortrait) {
                _direction = UIInterfaceOrientationPortrait;
                if ([self.delegate respondsToSelector:@selector(directionChange:)]) {
                    [self.delegate directionChange:_direction];
                }
            }
        }
    }else {
        if (y > sensitive) {
            if (_direction != UIInterfaceOrientationPortraitUpsideDown) {
                _direction = UIInterfaceOrientationPortraitUpsideDown;
                if ([self.delegate respondsToSelector:@selector(directionChange:)]) {
                    [self.delegate directionChange:_direction];
                }
            }
        }
    }
    if (x < 0 ) {
        if (fabs(x) > sensitive) {
            if (_direction != UIInterfaceOrientationLandscapeRight) {
                _direction = UIInterfaceOrientationLandscapeRight;
                if ([self.delegate respondsToSelector:@selector(directionChange:)]) {
                    [self.delegate directionChange:_direction];
                }
            }
        }
    }else {
        if (x > sensitive) {
            if (_direction != UIInterfaceOrientationLandscapeLeft) {
                _direction = UIInterfaceOrientationLandscapeLeft;
                if ([self.delegate respondsToSelector:@selector(directionChange:)]) {
                    [self.delegate directionChange:_direction];
                }
            }
        }
    }
}

@end
