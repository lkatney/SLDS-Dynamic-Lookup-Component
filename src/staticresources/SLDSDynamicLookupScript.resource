//setup before functions
var typingTimer;                //timer identifier
var doneTypingInterval = 500;  

/**
 * Method to fire once user stop writing
 */
function keyPressedOnLookup(componentId, objectName, fieldNames, fieldsPattern, photo, objectPluralName, remoteMethod){
    clearTimeout(typingTimer);
    var selector = '#'+componentId;
    if (document.querySelector(selector+" #lookup").value) {
        typingTimer = setTimeout(startSearch(componentId, objectName, fieldNames, fieldsPattern, photo, objectPluralName, remoteMethod), doneTypingInterval);
    }else{
        var searchText = document.querySelector(selector+" #lookup");
        var lstBox = document.querySelector(selector+" #list-box");
        lstBox.style.display = 'none';
    }
}

/**
 * Function to get users from servers to display for Reviewers
 */
function startSearch(componentId, objectName, fieldNames, fieldsPattern, photo, objectPluralName, remoteMethod) {
    var selector = '#'+componentId;
    showLoader(componentId);
    var searchText = document.querySelector(selector+" #lookup");
    Visualforce.remoting.Manager.invokeAction(remoteMethod,
            objectName, fieldNames, fieldsPattern, photo, searchText.value, null,
        function(result, event){
            if (event.status) {
                var lstBox = document.querySelector(selector+" #list-box");
                lstBox.style.display = 'block';
                
                var recordLst = document.querySelector(selector+" #record-list");
                recordLst.innerHTML = '';
                for(var i = 0; i < result.length ; i++){
                    var record = result[i];
                    recordLst.appendChild(createRecordLi(componentId,record));
                }
                document.querySelector(selector+" #search-text-info").innerHTML = searchText.value + ' in '+objectPluralName+' - '+ result.length + ' results found'; 
            } else if (event.type === 'exception') {
                    console.log(event.message);
                    console.log(event.where);
            } else {
                 console.log(event.message);
            }
            hideLoader(componentId);
        }, 
        {escape: true}
    );
}

/**
 * Create li for every record to display
 * @param  user
 * @return li
 */
function createRecordLi(componentId,record){
    var id = record.recordId;
    var displayName = record.displayValue;
    var photoUrl = record.photoUrl;
    var li = document.createElement("li");
    li.setAttribute("class", "slds-lookup__item");
    li.setAttribute("onclick", "select('"+componentId+"', '"+displayName+"', '"+photoUrl+"', '"+id+"')");
    var inner = '<a id=s02 role=option>';
        if(photoUrl){
            inner += '<img src="'+photoUrl+'" class="slds-icon slds-icon-text-default slds-icon--small"/>';
        }
        inner += displayName;
        inner += '</a>';
    
    li.innerHTML = inner;
    return li;
}

/**
 * Select record from list
 * @param  {[type]} displayName     [description]
 * @param  {[type]} photoUrl [description]
 * @param  {[type]} id       [description]
 * @return {[type]}          [description]
 */
function select(componentId, name,photoUrl,id){
    var selector = '#'+componentId;
    showLoader(componentId);
    document.querySelector(selector+" #selected-name").innerHTML = name;
    if(photoUrl != 'undefined' && photoUrl != '' && photoUrl != null){
        document.querySelector(selector+" #select-image").style.display = 'inline';
        document.querySelector(selector+" #select-image").setAttribute("src", photoUrl);
    }else{
        document.querySelector(selector+" #select-image").style.display = 'none';
    }
    eval(componentId+"setOwnerId('"+id+"')");
}

/**
 * User selected function
 * @return {[type]} [description]
 */
function recordSelected(componentId){
    var selector = '#'+componentId;
    if(document.querySelector(selector+" #selected-record").style.display == 'none'){
        document.querySelector(selector+" #selected-record").style.display = 'block';
        document.querySelector(selector+" #input-text").style.display = 'none';
        document.querySelector(selector+" #lookup").value = '';
        var lstBox = document.querySelector(selector+" #list-box");
        lstBox.style.display = 'none';
    }else{
        document.querySelector(selector+" #input-text").style.display = 'block';
        document.querySelector(selector+" #selected-record").style.display = 'none';
    }
    hideLoader(componentId);
}

/**
 * remove selected record
 * @return {[type]} [description]
 */
function removeRecord(componentId){
    var selector = '#'+componentId;
    eval(componentId+"setOwnerId(null)");
}

function showLoader(componentId){
    var selector = '#'+componentId;
    document.querySelector(selector+" #loader").style.display = 'block';
}

function hideLoader(componentId){
    var selector = '#'+componentId;
    document.querySelector(selector+" #loader").style.display = 'none';
}