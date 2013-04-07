//
//  KonashiPWMLED.h
//  hello-konashi
//
//  Created by Shiro Fukuda on 2013/04/07.
//  Copyright (c) 2013年 chan-shiro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KonashiPWMLED : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) int pinNum;
@property (nonatomic) int state;
@property (nonatomic) int ratio;

- (id)initWithName:(NSString *)name pinNum:(int)pinNum state:(int)state ratio:(int)ratio;
- (void)outputHigh;
- (void)outputLow;
- (void)toggleOutput;
- (void)updateRatio:(int)ratio;

@end
