//
//  ItemDetailViewController.m
//  Letao
//
//  Created by Callon Tom on 13-2-6.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "SlideImageView.h"
#import "UIImageUtil.h"

#define kImageBaseUrl  @"http://www.durex.com.cn"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithItem:(Item*)item
{
    self = [super init];
    if (self) {
        self.item = item;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"详情";
    
    [self addSlideImageView];
    
    [self addDetailView];
        
    NSLog(@"%f",_totalHeight);
    
    [_dataScrollView setContentSize:CGSizeMake(self.view.frame.size.width, _totalHeight)];
    
}

- (void)addDetailView
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, _totalHeight, 310, 30)];
    titleLabel.backgroundColor = [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text =  [NSString stringWithFormat:(@" %@"),_item.title];
    [self.dataScrollView addSubview:titleLabel];
    _totalHeight += titleLabel.frame.size.height;
    [titleLabel release];
    
    NSString *subtitle = _item.subtitle;
    if ([subtitle length] > 0) {
        UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _totalHeight, 300, 30)];
        subtitleLabel.backgroundColor = [UIColor clearColor];
        subtitleLabel.font = [UIFont systemFontOfSize:14];
        subtitleLabel.text =  subtitle;
        [self.dataScrollView addSubview:subtitleLabel];
        _totalHeight += subtitleLabel.frame.size.height;
        [subtitleLabel release];
    }
    
    CGSize withinSize = CGSizeMake(300, CGFLOAT_MAX);
    NSString *description = _item.description;
    CGSize size = [description sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];
     UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _totalHeight, 300, size.height)];
    descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.backgroundColor = [UIColor clearColor];
    descriptionLabel.font = [UIFont systemFontOfSize:14];
    descriptionLabel.text = description;
    [self.dataScrollView addSubview:descriptionLabel];
    _totalHeight += descriptionLabel.frame.size.height;
    [descriptionLabel release];
    
    
    NSString *smooth_index = _item.smooth_index;
    if ([smooth_index length] > 0) {
        UILabel *smooth_indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _totalHeight, 300, 30)];
        smooth_indexLabel.backgroundColor = [UIColor clearColor];
        smooth_indexLabel.font = [UIFont systemFontOfSize:14];
        smooth_indexLabel.text =  smooth_index;
        [self.dataScrollView addSubview:smooth_indexLabel];
        _totalHeight += smooth_indexLabel.frame.size.height;
        [smooth_indexLabel release];

    }
    
    NSString *information = [[_item.information stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] stringByReplacingOccurrencesOfString:@"mm" withString:@"mm\n"];
    size = [information sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];
    UILabel *informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _totalHeight, 300, size.height)];
    informationLabel.lineBreakMode = UILineBreakModeWordWrap;
    informationLabel.numberOfLines = 0;
    informationLabel.backgroundColor = [UIColor clearColor];
    informationLabel.font = [UIFont systemFontOfSize:14];
    informationLabel.text = information;
    [self.dataScrollView addSubview:informationLabel];
    _totalHeight += informationLabel.frame.size.height;
    [informationLabel release];
    
    NSString *tips = _item.tips;
    if ([tips length] > 0) {
        tips = [[_item.tips stringByReplacingOccurrencesOfString:@"：" withString:@"：\n"] stringByReplacingOccurrencesOfString:@"。" withString:@"。\n" ];
        size = [tips sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];
        UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _totalHeight, 300, size.height+10)];
        tipsLabel.lineBreakMode = UILineBreakModeWordWrap;
        tipsLabel.numberOfLines = 0;
        tipsLabel.backgroundColor = [UIColor clearColor];
        tipsLabel.font = [UIFont systemFontOfSize:14];
        tipsLabel.text = tips;
        [self.dataScrollView addSubview:tipsLabel];
        _totalHeight += tipsLabel.frame.size.height;
        [tipsLabel release];
    }    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_item release];
    [_slideImageView release];
    [super dealloc];
}

- (void)addSlideImageView
{
    NSMutableArray *imagePathList = [[NSMutableArray alloc] init];
    for (NSString *image in _item.imageList) {
        if (image.length == 0) {
            break;
        }
        NSString *path = [kImageBaseUrl stringByAppendingString:image];
        [imagePathList addObject:path];
    }
    
    _slideImageView = [[SlideImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    _slideImageView.defaultImage = @"3.png";
    
    [_slideImageView.pageControl setPageIndicatorImageForCurrentPage:[UIImage strectchableImageName:@"point_pic3.png"] forNotCurrentPage:[UIImage strectchableImageName:@"point_pic4.png"]];
    [_slideImageView setImages:imagePathList];
    [_dataScrollView addSubview:_slideImageView];
    _totalHeight = _slideImageView.frame.size.height;

    [imagePathList release];
    [_slideImageView release];
    
}

@end
