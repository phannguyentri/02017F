<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Machine extends MY_Controller
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
        $this->load->model('machine_model');
    }

    function index()
    {
        $this->data['error'] = validation_errors() ? validation_errors() : $this->session->flashdata('error');      
        $bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => lang('Loại máy móc')));
        $meta = array('page_title' => lang('Loại máy móc'), 'bc' => $bc);
        $this->page_construct('machine/index', $meta, $this->data);
    }

    function getMachine()
    {

        $this->load->library('datatables');
        $this->datatables
            ->select("machine.id, machine_code , machine_name , machine_categories.categories_name , machine_capacity,machine_details , machine_note")
            ->from("machine")           
            ->join('machine_categories', 'machine_categories.id=machine.id_machine_categories', 'left')
            ->add_column("Actions", "<center><a href='" . site_url('machine/edit/$1') . "'class='tip' title='Sửa máy móc'><i class=\"fa fa-edit\"></i></a> <a href='#' class='tip po' title='<b>Xóa máy móc</b>' data-content=\"<p>" . lang('r_u_sure') . "</p><a class='btn btn-danger po-delete' href='" . site_url('machine/delete/$1') . "'>" . lang('i_m_sure') . "</a> <button class='btn po-close'>" . lang('no') . "</button>\"  rel='popover'><i class=\"fa fa-trash-o\"></i></a></center>", "machine.id");

        echo $this->datatables->generate();
    }

    function add()
    {
        $this->load->helper('security');
        $this->form_validation->set_rules('machine_name', lang("Tên máy móc"), 'trim|required');
        $this->form_validation->set_rules('machine_capacity', lang("Công suất máy"), 'trim|required|numeric|min_length[0]');
        $this->form_validation->set_rules('machine_code', lang("Mã máy móc"), 'trim|required|is_unique[machine.machine_code]');
        
       
        
        if ($this->form_validation->run() == true) {
            $data = array(
            'machine_code'=>$this->input->post('machine_code'),
            'machine_name'=>$this->input->post('machine_name'),
            'id_machine_categories'=>$this->input->post('category'),
            'machine_capacity'=>$this->input->post('machine_capacity'),
            'machine_details'=>$this->input->post('machine_details'),
            'machine_note'=>$this->input->post('machine_note'),
            
        );
            
        } elseif ($this->input->post('add')) {
            $this->session->set_flashdata('error', validation_errors());
            redirect($_SERVER["HTTP_REFERER"]);
        }

        if ($this->form_validation->run() == true && $this->machine_model->addMachine($data)) {
            $this->session->set_flashdata('message', 'Thêm loại máy móc thành công');
            redirect('machine');
        } else {
           $this->data['categories'] = $this->machine_model->getAllCategories();       
           $bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => lang('Thêm máy móc')));
            $meta = array('page_title' => lang('Thêm máy móc'), 'bc' => $bc);
            $this->page_construct('machine/add', $meta, $this->data);
        }     
        
    }

     function edit($id=NULL)
    {
        $this->load->helper('security');
        $this->form_validation->set_rules('machine_name', lang("Tên máy móc"), 'trim|required');
        $this->form_validation->set_rules('machine_capacity', lang("Công suất máy"), 'trim|required|numeric|min_length[0]');
        $this->form_validation->set_rules('machine_code', lang("Mã máy móc"), 'trim|required');
      
        if ($this->form_validation->run() == true) {
            $data = array(
            'machine_code'=>$this->input->post('machine_code'),
            'machine_name'=>$this->input->post('machine_name'),
            'id_machine_categories'=>$this->input->post('category'),
            'machine_capacity'=>$this->input->post('machine_capacity'),
            'machine_details'=>$this->input->post('machine_details'),
            'machine_note'=>$this->input->post('machine_note'),
            
        );
        } elseif ($this->input->post('add')) {
            $this->session->set_flashdata('error', validation_errors());
            redirect($_SERVER["HTTP_REFERER"]);
        }

        if ($this->form_validation->run() == true && $this->machine_model->updateMachine($id,$data)) {
            $this->session->set_flashdata('message', 'Sửa máy móc thành công');
           redirect('machine');
        } else {
            $this->data['id'] = $id;
            $this->data['error'] = validation_errors() ? validation_errors() : $this->session->flashdata('error');
            $this->data['machine'] = $this->machine_model->getMachineByID($id);  
            $this->data['categories'] = $this->machine_model->getAllCategories();       
            $bc = array(array('link' => base_url(), 'page' => lang('home')), array('link' => '#', 'page' => lang('Sửa máy móc')));
            $meta = array('page_title' => lang('Sửa máy móc'), 'bc' => $bc);
            $this->page_construct('machine/edit', $meta, $this->data);
            
        }
    }

     function delete($id = NULL)
    {
        
        if ($this->machine_model->deleteMachine($id)) {

            echo lang("Xóa máy móc thành công");
        }
        else
        {
            echo lang("Xóa máy móc thất bại");
        }
    }

    function machine_actions()
    {

        $this->form_validation->set_rules('form_action', lang("form_action"), 'required');

        if ($this->form_validation->run() == true) {
            if (!empty($_POST['val'])) {
                if ($this->input->post('form_action') == 'delete') {
                    foreach ($_POST['val'] as $id) {
                        $this->categories_model->deleteCategories($id);
                    }
                    $this->session->set_flashdata('message', lang("Xóa máy móc thành công"));
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
                        $sc = $this->working_places_model->getWorkingPlaceByID($id);
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
