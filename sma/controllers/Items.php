<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Items extends MY_Controller
{

    function __construct()
    {
        parent::__construct();

        if (!$this->loggedIn) {
            $this->session->set_userdata('requested_page', $this->uri->uri_string());
            redirect('login');
        }

        
        $this->lang->load('settings', $this->Settings->language);
        $this->load->library('form_validation');
        $this->load->model('items_model');
        $this->load->model('units_model');
    }

    function index($warehouse_id = NULL)
    {
        if ($this->Owner || $this->Admin) {
            $this->data['warehouses'] = $this->site->getAllWarehouses();
            $this->data['warehouse_id'] = $warehouse_id;
            $this->data['warehouse'] = $warehouse_id ? $this->site->getWarehouseByID($warehouse_id) : NULL;
        } else {
            $this->data['warehouses'] = NULL;
            $this->data['warehouse_id'] = $this->session->userdata('warehouse_id');
            $this->data['warehouse'] = $this->session->userdata('warehouse_id') ? $this->site->getWarehouseByID($this->session->userdata('warehouse_id')) : NULL;
        }

        $this->data['error'] = validation_errors() ? validation_errors() : $this->session->flashdata('error');      
        $bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => lang('Nguyên vật liệu')));
        $meta = array('page_title' => lang('Nguyên vật liệu'), 'bc' => $bc);
        $this->page_construct('items/index', $meta, $this->data);
    }

    function getItems($warehouse_id=NULL)
    {
      
        $this->load->library('datatables');
        if ($warehouse_id) 
        {
            $this->datatables
            ->select("items.id as id,items.item,items.specification,items.size_long,items.size_wide,items.unit,warehouses_products.quantity,items.note",false)
            ->from('warehouses_products')
            ->join('items', 'items.id=warehouses_products.item_id','right')
            ->where('warehouses_products.warehouse_id',$warehouse_id)

            ->add_column("Actions", "<center><a href='" . site_url('items/edit/$1') . "'  class='tip' title='Sửa nguyên vật liệu'><i class=\"fa fa-edit\"></i></a> <a href='#' class='tip po' title='<b>Xóa nguyên vật liệu</b>' data-content=\"<p>" . lang('r_u_sure') . "</p><a class='btn btn-danger po-delete' href='" . site_url('items/delete/$1') . "'>" . lang('i_m_sure') . "</a> <button class='btn po-close'>" . lang('no') . "</button>\"  rel='popover'><i class=\"fa fa-trash-o\"></i></a></center>", "id");
        }
        else
        {
            $this->datatables
            ->select("id as id,item,specification,size_long,size_wide,unit, quantity, note",false)
            ->from("items")
            ->add_column("Actions", "<center><a href='" . site_url('items/edit/$1') . "'  class='tip' title='Sửa nguyên vật liệu'><i class=\"fa fa-edit\"></i></a> <a href='#' class='tip po' title='<b>Xóa nguyên vật liệu</b>' data-content=\"<p>" . lang('r_u_sure') . "</p><a class='btn btn-danger po-delete' href='" . site_url('items/delete/$1') . "'>" . lang('i_m_sure') . "</a> <button class='btn po-close'>" . lang('no') . "</button>\"  rel='popover'><i class=\"fa fa-trash-o\"></i></a></center>", "id");
        }
        

        echo $this->datatables->generate();
    }

    function getItemByID($id = NULL)
    {
        if ($rows = $this->items_model->getItemByID($id)) {
            $data = json_encode($rows);
        } else {
            $data = false;
        }
        echo $data;
    }

    function add()
    {
        $this->load->helper('security');
        
        $products = $this->items_model->getAllItems();
            
            foreach ($products as $key => $value) {
                
                if($value->item == $this->input->post('item') && $value->unit_id == $this->input->post('unit_id') &&  $value->specification == $this->input->post('specification')){
                    array(
                            $this->form_validation->set_rules('item','Nguyên vật liệu này', 'trim|is_unique[items.item]'),
                            $this->form_validation->set_rules('specification','trim|is_unique[items.specification]'),
                            $this->form_validation->set_rules('unit_id','trim|is_unique[items.unit_id]'),
                        );
                }
            }
        
        $this->form_validation->set_rules('quantity', lang("Số lượng"), 'trim|numeric');
        $this->form_validation->set_rules('cost', lang("Giá"), 'trim|numeric');
        $this->form_validation->set_rules('long', lang("Dài"), 'trim|numeric');
        $this->form_validation->set_rules('wide', lang("Rộng"), 'trim|numeric');
        $this->form_validation->set_rules('weight', lang("Trọng lượng"), 'trim|numeric');
        $warehouses = $this->site->getAllWarehouses();
        if ($this->form_validation->run() == true) {
            $data = array(
                'item'=>$this->input->post('item'),
                'specification'=>$this->input->post('specification'),
                'size_long'=>$this->input->post('size_long'),
                'size_wide'=>$this->input->post('size_wide'),
                'unit_id'=>$this->input->post('unit_id'),
                'unit'=>$this->input->post('unit'),
                'note'=>$this->input->post('note'),
                'weight'=>$this->input->post('weight'),
                'cost' =>$this->input->post('cost')
                );
            $wh_total_quantity = 0;
            foreach ($warehouses as $warehouse) {
                    if ($this->input->post('wh_qty_' . $warehouse->id)) {
                        $warehouse_qty[] = array(
                            'warehouse_id' => $this->input->post('wh_' . $warehouse->id),
                            'quantity' => 0,
                            'rack' => $this->input->post('rack_' . $warehouse->id) ? $this->input->post('rack_' . $warehouse->id) : NULL
                        );
                        $wh_total_quantity += $this->input->post('wh_qty_' . $warehouse->id);
                    }
                }
            $data['quantity'] = isset($wh_total_quantity) ? $wh_total_quantity : 0;
        } elseif ($this->input->post('add')) {
            $this->session->set_flashdata('error', validation_errors());
            redirect($_SERVER["HTTP_REFERER"]);
        }
        if ($this->form_validation->run() == true && $this->items_model->addItem($data,$warehouse_qty)) {
            $this->session->set_flashdata('message', 'Thêm nguyên vật liệu thành công');
            redirect('items');
        } else {
        $this->data['error'] = validation_errors() ? validation_errors() : $this->session->flashdata('error');   
        $this->data['warehouses'] = $warehouses;   
        $bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => site_url('items'), 'page' => lang('Nguyên vật liệu')),array('link' => '#', 'page' => lang('Thêm nguyên vật liệu')));
        $this->data['units'] = $this->units_model->getAllUnits();
        $meta = array('page_title' => lang('Nguyên vật liệu'), 'bc' => $bc);
        $this->page_construct('items/add', $meta, $this->data);
        }        
        
    }

    function edit($id)
    {

        $item = $this->items_model->getItemByID($id);
        $this->load->helper('security');
        foreach ($item as $key => $value) {
                
            if($value->item === $this->input->post('item') && $value->unit_id === $this->input->post('unit_id') &&  $value->specification === $this->input->post('specification')){
                array(
                        $this->form_validation->set_rules('item','Nguyên vật liệu này', 'trim|is_unique[items.item]'),
                        $this->form_validation->set_rules('specification','trim|is_unique[items.specification]'),
                        $this->form_validation->set_rules('unit_id','trim|is_unique[items.unit_id]'),
                    );
            }
        }
        $this->form_validation->set_rules('quantity', lang("Số lượng"), 'trim|numeric');
        $this->form_validation->set_rules('cost', lang("Giá"), 'trim|numeric');
        $this->form_validation->set_rules('long', lang("Dài"), 'trim|numeric');
        $this->form_validation->set_rules('wide', lang("Rộng"), 'trim|numeric');
        $this->form_validation->set_rules('weight', lang("Trọng lượng"), 'trim|numeric');
        $warehouses = $this->site->getAllWarehouses();
        
        if ($this->form_validation->run() == true) {
            $data = array(
                'item'=>$this->input->post('item'),
                'specification'=>$this->input->post('specification'),
                'size_long'=>$this->input->post('size_long'),
                'size_wide'=>$this->input->post('size_wide'),
                'unit_id'=>$this->input->post('unit_id'),
                'unit'=>$this->input->post('unit'),
                 'note'=>$this->input->post('note'),
                 'weight'=>$this->input->post('weight'),
                 'cost' =>$this->input->post('cost')
                );
            $wh_total_quantity = 0;
            foreach ($warehouses as $warehouse) {
                    if ($this->input->post('wh_qty_' . $warehouse->id)) {
                        $warehouse_qty[] = array(
                            'warehouse_id' => $this->input->post('wh_' . $warehouse->id),
                            'quantity' => $this->input->post('wh_qty_' . $warehouse->id),
                            'rack' => $this->input->post('rack_' . $warehouse->id) ? $this->input->post('rack_' . $warehouse->id) : NULL
                        );
                        $wh_total_quantity += $this->input->post('wh_qty_' . $warehouse->id);
                    }
                }

            $data['quantity'] = isset($wh_total_quantity) ? $wh_total_quantity : 0;
            
         
        } elseif ($this->input->post('edit')) {
            $this->session->set_flashdata('error', validation_errors());
            redirect('$_SERVER["HTTP_REFERER"]');
        }
        if ($this->form_validation->run() == true && $this->items_model->updateItem($id,$data,$warehouse_qty)) {
            $this->session->set_flashdata('message', 'Sửa nguyên vật liệu thành công');
            redirect('items');
        } else {
        $this->data['error'] = validation_errors() ? validation_errors() : $this->session->flashdata('error');      
        $bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => site_url('items'), 'page' => lang('Nguyên vật liệu')),array('link' => '#', 'page' => lang('Thêm nguyên vật liệu')));
        $this->data['warehouses'] = $warehouses;  
     
        $this->data['warehouses_products'] = $id ? $this->items_model->getAllWarehousesWithIQ($id) : NULL;
     

        $this->data['units'] = $this->units_model->getAllUnits();
        $this->data['item'] = $this->items_model->getItemByID($id);
        $this->data['id'] = $id;
        $this->data['items'] = $item;
      
        $meta = array('page_title' => lang('Nguyên vật liệu'), 'bc' => $bc);
        $this->page_construct('items/edit', $meta, $this->data);
        } 
    }
    function delete($id = NULL)
    {
        //Check before delete
        if ($this->items_model->deleteItem($id)) {
            echo lang("Xóa nguyên vật liệu thành công");
        }
        else
        {
            echo lang("Xóa nguyên vật liệu thất bại");
        }
    }

    function item_actions()
    {

        $this->form_validation->set_rules('form_action', lang("form_action"), 'required');

        if ($this->form_validation->run() == true) {
            if (!empty($_POST['val'])) {
                if ($this->input->post('form_action') == 'delete') {
                    foreach ($_POST['val'] as $id) {
                        $this->items_model->deleteItem($id);
                    }
                    $this->session->set_flashdata('message', lang("Xóa các đơn vị thành công"));
                    redirect($_SERVER["HTTP_REFERER"]);
                }

                if ($this->input->post('form_action') == 'export_excel' || $this->input->post('form_action') == 'export_pdf') {

                    $this->load->library('excel');
                    $this->excel->setActiveSheetIndex(0);
                    $this->excel->getActiveSheet()->setTitle(lang('categories'));
                    $this->excel->getActiveSheet()->SetCellValue('A1', lang('code'));
                    $this->excel->getActiveSheet()->SetCellValue('B1', lang('name'));

                    $row = 2;
                    foreach ($_POST['val'] as $id) {
                        $sc = $this->items_model->getItemByID($id);
                        $this->excel->getActiveSheet()->SetCellValue('A' . $row, $sc->code);
                        $this->excel->getActiveSheet()->SetCellValue('B' . $row, $sc->name);
                        $row++;
                    }

                    $this->excel->getActiveSheet()->getColumnDimension('B')->setWidth(20);
                    $this->excel->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
                    $filename = 'categories_' . date('Y_m_d_H_i_s');
                    if ($this->input->post('form_action') == 'export_pdf') {
                        $styleArray = array('borders' => array('allborders' => array('style' => PHPExcel_Style_Border::BORDER_THIN)));
                        $this->excel->getDefaultStyle()->applyFromArray($styleArray);
                        $this->excel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
                        require_once(APPPATH . "third_party" . DIRECTORY_SEPARATOR . "MPDF" . DIRECTORY_SEPARATOR . "mpdf.php");
                        $rendererName = PHPExcel_Settings::PDF_RENDERER_MPDF;
                        $rendererLibrary = 'MPDF';
                        $rendererLibraryPath = APPPATH . 'third_party' . DIRECTORY_SEPARATOR . $rendererLibrary;
                        if (!PHPExcel_Settings::setPdfRenderer($rendererName, $rendererLibraryPath)) {
                            die('Please set the $rendererName: ' . $rendererName . ' and $rendererLibraryPath: ' . $rendererLibraryPath . ' values' .
                                PHP_EOL . ' as appropriate for your directory structure');
                        }

                        header('Content-Type: application/pdf');
                        header('Content-Disposition: attachment;filename="' . $filename . '.pdf"');
                        header('Cache-Control: max-age=0');

                        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'PDF');
                        return $objWriter->save('php://output');
                    }
                    if ($this->input->post('form_action') == 'export_excel') {
                        header('Content-Type: application/vnd.ms-excel');
                        header('Content-Disposition: attachment;filename="' . $filename . '.xls"');
                        header('Cache-Control: max-age=0');

                        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
                        return $objWriter->save('php://output');
                    }

                    redirect($_SERVER["HTTP_REFERER"]);
                }
            } else {
                $this->session->set_flashdata('error', lang("No hotel selected"));
                redirect($_SERVER["HTTP_REFERER"]);
            }
        } else {
            $this->session->set_flashdata('error', validation_errors());
            redirect($_SERVER["HTTP_REFERER"]);
        }
    }

    
}
