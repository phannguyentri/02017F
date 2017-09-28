<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel">Thêm xưởng</h4>
        </div>
        <?php $attrib = array('data-toggle' => 'validator', 'role' => 'form');
        echo form_open("working_places/add", $attrib); ?>
        <div class="modal-body">
        <!-- <div class="col-md-12"> -->
            <p><?= lang('enter_info'); ?></p>

            <div class="form-group">
                <?php echo lang('Tên xưởng', 'working_place'); ?>
                <div class="controls">
                <?= form_input('working_place', (isset($_POST['working_place']) ? $_POST['working_place'] : ''), 'class="form-control" id="working_place" required="required"'); ?>
                </div>
            </div>

            <div class="form-group">
                <?php echo lang('Điện thoại', 'phone'); ?>
                <div class="controls">
                <?= form_input('phone', (isset($_POST['phone']) ? $_POST['phone'] : ''), 'class="form-control" id="phone"'); ?>
                </div>
            </div>
            <div class="form-group">
                <?php echo lang('address', 'address'); ?>
                <div class="controls">
                <?= form_input('address', (isset($_POST['address']) ? $_POST['address'] : ''), 'class="form-control" id="address"'); ?>
                </div>
            </div>
             <div class="form-group all">
              <?= lang("Máy móc", "category") ?>
              <select name="machine[]" class="form-control select" id="category" style="width: 100%" multiple="multiple">
                    <?php foreach ($machine as $key => $value) {?>                        
                        <optgroup label="<?php echo $value->categories_name ?>">
                            <?php foreach ($value->machine as $k => $v) { ?>
                                <option  value="<?php echo $v->id ?>"><?php echo $v->machine_name.' ('.$v->machine_code.')'?></option>
                            <?php } ?>
                        </optgroup>                                      
                    <?php } ?>                       
              </select>                 
            </div>
            <div class="form-group">
                <?= lang("Ghi chú", "note") ?>
                <?= form_textarea('note', (isset($_POST['note']) ? $_POST['note'] : ''), 'class="form-control" id="note"'); ?>
            </div>
            
        </div>

        <div class="modal-footer">
            <?php echo form_submit('add', 'Thêm xưởng', 'class="btn btn-primary"'); ?>
        </div>
    </div>
    <?php echo form_close(); ?>
</div>
<script type="text/javascript" src="<?= $assets ?>js/custom.js"></script>
<?= $modal_js ?>