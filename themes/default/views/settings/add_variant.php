<style type="text/css">
    small.help-block{
        display: none !important;
    }
</style>
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel"><?php echo lang('add_variant'); ?></h4>
        </div>
        <?php $attrib = array('data-toggle' => 'validator', 'role' => 'form');
        echo form_open("system_settings/add_variant", $attrib); ?>
        <div class="modal-body">
            <p><?= lang('enter_info'); ?></p>

            <div class="form-group">
                <label for="name"><?php echo $this->lang->line("name"); ?></label>
                <div class="controls"> <?php echo form_input('name', '', 'class="form-control" id="name" required="required"'); ?> 
                </div>
            </div>
            <div class="form-group">
                <label for="percent"><?php echo $this->lang->line("Phần trăm"); ?></label>
                <div class="controls"> <?php echo form_input('percent', '', 'class="form-control" id="percent" required="required"'); ?> 
            </div>

            </div>
        </div>
        <div class="modal-footer">
            <?php echo form_submit('add_variant', lang('add_variant'), 'class="btn btn-primary"'); ?>
        </div>
    </div>
    <?php echo form_close(); ?>
</div>

<?= $modal_js ?>
<script type="text/javascript">
    $('#percent').keyup(function(){
        if(!($(this).val() >= 0 && $(this).val() <= 100)){
            $(this).val(0);
            alert("Xin vui lòng nhập số phần trăm từ 1 đến 100");
        }
    })
</script>