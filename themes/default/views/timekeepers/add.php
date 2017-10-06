<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-users"></i>Thêm chấm công</h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-lg-12">

                <?php $attrib = array('class' => 'form-horizontal', 'data-toggle' => 'validator', 'role' => 'form');
                echo form_open("auth/create_user", $attrib);
                ?>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-10">

                          <div class="form-group">
                              <label>Chọn tháng</label>
                              <select name="month" class="form-control" id="month" style="width: 100%;">
                                <?php
                                  for ($i=1; $i <= 12; $i++) {
                                    echo '<option value="'.$i.'">'.$i.'</option>';
                                  }
                                ?>
                              </select>
                          </div>

                          <div class="form-group">
                              <label>Phòng ban</label>
                              <select name="department" class="form-control select" id="department" style="width: 100%;">
                                <?php
                                  foreach ($departments as $department) {
                                    echo '<option value="'.$department->id.'">'.$department->name.'</option>';
                                  }
                                ?>
                              </select>
                          </div>

                          <div class="form-group">
                              <div class="controls">
                                  <div style="padding:15px 0 10px;">
                                    <button class="J_sheetControl" id="J_timingDisable">Disable</button>
                                      <button class="J_sheetControl" id="J_timingEnable">Enable</button>
                                      <button class="J_sheetControl" id="J_timingClean">Clean</button>
                                      <button class="J_sheetControl" id="J_timingSubmit">Submit</button>
                                      <button class="J_sheetControl" id="J_timingIsFull">IsFull</button>
                                      <div style="padding:15px 0 5px;">
                                          <input type="text" placeholder="0,0" id="J_cellIndex" value="0,0"/> <button class="J_sheetControl" id="J_timingGetCell">GetCell</button>
                                      </div>
                                      <div style="padding:10px 0;">
                                          <input type="number" placeholder="0" id="J_rowIndex" value="0"/>  <button class="J_sheetControl" id="J_timingGetRow">GetRow</button>
                                      </div>
                                  </div>
                                  <div id="J_calenderWrapper">
                                      <table>
                                          <thead></thead>
                                          <tbody id="J_timedSheet">

                                          </tbody>
                                      </table>
                                  </div>
                              </div>
                          </div>


                            <p id="J_dataDisplay" style="color:#aaaaaa;font-family: 'Arial';"></p>

                            <div class="form-group">
                                <div class="controls">
                                    <?php echo form_submit('add_user', 'Lưu', 'class="btn btn-primary"'); ?>
                                </div>
                            </div>

                        </div>


                    </div>
                </div>
            </div>

                <p></p>

                <?php echo form_close(); ?>
            </div>
        </div>
    </div>
</div>
<?php
  $month = "10";
  $year = "2017";

  $start_date = "01-".$month."-".$year;
  $start_time = strtotime($start_date);

  echo $start_time;

  $end_time = strtotime("+1 month", $start_time);

  for($i = $start_time; $i < $end_time; $i +=86400)
  {
     $list[] = date('Y-m-d-D', $i);
  }
  echo "<pre>";
  print_r($list);
  echo "</pre>";
 ?>

<script type="text/javascript">
  /**
   * count all date in month and get current year
   * @param  integer month
   * @param  integer year
   * @return Object
   */
  function daysInMonth(month,year) {
    today = new Date(year, month, 0);
    return data = {
      'countDays' : today.getDate(),
      'year' : today.getFullYear()
    }

    /**
     * @param {int} The month number, 0 based
     * @param {int} The year, not zero based, required to account for leap years
     * @return {Date[]} List with date objects for each day of the month
     */
    function getDaysInMonth(month, year) {
         // Since no month has fewer than 28 days
         var date = new Date(year, month, 1);
         var days = [];
         console.log('month', month, 'date.getMonth()', date.getMonth())
         while (date.getMonth() === month) {
            days.push(new Date(date));
            date.setDate(date.getDate() + 1);
         }
         return days;
    }

    console.log(getDaysInMonth(4, 2012))

  }
  console.log(daysInMonth(10, 2017));

    $(document).ready(function () {
        $('#department').change(function(e) {

            e.preventDefault();
            var department_id = $( "#department" ).val();

            $.ajax({
                url: '<?= site_url('timekeepers/getAllBiller'); ?>',
                async : false,
                type: 'GET',
                dataType: 'json',
                data: {
                    department_id: department_id
                },
                success: function (response) {
                    console.log(response);

                    var nameList = []; // new Array
                    for (i in response) {
                        nameList.push({"name": response[i].name });
                    }
                    console.log(nameList);
                    console.log(Object.keys(nameList).length);
                    numRow = Object.keys(nameList).length;

                    var dimensions = [numRow,31];

                    var hourList = [
                        {name:"01",title:"01:00-02:00"},
                        {name:"02",title:"02:00-03:00"},
                        {name:"03",title:"03:00-04:00"},
                        {name:"04",title:"04:00-05:00"},
                        {name:"05",title:"05:00-06:00"},
                        {name:"06",title:"06:00-07:00"},
                        {name:"07",title:"07:00-08:00"},
                        {name:"08",title:"08:00-09:00"},
                        {name:"09",title:"09:00-10:00"},
                        {name:"10",title:"10:00-11:00"},
                        {name:"11",title:"11:00-12:00"},
                        {name:"12",title:"12:00-13:00"},
                        {name:"13",title:"13:00-14:00"},
                        {name:"14",title:"14:00-15:00"},
                        {name:"15",title:"15:00-16:00"},
                        {name:"16",title:"16:00-17:00"},
                        {name:"17",title:"17:00-18:00"},
                        {name:"18",title:"18:00-19:00"},
                        {name:"19",title:"19:00-20:00"},
                        {name:"20",title:"20:00-21:00"},
                        {name:"21",title:"21:00-22:00"},
                        {name:"22",title:"22:00-23:00"},
                        {name:"23",title:"23:00-00:00"},
                        {name:"24",title:"23:00-00:00"},
                        {name:"25",title:"23:00-00:00"},
                        {name:"26",title:"23:00-00:00"},
                        {name:"27",title:"23:00-00:00"},
                        {name:"28",title:"23:00-00:00"},
                        {name:"29",title:"23:00-00:00"},
                        {name:"30",title:"23:00-00:00"},
                        {name:"31",title:"23:00-00:00"},
                    ];

                    var sheetData = [
                        []
                    ];

                    var updateRemark = function(sheet){

                        var sheetStates = sheet.getSheetStates();
                        var rowsCount = dimensions[0];
                        var colsCount = dimensions[1];
                        var rowRemark = [];
                        var rowRemarkLen = 0;
                        var remarkHTML = '';

                        for(var row= 0, rowStates=[]; row<rowsCount; ++row){
                            rowRemark = [];
                            rowStates = sheetStates[row];
                            for(var col=0; col<colsCount; ++col){
                                if(rowStates[col]===0 && rowStates[col-1]===1){
                                    rowRemark[rowRemarkLen-1] += (col<=10?'0':'')+col+':00';
                                }else if(rowStates[col]===1 && (rowStates[col-1]===0 || rowStates[col-1]===undefined)){
                                    rowRemarkLen = rowRemark.push((col<=10?'0':'')+col+':00-');
                                }
                                if(rowStates[col]===1 && col===colsCount-1){
                                    rowRemark[rowRemarkLen-1] += '00:00';
                                }
                            }
                            remarkHTML = rowRemark.join("，");
                            sheet.setRemark(row,remarkHTML==='' ? sheet.getDefaultRemark() : remarkHTML);
                        }
                    };

                    var sheet = $("#J_timedSheet").TimeSheet({
                        data: {
                            dimensions : dimensions,
                            colHead : hourList,
                            rowHead : nameList,
                            sheetHead : {name:"Ngày trong tháng"},
                            sheetData : sheetData
                        },
                        remarks : {
                            title : "Description",
                            default : "N/A"
                        },
                        end : function(ev,selectedArea){
                            updateRemark(sheet);
                        }
                    });



                    updateRemark(sheet);

                    $("#J_timingDisable").click(function(ev){
                        sheet.disable();
                    });

                    $("#J_timingEnable").click(function(ev){
                        sheet.enable();
                    });

                    $("#J_timingClean").click(function(ev){
                        sheet.clean();
                    });

                    $("#J_timingSubmit").click(function(ev){

                        var sheetStates = sheet.getSheetStates();
                        var rowsCount = dimensions[0];
                        var $submitDataDisplay = $("#J_dataDisplay") ;

                        $submitDataDisplay.html("<b>Raw Data Submitted:</b><br/>[<br/>");

                        for(var row= 0, rowStates=[]; row<rowsCount; ++row){
                            rowStates = sheetStates[row];
                            $submitDataDisplay.append('&nbsp;&nbsp;[ '+rowStates+' ]'+(row==rowsCount-1?'':',')+'<br/>');
                        }

                        $submitDataDisplay.append(']');
                    });

                    $("#J_timingIsFull").click(function(ev){
                        alert(sheet.isFull());
                    });

                    $("#J_timingGetCell").click(function(ev){

                        var cellIndex = $("#J_cellIndex").val().split(',');
                        var cellData = sheet.getCellState(cellIndex);
                        var $dataDisplay = $("#J_dataDisplay") ;

                        $dataDisplay.html("<b>Cell Data At ["+cellIndex+"] : </b>"+cellData);
                    });

                    $("#J_timingGetRow").click(function(ev){
                        var rowIndex = $("#J_rowIndex").val();
                        var rowData = sheet.getRowStates(rowIndex);
                        var $dataDisplay = $("#J_dataDisplay") ;

                        $dataDisplay.html("<b>Row Data At "+rowIndex+" : </b>[ "+rowData+" ]");
                    });
                }
            })

        });

    });

</script>


<script type="text/javascript" src="<?=base_url();?>themes/default/assets/js/TimeSheet.js"></script>

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-36251023-1']);
  _gaq.push(['_setDomainName', 'jqueryscript.net']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
