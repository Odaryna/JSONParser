//
//  ViewController.m
//  JSONParser
//
//  Created by Admin on 1/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewController.h"
#import "BuildingsParser.h"
#import "Building.h"
#import "BuildingCell.h"
#import "MapViewController.h"
#import "WebLoading.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *showOnTHeMapBtn;
@property (strong, nonatomic) NSMutableArray* selectedBuildings;

@property (nonatomic, strong) NSMutableArray* arrayOfBuildings;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *str = @"http://zavtrakov.eurodir.ru/response.json";
    NSURL *url = [NSURL URLWithString:str];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    NSArray* response = [BuildingsParser parseJSONtoDictionary:data];
    self.arrayOfBuildings = [NSMutableArray new];
    
    for (NSDictionary* dict in response)
    {
        [self.arrayOfBuildings addObject:[[Building alloc]initFromDictionary:dict]];
        
    }
    self.showOnTHeMapBtn.hidden = YES;
    self.selectedBuildings = [NSMutableArray new];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayOfBuildings count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuildingCell *cell = (BuildingCell *)[tableView dequeueReusableCellWithIdentifier:@"Building" forIndexPath:indexPath];
    
    Building *currentBuild = [self.arrayOfBuildings objectAtIndex:indexPath.row];
    
    [WebLoading loadFromURL:[NSURL URLWithString:currentBuild.urlForImage] callback:^(UIImage *image)
    {
        if (image)
        {
            cell.leftImage.image = image;
        }
        else
        {
            NSLog(@"Error occured by loading image!");
        }
    }];
  
    cell.title.text = currentBuild.title;
    cell.descript.text = currentBuild.descriptionOfBuild;
    
    if (!cell.isSelected)
    {
       cell.rightImage.image = [UIImage imageNamed:@"check_ic_grey@2x.png"];
    }
    else
    {
        cell.rightImage.image = [UIImage imageNamed:@"check_ic_green@2x.png"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuildingCell *cell = (BuildingCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell.isSelected)
    {
        cell.rightImage.image = [UIImage imageNamed:@"check_ic_green@2x.png"];
        cell.isSelected = YES;
        self.showOnTHeMapBtn.hidden = NO;
        [self.selectedBuildings addObject:[self.arrayOfBuildings objectAtIndex:indexPath.row]];
        
    }
    else
    {
        cell.rightImage.image = [UIImage imageNamed:@"check_ic_grey@2x.png"];
        cell.isSelected = NO;
        [self.selectedBuildings removeObject:[self.arrayOfBuildings objectAtIndex:indexPath.row]];
    
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showMap"])
    {
        if (self.selectedBuildings)
        {
            MapViewController *controller = (MapViewController *)segue.destinationViewController;
            controller.selectedPins = [self.selectedBuildings copy];
        }
        
    }
}
@end
