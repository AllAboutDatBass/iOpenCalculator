//
//  UIHexButton.h
//  OpenCalculator
//
//  Created by daniel on 11/1/14.
//  Copyright (c) 2014 Daniel Randall Software. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

#define HEXAGON_VERTICES 6

// rotated slightly to the right for better alignment:
#define HEXAGON_START_ANGLE 0.52

@interface UIHexButton : UIButton
{
	CGPoint vertices[HEXAGON_VERTICES];
}

@end
