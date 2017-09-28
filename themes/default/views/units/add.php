<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel">Thêm đơn vị</h4>
        </div>
        <?php $attrib = array('data-toggle' => 'validator', 'role' => 'form');
        echo form_open("units/add", $attrib); ?>
        <div class="modal-body">
        <!-- <div class="col-md-12"> -->
            <p><?= lang('enter_info'); ?></p>

            <div class="form-group">
                <?php echo lang('Tên đơn vị', 'unit'); ?>
                <div class="controls">
                <?= form_input('unit', (isset($_POST['unit']) ? $_POST['unit'] : ''), 'class="form-control" id="unit" required="required"'); ?>
                </div>
            </div>

            <div class="form-group">
                <?php echo lang('Ghi chú', 'note'); ?>
                <div class="controls">
                <?= form_input('note', (isset($_POST['note']) ? $_POST['note'] : ''), 'class="form-control" id="note"'); ?>
                </div>
            </div>
            
        </div>

        <div class="modal-footer">
            <?php echo form_submit('add', 'Thêm đơn vị', 'class="btn btn-primary"'); ?>
        </div>
    </div>
    <?php echo form_close(); ?>
</div>
<script type="text/javascript" src="<?= $assets ?>js/custom.js"></script>
<?= $modal_js ?>