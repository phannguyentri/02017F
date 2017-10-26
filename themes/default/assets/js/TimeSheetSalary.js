/**
 * TimeSheet.js [v1.0]
 * Li Bin
 */

(function ($) {

    var CSheetCell = function(opt){

        /*
         * opt : {
         *   state : 0 or 1,
         *   toggleCallback : function(curState){...}
         *   settingCallback : function(){...}
         * }
         *
         * */

        var cellPrivate = $.extend({
            state : 0,
            toggleCallback : false,
            settingCallback : false
        },opt);


        this.toggle = function(){
            cellPrivate.state = cellPrivate.state>0 ? cellPrivate.state-1 : cellPrivate.state+1;
            if(cellPrivate.toggleCallback){
                cellPrivate.toggleCallback(cellPrivate.state);
            }
        }

        /*
        * state : 0 or 1
        * */
        this.set = function(state){
            cellPrivate.state = state==0 ? 0 : 1;
            if(cellPrivate.settingCallback){
                cellPrivate.settingCallback();
            }
        }

        this.get = function(){
            return cellPrivate.state;
        }

    }

    var CSheet = function(opt){

        var sheetPrivate = $.extend({
            dimensions : undefined,
            sheetData : undefined,
            toggleCallback : false,
            settingCallback : false
        },opt);

        sheetPrivate.cells = [];

        sheetPrivate.initCells = function(){

            var rowNum = sheetPrivate.dimensions[0];
            var colNum = sheetPrivate.dimensions[1];

            if(sheetPrivate.dimensions.length==2 && rowNum>0 && colNum>0){
                for(var row= 0,curRow = []; row<rowNum; ++row){
                    curRow = [];
                    for(var col=0; col<colNum; ++col){
                        curRow.push(new CSheetCell({
                            state : sheetPrivate.sheetData ? (sheetPrivate.sheetData[row]?sheetPrivate.sheetData[row][col]:0) : 0
                        }));
                    }
                    sheetPrivate.cells.push(curRow);
                }
            }else{
                throw new Error("CSheet : wrong dimensions");
            }
        }

        sheetPrivate.areaOperate = function(area,opt){

            /*
             * area : {
             *   startCell : [2,1],
             *   endCell : [7,6]
             * }
             * opt : {
             *    type:"set" or "toggle",
             *    state : 0 or 1 if type is set
             * }
             * */

            var rowCount = sheetPrivate.cells.length;
            var colCount = sheetPrivate.cells[0] ? sheetPrivate.cells[0].length : 0;
            var operationArea = $.extend({
                startCell : [0,0],
                endCell : [rowCount-1,colCount-1]
            },area);

            var isSheetEmpty = rowCount==0 || colCount==0;
            var isAreaValid = operationArea.startCell[0]>=0 && operationArea.endCell[0]<=rowCount-1 &&
                operationArea.startCell[1]>=0 && operationArea.endCell[1]<=colCount-1 &&                                             //operationArea不能超越sheet的边界
                operationArea.startCell[0]<=operationArea.endCell[0] && operationArea.startCell[1]<=operationArea.endCell[1];      //startCell必须居于endCell的左上方，或与之重合

            if(!isAreaValid){
                throw new Error("CSheet : operation area is invalid");
            }else if(!isSheetEmpty){
                for(var row=operationArea.startCell[0]; row<=operationArea.endCell[0]; ++row){
                    for(var col=operationArea.startCell[1]; col<=operationArea.endCell[1]; ++col){
                        if(opt.type=="toggle"){
                            sheetPrivate.cells[row][col].toggle();
                        }else if(opt.type=="set"){
                            sheetPrivate.cells[row][col].set(opt.state);
                        }
                    }
                }
            }

        }

        sheetPrivate.initCells();

        /*
        * toggleArea : {
         *   startCell : [2,1],
         *   endCell : [7,6]
         * }
        *
        * */
        this.toggle = function(toggleArea){

            sheetPrivate.areaOperate(toggleArea,{type:"toggle"});
            if(sheetPrivate.toggleCallback){
                sheetPrivate.toggleCallback();
            }

        }


        /*
        *  state : 0 or 1
        *  settingArea : {
         *   startCell : [2,1],
         *   endCell : [7,6]
         * }
        * */
        this.set = function(state,settingArea){

            sheetPrivate.areaOperate(settingArea,{type:"set",state:state});
            if(sheetPrivate.settingCallback){
                sheetPrivate.settingCallback();
            }
        }

        /*
         *  cellIndex ： [2,3]
         *  @return : 0 or 1
         * */
        this.getCellState = function(cellIndex){
            return sheetPrivate.cells[cellIndex[0]][cellIndex[1]].get();
        }

        /*
         *  row ： 2
         *  @return : [1,0,...,1]
         * */
        this.getRowStates = function(row){
            var rowStates = [];
            for(var col=0; col<sheetPrivate.dimensions[1]; ++col){
                rowStates.push(sheetPrivate.cells[row][col].get());
            }
            return rowStates;
        }

        /*
         *  @return : [[1,0,...,1],[1,0,...,1],...,[1,0,...,1]]
         * */
        this.getSheetStates = function(){
            var sheetStates = [];
            for(var row= 0,rowStates = []; row<sheetPrivate.dimensions[0]; ++row){
                rowStates = [];
                for(var col=0; col<sheetPrivate.dimensions[1]; ++col){
                    rowStates.push(sheetPrivate.cells[row][col].get());
                }
                sheetStates.push(rowStates);
            }
            return sheetStates;
        }

    }



    $.fn.TimeSheet = function(opt){

        var thisSheet = $(this);

        if(!thisSheet.is("TBODY")){
            throw new Error("TimeSheet needs to be bound on a TBODY element");
        }


        var sheetOption = $.extend({
            data: {},
            sheetClass: "",
            start: false,
            end : false,
            remarks : null
        }, opt);

        if(!sheetOption.data.dimensions || sheetOption.data.dimensions.length!==2 || sheetOption.data.dimensions[0]<0 || sheetOption.data.dimensions[1]<0){
            throw new Error("TimeSheet : wrong dimensions");
        }

        var operationArea = {
            startCell : undefined,
            endCell : undefined
        };

        var sheetModel = new CSheet({
            dimensions : sheetOption.data.dimensions,
            sheetData : sheetOption.data.sheetData ? sheetOption.data.sheetData : undefined
        });

        var initSheet = function(){
            thisSheet.html("");
            thisSheet.addClass("TimeSheet");
            if(sheetOption.sheetClass){
                thisSheet.addClass(sheetOption.sheetClass);
            }
            initColHeads();
            initRows();
            // repaintSheet();
        };

        var myDate = new Date();
        myDate.setFullYear(sheetOption.data.year);
        myDate.setMonth(parseInt(sheetOption.data.month)-1);

        var initColHeads = function(){

            var colHeadHtml = '<tr>';
            for(var i=0,curColHead=''; i<=sheetOption.data.dimensions[1]; ++i){
                if(i===0){
                    curColHead = '<td class="TimeSheet-head" rowspan="3" style="'+(sheetOption.data.sheetHead.style?sheetOption.data.sheetHead.style:'')+';"><b>'+sheetOption.data.sheetHead.name+'</b></td>';
                }else{
                    myDate.setDate(i);
                    if (myDate.getDay() == 0) {
                        curColHead = '<td rowspan="3" title="'+(sheetOption.data.colHead[i-1].title ? sheetOption.data.colHead[i-1].title:"")+'" data-col="'+(i-1)+'" class="TimeSheet-colHead '+(i===sheetOption.data.dimensions[1]?'rightMost':'')+'" style="background-color: #9ae89c;"><b>'+sheetOption.data.colHead[i-1].name+'</b></td>';
                    }else{
                        curColHead = '<td rowspan="3" title="'+(sheetOption.data.colHead[i-1].title ? sheetOption.data.colHead[i-1].title:"")+'" data-col="'+(i-1)+'" class="TimeSheet-colHead '+(i===sheetOption.data.dimensions[1]?'rightMost':'')+'" style=""><b>'+sheetOption.data.colHead[i-1].name+'</b></td>';
                    }

                }
                colHeadHtml += curColHead;
            }
            if(sheetOption.remarks){
                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3" style="color: #ed4444;"><b>'+sheetOption.remarks.title+'</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>Chủ nhật</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>Tăng ca</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>Lễ</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>P</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>Ro</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>R</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>Ô</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>Đ</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>NB</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>V</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>L</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>Lương cơ bản(VNĐ)</b></td>';


                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>Lương đóng BHXH(VNĐ)</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>Hệ số HTCV</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead color-blue" colspan="7"><b>Hệ số</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead" colspan="8"><b>Lương cơ bản, phụ cấp</b></td>';


                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>Tổng lương ngày công(VNĐ)</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>Tổng lương sản phẩm(VNĐ)</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead" rowspan="3"><b>Tổng lương(VNĐ)</b></td>';
            }
            colHeadHtml += '</tr>';

            colHeadHtml += '<tr>';
            colHeadHtml +=  '<td class="TimeSheet-remarkHead color-blue" colspan="3"><b>Lương và các khoản phụ cấp lương</b></td>'
            colHeadHtml +=  '<td class="TimeSheet-remarkHead color-blue" colspan="2"><b>Thâm niên</b></td>'
            colHeadHtml +=  '<td class="TimeSheet-remarkHead color-blue" colspan="2"><b>H.Suất</b></td>'


            colHeadHtml +=  '<td class="TimeSheet-remarkHead" rowspan="2"><b>Mức lương</b></td>';
            colHeadHtml +=  '<td class="TimeSheet-remarkHead" rowspan="2"><b>Lương quản lý</b></td>';
            colHeadHtml +=  '<td class="TimeSheet-remarkHead" rowspan="2"><b>Lương kỹ năng chuyên môn</b></td>';
            colHeadHtml +=  '<td class="TimeSheet-remarkHead" rowspan="2"><b>Thâm niên</b></td>';
            colHeadHtml +=  '<td class="TimeSheet-remarkHead" rowspan="2"><b>Lương hiệu suất</b></td>';
            colHeadHtml +=  '<td class="TimeSheet-remarkHead" rowspan="2" style="white-space: nowrap;"><b>Công tác phí, ĐT+ Đồng phục + Nhà ở + Đi lại</b></td>';
            colHeadHtml +=  '<td class="TimeSheet-remarkHead" rowspan="2"><b>Chuyên cần</b></td>';
            colHeadHtml +=  '<td class="TimeSheet-remarkHead" rowspan="2"><b>Thu hút</b></td>';

            colHeadHtml += '</tr>';

            colHeadHtml += '<tr>';
            colHeadHtml +=  '<td class="TimeSheet-remarkHead color-blue"><b>Hệ số lương</b></td>'
            colHeadHtml +=  '<td class="TimeSheet-remarkHead color-blue"><b>HS quản lý</b></td>'
            colHeadHtml +=  '<td class="TimeSheet-remarkHead color-blue"><b>HS kỹ năng chuyên môn</b></td>'
            colHeadHtml +=  '<td class="TimeSheet-remarkHead color-blue"><b>Hệ số</b></td>'
            colHeadHtml +=  '<td class="TimeSheet-remarkHead color-blue"><b>%</b></td>'
            colHeadHtml +=  '<td class="TimeSheet-remarkHead color-blue"><b>Hệ số</b></td>'
            colHeadHtml +=  '<td class="TimeSheet-remarkHead color-blue"><b>%</b></td>'
            colHeadHtml += '</tr>';

            thisSheet.append(colHeadHtml);
        };

        var initRows = function(){

            console.log(sheetOption.data.efficiencysData);
            arrEfficiency   = [];
            arrCompanyId    = [];
            arrInfoCompanies = [];
            for (var i = 0; i < sheetOption.data.companyIdsData.length; (i+=2)) {
                totalHours      = 0;
                hoursOvertime   = 0;
                hoursSunday     = 0;

                for (var j = 0; j < sheetOption.data.sheetContentData[i].length; j++) {
                    hours = (sheetOption.data.sheetContentData[i][j] == 0) ? 0 : sheetOption.data.sheetContentData[i][j];
                    if (hours == "P") {
                        continue;
                    }else if(hours == "Ro"){
                        continue;
                    }else if(hours == "R"){
                        continue;
                    }else if(hours == "Đ"){
                        continue;
                    }else if(hours == "V"){
                        continue;
                    }else if(hours == "L"){
                        continue;
                    }else if(hours == "Lễ"){
                        continue;
                    }else{
                        if (!isNaN(parseFloat(hours))){
                            totalHours = totalHours + parseFloat(hours);
                        }

                    }

                }

                for (var j = 0; j < sheetOption.data.sheetContentData[i+1].length; j++) {
                    myDate.setDate(j+1);
                    if (myDate.getDay() == 0) {
                        hoursSunday     += parseFloat(sheetOption.data.sheetContentData[i+1][j]);
                    }else{
                        hoursOvertime   += parseFloat(sheetOption.data.sheetContentData[i+1][j]);
                    }


                }

                arrInfoCompanies[sheetOption.data.companyIdsData[i].company_id] =  {
                  'info'            : sheetOption.data.infoCompaniesData[i],
                  'name'            : sheetOption.data.nameData[i].name,
                  'efficiency'      : sheetOption.data.efficiencysData[i].efficiency,
                  'workday'         : totalHours/8,
                  'hoursOverTime'   : hoursOvertime,
                  'hoursSunday'     : hoursSunday
                };
            }

            console.log('arrInfoCompanies', arrInfoCompanies);
            console.log('sheetOption.data.sheetContentData', sheetOption.data.sheetContentData);
            workDay = 0;
            colspan = (sheetOption.data.dimensions[1] - (sheetOption.data.dimensions[1] % 4)) /4;
            oddCol  = colspan + (sheetOption.data.dimensions[1] % 4);


            for(var col= 1, curCell=''; col<=sheetOption.data.dimensions[1]; ++col){
                myDate.setDate(col);
                if (myDate.getDay() != 0) {
                    workDay++;
                }
            }

            for(var row=0,curRowHtml=''; row<sheetOption.data.dimensions[0]; ++row){
                company_id = sheetOption.data.companyIdsData[row].company_id;

                rowBonusProductHtml = '';
                totalBonusMoney = 0;

                curRowHtml= '<tr id="row-'+row+'" class="TimeSheet-row">'
                totalHours = 0;
                totalOvertime = 0;
                sundayHours = 0;
                p   = 0;
                ro  = 0;
                r   = 0;
                d   = 0;
                v   = 0;
                l   = 0;
                le  = 0;

                for(var col= 0, curCell=''; col<=sheetOption.data.dimensions[1]; ++col){
                    if(col===0){
                        curCell = '<td title="" class="TimeSheet-rowHead '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'" style="color:#428bca;"><b>'+sheetOption.data.rowHead[row].name+'</b></td>';
                    }else{
                        text = (sheetOption.data.sheetContentData[row][col-1] == 0) ? '' : sheetOption.data.sheetContentData[row][col-1];
                        hours = (sheetOption.data.sheetContentData[row][col-1] == 0) ? 0 : sheetOption.data.sheetContentData[row][col-1];

                        if (hours == "P") {
                            p++;
                        }else if(hours == "Ro"){
                            ro++;
                        }else if(hours == "R"){
                            r++;
                        }else if(hours == "Đ"){
                            d++;
                        }else if(hours == "V"){
                            v++;
                        }else if(hours == "L"){
                            l++;
                        }else if(hours == "Lễ"){
                            le++;
                        }else{
                            if (!isNaN(parseFloat(hours))){
                                totalHours = totalHours + parseFloat(hours);
                            }

                        }


                        myDate.setDate(col);

                        if (row % 2 != 0) {
                            if (myDate.getDay() != 0) {
                                if (!isNaN(parseFloat(hours))){
                                    totalOvertime = totalOvertime + parseFloat(hours);
                                }

                            }else{
                                if (!isNaN(parseFloat(hours))){
                                    sundayHours = sundayHours + parseFloat(hours);
                                }

                            }
                        }

                        if (myDate.getDay() == 0) {
                            curCell = '<td class="TimeSheet-cell '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+(col===sheetOption.data.dimensions[1]?'rightMost':'')+'" data-row="'+row+'" data-col="'+(col-1)+'" style="background-color: #9ae89c;">'+ text +'</td>';
                        }else{
                            curCell = '<td class="TimeSheet-cell '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+(col===sheetOption.data.dimensions[1]?'rightMost':'')+'" data-row="'+row+'" data-col="'+(col-1)+'">'+ text +'</td>';
                        }

                    }
                    curRowHtml += curCell;
                }

                finalTotal = totalHours/8;
                oneDaySalary = parseFloat(sheetOption.data.basicSalariesData[row].basic_salary)/workDay;
                totalSalary = oneDaySalary*finalTotal;


                if(sheetOption.remarks){

                    if (row % 2 == 0) {

                        realBasicSalary = arrInfoCompanies[company_id].info.basic_salary*parseFloat(arrInfoCompanies[company_id].info.coefficient_salary);
                        console.log('realBasicSalary', realBasicSalary);

                        wageSalary = realBasicSalary*parseFloat(arrInfoCompanies[company_id].info.coefficient_salary)/workDay*parseFloat(arrInfoCompanies[company_id].workday)*parseFloat(arrInfoCompanies[company_id].info.coefficient_htcv);
                        manageSalary = realBasicSalary
                         *parseFloat(arrInfoCompanies[company_id].info.coefficient_manage)
                         /workDay
                         *parseFloat(arrInfoCompanies[company_id].workday)
                         *parseFloat(arrInfoCompanies[company_id].info.coefficient_htcv);
                        specializeSalary = parseFloat(arrInfoCompanies[company_id].info.coefficient_specialize)
                         *500000
                         /workDay
                         *parseFloat(arrInfoCompanies[company_id].workday)
                         *parseFloat(arrInfoCompanies[company_id].info.coefficient_htcv);
                        senioritySalary = parseFloat(arrInfoCompanies[company_id].info.coefficient_seniority)
                         *500000
                         /workDay
                         *parseFloat(arrInfoCompanies[company_id].workday)
                         *parseFloat(arrInfoCompanies[company_id].info.coefficient_htcv)
                         *parseFloat(arrInfoCompanies[company_id].info.percent_seniority);
                        efficiencySalary = parseFloat(arrInfoCompanies[company_id].info.efficiency)
                         *500000
                         *parseFloat(arrInfoCompanies[company_id].info.percent_efficiency)
                         *parseFloat(arrInfoCompanies[company_id].workday)
                         /workDay;


                        curRowHtml += '<td style="color: #ed4444;" class="TimeSheet-remark total'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+finalTotal+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark le'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+le+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark p'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+p+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark ro'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+ro+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark r'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+r+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark d'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+d+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark v'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+v+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark l'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+l+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+formatMoney(sheetOption.data.basicSalariesData[row].basic_salary)+'</td>';

                        curRowHtml += '<td class="TimeSheet-remark ">'+formatMoney(arrInfoCompanies[company_id].info.social_insurance)+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark ">'+arrInfoCompanies[company_id].info.coefficient_htcv+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark color-blue" title="Hệ số lương">'+parseFloat(arrInfoCompanies[company_id].info.coefficient_salary).toFixed(2)+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark color-blue" title="Hệ số quản lý">'+parseFloat(arrInfoCompanies[company_id].info.coefficient_manage).toFixed(2)+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark color-blue" title="Hệ số kỹ năng chuyên môn">'+parseFloat(arrInfoCompanies[company_id].info.coefficient_specialize).toFixed(2)+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark color-blue" title="Hệ số thâm niên">'+parseFloat(arrInfoCompanies[company_id].info.coefficient_seniority).toFixed(2)+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark color-blue" title="Phần trăm thâm niên">'+parseFloat(arrInfoCompanies[company_id].info.percent_seniority).toFixed(2)+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark color-blue" title="Hệ số hiệu suất">'+parseFloat(arrInfoCompanies[company_id].info.efficiency).toFixed(2)+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark color-blue" title="Phần trăm hiệu suất">'+parseFloat(arrInfoCompanies[company_id].info.percent_efficiency).toFixed(2)+'</td>';

                        curRowHtml += '<td class="TimeSheet-remark" title="Mức lương">'+formatMoney(wageSalary.toFixed(4))+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark" title="Lương quản lý">'+formatMoney(manageSalary.toFixed(4))+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark" title="Lương kỹ năng chuyên môn">'+formatMoney(specializeSalary.toFixed(4))+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark" title="Thâm niên">'+formatMoney(senioritySalary.toFixed(4))+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark" title="Lương hiệu suất">'+formatMoney(efficiencySalary.toFixed(4))+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark" title="Công tác phí, ĐT+ Đồng phục + Nhà ở + Đi lại"></td>';
                        curRowHtml += '<td class="TimeSheet-remark" title="Chuyên cần"></td>';
                        curRowHtml += '<td class="TimeSheet-remark" title="Thu hút"></td>';


                        curRowHtml += '<td class="TimeSheet-remark salary-daywork'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+formatMoney(totalSalary)+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark bonus'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark final-salary'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                    }else{
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark sunday-hours'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+sundayHours+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark over-time'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+totalOvertime+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';

                        curRowHtml += '<td class="TimeSheet-remark "></td>';
                        curRowHtml += '<td class="TimeSheet-remark "></td>';

                        curRowHtml += '<td class="TimeSheet-remark "></td>';
                        curRowHtml += '<td class="TimeSheet-remark "></td>';
                        curRowHtml += '<td class="TimeSheet-remark "></td>';
                        curRowHtml += '<td class="TimeSheet-remark "></td>';
                        curRowHtml += '<td class="TimeSheet-remark "></td>';
                        curRowHtml += '<td class="TimeSheet-remark "></td>';
                        curRowHtml += '<td class="TimeSheet-remark "></td>';

                        curRowHtml += '<td class="TimeSheet-remark "></td>';
                        curRowHtml += '<td class="TimeSheet-remark "></td>';
                        curRowHtml += '<td class="TimeSheet-remark "></td>';
                        curRowHtml += '<td class="TimeSheet-remark "></td>';
                        curRowHtml += '<td class="TimeSheet-remark "></td>';
                        curRowHtml += '<td class="TimeSheet-remark "></td>';
                        curRowHtml += '<td class="TimeSheet-remark "></td>';
                        curRowHtml += '<td class="TimeSheet-remark "></td>';

                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                    }

                }
                curRowHtml += '</tr>';

                if (row % 2 != 0) {
                    // company_id = sheetOption.data.companyIdsData[row].company_id;
                    arrIdProductBonus   = [];
                    arrNameProductBonus = [];
                    arrWage             = [];
                    arrQuatityConfig    = [];
                    arrRealCompleted    = [];
                    arrBonusMoney       = [];

                    arrIdProduction     = [];


                    for (var p = 0; p < sheetOption.data.productionsData.length; p++) {
                        if (!arrIdProduction.includes(sheetOption.data.productionsData[p].id)) {
                            arrIdProduction.push(sheetOption.data.productionsData[p].id);
                        }
                    }

                    // console.log('arrIdProduction', arrIdProduction);
                    console.log(sheetOption.data.productionsData);
                    for (var j = 0; j < sheetOption.data.productionsData.length; j++) {
                        tempEmp = sheetOption.data.productionsData[j].employee.split(",");
                        for (var v = 0; v < tempEmp.length; v++) {
                            if (tempEmp[v] == company_id) {
                                if (!arrIdProductBonus.includes(sheetOption.data.productionsData[j].product_id)) {
                                    arrIdProductBonus.push(sheetOption.data.productionsData[j].product_id);


                                    arrNameProductBonus.push(sheetOption.data.productionsData[j].product_name);
                                    wage = sheetOption.data.productionsData[j].wage;
                                    arrWage.push(sheetOption.data.productionsData[j].wage);
                                    arrQuatityConfig.push(sheetOption.data.productionsData[j].quantity_config);

                                    arrQuantityCompleted = [];
                                    arrQuantityCompletedTest = [];

                                    totalRealCompleted = 0;
                                    tmp_id_prot = null;
                                    sameEmp = false;
                                    teamEmp = [];
                                    currentWorkDay = parseFloat(arrInfoCompanies[parseInt(company_id)].workday);
                                    currentEfficiency = parseFloat(arrInfoCompanies[parseInt(company_id)].efficiency);
                                    moneyBonusProduct = 0;

                                    for (var x = 0; x < sheetOption.data.productionsData.length; x++) {
                                        if ((sheetOption.data.productionsData[j].product_id == sheetOption.data.productionsData[x].product_id)) {

                                            tempEmp2    = sheetOption.data.productionsData[x].employee.split(",");

                                            if ((x != 0) && (sheetOption.data.productionsData[x].id != tmp_id_prot) && (tmp_id_prot != null)) {
                                                if (sameEmp == true) {
                                                    totalRealCompleted += Math.min(...arrQuantityCompleted);

                                                    countEmp = teamEmp.length;

                                                    totalWorkDay = 0;
                                                    totalEfficiency = 0;

                                                    $.each(teamEmp, function( index, val) {
                                                        totalWorkDay += arrInfoCompanies[parseInt(val)].workday;
                                                        totalEfficiency += parseFloat(arrInfoCompanies[parseInt(val)].efficiency);
                                                    })

                                                    a   = countEmp*Math.min(...arrQuantityCompleted)*wage;
                                                    b   = totalWorkDay * totalEfficiency;

                                                    moneyBonusProduct += (a/b) * currentWorkDay * currentEfficiency;

                                                }

                                                sameEmp = false;

                                                teamEmp = [];
                                                arrQuantityCompleted = [];

                                            }

                                            for (var a = 0; a < tempEmp2.length; a++) {
                                                if (tempEmp2[a] == company_id) {
                                                    sameEmp = true;
                                                }
                                                if (!teamEmp.includes(tempEmp2[a])) {
                                                    teamEmp.push(tempEmp2[a]);
                                                }

                                            }

                                            tmp_id_prot = sheetOption.data.productionsData[x].id;

                                            arrQuantityCompleted.push(parseInt(sheetOption.data.productionsData[x].soluonghoanthanh));

                                        }
                                    }

                                    if (sameEmp == true) {
                                        console.log('teamEmp', teamEmp);
                                        totalRealCompleted += Math.min(...arrQuantityCompleted);

                                        countEmp = teamEmp.length;

                                        totalWorkDay = 0;
                                        totalEfficiency = 0;

                                        $.each(teamEmp, function( index, val) {
                                            totalWorkDay += arrInfoCompanies[parseInt(val)].workday;
                                            totalEfficiency += parseFloat(arrInfoCompanies[parseInt(val)].efficiency);
                                        })

                                        a   = countEmp*Math.min(...arrQuantityCompleted)*wage;
                                        b   = totalWorkDay * totalEfficiency;

                                        moneyBonusProduct += ((a/b) * currentWorkDay * currentEfficiency);

                                    }

                                    arrRealCompleted.push(totalRealCompleted);

                                    totalBonusMoney += moneyBonusProduct;
                                    arrBonusMoney.push(moneyBonusProduct);
                                    $('#row-'+(row-1)).find('.bonus').text(formatMoney(totalBonusMoney));
                                    salaryDaywork = ($('#row-'+(row-1)).find('.salary-daywork').text());
                                    salaryDaywork = parseFloat(salaryDaywork.replace(/,/g,''));
                                    finalSalary = salaryDaywork + parseFloat(totalBonusMoney);
                                    $('#row-'+(row-1)).find('.final-salary').text(formatMoney(finalSalary));
                                }
                            }
                        }
                    }

                    if (totalBonusMoney == 0) {
                        finalSalary = $('#row-'+(row-1)).find('.salary-daywork').text();
                        $('#row-'+(row-1)).find('.bonus').text(0);
                        $('#row-'+(row-1)).find('.final-salary').text(finalSalary);
                    }

                    console.log('--------------------------------------------------');

                    if (arrIdProductBonus.length) {
                        rowBonusProductHtml += '<tr class="TimeSheet-row"><td class="TimeSheet-rowHead" style="color:#428bca; border-top: none;"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-cell" data-row="3" data-col="30" colspan="'+colspan+'" style="text-align: center;"><b>Đơn giá nguyên công</b></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-cell" data-row="3" data-col="30" colspan="'+colspan+'" style="text-align: center;"><b>Số lượng cấu thành</b></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-cell" data-row="3" data-col="30" colspan="'+colspan+'" style="text-align: center;"><b>Hoàn thành thực tế</b></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-cell" data-row="3" data-col="30" colspan="'+oddCol+'" style="text-align: center;"><b>Tổng tiền(VNĐ)</b></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'

                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'

                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'

                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'

                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                        rowBonusProductHtml += '<td class="TimeSheet-remark"></td></tr>';
                        for (var i = 0; i < arrIdProductBonus.length; i++) {

                            rowBonusProductHtml += '<tr>'
                            rowBonusProductHtml += '<td style="color:#428bca; border-left: none;">'+arrNameProductBonus[i]+'</td>'
                            rowBonusProductHtml += '<td class="TimeSheet-cell" data-row="3" data-col="30" colspan="'+colspan+'">'+formatMoney(arrWage[i])+'</td>'
                            rowBonusProductHtml += '<td class="TimeSheet-cell" data-row="3" data-col="30" colspan="'+colspan+'">'+formatMoney(arrQuatityConfig[i])+'</td>'
                            rowBonusProductHtml += '<td class="TimeSheet-cell" data-row="3" data-col="30" colspan="'+colspan+'">'+formatMoney(arrRealCompleted[i])+'</td>'
                            rowBonusProductHtml += '<td class="TimeSheet-cell" data-row="3" data-col="30" colspan="'+oddCol+'">'+formatMoney(arrBonusMoney[i])+'</td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'

                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'

                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'

                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'

                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td>'
                            rowBonusProductHtml += '<td class="TimeSheet-remark"></td></tr>';
                        }

                    }

                }

                curRowHtml += rowBonusProductHtml;
                thisSheet.append(curRowHtml);
            }
        };


        var removeSelecting = function(){
            thisSheet.find(".TimeSheet-cell-selecting").removeClass("TimeSheet-cell-selecting");
        };

        var cleanRemark = function(){
            thisSheet.find(".TimeSheet-remark").each(function(idx,ele){
                var curDom = $(ele);
                curDom.prop("title","");
                curDom.html(sheetOption.remarks.default);
            });
        };

        /*
         * targetArea ： {
         *      topLeft ： [1,2],
         *      bottomRight: [3,8]
         * }
         * */
        var afterSelecting = function(ev,targetArea){
            var curDom = $(ev.currentTarget);
            var key = $(ev.which);
            var targetState = undefined;

            if(key[0]===1){       targetState = 1;}   //1
            else if(key[0]===3){ targetState = 0;}   //0

            if(isSelecting && curDom.hasClass("TimeSheet-cell") || isColSelecting && curDom.hasClass("TimeSheet-colHead")){

            }else{
                removeSelecting();
            }

            isSelecting = false;
            isColSelecting = false;
            operationArea = {
                startCell : undefined,
                endCell : undefined
            }
        };

        var isSelecting = false;

        var isColSelecting = false;

        initSheet();



        var publicAPI = {

            /*
            * cellIndex ：[1,2]
            * @return : 0 or 1
            * */
            getCellState : function(cellIndex){
                return sheetModel.getCellState(cellIndex);
            },

            /*
             * row ：2
             * @return : [1,0,0,...,0,1]
             * */
            getRowStates : function(row){
                return sheetModel.getRowStates(row);
            },

            /*
             * @return : [[1,0,0,...,0,1],[1,0,0,...,0,1],...,[1,0,0,...,0,1]]
             * */
            getSheetStates : function(){
                return sheetModel.getSheetStates();
            },

            /*
            * row : 2,
            * */
            setRemark : function(row,html){
                if($.trim(html)!==''){
                    $(thisSheet.find(".TimeSheet-row")[row]).find(".TimeSheet-remark").prop("title",html).html(html);
                }
            },

            /*
            * */
            clean : function(){
                sheetModel.set(0,{});
                // repaintSheet();
                cleanRemark();
            },

            /*
            * default remark
            * */
            getDefaultRemark : function(){
                return sheetOption.remarks.default;
            },

            /*
            * */
            disable : function(){
                thisSheet.undelegate(".umsSheetEvent");
            },

            /*
             * */
            enable : function(){
                eventBinding();
            },

            /*
            * @return ： true or false
            * */
            isFull : function(){
                for(var row=0; row<sheetOption.data.dimensions[0]; ++row){
                    for(var col=0; col<sheetOption.data.dimensions[1]; ++col){
                        if(sheetModel.getCellState([row,col])===0){
                            return false;
                        }
                    }
                }
                return true;
            }
        };

        return publicAPI;

    }


})(jQuery);
