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
                            <span class="text-warning"><?= lang("csv1"); ?></span><br/><?= lang("csv2"); ?> <span
                                class="text-info">(<?= lang("product_code") . ', ' . lang("product_name") . ', ' . lang("category_code") . ', ' . lang("product_unit") . ', ' . lang("product_cost") . ', ' . lang("product_price") . ', Quy cách, Trọng lượng, Định mức nhân công, Định mức máy móc, Độ dài, Độ rộng, Số lượng cấu thành'; ?>
                                )</span> <?= lang("csv3"); ?>

                        </div>


                        <div class="col-md-12">

                            <div class="form-group">
                                <label>Năm</label>

                                <select name="year" class="form-control select" style="width: 100%;">
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

                                <select name="month" class="form-control select" style="width: 100%;">
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
                                <?php echo form_submit('import', 'Nhập chấm công', 'class="btn btn-primary"'); ?>
                            </div>
                        </div>
                    </div>
                    <?= form_close(); ?>

                </div>

            </div>
        </div>
    </div>
</div>
