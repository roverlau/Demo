//
//  MapViewController.m
//  Car
//
//  Created by qianfeng on 15/11/7.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface MapViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>

@property (nonatomic,strong) MKMapView *mapView;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) UISegmentedControl *segCtl;
@property (nonatomic,copy) NSArray *infoArr;

@end

@implementation MapViewController

#pragma mark - 初始化
-(MKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 64, KMainScreenWidth, KMainScreenHeight-108)];
        _mapView.delegate = self;
        [self.view addSubview:_mapView];
    }
    return _mapView;
}

-(CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

-(NSArray *)infoArr
{
    if (!_infoArr) {
        _infoArr = @[@"汽车修理店",@"加油站"];
    }
    return  _infoArr;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(22.533367, 113.935404);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    self.mapView.region = region;
}

-(void)initUI
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30,30, 40, 25)];
    [btn setTitle:@"定位" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(myLocationAction) forControlEvents:UIControlEventTouchUpInside];
    btn.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:btn];
    
    _segCtl = [[UISegmentedControl alloc]initWithItems:@[@"汽车修理店",@"加油站"]];
    _segCtl.frame = CGRectMake(120, 30, 160, 30);
    [self.view addSubview:_segCtl];
    [_segCtl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, KMainScreenHeight-35, 20, 30)];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(goBackTo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

-(void)goBackTo
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

//获取用户当前位置
-(void)myLocationAction
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0) {
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    self.mapView.showsUserLocation = YES;
}

#pragma mark - CLLocationManagerDelegate
//定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = locations[0];
    self.mapView.region = MKCoordinateRegionMake(location.coordinate, self.mapView.region.span);
    [self.locationManager stopUpdatingLocation];

}

//定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"定位失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alterView show];
}

//信息查询
-(void)change:(UISegmentedControl *)segCtl
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    
    request.naturalLanguageQuery = self.infoArr[segCtl.selectedSegmentIndex];
    request.region = self.mapView.region;
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        for (MKMapItem *item in response.mapItems) {
           // NSLog(@"%@",item.phoneNumber);
          //  NSLog(@"%@",item.name);
            [self addAnnotation:item];
        }
    }];
    
}

-(void)addAnnotation:(MKMapItem *)item
{
    MyAnnotation *annotation = [MyAnnotation new];
//     NSLog(@"%@",item.phoneNumber);
//      NSLog(@"%@",item.name);
    annotation.title = item.name;
    annotation.subtitle = item.phoneNumber;
    annotation.coordinate = item.placemark.coordinate;
    /**
     *  <#Description#>
     */
    annotation.coordinate = item.placemark.coordinate;
    [self.mapView addAnnotation:annotation];
    /**
     *  <#Description#>
     */
    [self mapView:self.mapView viewForAnnotation:annotation];
}

//添加一个自定义标注就会走此方法一次
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
    if (!annotationView) {
        annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
    }
    annotationView.image = [UIImage imageNamed:[self.segCtl titleForSegmentAtIndex:self.segCtl.selectedSegmentIndex]];
    annotationView.canShowCallout = YES;
    return annotationView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
