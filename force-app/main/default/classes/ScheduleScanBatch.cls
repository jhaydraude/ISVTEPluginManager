global class ScheduleScanBatch implements Schedulable{

   global void execute(SchedulableContext sc) {
      BatchProcessScans b = new BatchProcessScans(); 
      Database.executeBatch(b);
   }
}