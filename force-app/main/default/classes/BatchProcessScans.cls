global class BatchProcessScans implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        // Collect the batches of records or objects to be passed to execute
        String query = 'Select Id, Dependencies__c, Application__c from Scan__c';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Scan__c> scans) {
        // Process scans from the ISVTE plugin
        PluginScanCtl.doProcess(scans);
    }   
    
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations like sending email
    }
}