<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel">Sửa đơn vị</h4>
        </div>
        <?php $attrib = array('data-toggle' => 'validator', 'role' => 'form');
        echo form_open("units/edit/" . $id, $attrib); ?>
        <div class="modal-body">
            <p><?= lang('update_info'); ?></p>

            <div class="form-group">
                <?php echo lang('Tên đơn vị', 'unit'); ?>
                <div class="controls">
                <?= form_input('unit', (isset($_POST['unit']) ? $_POST['unit'] : (isset($unit
                ) ? $unit->unit : '')), 'class="form-control" id="unit" required="required"'); ?>
                </div>
            </div>

            <div class="form-group">
                <?php echo lang('Ghi chú', 'note'); ?>
                <div class="controls">
                <?= form_input('note', (isset($_POST['note']) ? $_POST['note'] : (isset($unit
                ) ? $unit->note : '')), 'class="form-control" id="note"'); ?>
                </div>
            </div>
            <?php echo form_hidden('id', $id); ?>
        </div>
        <div class="modal-footer">
            <?php echo form_submit('edit', lang('Sửa đơn vị'), 'class="btn btn-primary"'); ?>
        </div>
    </div>
    <?php echo form_close(); ?>
</div>
<script type="text/javascript" src="<?= $assets ?>js/custom.js"></script>
<?= $modal_js ?>