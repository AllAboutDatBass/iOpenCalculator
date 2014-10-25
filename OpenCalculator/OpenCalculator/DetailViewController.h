//
//  DetailViewController.h
//  OpenCalculator
//
//  Created by daniel on 10/24/14.
//  Copyright (c) 2014 Daniel Randall Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

