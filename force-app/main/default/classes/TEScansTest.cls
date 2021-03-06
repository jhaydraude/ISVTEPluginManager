@isTest
private class TEScansTest {
    
    @testSetup
    static void setupTestData() {
        Account a = new Account(Name='Test Account');
        insert a;
        Application__c app = new Application__c();
        app.Account__c = a.id;
        app.Name = 'Test App';
        insert app;
        
        Scan__c s = new Scan__c();
        s.Application__c = app.id;
        s.Scan_Date__c = System.now();
        
        insert s;
        
        ContentVersion cv = new ContentVersion();
        cv.Title='TestScan';
        cv.PathOnClient='Test.json';
        cv.VersionData= Blob.valueof('[{"path":"./metadataPackage_1589470282990","date":"Thu 14 May 2020 11:31:25 EDT","result":""}]');
        insert cv;
        
        List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        
        ContentDocumentLink contentlink=new ContentDocumentLink();
        contentlink.LinkedEntityId=s.id;  
        contentlink.ShareType= 'I';               
        contentlink.ContentDocumentId=documents[0].Id;
        contentlink.Visibility = 'AllUsers'; 
        insert contentlink;
        
    }
    
    @isTest
    static void testScan() {
        List<Scan__c> s = [select id from Scan__c];
        List<id> i = new List<id>();
        i.add(s[0].id);
        PluginScanCtl.processResults(i);
    }
}