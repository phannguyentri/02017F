<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Machine_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
    }

    public function addMachine($data)
    {
       
        
        unset($data['add']);
        if ($this->db->insert("machine", $data)) {
            return true;             
        }
        return false;
    }

    public function updateMachine($id, $data = array())
    {
        unset($data['edit']);
        $this->db->where('id', $id);

        if ($this->db->update("machine", $data)) {   
                        
            return true;

        }
        return false;
    }

    public function deleteMachine($id)
    {
       
        if ($this->db->delete("machine", array('id' => $id))) {
            return true;
        }
        return FALSE;
    }

    
    public function getAllCategories()
    {
       $q = $this->db->get('machine_categories');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }

            return $data;
        }
    }

    public function getMachineByID($id)
    {
        $q = $this->db->get_where("machine", array('id' => $id),1);
        if ($q->num_rows() > 0) {

            return $q->row();
        }

        return FALSE;
    }
}
