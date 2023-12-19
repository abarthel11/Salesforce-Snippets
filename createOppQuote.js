/**
 * @description       : 
 * @author            : Austin Barthel
 * @group             : Cloud Coach
 * @last modified on  : 12-18-2023
 * @last modified by  : Austin Barthel
**/
import { LightningElement, api } from 'lwc';

export default class CreateOppQuote extends LightningElement {
	@api recordId
	@api oppName

	get title(){
		return `Manage Opportunity Quotes for ${this.oppName}`
	}

	navigateToOpp(event){
		event.preventDefault();
		const customEvent = new CustomEvent("navigatetoopp",{
			bubbles: true,
			composed: true
		});
        this.dispatchEvent(customEvent);
	}

}
