/**
 * @description       : 
 * @author            : Austin Barthel
 * @group             : Cloud Coach
 * @last modified on  : 12-18-2023
 * @last modified by  : Austin Barthel
**/
public with sharing class CreateOppQuoteController {
    public Id oppId {get;set;}

    public CreateOppQuoteController(ApexPages.StandardController controller){
        this.oppId = controller.getId();
    }

    // public interface RemoteInterface { String getId(); }
    // public class NavigateInterface implements RemoteInterface { 
    //     private String interfaceId; 
    //     public String getId() { return interfaceId; }
    // }

    @RemoteAction
    public static PageReference navigateToOpp(String oppId){
        String url = '/'+oppId+'/view';
        System.debug(url);
        PageReference pg = new PageReference(url);
        pg.setRedirect(true);
        return pg;
    }

    @AuraEnabled(cacheable=true)
    public static List<Subscription_Quote__c> getOppQuotes(Id oppId){
        try {
            return [
                SELECT 
                    Name,
                    Primary_Quote__c,
                    (
                        SELECT
                            Tier__c,
                            ServiceType__c,
                            Quantity__c,
                            Term__c,
                            Total__c,
                            UserType__c,
                            Name,
                            QuoteLineType__c,
                            CurrencyIsoCode
                        FROM Subscription_Quote_Line_Items__r
                    )
                FROM Subscription_Quote__c
                WHERE Opportunity__c = :oppId
                ORDER BY Primary_Quote__c DESC
            ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}
