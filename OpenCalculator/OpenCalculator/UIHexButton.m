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
	const CGFloat nextVertex = 2.0 * M_PI / HEXAGON_VERTICES;

	CGPoint origin = CGPointMake(
		rect.origin.x + (rect.size.width  / 2),
		rect.origin.y + (rect.size.height / 2));
	
	CGFloat radius = ((rect.size.height - 2) / 2);
	
	CGFloat angle = HEXAGON_START_ANGLE;
	
	for (int vertex = 0; vertex < HEXAGON_VERTICES; vertex++)
	{
		vertices[vertex] = CGPointMake(
			radius * cos(angle) + origin.x,
			radius * sin(angle) + origin.y);
		
		angle += nextVertex;
	}
	
	[self fillHexagon];
	
	[self drawHexagon];
	
	[super drawRect:rect];
}

// restrict hitTest operations to points within the hexagon:
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // Return FALSE if superclass does:
    if (![super pointInside:point withEvent:event])
		{
			return FALSE;
		}
	
    // repeat last reply if last test point was repeated:
    if (CGPointEqualToPoint(point, lastPointInside))
		{
			return lastPointInsideResult;
    }
		else
		{
			// cache current test point:
			lastPointInside = point;
    }

		// determine point falls within polygon:
		BOOL response = FALSE;
		int east = (HEXAGON_VERTICES - 1);
		for (int west = 0; west < HEXAGON_VERTICES; east = west++)
		{
			if (((vertices[west].y > point.y) != (vertices[east].y > point.y)) &&
				(point.x < (vertices[east].x - vertices[west].x) *
				(point.y - vertices[west].y) /
				(vertices[east].y - vertices[west].y) +
				vertices[west].x))
			{
				response = (!response);
			}
		}
	
		// cache current response:
		lastPointInsideResult = response;
	
		return response;
}

-(void)fillHexagon
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	[_fillColor set];

	CGPathRef path = [self hexPath];

	CGContextAddPath(context, path);
	
  CGContextFillPath(context);
	
	CGPathRelease(path);
}

-(void)drawHexagon
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetLineWidth(context, _lineWidth);
	
	[_lineColor set];

	CGPathRef path = [self hexPath];

	CGContextAddPath(context, path);
	
	CGContextStrokePath(context);
	
	CGPathRelease(path);
}

-(CGPathRef)hexPath
{
	CGMutablePathRef path = CGPathCreateMutable();
	
	CGPathMoveToPoint(path, NULL, vertices[0].x, vertices[0].y);
 
	for (int vertex = 1; vertex < HEXAGON_VERTICES; vertex++)
	{
		CGPathAddLineToPoint(path, NULL, vertices[vertex].x, vertices[vertex].y);
	}
 
	CGPathCloseSubpath(path);
 
	return path;
}

@end
