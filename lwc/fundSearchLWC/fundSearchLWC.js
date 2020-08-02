import {track,wire,LightningElement,api } from 'lwc';

export default class FundSearchLWC extends LightningElement {
    @api searchfund;
    @track showResult;
    
    handleSearch(){
        this.showResult = true;   
        var temp = this.template.querySelector('lightning-input');
        if(temp.name === 'fundname')
            this.searchfund = temp.value;          
    }
}