//
//  OFMenuViewController.m
//  OrangeFashion
//
//  Created by Khang on 11/5/13.
//  Copyright (c) 2013 Khang. All rights reserved.
//

#import "OFMenuViewController.h"
#import "OFHomeTableViewCell.h"
#import "OFHelperManager.h"
#import "OFProductsViewController.h"
#import "OFAppDelegate.h"

@interface OFMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView    * tableMenu;
@property (strong, nonatomic) NSMutableArray        * arrMenu;

@end

@implementation OFMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];    
    [self.navigationController setNavigationBarHidden:NO];
    
    [[OFHelperManager sharedInstance] getMenuListOnComplete:^(NSArray *menu) {
        self.arrMenu = [[[menu mutableCopy] objectAtIndex:1] objectForKey:@"session"];
        [self.tableMenu reloadData];
    } orFailure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"Không tải được menu, vui lòng thử lại sau"];
    }];
    
    [self.tableMenu registerNib:[UINib nibWithNibName:@"OFHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"OFHomeTableViewCell"];
    
    self.tableMenu.delegate = self;
    self.tableMenu.dataSource = self;    
}

#pragma mark - UITableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrMenu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"OFHomeTableViewCell";
    OFHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
        cell = (OFHomeTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    [cell configWithData:[self.arrMenu objectAtIndex:indexPath.row]];
    return cell;        
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

#pragma mark - UITableView delegate

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if (![[segue identifier] isEqualToString:@"SegueFromMenuToListProducts"])
        return;
    
    NSInteger selectIndex = [self.tableMenu indexPathForSelectedRow].row;
    NSInteger categoryID = [[[self.arrMenu objectAtIndex:selectIndex] objectForKey:@"id"] integerValue];
    
    OFProductsViewController *productsVC = (OFProductsViewController *)[segue destinationViewController];
    productsVC.category_id = categoryID;
}

@end
