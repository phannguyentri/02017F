<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-users"></i>Tính lương</h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-lg-12">

              <?php
                // echo date("w",strtotime('17-7-2017'));
                // echo "<pre>";
                // print_r($productions);
                // echo "</pre>";
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
                          <button id="btn-save-salaries" type="button" class="btn btn-primary" disabled>
                            <span class="icon fa fa-floppy-o"></span> Lưu bảng lương
                          </button>
                      </div>
                    </div>
                  </div>

                  <div class="col-md-3" style="margin-top: 15px;">
                    <div class="form-group">
                      <div class="controls">
                          <button id="btn-xls" type="button" class="btn btn-primary" style="background-color:#449a70; border-color: #449a70;" disabled>
                            <span class="icon fa fa-file-excel-o"></span> Tải về dạng XLS
                          </button>
                      </div>
                    </div>
                  </div>

                  <div class="col-md-3" style="margin-top: 15px;">
                    <div class="form-group">
                      <div class="controls">
                          <button id="btn-general-xls" type="button" class="btn btn-primary"
                           style="background-color:#449a70; border-color: #449a70;" disabled>
                            <span class="icon fa fa-file-excel-o"></span> Tải về bảng tổng quát dạng XLS
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

  function calculatorTNCN(tncn){
    let a = 0;
    let b = 0;
    let c = 0;
    let d = 0;
    if (tncn < 0 ) {
      a = 0;
    }else{
      if (tncn <= 5000000) {
        a = tncn*0.05;
      }else{
        if (tncn > 5000000 && tncn <= 10000000) {
          a = 250000+(tncn-5000000)*0.1;
        }else{
          a = 0;
        }
      }

    }

    if (tncn > 10000000 && tncn <= 18000000) {
      b = 750000+(tncn - 10000000)*0.15;
    }

    if (tncn > 18000000 && tncn <= 32000000){
      c = 1950000+(tncn-18000000)*0.2;
    }else{
      if (tncn > 32000000 && tncn <= 52000000) {
        c = 4750000+(tncn-32000000)*0.25;
      }else{
        c = 0;
      }
    }

    if (tncn > 52000000 && tncn <= 80000000) {
      d = 9750000+(tncn-52000000)*0.30;
    }else{
      if (tncn > 80000000) {
        d = 18150000+(tncn-80000000)*0.35;
      }else{
        d = 0;
      }
    }

    total = a+b+c+d;

    return total;
  }

  var sheetContentData = [];
  var timekeeperDetailIds = null;
  var dataUpdateSalaries = [];

  $(document).ready(function () {

    $(document).on('click', '.edit', function() {
      var input = prompt('Nhập thay đổi: ');
        if(input != null) {
          if (input >= 0) {
            if (input == 0) {
              $(this).text('');
            }else{
              $(this).text(formatMoney(input));
              companyId = $(this).parent().attr('data-company-id');
              fieldName = $(this).attr('data-field-name');

              if (!dataUpdateSalaries[companyId]) {
                dataUpdateSalaries[companyId] = {};
              }
              dataUpdateSalaries[companyId][fieldName] = input

              $('#btn-save-salaries').removeAttr('disabled');
              console.log(dataUpdateSalaries);
            }
          }else{
            bootbox.alert('Bạn chỉ được nhập số.');
          }
        }
    })

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
                $('#btn-save-salaries').attr('disabled', 'disabled');
                $('#link-xls').attr('href', );
                $('#btn-xls').removeAttr('disabled');
                $('#btn-general-xls').removeAttr('disabled');

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
                        nameData          : response.timekeeperDetailsName,
                        infoCompaniesData : response.infoCompanies,
                        salariesData      : response.salaries,
                        month             : month,
                        year              : year
                    },
                    remarks : {
                        title : "Ngày công làm việc",
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

    $('#btn-general-xls').click(function(e) {
      event.preventDefault();
      window.location.href = '<?= site_url('salaries/xlsGeneral/'); ?>?department_id='+department_id+'&month='+month+'&year='+year;
    });


    $('#btn-save-salaries').click(function(e) {
      e.preventDefault();
      console.log('dataUpdateSalaries', dataUpdateSalaries);

      $.ajax({
          url: '<?= site_url('salaries/saveSalaries'); ?>',
          async : false,
          type: 'post',
          dataType: 'json',
          data: {
              month         : month,
              year          : year,
              dataSalaries  : dataUpdateSalaries,
              <?php echo $this->security->get_csrf_token_name() ?> : '<?php echo $this->security->get_csrf_hash() ?>'
          },
          success: function (response) {
            if (response.status == "success") {
              bootbox.alert('Lưu bảng lương thành công!');
              $('#btn-save-salaries').attr('disabled', 'disabled');
            }else{
              bootbox.alert('Lưu bảng lương thất bại!');
            }
          }
      })

    });

  });
</script>
<style type="text/css">
  .color-blue{
    background-color: #c6e7f9;
  }
</style>
