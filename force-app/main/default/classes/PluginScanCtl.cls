public class PluginScanCtl {
   @InvocableMethod
   public static void processResults(List<id> scanIds) {
      List<Scan__c> scans = [Select Id, Dependencies__c, Application__c from Scan__c where id in :scanIds];
      
       doProcess(scans);
   }
    
    public static void doProcess(List<Scan__c> Scans) {
        Map<id,String> scanContents = new Map<id,String>();
        for (Scan__c s: Scans) {
            s.Dependencies__c = Util.ExtractDependencies(getScanContent(s.id));
        }
        update Scans;
    }
    
    private static String getScanContent(id scanId) {
        ContentDocumentLink cd = [select ContentDocument.LatestPublishedVersion.VersionData from contentDocumentLink where linkedEntityID =:scanId];
		return (cd.ContentDocument.LatestPublishedVersion.VersionData.toString());
    }
}