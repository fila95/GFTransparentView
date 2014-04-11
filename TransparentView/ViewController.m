//
//  ViewController.m
//  UIToolbarBlurTry
//
//  Created by Giovanni Filaferro on 08/04/14.
//  Copyright (c) 2014 Giovanni Filaferro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UILabel *toolbarLabel;
}

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [image setContentMode:UIViewContentModeScaleAspectFill];
        [image setImage:[UIImage imageNamed:@"artwork.png"]];
        [self.view addSubview:image];
        
        FXBlurView *toolbar = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [toolbar setTintColor:[UIColor clearColor]];
        [toolbar setBlurEnabled:YES];
        [toolbar setBlurRadius:30.0f];
        
        [self.view addSubview:toolbar];
        
        GFMaskView *darkView = [[GFMaskView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [darkView setBackgroundColor:[UIColor blackColor]];
        [darkView setAlpha:0.6f];
        [toolbar addSubview:darkView];
        
        toolbarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 100)];
        //[toolbarLabel setBackgroundColor:[UIColor whiteColor]];
        [toolbarLabel setTextColor:[UIColor whiteColor]];
        [toolbarLabel setText:@"Prova Label"];
        [toolbarLabel setTextAlignment:NSTextAlignmentCenter];
        [toolbarLabel setFont:[UIFont boldSystemFontOfSize:28]];
        [darkView addSubview:toolbarLabel];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, toolbarLabel.frame.size.height+toolbarLabel.frame.origin.y, darkView.frame.size.width-40, darkView.frame.size.width-40)];
        [imageView setImage:[UIImage imageNamed:@"artwork.png"]];
        [toolbar addSubview:imageView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, imageView.frame.size.height+imageView.frame.origin.y+20, darkView.frame.size.width, 40)];
        [button addTarget:self action:@selector(changeText) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"Cambia" forState:UIControlStateNormal];
        [darkView addSubview:button];
        
    }
    return self;
}

- (void)changeText {
    [toolbarLabel setText:@"Funziona!"];
}
- (void)selected:(id)sender {
    NSLog(@"selected");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
