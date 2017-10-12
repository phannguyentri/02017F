<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-users"></i>Thêm chấm công</h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-lg-12">

                <div class="row">
                  <div class="col-md-4">

                    <div class="form-group">
                      <label>Năm</label>

                      <select name="year" class="form-control select" id="year" style="width: 100%;">
                        <?php
                          for ($i=date('Y')-1; $i <= date('Y') + 1 ; $i++) {
                            if ($i == date('Y')) {
                              echo '<option value="'.$i.'" selected>'.$i.'</option>';
                            }else{
                              echo '<option value="'.$i.'">'.$i.'</option>';
                            }

                          }
                         ?>
                      </select>
                    </div>


                    <div class="form-group">
                      <label>Tháng</label>

                      <select name="month" class="form-control select" id="month" style="width: 100%;">
                        <?php
                          for ($i=1; $i <= 12 ; $i++) {
                            if ($i == date('m')) {
                              echo '<option value="'.$i.'" selected>Tháng '.$i.'</option>';
                            }else{
                              echo '<option value="'.$i.'">Tháng '.$i.'</option>';
                            }

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

                    <!-- <h1><?php echo $this->security->get_csrf_hash(); ?></h1> -->


                    <div class="controls">
                        <div id="J_calenderWrapper">
                            <table class="table table-bordered">
                                <thead></thead>
                                <tbody id="J_timedSheet">

                                </tbody>
                            </table>
                        </div>
                    </div>

                      <!-- <p id="J_dataDisplay" style="color:#aaaaaa;font-family: 'Arial';"></p> -->

                    <div class="form-group">
                      <div class="controls">
                        <input type="submit" name="add_user" value="Lưu" id="btn-save" class="btn btn-primary" disabled>
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

<script type="text/javascript">
  /**
   * count all date in month and get current year
   * @param  integer month
   * @param  integer year
   * @return Object
   */
  function daysInMonth(month, year) {
    time = new Date(year, month, 0);
    // return data = {
    //   'countDays' : time.getDate(),
    //   'year' : time.getFullYear()
    // }
    return time.getDate();
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

  var sheetContentData = [];
  $(function() {
      $(document).on('click', '.TimeSheet-cell', function() {
        const input = prompt('Nhập thay đổi: ');
        if(input != null) {
          if ((input > 0 && input <= 24) || (input == "CT" || input == "P" || input == "Ro" || input == "R" || input == "Ô" || input == "Đ"
           || input == "NB" || input == "V" || input == "L")) {
            $(this).text(input);
            sheetContentData[$(this).attr('data-row')][$(this).attr('data-col')] = input;
          }else{
            bootbox.alert('Không hợp lệ');
          }
        }

        console.log(sheetContentData);

      });
  });

  $(document).ready(function () {

    $('#year, #month, #department').change(function(e) {

      e.preventDefault();
      var department_id = $("#department" ).val();
      var month         = $("#month").val();
      var year          = $("#year").val();

      $.ajax({
          url: '<?= site_url('timekeepers/getAllBiller'); ?>',
          async : false,
          type: 'GET',
          dataType: 'json',
          data: {
              department_id : department_id,
              month         : month,
              year          : year
          },
          success: function (response) {
              if (response.timekeeperDetails.length != undefined) {
                console.log(response);
                $('#btn-save').removeAttr('disabled');

                var nameList = []; // new Array
                var dayList = [];

                for (i in response.timekeeperDetailsName) {
                  if (i % 2 == 0) {
                    nameList.push({"name": response.timekeeperDetailsName[i].name });
                  }else{
                    nameList.push({"name": '' });
                  }

                }

                for (i in response.timekeeperDetails) {
                  row_keeper = [];
                  for (j in response.timekeeperDetails[i]) {
                    row_keeper.push(response.timekeeperDetails[i][j]);
                  }

                  sheetContentData.push(row_keeper);
                }

                // console.log('sheetContentData', sheetContentData);

                numRow = Object.keys(nameList).length;

                var dimensions = [numRow, daysInMonth(month, year)];

                for (i = 1; i <= daysInMonth(month, year); i++) {
                  if (i < 10) {
                    pre = '0';
                  }
                  dayList.push({name: pre+i, title: "Ngày "+i});
                  pre = '';
                }
                // console.log('dayList',dayList);

                var sheetData = sheetContentData;

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
                        colHead : dayList,
                        rowHead : nameList,
                        sheetHead : {name:"Ngày trong tháng"},
                        sheetData : sheetData,
                        sheetContentData : sheetContentData,
                        month: month,
                        year: year
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

                $("#btn-save").click(function(e){
                    e.preventDefault();
                    $.ajax({
                      url: '<?= site_url('timekeepers/editView'); ?>',
                      type: 'POST',
                      dataType: 'json',
                      data: {
                        sheetContentData,
                        timekeeperDetailIds: response.timekeeperDetailIds,
                        year: year,
                        month: month,
                        <?php echo $this->security->get_csrf_token_name() ?> : '<?php echo $this->security->get_csrf_hash() ?>',

                      },
                      success: function (response_edit) {
                        console.log(response_edit);
                      }
                    });

                });


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
              }else{
                bootbox.alert('Không tồn tại bảng chấm công tháng '+month+' năm '+year+' của phòng ban '+$("#department option:selected" ).text());
              }

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
