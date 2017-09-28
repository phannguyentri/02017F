<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Working_places_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
    }

    public function addWorkingPlace($data,$machines)
    {
        unset($data['add']);
        if ($this->db->insert("working_places", $data)) {
            $workingplace_id = $this->db->insert_id();
            $arrMachine=array();
            foreach ($machines as $machine) {
                foreach ($machine as $value) {
                    $a=array(
                        'machine_id' => $value,
                        'working_place_id' => $workingplace_id,
                    );
                    $arrMachine[]=$value;
                    $this->db->insert('working_place_items', $a);
                }

            }

            $this->setActive($arrMachine,1);
            return true;
        }
        return false;
    }

    public function updateWorkingPlace($id, $data,$machines)
    {
        unset($data['edit']);

        $this->db->where('id', $id);
        if ($this->db->update("working_places", $data)) {
            $its=$this->db->get_where('working_place_items',array('working_place_id' => $id))->result();
            foreach ($its as $key => $value) {
                $this->setActive($value->machine_id,0);
            }
            $this->db->delete("working_place_items", array('working_place_id' => $id));
            foreach ($machines as $machine) {
                foreach (array_unique($machine) as $value) {
                    $a=array(
                        'machine_id' => $value,
                        'working_place_id' => $id,
                    );

                    $this->db->insert('working_place_items', $a);
                    $this->setActive($value,1);
                }

            }
            return true;
        }
        return false;
    }

    public function setActive($id,$status)
    {
        if(is_array($id))
        {
            $this->db->where_in('id',$id);
        }
        else
        {
            $this->db->where('id',$id);
        }
        $this->db->update('machine',array('active'=>$status));
        if($this->db->affected_rows())
        {
            return true;
        }
        return false;
    }

    public function deleteWorkingPlace($id)
    {

        $this->db->select('machine_id');
        $machines=$this->db->get_where('working_place_items',array('working_place_id'=>$id))->result();
        if ($this->db->delete("working_places", array('id' => $id)) && $this->db->delete("working_place_items", array('working_place_id' => $id)))
        {
            if(!empty($machines))
            {
                $arr=array();
                foreach ($machines as $key => $value) {
                    $arr[]=$value->machine_id;
                }
                $this->setActive($arr,0);
            }
            return true;
        }
        return FALSE;
    }

    public function getWorkingPlaceByID($id)
    {
        $q = $this->db->get_where("working_places", array('id' => $id),1);
        if ($q->num_rows() > 0) {

            return $q->row();
        }

        return FALSE;
    }

     public function getMachineByIdCate($id)
    {
        $this->db->select('machine.id,machine.machine_name,machine.machine_code, machine.id_machine_categories')
            ->join('machine_categories', 'machine.id_machine_categories=machine_categories.id', 'left')
            ->where('machine.id_machine_categories',$id);

            $this->db->where_in('active',array(0,NULL));
        $q = $this->db->get('machine');

         if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

      public function getMachineByIdCateEdit($id,$working_place_id)
    {
        $this->db->select('machine.id,machine.machine_name,machine.machine_code, machine.id_machine_categories')
            ->join('machine_categories', 'machine.id_machine_categories=machine_categories.id', 'left')
            ->join('working_place_items', 'working_place_items.machine_id=machine.id', 'left')
            ->where('machine.id_machine_categories',$id);
             $this->db->where_in('active',array(0,NULL));

             $this->db->or_where('working_place_id',$working_place_id);
        $q = $this->db->get('machine');

         if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
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

    public function getAllWPS()
    {
       $q = $this->db->get('working_places');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }

            return $data;
        }
    }

    public function getAllMechines($id)
    {
        $this->db->select('working_place_items.machine_id as id, machine.machine_name as text');
        $this->db->join('machine', 'machine.id=working_place_items.machine_id', 'left');
       $q = $this->db->get_where('working_place_items',array('working_place_id'=>$id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }

            return $data;
        }
    }

    public function getCategoriesByIdW($id)
    {
        $this->db->select('working_place_items.working_place_id,working_place_items.machine_id')

            ->where('working_place_items.working_place_id',$id);


        $q = $this->db->get('working_place_items');
         if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }



        return FALSE;

    }
}
