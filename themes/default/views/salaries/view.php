<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-users"></i>Tính lương</h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-lg-12">

              <?php
                // echo date("w",strtotime('17-7-2017'));
                echo "<pre>";
                print_r($productions);
                echo "</pre>";
               ?>
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
                      <input type="submit" value="Tính lương" id="btn-show" class="btn btn-success"
                       style="margin-top: 15px;">
                    </div>
                  </div>

                  <div class="col-md-12">
                    <div style="overflow-x:scroll;">
                      <div class="table-responsive">
                          <div id="J_calenderWrapper">
                            <table class="table" style="width:1000px; max-width:1000px; ">
                                <thead></thead>
                                <tbody id="J_timedSheet" >
                                </tbody>
                            </table>
                          </div>
                      </div>
                    </div>
                  </div>



                  <div class="col-md-3" style="margin-top: 15px;">
                    <div class="form-group">
                      <div class="controls">
                          <button id="btn-xls" type="button" class="btn btn-info" disabled>
                            <span class="icon fa fa-file-excel-o"></span> Tải về dạng XLS
                          </button>
                      </div>
                    </div>
                  </div>

            </div>

            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="<?=base_url();?>themes/default/assets/js/TimeSheetSalary.js"></script>

<script type="text/javascript">
  var year = null;
  var month = null;
  var department_id = null;
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


  $(document).ready(function () {

    $('#btn-show').click(function(e) {
      sheetContentData = [];

      e.preventDefault();
      department_id = $("#department" ).val();
      month         = $("#month").val();
      year          = $("#year").val();

      $.ajax({
          url: '<?= site_url('salaries/getAllTimekeeperDetails'); ?>',
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
                $('#link-xls').attr('href', );
                $('#btn-xls').removeAttr('disabled');

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
                        sheetContentData  : sheetContentData,
                        basicSalariesData : response.basicSalaries,
                        productionsData   : response.productionsInMonthYear,
                        companyIdsData    : response.companyIds,
                        efficiencysData   : response.efficiencys,
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

              }else{
                bootbox.alert('Không tồn tại bảng chấm công tháng '+month+' năm '+year+' của phòng ban '+$("#department option:selected" ).text().toLowerCase());
              }

          }
      })

    });

    $('#btn-xls').click(function(e) {
      event.preventDefault();
      window.location.href = '<?= site_url('salaries/xls/'); ?>?department_id='+department_id+'&month='+month+'&year='+year;
    });

  });
</script>
