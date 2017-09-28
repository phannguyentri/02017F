<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Categories_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
    }

    public function addCategories($data)
    {
        
        unset($data['add']);
        if ($this->db->insert("machine_categories", $data)) {
            
            return true;
        }
        return false;
    }

    public function updateCategories($id, $data = array())
    {
        unset($data['edit']);
        $this->db->where('id', $id);
        if ($this->db->update("machine_categories", $data)) {
            return true;
        }
        return false;
    }

    public function deleteCategories($id)
    {
        if ($this->db->delete("machine_categories", array('id' => $id))) {
            return true;
        }
        return FALSE;
    }

    public function getCategoriesByID($id)
    {
        $q = $this->db->get_where("machine_categories", array('id' => $id),1);
        if ($q->num_rows() > 0) {

            return $q->row();
        }

        return FALSE;
    }


}
