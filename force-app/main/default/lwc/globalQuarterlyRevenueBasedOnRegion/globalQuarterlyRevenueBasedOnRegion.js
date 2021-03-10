import { LightningElement, track, wire } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity';
import TERRITORY_FIELD from '@salesforce/schema/Account.Territory__c';
import STAGE_BUCKET_FIELD from '@salesforce/schema/Opportunity.Stage_Bucket__c';
import prepareWrapperData from '@salesforce/apex/globalQuarterlyRevenueBasesOnRegionCtrl.prepareWrapperData';
import getOptyOwnerManagerData from '@salesforce/apex/globalQuarterlyRevenueBasesOnRegionCtrl.getOptyOwnerManagerData';


export default class GlobalQuarteryRevenueBasedOnRegion extends LightningElement {

    @track detailcolumns = [

        {
            label: 'User Name', fieldName: 'userUrl', type: 'url', wrapText: true, initialWidth: 150,

            typeAttributes: {
                label: {
                    fieldName: 'userName'
                },
                target: '_blank'
            }
        },
        { label: 'Probability', fieldName: 'probability', type: 'percent', initialWidth: 120 },
        {
            label: 'Account', fieldName: 'accountUrl', type: 'url', wrapText: true, initialWidth: 150,
            typeAttributes: {
                label: {
                    fieldName: 'accountName'
                },
                target: '_blank'
            }
        },
        {
            label: 'Opportunity', fieldName: 'opportunityUrl', type: 'url', wrapText: true, initialWidth: 250,
            typeAttributes: {
                label: {
                    fieldName: 'opportunityName'
                },
                target: '_blank'
            }
        },
        { label: 'StartDate', fieldName: 'optyStartDate', type: 'Date', initialWidth: 100 },
        { label: 'EndDate', fieldName: 'optyEndDate', type: 'Date', initialWidth: 100 },


        {
            label: 'Apr',
            fieldName: 'Apr', initialWidth: 120,
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'May',
            fieldName: 'May', initialWidth: 120,
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'Jun',
            fieldName: 'Jun', initialWidth: 120,
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'Jul',
            fieldName: 'Jul', initialWidth: 120,
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        }, {
            label: 'Aug',
            fieldName: 'Aug', initialWidth: 120,
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'Sep',
            fieldName: 'Sep', initialWidth: 120,
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'Oct',
            fieldName: 'Oct', initialWidth: 120,
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'Nov',
            fieldName: 'Nov', initialWidth: 120,
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'Dec',
            fieldName: 'Dec', initialWidth: 120,
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'Jan',
            fieldName: 'Jan',
            type: 'currency', initialWidth: 120,
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'Feb',
            fieldName: 'Feb', initialWidth: 120,
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'Mar',
            fieldName: 'Mar', initialWidth: 120,
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        }


    ];
    @track columns = [

        {
            label: 'User Name', fieldName: 'userUrl', type: 'url', wrapText: true, initialWidth: 150,
            typeAttributes: {
                label: {
                    fieldName: 'userName'
                },
                target: '_blank'
            }
        },
        {
            label: 'Q1 Goal', initialWidth: 150,
            fieldName: 'Q1_Goal',
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'Q1 Planned Revenue', initialWidth: 150,
            fieldName: 'Q1_Forecast',
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'Q1 % Goal',
            fieldName: 'Q1_Goal_percentage', initialWidth: 120,
            type: 'percent'
        },
        {
            label: 'Q1 Difference',
            fieldName: 'Q1_Goal_Difference', initialWidth: 150,
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
        },
        {
            label: 'Q2 Goal', initialWidth: 150,
            fieldName: 'Q2_Goal',
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'Q2 Planned Revenue', initialWidth: 150,
            fieldName: 'Q2_Forecast',
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'Q2 % Goal',
            fieldName: 'Q2_Goal_percentage', initialWidth: 120,
            type: 'percent'
        },
        {
            label: 'Q2 Difference',
            fieldName: 'Q2_Goal_Difference', initialWidth: 150,
            type: 'currency', typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
        },
        {
            label: 'Q3 Goal', initialWidth: 150,
            fieldName: 'Q3_Goal',
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'Q3 Planned Revenue', initialWidth: 150,
            fieldName: 'Q3_Forecast',
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'Q3 % Goal',
            fieldName: 'Q3_Goal_percentage', initialWidth: 120,
            type: 'percent'
        },
        {
            label: 'Q3 Difference',
            fieldName: 'Q3_Goal_Difference', initialWidth: 150,
            type: 'currency', typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
        },
        {
            label: 'Q4 Goal', initialWidth: 150,
            fieldName: 'Q4_Goal',
            type: 'currency',
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
            sortable: false
        },
        {
            label: 'Q4 Planned Revenue', initialWidth: 120,
            fieldName: 'Q4_Forecast',
            type: 'currency',
            sortable: false,
            typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
        },
        {
            label: 'Q4 % Goal',
            fieldName: 'Q4_Goal_percentage', initialWidth: 150,
            type: 'percent'
        },

        {
            label: 'Q4 Difference',
            fieldName: 'Q4_Goal_Difference', initialWidth: 150,
            type: 'currency', typeAttributes: { currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: "code" },
        },


    ];
    @track value = '';  //this displays selected value of combo box
    @track yearvalue = '';
    @track stagevalue = '';
    @track managername = '';
    TerritoryPicklist;
    @track isLoaded = false;
    @track optyOwnerManagerData = [];
    @track clonedOptyOwnerManagerData = [];
    @track reportWrapper = [];
    @track basictable = false;
    @track detailReportWrapper = [];
    @track detiltable = false;

    connectedCallback() {
        this.basictable = true;
        //this.isLoaded=true; //remove later
    }

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    accountMetadata;

    @wire(getOptyOwnerManagerData)
    wiredContacts({ error, data }) {
        if (data) {
            console.log('dtaa---' + JSON.stringify(data));
            let i;
            for (i = 0; i < data.length; i++) {
                this.optyOwnerManagerData.push({ label: data[i], value: data[i] });
            }
            this.optyOwnerManagerData.push({ label: "All", value: "All" });
            this.optyOwnerManagerData = JSON.parse(JSON.stringify(this.optyOwnerManagerData));
            this.clonedOptyOwnerManagerData = this.optyOwnerManagerData;
            console.log('optyOwnerManagerData---' + JSON.stringify(this.optyOwnerManagerData));
            //this.optyOwnerManagerData.push({"label":}) = data;
            this.error = undefined;
            this.value = 'All Regions';
            this.stagevalue = 'Booked';
            this.managername = 'All';
            let year;
            let today = new Date();
            if (today.getMonth() >= 4) {
                console.log('inside if');
                year = today.getFullYear();

            } else {
                console.log('inside else');
                year = today.getFullYear() - 1;
            }
            this.yearvalue = JSON.stringify(year);
            this.handleSubmit();
        } else if (error) {
            console.log('error---' + error);
            this.error = error;
            this.contacts = undefined;
            this.handleSubmit();
        }
    }
    @wire(getPicklistValues,
        {
            recordTypeId: '$accountMetadata.data.defaultRecordTypeId',
            fieldApiName: TERRITORY_FIELD
        }
    )


    getTerritotrPicklistValues(result) {
        if (result.data) {
            console.log(JSON.stringify(result.data));
            this.TerritoryPicklist = [...result.data.values, { label: 'All Regions', value: 'All Regions' }];
        } else if (result.error) {
            alert('ERROR');
        }
    }
    @wire(getObjectInfo, { objectApiName: OPPORTUNITY_OBJECT })

    oppMetadata;
    @wire(getPicklistValues,
        {
            recordTypeId: '$oppMetadata.data.defaultRecordTypeId',
            fieldApiName: STAGE_BUCKET_FIELD
        }
    )
    stageoptions;
    handleChange(event) {

        this.value = event.detail.value;
        console.log('chosen value---' + this.value);
        if (this.value === 'SIEA') {
            this.optyOwnerManagerData = [];
            this.optyOwnerManagerData.push({ label: "Sabine Cummins", value: "Sabine Cummins" });
            this.optyOwnerManagerData.push({ label: "Natalie Ochoa ", value: "Natalie Ochoa" });
            this.optyOwnerManagerData.push({ label: "All", value: "All" });
            this.optyOwnerManagerData = JSON.parse(JSON.stringify(this.optyOwnerManagerData));
        }
        else if (this.value === 'SIEE') {
            this.optyOwnerManagerData = [];
            this.optyOwnerManagerData.push({ label: "Claire Kim", value: "Claire Kim" });
            this.optyOwnerManagerData.push({ label: "All", value: "All" });
            this.optyOwnerManagerData = JSON.parse(JSON.stringify(this.optyOwnerManagerData));

        } else if (this.value === 'SIEJ') {
            this.optyOwnerManagerData = [];
            this.optyOwnerManagerData.push({ label: "Taku Seimiya", value: "Taku Seimiya" });
            this.optyOwnerManagerData.push({ label: "All", value: "All" });
            this.optyOwnerManagerData = JSON.parse(JSON.stringify(this.optyOwnerManagerData));
        } else if (this.value === 'All Regions') {
            console.log('ebtering');
            this.optyOwnerManagerData = [];
            this.optyOwnerManagerData = this.clonedOptyOwnerManagerData;

        }
    }
    handleLeadChange(event) {
        this.managername = event.detail.value;
        console.log('chosen lead value---' + this.managername);
    }
    get yearoptions() {
        return [
            { label: '2000', value: '2000' }, { label: '2001', value: '2001' }, { label: '2002', value: '2002' }, { label: '2003', value: '2003' },
            { label: '2004', value: '2004' }, { label: '2005', value: '2005' }, { label: '2006', value: '2006' }, { label: '2007', value: '2007' }, { label: '2008', value: '2008' },
            { label: '2009', value: '2009' }, { label: '2010', value: '2010' }, { label: '2011', value: '2011' }, { label: '2012', value: '2012' }, { label: '2013', value: '2013' },
            { label: '2014', value: '2014' }, { label: '2015', value: '2015' }, { label: '2016', value: '2016' }, { label: '2017', value: '2017' }, { label: '2018', value: '2018' },
            { label: '2019', value: '2019' }, { label: '2020', value: '2020' }, { label: '2021', value: '2021' }, { label: '2022', value: '2022' }, { label: '2023', value: '2023' }, { label: '2024', value: '2024' },
            { label: '2025', value: '2025' }, { label: '2026', value: '2026' }, { label: '2027', value: '2027' }, { label: '2028', value: '2028' }, { label: '2029', value: '2029' }, { label: '2030', value: '2030' }, { label: '2031', value: '2031' },
            { label: '2032', value: '2032' }, { label: '2033', value: '2033' }, { label: '2034', value: '2034' }, { label: '2035', value: '2035' }, { label: '2036', value: '2036' },
            { label: '2037', value: '2027' }, { label: '2038', value: '2038' }, { label: '2039', value: '2039' }, { label: '2040', value: '2040' }, { label: '2041', value: '2041' }, { label: '2042', value: '2042' },
            { label: '2043', value: '2043' }, { label: '2044', value: '2044' }, { label: '2045', value: '2045' }, { label: '2046', value: '2046' }, { label: '2047', value: '2047' }, { label: '2048', value: '2048' },
            { label: '2049', value: '2049' }, { label: '2050', value: '2050' }, { label: '2051', value: '2051' }, { label: '2052', value: '2052' }, { label: '2053', value: '2053' }, { label: '2054', value: '2054' },
            { label: '2055', value: '2055' }, { label: '2056', value: '2056' }, { label: '2057', value: '2057' }, { label: '2058', value: '2058' }, { label: '2059', value: '2059' }, { label: '2060', value: '2060' }

        ];

    }
    handleYearChange(e) {
        this.yearvalue = e.detail.value;
        console.log('sleected year--' + this.yearvalue);
    }
    handlestageoption(event) {
        this.stagevalue = event.detail.value;
        console.log('this selected stage value---' + this.stagevalue);
    }

    handleSubmit() {
        if (this.detiltable === true) {
            this.detiltable = false;
            this.basictable = true;
        }
        if (this.isLoaded === true) {
            this.isLoaded = false;
        }
        if (this.value === 'SIEA' && (this.managername === 'Claire Kim' || this.managername === 'Taku Seimiya')) {
            this.managername = 'All';
        }
        if (this.value === 'SIEE' && (this.managername === 'Taku Seimiya' || this.managername == 'Sabine Cummins' || this.managername === 'Natalie Ochoa')) {
            this.managername = 'All';
        }
        if (this.value === 'SIEJ' && (this.managername == 'Sabine Cummins' || this.managername === 'Natalie Ochoa' || this.managername == 'Claire Kim')) {
            this.managername = 'All';
        }
        console.log('called handlesubmit--' + this.value + 'manager---' + this.managername + ' stage--' + this.stagevalue + ' year--' + this.yearvalue);
        prepareWrapperData({ region: this.value, manager: this.managername, stageBucket: this.stagevalue, selectedYear: this.yearvalue, flag: true })
            .then(result => {
                console.log(JSON.stringify(result));
                let baseUrl = 'https://' + location.host + '/';
                // console.log('result---'+JSON.stringify(result));
                result.forEach(element => {
                    if (element.accountId) {

                        element.accountUrl = baseUrl + element.accountId;
                    }
                    if (element.userId) {
                        element.userUrl = baseUrl + element.userId;
                    }
                    if (element.Q4_Goal_percentage) {
                        element.Q4_Goal_percentage = element.Q4_Goal_percentage / 100;
                    }
                    if (element.Q3_Goal_percentage) {
                        element.Q3_Goal_percentage = element.Q3_Goal_percentage / 100;
                    }
                    if (element.Q2_Goal_percentage) {
                        element.Q2_Goal_percentage = element.Q2_Goal_percentage / 100;
                    }
                    if (element.Q1_Goal_percentage) {
                        element.Q1_Goal_percentage = element.Q1_Goal_percentage / 100;
                    }
                });
                this.reportWrapper = result;
                this.isLoaded = true;
                console.log(this.reportWrapper);
                this.error = null;
                let test = this.template.querySelector('.toggleButton');
                console.log(test.checked);
                if (test.checked === true) {
                    test.checked = false;
                }
            })
            .catch(error => {
                this.message = error;
            });
    }
    getToggleButtonValue(event) {
        let DetailRowFlag;
        console.log(event.target.checked);
        DetailRowFlag = event.target.checked;
        if (DetailRowFlag === true) {
            this.basictable = false;
            this.isLoaded = false;
            this.detiltable = true;
            prepareWrapperData({ region: this.value, manager: this.managername, stageBucket: this.stagevalue, selectedYear: this.yearvalue, flag: false })
                .then(result => {
                    console.log(JSON.stringify(result));
                    let baseUrl = 'https://' + location.host + '/';
                    // console.log('result---'+JSON.stringify(result));
                    result.forEach(element => {
                        if (element.accountId) {

                            element.accountUrl = baseUrl + element.accountId;
                        }
                        if (element.userId) {
                            element.userUrl = baseUrl + element.userId;
                        }
                        if (element.oppId) {
                            element.opportunityUrl = baseUrl + element.oppId;
                        }
                        if (element.probability) {
                            element.probability = element.probability / 100;
                        }
                    });
                    this.detailReportWrapper = result;
                    this.isLoaded = true;
                    console.log(this.detailReportWrapper);
                    this.error = null;
                })
                .catch(error => {
                    this.message = error;
                });
        }
        if (DetailRowFlag === false) {
            this.basictable = true;
            this.detiltable = false;
            this.handleSubmit();
        }
    }
    // this method validates the data and creates the csv file to download
    downloadCSVFile() {
        let rowEnd = '\n';
        let csvString = '';
        // this set elminates the duplicates if have any duplicate keys
        let rowData = new Set();

        // getting keys from data
        this.detailReportWrapper.forEach(function (record) {
            Object.keys(record).forEach(function (key) {
                rowData.add(key);
            });
        });

        // Array.from() method returns an Array object from any object with a length property or an iterable object.
        rowData = Array.from(rowData);

        // splitting using ','
        csvString += rowData.join(',');
        csvString += rowEnd;

        // main for loop to get the data based on key value
        for (let i = 0; i < this.detailReportWrapper.length; i++) {
            let colValue = 0;

            // validating keys in data
            for (let key in rowData) {
                if (rowData.hasOwnProperty(key)) {
                    // Key value 
                    // Ex: Id, Name
                    let rowKey = rowData[key];
                    // add , after every value except the first.
                    if (colValue > 0) {
                        csvString += ',';
                    }
                    // If the column is undefined, it as blank in the CSV file.
                    let value = this.detailReportWrapper[i][rowKey] === undefined ? '' : this.detailReportWrapper[i][rowKey];
                    csvString += '"' + value + '"';
                    colValue++;
                }
            }
            csvString += rowEnd;
        }

        // Creating anchor element to download
        let downloadElement = document.createElement('a');

        // This  encodeURI encodes special characters, except: , / ? : @ & = + $ # (Use encodeURIComponent() to encode these characters).
        downloadElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csvString);
        downloadElement.target = '_self';
        // CSV File Name
        downloadElement.download = 'reportData.csv';
        // below statement is required if you are using firefox browser
        document.body.appendChild(downloadElement);
        // click() Javascript function to download CSV file
        downloadElement.click();
    }


}