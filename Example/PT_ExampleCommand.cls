public class PT_ExampleCommand implements PT_ICommand {

    // Use anonymous apex execution window to schedule:
    // PT_CyclicCodeRunner.run(PT_ExampleCommand.class, 5); <- run every 5min

    public void perform() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://httpbin.org/get');
        req.setMethod('GET');
        HttpResponse res = new Http().send(req);
        insert new CalloutLog__c(
                ServiceEndpoint__c = req.getEndpoint(),
                RequestBody__c = req.getBody(),
                ResponseBody__c = res.getBody(),
                StatusCode__c = String.valueOf(res.getStatusCode()));
    }
}