@isTest
public class SLDSLookupComponentDemoControllerTest {
    public static testmethod void createRecordTest(){
        SLDSLookupComponentDemoController controller = new SLDSLookupComponentDemoController();
        controller.con.Firstname = 'Test';
        controller.con.Lastname = 'SLDS Demo';
        
        Test.startTest();
            controller.createRecord();
        Test.stopTest();
    }
}