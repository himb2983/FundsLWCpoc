//Mock class for FundsData_Test class
@isTest
global class MockFundsAPI implements HttpCalloutMock {
   
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        // Create a fake response for Fund search results
        if(req.getEndpoint().contains('https://staging.synaptic.co.uk')){
            res.setHeader('Content-Type', 'application/json');
            res.setBody('[{"synCode": "00HZ","citiCode": "00HZ","isin": "GB00B68MR202","name": "(ex Insight DTR) Blackrock Diversified Dynamic Growth (ARC) Pn",'+
                        '"promoter": "Aegon/Scottish Equitable","localSector": "ABI Specialist","globalSector": "Mixed Asset - Flexible",'+
                        '"unitPrice": 125.4217,"factSheet": "https://ingress.synaptic.co.uk/funds/00HZ/factsheet"}]');
            res.setStatusCode(200);            
        }
        // Create a fake response for Access token
        if(req.getEndpoint().contains('https://login.microsoftonline.com')){
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"token_type":"Bearer","expires_in":"3599","ext_expires_in":"3599","expires_on":"1596369288","not_before":"1596365388","resource":"00000002-0000-0000-c000-000000000000","access_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Im"}');
            res.setStatusCode(200);
        }
        
        return res;
    }
}
