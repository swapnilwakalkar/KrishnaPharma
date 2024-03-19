@isTest
public class PurchaseHandlerTest {
    
    @isTest
    static void testInsertacc() {
        // Create a test Supplier record
        Account testSupplier = new Account(Name = 'Test Supplier',RecordTypeId =System.Label.PurchaseRecordTypeId);
        Product2 testPro = new Product2(Name ='Test Product');
       
        insert testSupplier;
        insert testPro;
        
        
        // Use the ID of the test Supplier
        String supplierId = testSupplier.Id;
        String productId = testPro.Id;
        
        // Create test data
        String apexmaterial = 'Raw Material';
        
        // Create a Purchase_Product__c record (replace with actual field values)
        Purchase_Product__c testProduct = new Purchase_Product__c(Product__c=productId);
        
        // Set testProduct field values here
        
        
        List<Purchase_Product__c> productList = new List<Purchase_Product__c>();
        productList.add(testProduct);
        
        
        // Start test
        Test.startTest();
        
        // Call the method you want to test
        Id purchaseId = PurchaseHandler.insertacc(supplierId, apexmaterial, productList);
        
        // Query the Purches__c and related Purchase_Product__c records to verify the insert
        
        List<Purches__c> insertedProducts = [SELECT Id,Name, Supplier__c, Materials__c ,(SELECT Id,Name, Purchase__c, Product__c FROM Purchase_Products__r) FROM Purches__c WHERE Id = :purchaseId];
        
        // Assertions to verify that the records were inserted correctly
        System.assertEquals(1, insertedProducts.size(), 'One Purchase_Product__c record should be inserted');
        System.assertEquals(supplierId, insertedProducts[0].Supplier__c, 'Supplier Id should match');
        System.assertEquals(apexmaterial,insertedProducts[0].Materials__c, 'Material name should match');
        
        // End test
        Test.stopTest();
    }
}

/*@isTest
public class PurchaseHandlerTest {

@isTest
static void testInsertacc() {
// Create a test Supplier record
Account testSupplier = new Account(Name = 'Test Supplier',RecordTypeId ='0121m000001VmboAAC');
insert testSupplier;

// Use the ID of the test Supplier
String supplierId = testSupplier.Id;

// Create test data
String apexmaterial = 'Raw Material';




// Create a Purchase_Product__c record (replace with actual field values)
Purchase_Product__c testProduct = new Purchase_Product__c();

// Set testProduct field values here


List<Purchase_Product__c> productList = new List<Purchase_Product__c>();
productList.add(testProduct);


// Start test
Test.startTest();

// Call the method you want to test
Id purchaseId = PurchaseHandler.insertacc(supplierId, apexmaterial, productList);

// Query the Purches__c and related Purchase_Product__c records to verify the insert

List<Purches__c> insertedProducts = [SELECT Id, Supplier__c, Materials__c ,(SELECT Id, Purchase__c, Product__c FROM Purchase_Products__r) FROM Purches__c WHERE Id = :purchaseId];

// Assertions to verify that the records were inserted correctly
System.assertEquals(1, insertedProducts.size(), 'One Purchase_Product__c record should be inserted');
System.assertEquals(supplierId, insertedProducts[0].Supplier__c, 'Supplier Id should match');
System.assertEquals(apexmaterial,insertedProducts[0].Materials__c, 'Material name should match');

// End test
Test.stopTest();

}


}*/