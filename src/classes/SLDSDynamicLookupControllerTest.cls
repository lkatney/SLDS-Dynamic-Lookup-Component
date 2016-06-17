@isTest
private class SLDSDynamicLookupControllerTest {
    
    private static String USERNAME = 'SLDSDemoUser@lkatney.com';
    
	private static testMethod void generateObjectLabelPluralTest() {
	    SLDSDynamicLookupController controller = new SLDSDynamicLookupController();
	    controller.objectName = 'Account';
	    System.assertEquals('Accounts', controller.objectLabelPlural);
	}
	
	private static testMethod void generateUniqueComponentIdTest() {
	    SLDSDynamicLookupController controller = new SLDSDynamicLookupController();
	    controller.Label = 'Set Account';
	    System.assertEquals('setaccount', controller.uniqueComponentId);
	}
    
    private static testmethod void searchTest(){
        setupUser();
        List<SLDSDynamicLookupController.Wrapper> lst = SLDSDynamicLookupController.search('User', 'Username,Name', 'Name(Username)', 'field->smallPhotoUrl', 'SLDS');
        System.assertEquals(1, lst.size());
    }

    private static testMethod void setupUser() {
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User u = new User(  Alias = 'standt', Email=USERNAME, 
                            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', ProfileId = p.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName=USERNAME
                            );
        insert u;
    }
}