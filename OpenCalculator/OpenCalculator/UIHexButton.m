//
//  UIHexButton.m
//  OpenCalculator
//
//  Created by daniel on 11/1/14.
//  Copyright (c) 2014 Daniel Randall Software. All rights reserved.
//

#import "UIHexButton.h"

@implementation UIHexButton

-(void)drawRect:(CGRect)rect
{
	const CGFloat vertices = 6;

	const CGFloat nextVertex = 2.0 * M_PI / vertices;

	CGPoint origin = CGPointMake(
		rect.origin.x + (rect.size.width  / 2),
		rect.origin.y + (rect.size.height / 2));
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetLineWidth(context, 1);
	
	CGContextSetStrokeColorWithColor(
		context,
		[UIColor colorWithWhite:0.0 alpha:1.0].CGColor);

	CGFloat radius = ((rect.size.height - 2) / 2);
	
	// rotated slightly to the right for better alignment:
	CGFloat angle = 0.52;
	
	CGPoint endPoint = CGPointMake(
		radius * cos(angle) + origin.x,
		radius * sin(angle) + origin.y);

	CGContextMoveToPoint(context, endPoint.x, endPoint.y);

	for (int vertex = 0; vertex < vertices; vertex++)
	{
		angle += nextVertex;

		endPoint = CGPointMake(
			radius * cos(angle) + origin.x,
			radius * sin(angle) + origin.y);

		CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
	}
	
	CGContextStrokePath(context);
	
	[super drawRect:rect];
}

@end
