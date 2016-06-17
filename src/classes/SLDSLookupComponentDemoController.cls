public class SLDSLookupComponentDemoController {
    
    public contact con{get;set;}
    
    /**
     * Constructor
    **/
    public SLDSLookupComponentDemoController(){
        con = new Contact();
    }
    
    /**
     * Method to create a record
    **/
    public pagereference createRecord(){
        insert con;
        return new pagereference('/'+con.Id);
    }
}