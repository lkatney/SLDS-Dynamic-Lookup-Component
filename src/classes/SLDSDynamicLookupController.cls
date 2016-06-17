public class SLDSDynamicLookupController {
    /*
    * public variables
    **/
    public String objectName{get;
        set{
            if(objectName != value){
                objectName = value;
                objectLabelPlural = Schema.getGlobalDescribe().get(ObjectName).getDescribe(). getLabelPlural();
            }
        }
        
    }
    
    public String label{
        get;
        set{
            label = value;
            uniqueComponentId = label.replace(' ', '').toLowerCase();
        }
    }
    
    public String uniqueComponentId{get;set;}
    public String objectLabelPlural{get;set;}
    
    /**
	 * Remote action method to send list of records
	 * @param  searchText 
	 * @return  List<Wrapper>
	 */
	@RemoteAction
	public static List<Wrapper> search(String objectName, String displayFieldNames, String fieldsPattern, String photoValue,String searchText) {
	    String query;
        List<String> displayFieldNamesLst;
        String photoFieldName;
	    List<Wrapper> results = new List<Wrapper>();
	    String finalQuery;
	    String photoToDisplay;
	    
        if(String.isBlank(fieldsPattern)){
            fieldsPattern = displayFieldNames;
        }
        
        //prepare a where clause
        displayFieldNamesLst = displayFieldNames.split(',');
        String whereClause = '';
        for(String fieldName : displayFieldNamesLst){
            whereClause += String.isBlank(whereClause) ? ' WHERE ' + fieldName + ' LIKE \'%{text}%\'' : ' OR ' + fieldName + ' LIKE \'%{text}%\'';
        }
        //add Id field to field names if necessary
        if(!displayFieldNames.toLowerCase().contains('id')){
            displayFieldNames += ', Id';
        }
        
        //add photo field if not added
        if(photoValue.toLowerCase().contains('field')){
            List<String> photoValueLst = photoValue.split('->');
            if(photoValueLst.size() > 1 && !displayFieldNames.toLowerCase().contains(photoValueLst[1].toLowerCase())){
                photoFieldName = photoValueLst[1];
                displayFieldNames += ', '+photoValueLst[1];
            }
        }else if(photoValue.toLowerCase().contains('url')){
            List<String> photoValueLst = photoValue.split('->');
            if(photoValueLst.size() > 1){
                photoToDisplay = photoValueLst[1];
            }
        }
        
        query = 'SELECT ' + displayFieldNames + ' FROM ' + objectName + whereClause;
        finalQuery = query.replace('{text}', searchText);
	    
	    for(Sobject sobj : database.query(finalQuery)){
	        String displayValue = fieldsPattern;
	        for(String fieldName : displayFieldNamesLst){
	            String fieldValue = sobj.get(fieldName) == null ? '' : String.valueOf(sobj.get(fieldName));
	            displayValue = displayValue.replace(fieldName, fieldValue);
	            if(String.isNotBlank(photoFieldName) && sobj.get(photoFieldName) != null){
	                photoToDisplay = String.valueOf(sobj.get(photoFieldName));
	            }
	        }
	        results.add(new Wrapper(String.valueOf(sobj.get('Id')), displayValue, photoToDisplay));
	    }
	    return results;
	}
	
	
	/*************************************************************************
	 ******************************* WRAPPER **************************************
	 ****************************************************************************/
	public class Wrapper{
	    public Id recordId{get;set;}
	    public String displayValue{get;set;}
	    public String photoUrl{get;set;}
	    public Wrapper(Id recordId, String displayValue, String photoUrl){
	        this.recordId = recordId;
	        this.displayValue = displayValue;
	        this.photoUrl = photoUrl;
	    }
	}
}