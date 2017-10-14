<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-users"></i>Chấm công</h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-lg-12">

                  <div class="well well-small">
                    <a href="<?php echo base_url(); ?>assets/xls/timekeepers_import.xlsx" class="btn btn-primary pull-right"><i class="fa fa-download"></i> Tải file mẫu</a>
                      <span class="text-info"><b>0 đến 24</b></span> là những số hợp lệ bạn có thể điền vào bảng chấm công.
                      </br>
                      <span class="text-info"><b>P, Ro, R, Đ, V, L</b></span> là những từ hợp lệ bạn có thể điền vào bảng chấm công.</br>
                      <span class="text-warning">Vui lòng nhập theo quy định này</span>
                  </div>

                  <div class="col-md-3">

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
                  </div>

                  <div class="col-md-3">
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
                  </div>

                  <div class="col-md-3">
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

                  </div>

                  <div class="col-md-3" style="margin-top: 15px;">
                    <div class="form-group">
                      <input type="submit" value="Chấm công" id="btn-show" class="btn btn-success"
                       style="margin-top: 15px;">
                    </div>
                  </div>

                  <div class="col-md-12">
                    <div style="overflow-x:scroll;">
                      <div class="table-responsive">
                          <div id="J_calenderWrapper">
                            <table class="table" style="width:1000px; max-width:1000px; ">
                                <thead></thead>
                                <tbody id="J_timedSheet">
                                </tbody>
                            </table>
                          </div>
                      </div>
                    </div>
                  </div>



                  <div class="col-md-3" style="margin-top: 15px;">
                    <div class="form-group">
                      <div class="controls">
                        <input type="submit" name="add_user" value="Lưu bảng chấm công" id="btn-save" class="btn btn-primary" disabled>
                      </div>
                    </div>
                  </div>

            </div>

            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
  var year = null;
  var month = null;
  /**
   * count all date in month and get current year
   * @param  integer month
   * @param  integer year
   * @return Object
   */
  function daysInMonth(month, year) {
    time = new Date(year, month, 0);
    return time.getDate();
  }

  var sheetContentData = [];
  var timekeeperDetailIds = null;
  $(function() {
      $(document).on('click', '.TimeSheet-cell', function() {
        const input = prompt('Nhập thay đổi: ');
        if(input != null) {
          if ((input >= 0 && input <= 24) || (input == "CT" || input == "P" || input == "Ro" || input == "R" || input == "Ô" || input == "Đ" || input == "NB" || input == "V" || input == "L")) {

            isOverTime = ($(this).attr('data-row') % 2 != 0) ? true : false;

            if (isOverTime && (input == "CT" || input == "P" || input == "Ro" || input == "R" || input == "Ô" || input == "Đ" || input == "NB" || input == "V" || input == "L")) {
              bootbox.alert('Dòng tăng ca chỉ được nhập chữ số.');
            }else{
              if (input == 0) {
                $(this).text('');
              }else{
                $(this).text(input);
              }

              sheetContentData[$(this).attr('data-row')][$(this).attr('data-col')] = input;

              totalHours = 0;
              totalOvertime = 0;
              sundayHours = 0;
              p   = 0;
              ro  = 0;
              r   = 0;
              d   = 0;
              v   = 0;
              l   = 0;



              var myDate = new Date();
              myDate.setFullYear(year);
              myDate.setMonth(parseInt(month)-1);

              for (var i = 0; i < sheetContentData[$(this).attr('data-row')].length; i++) {
                hours = (sheetContentData[$(this).attr('data-row')][i] === 0) ? 0 : sheetContentData[$(this).attr('data-row')][i];

                if (hours === "P") {
                    p++;
                }else if(hours === "Ro"){
                    ro++;
                }else if(hours === "R"){
                    r++;
                }else if(hours === "Đ"){
                    d++;
                }else if(hours === "V"){
                    v++;
                }else if(hours === "L"){
                    l++;
                }else{
                  if (!isNaN(parseFloat(hours))) {
                    totalHours = totalHours + parseFloat(hours);
                  }
                }

                myDate.setDate(i+1);

                if (isOverTime) {
                  if (myDate.getDay() != 0) {
                    if (!isNaN(parseFloat(hours))) {
                      totalOvertime = totalOvertime + parseFloat(hours);
                    }

                  }else{
                    if (!isNaN(parseFloat(hours))) {
                      sundayHours = sundayHours + parseFloat(hours);
                    }
                  }
                }

              }

              if (isOverTime) {
                $(this).parent().find('.sunday-hours').text(sundayHours);
                $(this).parent().find('.over-time').text(totalOvertime);
              }else{
                total = totalHours/8;
                $(this).parent().find('.total').text(total);
                $(this).parent().find('.p').text(p);
                $(this).parent().find('.ro').text(ro);
                $(this).parent().find('.r').text(r);
                $(this).parent().find('.d').text(d);
                $(this).parent().find('.v').text(v);
                $(this).parent().find('.l').text(l);
              }
            }





          }else{
            bootbox.alert('Ký tự không hợp lệ!');
          }
        }

      });
  });

  $(document).ready(function () {

    $('#btn-show').click(function(e) {
      sheetContentData = [];

      e.preventDefault();
      var department_id = $("#department" ).val();
      month         = $("#month").val();
      year          = $("#year").val();

      $.ajax({
          url: '<?= site_url('timekeepers/getAllTimekeeperDetails'); ?>',
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

                timekeeperDetailIds = response.timekeeperDetailIds;
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

                numRow = Object.keys(nameList).length;

                var dimensions = [numRow, daysInMonth(month, year)];

                for (i = 1; i <= daysInMonth(month, year); i++) {
                  if (i < 10) {
                    pre = '0';
                  }
                  dayList.push({name: pre+i, title: "Ngày "+i});
                  pre = '';
                }

                var sheetData = sheetContentData;

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
                        title : "Tổng cộng",
                        default : "N/A"
                    },
                    end : function(ev,selectedArea){
                        // updateRemark(sheet);
                    }
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
                bootbox.alert('Không tồn tại bảng chấm công tháng '+month+' năm '+year+' của phòng ban '+$("#department option:selected" ).text().toLowerCase());
              }

          }
      })

    });

    $("#btn-save").click(function(e){
        e.preventDefault();
        $.ajax({
          url: '<?= site_url('timekeepers/editView'); ?>',
          type: 'POST',
          dataType: 'json',
          data: {
            sheetContentData,
            timekeeperDetailIds: timekeeperDetailIds,
            year: year,
            month: month,
            <?php echo $this->security->get_csrf_token_name() ?> : '<?php echo $this->security->get_csrf_hash() ?>',

          },
          success: function (response_edit) {
            // console.log(response_edit);
            if (response_edit.status === "success") {
              bootbox.alert('Lưu bảng chấm công thành công!');
            }else{
              bootbox.alert('Lưu bảng chấm công thất bại');
            }
            $('#btn-save').attr('disabled', 'disabled');
          }
        });

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
