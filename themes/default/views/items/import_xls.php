<div class="box">
    <div class="box-header">
        <h2 class="blue"><i class="fa-fw fa fa-plus"></i>Thêm nguyên vật liệu bằng file excel</h2>
    </div>
    <div class="box-content">
        <div class="row">
            <div class="col-lg-12">

                <?php
                $attrib = array('class' => 'form-horizontal', 'data-toggle' => 'validator', 'role' => 'form');
                echo form_open_multipart("items/import_xls", $attrib)
                ?>
                <div class="row">
                    <div class="col-md-12">

                        <div class="well well-small">
                            <a href="<?php echo base_url(); ?>assets/xls/items_import.xlsx"
                               class="btn btn-primary pull-right"><i
                                    class="fa fa-download"></i> <?= lang("download_sample_file") ?></a>
                            <span class="text-warning">Dòng đầu tiên trong file excel mẫu là gợi ý cho bạn. Vui lòng không thay đổi thứ tự các cột.</span><br/>
                                Thứ tự cột hợp lệ
                                <span class="text-info">(Tên Nguyên Vật Liệu, Đơn Vị, Giá, Quy Cách, Độ Dài, Độ Rộng, Trọng Lượng)
                                </span>, bạn phải nhập theo thứ tự này.

                        </div>


                        <div class="col-md-12">

                            <div class="form-group">
                                <label for="csv_file">Tải file lên</label>
                                <input type="file" name="userfile" class="form-control file" data-show-upload="false"
                                       data-show-preview="false" id="xlsx_file" required="required"/>
                            </div>

                            <div class="form-group">
                                <?php echo form_submit('import', 'Thêm nguyên vật liệu', 'class="btn btn-primary"'); ?>
                            </div>
                        </div>
                    </div>
                    <?= form_close(); ?>

                </div>

            </div>
        </div>
    </div>
</div>
