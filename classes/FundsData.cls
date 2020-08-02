public class FundsData {
    
    private static string cKey = 'db8606e1-73b8-49f3-94ae-c47a87602b0e';
    private static string cSecret = '44cjQ0YJ008tc106q*BYDb40';
    
    //wrapper to store access token response   
    public class responseWrapper {
        public string id;
        public string access_token;
        public string instance_url;
    }
    
    //method to get access token
    public static string getAccessToken() {             
        string reqBody = 'grant_type=client_credentials&client_id=' + cKey + '&client_secret=' + cSecret;
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse hresp = new HttpResponse();
        req.setBody(reqBody);
        req.setMethod('POST');
        req.setEndpoint('https://login.microsoftonline.com/019a2b10-1d9e-4d71-8ed6-30f39b21def4/oauth2/token');
        hresp = h.send(req);
        responseWrapper wResp = (responseWrapper) JSON.deserialize(hresp.getBody(), responseWrapper.class);
       	return wResp.access_token;    
      }
     
     //get Funds results from API
     @AuraEnabled(cacheable = true)
     public static List<resultWrapper>  getFunds(string fundName) {
         
        string accToken;
        string responseBody;  		
        List<resultWrapper> wResp1 = new List<resultWrapper>();
        List<resultWrapper> final_list = new List<resultWrapper>();
        string fund_name = EncodingUtil.urlEncode(fundName, 'UTF-8'); 
        string endPoint = 'https://staging.synaptic.co.uk/c/pf/funds?name='+fund_name;
        
        accToken = getAccessToken();        
        if (accToken != '') {
            Http h1 = new Http();
            HttpRequest req1 = new HttpRequest();
            HttpResponse hresp1 = new HttpResponse();
            req1.setHeader('Authorization', 'Bearer ' + accToken);
            req1.setHeader('Content-Type', 'application/json');
            req1.setMethod('GET');
            req1.setEndpoint(endPoint);            
            hresp1 = h1.send(req1);
            wResp1 = (List<resultWrapper>) JSON.deserialize(hresp1.getBody(), List<resultWrapper>.class);
            final_list =  trim_list(wResp1, 0, 50);            
        }
        return final_list; 
    }
    
    //method to trim results
    public static List<resultWrapper> trim_list(List<resultWrapper> v_list, integer min, integer max)
	{
        List<resultWrapper> short_list = v_list.clone();
        for (integer i = 0; i < min; i++) short_list.remove(0);
        integer elements = max - min;
        while (short_list.size() > elements) short_list.remove(elements);
        return short_list;
	}
    
    //wrapper for fund results
    public class resultWrapper {
        	@AuraEnabled
        	public string synCode;
            @AuraEnabled
            public string name;
       		@AuraEnabled
            public string promoter;
        	@AuraEnabled
            public decimal unitPrice;
        }
    
    
}