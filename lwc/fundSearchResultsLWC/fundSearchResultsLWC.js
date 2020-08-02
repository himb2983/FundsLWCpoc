import { track,wire,LightningElement,api } from 'lwc';
import GetFundList from '@salesforce/apex/FundsData.getFunds';

export default class FundSearchResultsLWC extends LightningElement {
@track columns = [{
        label: 'SynCode',
        fieldName: 'synCode',
        type: 'text'
    },
    {
        label: 'Name',
        fieldName: 'name',
        type: 'text'
    },
    {
        label: 'Promoter',
        fieldName: 'promoter',
        type: 'text'
    },
    {
        label: 'Unit Price',
        fieldName: 'unitPrice',
        type: 'number'
    }
];

@api searchterm;
@track error;
@track fundList ;

@wire(GetFundList,{fundName: '$searchterm'})
wiredfunds({
    error,
    data
}) {
    if (data) {
        this.fundList = data;
        if(data.length==0)
            this.error = 'No results found!';
            else
            this.error = '';
    } else if (error) {
        this.fundList = null;
        this.error = 'Received error - Unknown error';
            if (Array.isArray(error.body)) {
                this.error = 'Received error - '+ error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                this.error = 'Received error - '+error.body.message;
            }
    }
}

}