<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Units_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
    }

    public function addUnit($data)
    {
        unset($data['add']);
        if ($this->db->insert("units", $data)) {
            return true;
        }
        return false;
    }

    public function updateUnit($id, $data = array())
    {
        
        unset($data['id']);
        unset($data['edit']);
        $this->db->where('id', $id);
        if ($this->db->update("units", $data)) {
            return true;
        }
        return false;
    }

    public function deleteUnit($id)
    {
        if ($this->db->delete("units", array('id' => $id))) {
            return true;
        }
        return FALSE;
    }

    public function getUnitByID($id)
    {
        $q = $this->db->get_where("units", array('id' => $id),1);
        if ($q->num_rows() > 0) {

            return $q->row();
        }

        return FALSE;
    }
    public function getAllUnits()
    {
        $q = $this->db->get('units');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
}
