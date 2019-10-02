<?php
class ModelCheckoutCartUser extends model {
	public function getUser() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "cart_user WHERE customer_id = '" . (int)$this->customer->getId() . "' AND api_id = '" . (isset($this->session->data['api_id']) ? (int)$this->session->data['api_id'] : 0) . "' AND session_id='" . $this->db->escape($this->session->getId()) . "'");

		$json = $query->row;
		
		if($json) {
			$user = array(
				'name' => $json['name'],
				'phone' => $json['phone'],
				'email' => $json['email'],
				'laying' => json_decode($json['laying'], true),
				'delivery' => json_decode($json['delivery'], true),
				'needs' => json_decode($json['needs'], true),
			);
		}

		return $user;
	}

	public function addOrUpdateCartUser($data) {
		if(isset($data['name'])) {
			$name = $data['name'];
		}
		if(isset($data['phone'])) {
			$phone = $data['phone'];
		}
		if(isset($data['email'])) {
			$email = $data['email'];
		}
		if(isset($data['laying'])) {
			$laying = $data['laying'];
		}
		if(isset($data['delivery'])) {
			$delivery = $data['delivery'];
		}
		if(isset($data['additionals'])) {
			$additionals = $data['additionals'];
		}

		if($name && $phone && $email) {
			$this->add($name, $phone, $email);
		}

		if($delivery) {
			$this->addDelivery($delivery);
		}

		if($laying) {
			$this->addLaying($laying);
		}

		if($additionals) {
			$this->addNeeds($additionals);
		}

	}

	public function add($name, $phone, $email) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "cart_user WHERE customer_id = '" . (int)$this->customer->getId() . "' AND api_id = '" . (isset($this->session->data['api_id']) ? (int)$this->session->data['api_id'] : 0) . "' AND session_id='" . $this->db->escape($this->session->getId()) . "'");

		if (!$query->row['total']) {
			$this->db->query("INSERT " . DB_PREFIX . "cart_user SET customer_id = '" . (int)$this->customer->getId() . "', api_id = '" . (isset($this->session->data['api_id']) ? (int)$this->session->data['api_id'] : 0) . "', session_id='" . $this->db->escape($this->session->getId()) . "', name = '" . $name . "', phone = '" . $phone . "', email = '" . $email . "'");
		} else {
			$this->db->query("UPDATE " . DB_PREFIX . "cart_user SET name = '" . $name . "', phone = '" . $phone . "', email= '" . $email . "' WHERE customer_id = '" . (int)$this->customer->getId() . "' AND api_id = '" . (isset($this->session->data['api_id']) ? (int)$this->session->data['api_id'] : 0) . "' AND session_id='" . $this->db->escape($this->session->getId()) . "'");
		}
	}

	public function remove($cart_user_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "cart_user WHERE cart_user_id = '" . (int)$cart_user_id . "' AND api_id = '" . (isset($this->session->data['api_id']) ? (int)$this->session->data['api_id'] : 0) . "' AND customer_id = '" . (int)$this->customer->getId() . "' AND session_id = '" . $this->db->escape($this->session->getId()) . "'");
	}

	public function addNeeds($needs) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "cart_user WHERE customer_id = '" . (int)$this->customer->getId() . "' AND api_id = '" . (isset($this->session->data['api_id']) ? (int)$this->session->data['api_id'] : 0) . "' AND session_id='" . $this->db->escape($this->session->getId()) . "'");

		if (!$query->row['total']) {
				$this->db->query("INSERT " . DB_PREFIX . "cart_user SET customer_id = '" . (int)$this->customer->getId() . "', api_id = '" . (isset($this->session->data['api_id']) ? (int)$this->session->data['api_id'] : 0) . "', session_id='" . $this->db->escape($this->session->getId()) . "', needs = '" . json_encode(json_encode($needs)) . "'");
		} else {
			$this->db->query("UPDATE " . DB_PREFIX . "cart_user SET needs = '" . $this->db->escape(json_encode($needs)) . "' WHERE customer_id = '" . (int)$this->customer->getId() . "' AND api_id = '" . (isset($this->session->data['api_id']) ? (int)$this->session->data['api_id'] : 0) . "' AND session_id='" . $this->db->escape($this->session->getId()) . "'");
		}
	}

	public function addLaying($laying) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "cart_user WHERE customer_id = '" . (int)$this->customer->getId() . "' AND api_id = '" . (isset($this->session->data['api_id']) ? (int)$this->session->data['api_id'] : 0) . "' AND session_id='" . $this->db->escape($this->session->getId()) . "'");

		if (!$query->row['total']) {
				$this->db->query("INSERT " . DB_PREFIX . "cart_user SET customer_id = '" . (int)$this->customer->getId() . "', api_id = '" . (isset($this->session->data['api_id']) ? (int)$this->session->data['api_id'] : 0) . "', session_id='" . $this->db->escape($this->session->getId()) . "', laying = '" . $this->db->escape(json_encode($laying)) . "'");
		} else {
			$this->db->query("UPDATE " . DB_PREFIX . "cart_user SET laying = '" . $this->db->escape(json_encode($laying)) . "' WHERE customer_id = '" . (int)$this->customer->getId() . "' AND api_id = '" . (isset($this->session->data['api_id']) ? (int)$this->session->data['api_id'] : 0) . "' AND session_id='" . $this->db->escape($this->session->getId()) . "'");
		}
	}

	public function addDelivery($delivery) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "cart_user WHERE customer_id = '" . (int)$this->customer->getId() . "' AND api_id = '" . (isset($this->session->data['api_id']) ? (int)$this->session->data['api_id'] : 0) . "' AND session_id='" . $this->db->escape($this->session->getId()) . "'");

		if (!$query->row['total']) {
				$this->db->query("INSERT " . DB_PREFIX . "cart_user SET customer_id = '" . (int)$this->customer->getId() . "', api_id = '" . (isset($this->session->data['api_id']) ? (int)$this->session->data['api_id'] : 0) . "', session_id='" . $this->db->escape($this->session->getId()) . "', delivery = '" . $this->db->escape(json_encode($delivery)) . "'");
		} else {
			$this->db->query("UPDATE " . DB_PREFIX . "cart_user SET delivery = '" . $this->db->escape(json_encode($delivery)) . "' WHERE customer_id = '" . (int)$this->customer->getId() . "' AND api_id = '" . (isset($this->session->data['api_id']) ? (int)$this->session->data['api_id'] : 0) . "' AND session_id='" . $this->db->escape($this->session->getId()) . "'");
		}
	}
}