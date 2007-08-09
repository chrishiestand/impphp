<?php
/**
* The main ImpCMS class
*
* This class handles site-configuration, database connections, access levels
* and provides methods to create all other CMS objects.
*
* @author	 Chris Adams <chris@improbable.org>
* @version	$Id$
* @package	ImpCMS
* @access	 public
*
*/

class ImpCMS {
		protected $AdminAccess = false;
 		protected $ShowInvisibleDocuments;
		protected $ReadOnly;
		protected $DB; // MySQL database object

		public function __construct($DB = null) { // FIXME: PDO prototype
			$this->ShowInvisibleDocuments = $this->AdminAccess;
			$this->ReadOnly               = $this->AdminAccess;

			if (empty($DB)) {
				assert(defined("IMPCMS_DB_SERVER"));
				assert(defined("IMPCMS_DB_NAME"));
				assert(defined("IMPCMS_DB_USER"));
				assert(defined("IMPCMS_DB_USER_PASSWORD"));
				$this->DB = new PDO('mysql:host=' . IMPCMS_DB_SERVER . ';dbname=' . IMPCMS_DB_NAME, IMPCMS_DB_NAME, IMPCMS_DB_USER, IMPCMS_DB_USER_PASSWORD);
			} else {
				//FIXME: assert($DB instanceof PDO);
				$this->DB =& $DB;
			}

			$this->EventDispatcher = new UserEventDispatcher($this);
			$this->Permissions = new UserPermissionManager($this);
		}

		function enableAdminAccess($Username, $Password) {
			if (!$this->EventDispatcher->PreEnableAdminAccess($Username, $Password)) {
				return false;
			}

			$this->DB->changeConnection(IMPCMS_DB_SERVER, IMPCMS_DB_NAME, IMPCMS_DB_ADMIN, IMPCMS_DB_ADMIN_PASSWORD);

			$this->AdminAccess = true;

			$this->EventDispatcher->PostEnableAdminAccess();

			return $this->AdminAccess;
		}

		function newDocument() {
			return Document::get();
		}

		function getRootDocument() {
			/**
			 *	Returns a Document object for the root of the CMS (everything else is a child of this Document)
			 *
			 *	We currently don't support multiple roots, although it
			 *	will be a natural extension to make a function like this
			 *	which returns an array
			 */

			$r = $this->DB->query("SELECT ID FROM Documents WHERE Parent IS NULL") or trigger_error("ImpCMS::getRootDocument() couldn't find root document - check your configuration!", E_USER_ERROR);

			if (count($r) != 1) {
				trigger_error("ImpCMS::getRootDocument() expected 1 root document but received " . count($r), E_USER_ERROR);
			}

			return Document::get($r[0]["ID"]);
		}

		function getDocument($ID) {
			global $DB;
			/**
			 *	Returns a Document object for the passed Document ID
			 */

			if (empty($ID)) return;

			if (intval($ID) > 0) {
				$dID = $DB->queryValue('SELECT ID FROM Documents WHERE ID=?', intval($ID));
			} else {
				$dID = $DB->queryValue('SELECT ID FROM Documents WHERE TextID=?', $ID);
			}

			if (!empty($dID)) {
				settype($dID, "integer");
				return Document::get($dID);
			} else {
				return false;
			}
		}

		function getDocumentForVersion($Version) {
			global $DB;

			$Version = intval($Version);
			$ID = intval($DB->queryValue("SELECT Document FROM DocumentVersions WHERE ID=$Version"));

			if (!empty($ID)) {
				return Document::get($ID);
			} else {
				trigger_error("ImpCMS::getDocumentForVersion() couldn't retrieve a document for version #$Version", E_USER_WARNING);
				return false;
			}
		}

		function getDocumentsInContainer($Container, $ShowAll = false) {
			global $DB;
			// A container is simply an arbitrary way for us to group content
						// based on some external organizational structure. In this case we
						// simply query for documents whose Container matches the provided
						// value

			$Documents = array();
			foreach ($DB->queryValues("SELECT ID FROM Documents WHERE Container=? " . ($ShowAll ? '' : 'AND Visible=1'), $Container) as $did) {
				$Documents[] = Document::get($did);
			}

			return $Documents;
		}

		function processXMLRPCRequest($xml) {
			if (!class_exists("XMLRPCHandler")) {
				include_once("ImpUtils/ImpCMS/XMLRPC.php");
			}

			$Handler = new XMLRPCHandler($this);
			$Handler->processRequest($xml);
		}
	}
?>
