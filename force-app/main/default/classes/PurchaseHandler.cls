public class PurchaseHandler {
    @AuraEnabled
    public static id insertacc(string apexname, string apexmaterial, list<Purchase_Product__c>products){
        
        Purches__c a=new Purches__c();
        a.Supplier__c=apexname;
        a.Materials__c=apexmaterial;
        insert a;
        system.debug('Purches insert'+a);
        
        
        for (Purchase_Product__c product : products) {
            system.debug(products);
            product.Purchase__c = a.Id;
            product.Purchase_Date__c = Date.valueOf(product.Purchase_Date__c);
        }
        insert products;
        system.debug(products);
        return a.id;
        
    }
    
}