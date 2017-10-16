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

        /*
        * opt : {
        *   dimensions : [8,9],  [行数，列数]
        *   sheetData : [[0,1,1,0,0],[...],[...],...]    sheet
        *   toggleCallback : function(){..}
        *   settingCallback : function(){..}
        * }
        *
        * */

        var sheetPrivate = $.extend({
            dimensions : undefined,
            sheetData : undefined,
            toggleCallback : false,
            settingCallback : false
        },opt);

        sheetPrivate.cells = [];

        /*
        * 初始化表格中的所有单元格
        * */
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
            // console.log('year:'+ sheetOption.data.year + ', month:'+ sheetOption.data.month);

            var colHeadHtml = '<tr>';
            for(var i=0,curColHead=''; i<=sheetOption.data.dimensions[1]; ++i){
                if(i===0){
                    curColHead = '<td class="TimeSheet-head" style="'+(sheetOption.data.sheetHead.style?sheetOption.data.sheetHead.style:'')+'"><b>'+sheetOption.data.sheetHead.name+'</b></td>';
                }else{
                    myDate.setDate(i);
                    if (myDate.getDay() == 0) {
                        curColHead = '<td title="'+(sheetOption.data.colHead[i-1].title ? sheetOption.data.colHead[i-1].title:"")+'" data-col="'+(i-1)+'" class="TimeSheet-colHead '+(i===sheetOption.data.dimensions[1]?'rightMost':'')+'" style="background-color: #9ae89c;"><b>'+sheetOption.data.colHead[i-1].name+'</b></td>';
                    }else{
                        curColHead = '<td title="'+(sheetOption.data.colHead[i-1].title ? sheetOption.data.colHead[i-1].title:"")+'" data-col="'+(i-1)+'" class="TimeSheet-colHead '+(i===sheetOption.data.dimensions[1]?'rightMost':'')+'" style=""><b>'+sheetOption.data.colHead[i-1].name+'</b></td>';
                    }

                }
                colHeadHtml += curColHead;
            }
            if(sheetOption.remarks){
                colHeadHtml += '<td class="TimeSheet-remarkHead"><b>'+sheetOption.remarks.title+'</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead"><b>Chủ nhật</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead"><b>Tăng ca</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead"><b>Tổng lương ngày công</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead"><b>Lễ</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead"><b>P</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead"><b>Ro</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead"><b>R</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead"><b>Ô</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead"><b>Đ</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead"><b>NB</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead"><b>V</b></td>';
                colHeadHtml += '<td class="TimeSheet-remarkHead"><b>L</b></td>';
            }
            colHeadHtml += '</tr>';
            thisSheet.append(colHeadHtml);
        };

        var initRows = function(){
            workDay = 0;

            for(var col= 1, curCell=''; col<=sheetOption.data.dimensions[1]; ++col){
                myDate.setDate(col);
                if (myDate.getDay() != 0) {
                    workDay++;
                }
            }

            for(var row=0,curRowHtml=''; row<sheetOption.data.dimensions[0]; ++row){
                curRowHtml= '<tr class="TimeSheet-row">'
                totalHours = 0;
                totalOvertime = 0;
                sundayHours = 0;
                p   = 0;
                ro  = 0;
                r   = 0;
                d   = 0;
                v   = 0;
                l   = 0;

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
                            // workDay++;
                        }

                    }
                    curRowHtml += curCell;
                }

                finalTotal = totalHours/8;
                oneDaySalary = parseFloat(sheetOption.data.basicSalariesData[row].basic_salary)/workDay;
                totalSalary = oneDaySalary*finalTotal;

                // console.log('basic',(parseFloat(sheetOption.data.basicSalariesData[row].basic_salary)/workDay)*finalTotal);

                if(sheetOption.remarks){
                    // console.log(finalTotal);

                    if (row % 2 == 0) {
                        curRowHtml += '<td class="TimeSheet-remark total'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+finalTotal+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+formatMoney(totalSalary)+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark p'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+p+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark ro'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+ro+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark r'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+r+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark d'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+d+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'"></td>';
                        curRowHtml += '<td class="TimeSheet-remark v'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+v+'</td>';
                        curRowHtml += '<td class="TimeSheet-remark l'+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+l+'</td>';
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
                    }

                    // curRowHtml += '<td class="TimeSheet-remark '+(row===sheetOption.data.dimensions[0]-1?'bottomMost ':' ')+'">'+finalTotal+'</td>';
                }
                curRowHtml += '</tr>';

                if (row % 2 != 0) {
                    company_id = sheetOption.data.companyIdsData[row].company_id;
                    arrIdProductBonus = [];
                    arrNameProductBonus = [];

                    for (var j = 0; j < sheetOption.data.productionsData.length; j++) {
                        tempEmp = sheetOption.data.productionsData[j].employee.split(",");
                        for (var v = 0; v < tempEmp.length; v++) {
                            if (tempEmp[v] == company_id) {
                                if (!arrIdProductBonus.includes(sheetOption.data.productionsData[j].product_id)) {
                                    arrIdProductBonus.push(sheetOption.data.productionsData[j].product_id);
                                    arrNameProductBonus.push(sheetOption.data.productionsData[j].product_name);
                                }
                            }
                        }
                    }

                    if (arrIdProductBonus.length) {
                        curRowHtml += '<tr class="TimeSheet-row"><td class="TimeSheet-rowHead" style="color:#428bca;"></td>'
                        curRowHtml += '<td class="TimeSheet-cell" data-row="3" data-col="30" colspan="10" style="text-align: center;"><b>Đơn giá nguyên công</b></td>'
                        curRowHtml += '<td class="TimeSheet-cell" data-row="3" data-col="30" colspan="10" style="text-align: center;"><b>Số lượng cấu thành</b></td>'
                        curRowHtml += '<td class="TimeSheet-cell" data-row="3" data-col="30" colspan="11" style="text-align: center;"><b>Hoàn thành thực tế</b></td>'
                        curRowHtml += '<td class="TimeSheet-remark"></td><td class="TimeSheet-remark"></td><td class="TimeSheet-remark"></td><td class="TimeSheet-remark"></td><td class="TimeSheet-remark  "></td><td class="TimeSheet-remark"></td><td class="TimeSheet-remark  "></td><td class="TimeSheet-remark  "></td><td class="TimeSheet-remark  "></td><td class="TimeSheet-remark  "></td><td class="TimeSheet-remark  "></td><td class="TimeSheet-remark  "></td><td class="TimeSheet-remark  "></td></tr>';
                        for (var i = 0; i < arrIdProductBonus.length; i++) {

                            curRowHtml += '<tr>'
                            curRowHtml += '<td style="color:#428bca;">'+arrNameProductBonus[i]+'</td>'
                            curRowHtml += '<td class="TimeSheet-cell" data-row="3" data-col="30" colspan="10">4,000</td>'
                            curRowHtml += '<td class="TimeSheet-cell" data-row="3" data-col="30" colspan="10">3</td>'
                            curRowHtml += '<td class="TimeSheet-cell" data-row="3" data-col="30" colspan="11">50</td>'
                            curRowHtml += '<td class="TimeSheet-remark"></td><td class="TimeSheet-remark sunday-hours "></td><td class="TimeSheet-remark over-time "></td><td class="TimeSheet-remark  "></td><td class="TimeSheet-remark  "></td><td class="TimeSheet-remark  "></td><td class="TimeSheet-remark  "></td><td class="TimeSheet-remark  "></td><td class="TimeSheet-remark  "></td><td class="TimeSheet-remark  "></td><td class="TimeSheet-remark  "></td><td class="TimeSheet-remark  "></td><td class="TimeSheet-remark  "></td></tr>';
                        }

                    }

                    console.log('arrNameProductBonus', arrNameProductBonus);
                    console.log('company_id', company_id);
                    console.log('arrIdProductBonus', arrIdProductBonus);
                    console.log('-------------------------------------------------------------------------------');
                }
                thisSheet.append(curRowHtml);
            }
        };

        /*
        * cell1:[2,3]
        * cell2:[4,5]
        * @return:{
             topLeft : cell1,
             bottomRight : cell2
         }
        * */
        var cellCompare = function(cell1,cell2){  //check which cell is more top-left
            var sum1 = cell1[0] + cell1[1];
            var sum2 = cell2[0] + cell2[1];

            if((cell1[0]-cell2[0])*(cell1[1]-cell2[1])<0){
                return {
                    topLeft : cell1[0]<cell2[0] ? [cell1[0],cell2[1]] : [cell2[0],cell1[1]],
                    bottomRight : cell1[0]<cell2[0] ? [cell2[0],cell1[1]] : [cell1[0],cell2[1]]
                };
            }

            return {
                topLeft : sum1<=sum2 ? cell1 : cell2,
                bottomRight : sum1>sum2 ? cell1 : cell2
            };
        };

        // var repaintSheet = function(){
        //     var sheetStates = sheetModel.getSheetStates();
        //     thisSheet.find(".TimeSheet-row").each(function(row,rowDom){
        //         var curRow = $(rowDom);
        //         curRow.find(".TimeSheet-cell").each(function(col,cellDom){
        //             var curCell = $(cellDom);
        //             if(sheetStates[row][col]===1){
        //                 curCell.addClass("TimeSheet-cell-selected");
        //             }else if(sheetStates[row][col]===0){
        //                 curCell.removeClass("TimeSheet-cell-selected");
        //             }
        //         });
        //     });
        // };

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
        * startCel ： [1,4]
        * */
        var startSelecting = function(ev,startCel){
            operationArea.startCell = startCel;
            if(sheetOption.start){
                sheetOption.start(ev);
            }
        };

        /*
         * topLeftCell ： [1,4]，
         * bottomRightCell ： [3,9]
         * */
        var duringSelecting = function(ev,topLeftCell,bottomRightCell){
            var curDom = $(ev.currentTarget);

            if(isSelecting && curDom.hasClass("TimeSheet-cell") || isColSelecting && curDom.hasClass("TimeSheet-colHead")){
                removeSelecting();
                for(var row=topLeftCell[0]; row<=bottomRightCell[0]; ++row){
                    for(var col=topLeftCell[1]; col<=bottomRightCell[1]; ++col){
                        $($(thisSheet.find(".TimeSheet-row")[row]).find(".TimeSheet-cell")[col]).addClass("TimeSheet-cell-selecting");
                    }
                }
            }
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

        var eventBinding = function(){

            thisSheet.undelegate(".umsSheetEvent");

            thisSheet.delegate(".TimeSheet-cell","mousedown.umsSheetEvent",function(ev){
                var curCell = $(ev.currentTarget);
                var startCell = [curCell.data("row"),curCell.data("col")];
                isSelecting = true;
                startSelecting(ev,startCell);
            });

            thisSheet.delegate(".TimeSheet-cell","mouseup.umsSheetEvent",function(ev){
                if(!operationArea.startCell){
                    return;
                }
                var curCell = $(ev.currentTarget);
                var endCell = [curCell.data("row"),curCell.data("col")];
                var correctedCells = cellCompare(operationArea.startCell,endCell);
                afterSelecting(ev,correctedCells);
            });

            thisSheet.delegate(".TimeSheet-cell","mouseover.umsSheetEvent",function(ev){
                if(!isSelecting){
                    return;
                }
                var curCell = $(ev.currentTarget);
                var curCellIndex = [curCell.data("row"),curCell.data("col")];
                var correctedCells = cellCompare(operationArea.startCell,curCellIndex);
                var topLeftCell = correctedCells.topLeft;
                var bottomRightCell = correctedCells.bottomRight;

                duringSelecting(ev,topLeftCell,bottomRightCell);
            });


            thisSheet.delegate(".TimeSheet-colHead","mousedown.umsSheetEvent",function(ev){
                var curColHead = $(ev.currentTarget);
                var startCell = [0,curColHead.data("col")];
                isColSelecting = true;
                startSelecting(ev,startCell);
            });

            thisSheet.delegate(".TimeSheet-colHead","mouseup.umsSheetEvent",function(ev){
                if(!operationArea.startCell){
                    return;
                }
                var curColHead = $(ev.currentTarget);
                var endCell = [sheetOption.data.dimensions[0]-1,curColHead.data("col")];
                var correctedCells = cellCompare(operationArea.startCell,endCell);
                afterSelecting(ev,correctedCells);
            });

            thisSheet.delegate(".TimeSheet-colHead","mouseover.umsSheetEvent",function(ev){
                if(!isColSelecting){
                    return;
                }
                var curColHead = $(ev.currentTarget);
                var curCellIndex = [sheetOption.data.dimensions[0]-1,curColHead.data("col")];
                var correctedCells = cellCompare(operationArea.startCell,curCellIndex);
                var topLeftCell = correctedCells.topLeft;
                var bottomRightCell = correctedCells.bottomRight;

                duringSelecting(ev,topLeftCell,bottomRightCell);
            });

            thisSheet.delegate("td","contextmenu.umsSheetEvent",function(ev){
                return false;
            });
        };


        initSheet();
        eventBinding();


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