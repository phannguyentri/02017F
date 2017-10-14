<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-plus"></i>Thêm bảng chấm công bằng excel</h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-lg-12">

                <?php
                    $attrib = array('class' => 'form-horizontal', 'data-toggle' => 'validator', 'role' => 'form');
                    echo form_open_multipart("timekeepers/import_xls", $attrib)
                ?>

                <div class="row">
                    <div class="col-md-12">

                        <div class="well well-small">
                            <a href="<?php echo base_url(); ?>assets/xls/timekeepers_import.xlsx"
                               class="btn btn-primary pull-right"><i
                                    class="fa fa-download"></i> <?= lang("download_sample_file") ?></a>
                            <span class="text-warning">Vui lòng không thay đổi thứ tự các cột. bạn phải nhập theo thứ tự trong file mẫu.</span>

                        </div>


                        <div class="col-md-12">

                            <div class="form-group">
                                <label>Năm</label>

                                <select id="year" name="year" class="form-control select" style="width: 100%;">
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

                                <select id="month" name="month" class="form-control select" style="width: 100%;">
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

                            <div class="form-group">
                                <label for="csv_file">Tải file lên</label>
                                <input type="file" name="userfile" class="form-control file" data-show-upload="false"
                                       data-show-preview="false" id="xlsx_file" required="required"/>
                            </div>

                            <div class="form-group">
                                <?php echo form_submit('import', 'Nhập chấm công', 'id="btn-save" class="btn btn-primary"'); ?>
                            </div>
                        </div>
                    </div>
                    <?= form_close(); ?>

                </div>

            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
  $(document).ready(function(){
    $('#btn-save').click(function(e) {

      department_id = $('#department').val();
      month         = $('#month').val();
      year          = $('#year').val();

      $.ajax({
        url: '<?= site_url('timekeepers/checkTimekeeper'); ?>',
        type: 'post',
        dataType: 'json',
        data: {
          department_id : department_id,
          month         : month,
          year          : year,
          <?php echo $this->security->get_csrf_token_name() ?> : '<?php echo $this->security->get_csrf_hash() ?>'
        },
      })
      .done(function(responses) {
        if (responses.status === "exist") {
          if (confirm('Đã tồn tại bảng chấm công tháng '+$('#month').val()+' năm '+$('#year').val()+' phòng ban '+$('#department option:selected').text().toLowerCase()+'.\nBạn có muốn cập nhật lại dữ liệu không?')) {
            return true;
          }
          return false;
        }
      });

    });
  })
</script>
