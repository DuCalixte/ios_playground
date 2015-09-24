//
//  AppDelegate.m
//  PAFinal
//
//  Created by STANLEY CALIXTE on 3/9/14.
//  Copyright (c) 2014 STANLEY CALIXTE. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate
{
    int y_pos;
    
    // App auther label
    UILabel *appAuthorLabel;
    
    UILabel *timerLabel;
    int timerCount;
    
    UILabel *threadLabel;
    int threadCount;
    
    UITextView *upperTextView;
    NSMutableArray *students;
    NSMutableString *upperViewContent;
    
    UITextView *middleTextView;
    NSMutableString *middleViewContent;
    float temperature_celcius;
    bool foundTemperature;
    
    CLLocationManager *locationManager;
    CLLocation *location;
    
    UITextField *urlInputTextField;
    
    UITextView *lowerTextView;
    NSMutableData *urlDataContent;
    NSMutableString *lowerViewContent;
    
    __block int colorCount;
    NSArray *colorScheme;
    
}

#pragma mark Core Location Manager Delegate

-(void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray *)locations
{
    //NOTE: Assume only a single location
    location = locations[0];
    NSLog(@"%f-%f", location.coordinate.latitude, location.coordinate.longitude);
}

#pragma mark UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    lowerViewContent = [[NSMutableString alloc] init];
    urlDataContent = [[NSMutableData alloc]init];
    
    [self updateDisplay:__PRETTY_FUNCTION__];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self updateDisplay:__PRETTY_FUNCTION__];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self updateDisplay:__PRETTY_FUNCTION__];
    if (location != nil)
        [lowerViewContent appendFormat:@"\n-\tlatitude: %f\n-\tlongitude: %f\n\n", location.coordinate.latitude, location.coordinate.longitude];
    [self establishConnection:urlInputTextField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self updateDisplay:__PRETTY_FUNCTION__];
    [urlInputTextField resignFirstResponder];
    return YES;
}

#pragma mark Starting Parsing XML Delegate

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    temperature_celcius = 0.00;
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"temperature: %f", temperature_celcius);
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [middleViewContent appendFormat:@"Parsed (Celcius) XML data output: %f\n", temperature_celcius];
}
-(void)parser:(NSXMLParser *)parser
parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSString *error = [NSString stringWithFormat:@"error: %@", [parseError localizedDescription]];
    NSLog(@"%@",error);
    [middleViewContent appendFormat:@"\n%@", error];
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"element: %@", elementName);
    if ([elementName isEqualToString:@"double"]) {
        foundTemperature = YES;
    }
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"%@", string);
    if (foundTemperature) {
        NSNumber *n =
        [NSNumber numberWithFloat:[string floatValue]];
        temperature_celcius = [n floatValue];
        foundTemperature = NO;
    }
}


#pragma mark  Starting NSURL Connection Delegate

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [lowerViewContent appendString:[error localizedDescription]];
    
    [self updateUITextView];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)dataReceived
{
    [urlDataContent appendData:dataReceived];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *siteData = [[NSString alloc]initWithData:urlDataContent encoding:NSUTF8StringEncoding];
    [lowerViewContent appendString:siteData];
    
    [self updateUITextView];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = viewController;
    self.window.backgroundColor = [UIColor whiteColor];
    
    y_pos = 0;
    [self setupAppAuthorLabel];
    [self initializeCounters];

    [self setupUpperTextViewAndContents];
    [self initializeStudents];
    
    [self setupMiddleTextViewAndContents];
    [self initializeJSonParsing];

    [self initializeCoreLocationManager];
    [self setupTextFieldForInsertion];
    
    [self setupLowerTextViewAndContents];
    
    [self initiateColorSchemeOnLowerTextView];
    [self.window makeKeyAndVisible];
    
    
    NSRunLoop *runLoop = [NSRunLoop mainRunLoop];
    NSLog(@"runLoop: %@", runLoop);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/* Start of Initialization Methods */

- (void) setupAppAuthorLabel
{
    upperViewContent = [[NSMutableString alloc] init];
    urlDataContent = [[NSMutableData alloc] init];
    
    CGRect rect = self.window.bounds;
    y_pos += 20;
    rect.origin.y = y_pos;
    rect.size.height = 25;
    y_pos += rect.size.height;
    
    NSString *labelContent = @"Stanley Calixte";
    UIColor * foreColor = [UIColor whiteColor];
    UIColor * backColor = [UIColor lightGrayColor];
    UIFont *labelFont = [UIFont fontWithName:@"Helvetica" size:16.0f];
    
    appAuthorLabel = [[UILabel alloc] initWithFrame:rect];
    appAuthorLabel.font = labelFont;
    appAuthorLabel.backgroundColor = backColor;
    appAuthorLabel.textColor = foreColor;
    appAuthorLabel.textAlignment = NSTextAlignmentCenter;
    appAuthorLabel.text = labelContent;
    
    [self.window.rootViewController.view addSubview:appAuthorLabel];
}

- (void) initializeCounters
{
    CGRect rect = self.window.bounds;
    rect.origin.y = y_pos;
    rect.size.height = 20;
    y_pos += rect.size.height;
    
    CGFloat w = rect.size.width/2-2;
    CGRect r1 = rect;
    r1.size.width = w;
    
    
    CGRect r2 = rect;
    r2.size.width = w;
    r2.origin.x = w+4;
    
    
    UIColor * foreColor_one = [UIColor redColor];
    UIColor * foreColor_two = [UIColor greenColor];
    
    UIColor * backColor = [UIColor blackColor];
    UIFont *labelFont = [UIFont fontWithName:@"Helvetica" size:12.0f];
    
    timerLabel = [[UILabel alloc] initWithFrame:r1];
    timerLabel.font = labelFont;
    timerLabel.backgroundColor = backColor;
    timerLabel.textColor = foreColor_one;
    timerLabel.textAlignment = NSTextAlignmentLeft;
    
    timerLabel.text = @"\tCount= 0";
    
    threadLabel = [[UILabel alloc] initWithFrame:r2];
    threadLabel.font = labelFont;
    threadLabel.backgroundColor = backColor;
    threadLabel.textColor = foreColor_two;
    threadLabel.textAlignment = NSTextAlignmentLeft;
    
    threadLabel.text = @"\tCount= 0";
    
    [self.window.rootViewController.view addSubview:timerLabel];
    [self.window.rootViewController.view addSubview:threadLabel];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doTimer:) userInfo:nil repeats:YES];
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(doThread:) object:nil];
    [thread start];
}

- (void) setupUpperTextViewAndContents
{
    lowerViewContent = [[NSMutableString alloc] init];
    
    CGRect rect = self.window.bounds;
    rect.origin.y = y_pos;
    rect.size.height = 150;
    y_pos += rect.size.height;
    
    UIColor * foreColor = [UIColor blackColor];
    UIColor * backColor = [UIColor colorWithRed:103.2269 green:89.8846 blue:80.6731 alpha:0.75];
    
    UIFont *labelFont = [UIFont fontWithName:@"Courier" size:12.0f];
    
    upperTextView = [[UITextView alloc] initWithFrame:rect];
    upperTextView.font = labelFont;
    upperTextView.backgroundColor = backColor;
    upperTextView.textColor = foreColor;
    upperTextView.editable = NO;
    
    [self.window.rootViewController.view addSubview:upperTextView];
}

- (void) initializeStudents
{
    [upperViewContent appendString:@"Inserting and processing new students\n"];
    
    ExtendedStudentBand *e1 = [[ExtendedStudentBand alloc] initWithName:@"john Dow" andNumber:123];
    ExtendedStudentBand *e2 = [[ExtendedStudentBand alloc] initWithName:@"Billy Joe" andNumber:657 andDate:[[NSDate alloc]initWithTimeIntervalSinceNow:0]];
    
    Student *s1 = e1;
    StudentBand *b1 = e1;
    
    e1.instrument = @"Saxophone";
    e2.instrument = @"Trumpet";
    
    Student *s2 = e2;
    StudentBand *b2 = e2;
    
    
    NSLog(@"%@",[s1 description]);
    NSLog(@"%@",[s2 description]);
    NSLog(@"%@",s2);
    
    NSLog(@"%@",[b1 description]);
    NSLog(@"%@",[b2 description]);
    NSLog(@"%@",b1);
    
    
    e1.city = @"San Diego";
    e1.state = @"CA";
    e1.country = @"United States";
    
    e2.city = @"Miami";
    e2.state = @"FL";
    e2.country = @"United States";
    
    students = [[NSMutableArray alloc] initWithObjects:e1, e2, nil];
    NSLog(@"%@",students);
    
    [students insertObject:[[ExtendedStudentBand alloc] initWithName:@"Sally Smith" andNumber:456 andInstrument:@"Oboe" andCity:@"Madrid" andCountry:@"Spain"] atIndex:1];
    NSLog(@"%@",students);

    
    [students addObject:[ExtendedStudentBand extendedStudentBandWithName:@"Abey Brown" andNumber:890 andInstrument:@"Tuba" andDate:[NSDate date] andCity:@"New York" andState:@"NY" andCountry:@"United States"]];
    NSLog(@"%@",students);

    
    [upperViewContent appendString:[NSString stringWithFormat:@"\n%lu students were processed.\n", (unsigned long)students.count]];
    NSLog(@"%@",students);

    
    for (ExtendedStudentBand *student in students) {
        [upperViewContent appendString:[student description]];
    }
    
    [upperViewContent appendString:@"\n\nShowing File I/O and KeyedArchive\n"];
    
    [upperViewContent appendFormat:@"*\thomeDir: %@\n\n", NSHomeDirectory()];
    [upperViewContent appendFormat:@"*\ttmpDir: %@\n\n", NSTemporaryDirectory()];
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent: @"Documents/myfile"];
    
    [NSKeyedArchiver archiveRootObject:students toFile:path];
    
    NSArray *studentsIn = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    for (Student *student in studentsIn) {
        NSLog(@"%@-%i", student.fullname, student.number);
        [upperViewContent appendString:[student description]];
    }
    
    Student *one = [Student studentWithName:@"Marie Sally" andNumber:345];
    StudentAdvisor *sa = [[StudentAdvisor alloc] init];
    
    sa.delegate = one;
    [sa simulateWorkDone];
    
    [upperViewContent appendString:@"\n\n"];
    upperTextView.text = upperViewContent;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *op = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(initiateCountryInfoAccess:) object:students[0]];
    [queue addOperation:op];

}

- (void) setupMiddleTextViewAndContents
{
    
    CGRect rect = self.window.bounds;
    rect.origin.y = y_pos;
    rect.size.height = 100;
    
    y_pos += rect.size.height;
    
    UIColor * foreColor = [UIColor blackColor];
    UIColor *backColor = [UIColor orangeColor];
    UIFont *labelFont = [UIFont fontWithName:@"Courier" size:12.0f];
    
    middleTextView = [[UITextView alloc] initWithFrame:rect];
    middleTextView.font = labelFont;
    middleTextView.backgroundColor = backColor;
    middleTextView.textColor = foreColor;
    middleTextView.editable = NO;
    
    [self.window.rootViewController.view addSubview:middleTextView];
}

-(void) setupTextFieldForInsertion
{
    CGRect rect = self.window.bounds;
    rect.origin.y = y_pos;
    rect.size.height = 25;
    
    y_pos += rect.size.height;
    
    UIColor * foreColor = [UIColor blackColor];
    UIColor *backColor = [UIColor cyanColor];
    UIFont *labelFont = [UIFont fontWithName:@"Arial" size:14.0f];
    
    urlInputTextField = [[UITextField alloc] initWithFrame:rect];
    urlInputTextField.backgroundColor = backColor;
    urlInputTextField.font = labelFont;
    urlInputTextField.textColor = foreColor;
    urlInputTextField.placeholder = @"Insert a url to show its source code content below";
    urlInputTextField.keyboardType = UIKeyboardTypeURL;
    urlInputTextField.delegate = self;
    
    [self.window.rootViewController.view addSubview:urlInputTextField];
}

- (void) setupLowerTextViewAndContents
{
    
    CGRect rect = self.window.bounds;
    rect.origin.y = y_pos;
    CGFloat height = rect.size.height;
    rect.size.height = height - y_pos;
    
    y_pos += rect.size.height;
    
    UIColor * foreColor = [UIColor blackColor];
    UIColor *backColor = [UIColor lightGrayColor];
    UIFont *labelFont = [UIFont fontWithName:@"Courier" size:12.0f];
    
    lowerTextView = [[UITextView alloc] initWithFrame:rect];
    lowerTextView.font = labelFont;
    lowerTextView.backgroundColor = backColor;
    lowerTextView.textColor = foreColor;
    lowerTextView.editable = NO;
    
    lowerViewContent = [[NSMutableString alloc] init];
    urlDataContent = [[NSMutableData alloc]init];
    
    [self.window.rootViewController.view addSubview:lowerTextView];
}

-(void) initiateColorSchemeOnLowerTextView
{
    colorScheme = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor purpleColor], [UIColor yellowColor], nil];
    dispatch_queue_t gcd_queue;
    gcd_queue = dispatch_queue_create("com.demo.myqueue", 0);
    dispatch_async(gcd_queue, ^{
        while (YES) {
            NSLog(@"Executing on separate thread, other than the main thread");
            NSLog(@"Changing the color background of the lower UITextView every 5 seconds or so.");
            dispatch_queue_t mainqueue = dispatch_get_main_queue();
            dispatch_async(mainqueue, ^{ lowerTextView.backgroundColor = colorScheme[colorCount++ % [colorScheme count]];  });
            sleep(5);
        }
    });
}

-(void) initializeCoreLocationManager
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.delegate = self;

    [locationManager startUpdatingLocation];
}

/* End of Initialization Methods */

- (void) initiateCountryInfoAccess:(id) object
{
    ExtendedStudentBand *student = (ExtendedStudentBand *) object;
    NSString *city = [student.city stringByReplacingOccurrencesOfString: @" " withString:@"%20"];
    NSString *country = [student.country stringByReplacingOccurrencesOfString: @" " withString:@"%20"];
    
    [upperViewContent appendFormat:@"\nWeather information about city: %@ and country: %@.\n\n", student.city, student.country];
    NSString *siteUrl = [NSString stringWithFormat:@"http://www.webservicex.net/globalweather.asmx/GetWeather?CityName=%@&CountryName=%@", city, country];
    
    NSLog(@"%@",siteUrl);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self performSelectorInBackground:@selector(doWebService:) withObject:siteUrl];
}

- (void) doWebService:(id)object
{
    NSString *urlString = object;
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSError *error = nil;
    NSString *xmlString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
    {
        xmlString = [error localizedDescription];
        NSLog(@"%@",xmlString);
    }
    else{
    [self performSelectorOnMainThread:@selector(updateGuid:) withObject:xmlString waitUntilDone:NO];
    }
}

- (void) updateGuid:(id)object
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *xmlString = object;
    [upperViewContent appendString: xmlString];
    self->upperTextView.text = upperViewContent;
}

-(void)doThread:(id)object
{
    @autoreleasepool {
        while (YES) {
            threadCount++;
            threadLabel.tag = threadCount;
            [self performSelectorOnMainThread:@selector(updateLabel:) withObject:threadLabel waitUntilDone:YES];
        }
    }
}

-(void)updateLabel:(UILabel *)label
{
    label.text =
    [NSString stringWithFormat:@"\tCount= %li",
     (long)label.tag];
}


-(void)doTimer:(NSTimer *)timer
{
    timerCount++;
    timerLabel.text = [NSString stringWithFormat:@"\tCount= %i",
                       timerCount];
}

- (void) initializeJSonParsing
{
    foundTemperature = NO;
    middleViewContent = [[NSMutableString alloc] init];
    
    [middleViewContent appendString:@"Parsing JSON data from a file with a temperature value in Fahrenheit.\n"];
    
    float result = 0;
    
    // JSON Parsing
    NSURL *url = [[NSBundle mainBundle]
           URLForResource:@"temperature" withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSError *myError = nil;
    NSDictionary *jsonDictionary =
    [NSJSONSerialization JSONObjectWithData:data
                                    options:0 error:&myError];
    if (myError) {
        NSLog(@"json Error: %@", [myError localizedDescription]);
    }
    else {
        NSLog(@"%@", jsonDictionary);
        NSLog(@"temperature: %@", jsonDictionary[@"double"]);
        NSNumber *n = jsonDictionary[@"double"];
        result = [n floatValue];
        NSLog(@"temperature: %f", result);
    }
    
    [middleViewContent appendFormat:@"Parsed (Fahrenheit) JSON data input: %f\n", result];
    
     NSString *siteUrl = [NSString stringWithFormat:@"http://www.webservicex.net/ConvertTemperature.asmx/ConvertTemp?Temperature=%f&FromUnit=degreeFahrenheit&ToUnit=degreeCelsius", result];
    
    NSLog(@"%@",siteUrl);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self performSelectorInBackground:@selector(doWebServiceTemperature:) withObject:siteUrl];
    
}

- (void) doWebServiceTemperature:(id)object
{
    NSString *urlString = object;
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSError *error = nil;
    NSString *xmlString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
    {
        xmlString = [error localizedDescription];
        NSLog(@"%@",xmlString);
        [middleViewContent appendFormat:@"\n%@",xmlString];
    }
    
    NSData *xmlData = [xmlString dataUsingEncoding:NSASCIIStringEncoding];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    
    [parser setDelegate:self];
    [parser parse];
    
    [self performSelectorOnMainThread:@selector(updateTemperatureOnScreen:) withObject:xmlString waitUntilDone:NO];
}

- (void) updateTemperatureOnScreen:(id)object
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    self->middleTextView.text = middleViewContent;
}

-(void)updateDisplay:(const char *)msg
{
    [lowerViewContent appendFormat:@"%s\n", msg];
    lowerTextView.text = lowerViewContent;
}

- (void) updateUITextView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    lowerTextView.text = lowerViewContent;
}

-(void) establishConnection:(id) object
{
    [lowerViewContent appendString:@"Starting access...\n\n"];
    NSString *urlString = object;
    
    NSURL *myURL = [NSURL URLWithString:urlString];
    
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:myURL];
    
    [NSURLConnection connectionWithRequest:myRequest delegate:self];
}

@end


