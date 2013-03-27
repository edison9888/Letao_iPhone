//
//  SearchViewController.h
//  Letao
//
//  Created by Kaibin on 13-3-26.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBlankView.h"
#import <RestKit/RestKit.h>

@interface SearchViewController : UIViewController<RKObjectLoaderDelegate>

@property (retain, nonatomic) IBOutlet UIImageView *searchTextFieldBackgroundView;
@property (retain, nonatomic) IBOutlet UIButton *searchButton;
@property (retain, nonatomic) IBOutlet UITextField *searchTextField;
@property (retain, nonatomic) UIView *wordsView;
@property (nonatomic, retain) UIBlankView *blankView;

- (IBAction) clickSearchButton:(id)sender;

@end
