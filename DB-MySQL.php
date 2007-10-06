<?php
	/**
	 * DB_MySQL
	 *
	 * Wrapper class for communicating with MySQL
	 *
	 * RATIONALE
	 *		Unlike PEAR's DB class, this class is designed to allow the use of all MySQL
	 *	features with an eye toward performance and ease of development at the expense
	 *	of database portability. Since MySQL is free and runs just about anywhere PHP
	 *	runs, this is an acceptable tradeoff for many applications.
	 *
	 *	Use PEAR DB if you need to support many databases and can live
	 *	with the subset of common functionality
	 *
	 *	Use DB_MySQL if you don't need to support other databases (or
	 *	plan on maintaining optimized SQL codebases anyway)
	 *	and want to support MySQL as easily as possible
	 *
	 * TODO:
	 *		- versions other databases?
	 *
	 *		- wrap the following functions:
	 *			mysql_create_db()
	 *			mysql_drop_db()
	 *			mysql_db_name()
	 *			mysql_error() / mysql_errno()
	 *			mysql_fetch_(array|field|lengths|object) - perhaps in a complex query mode
	 *			mysql_field_*
	 *			mysql_list_*
	 *
	 *		- query trapping feature to dump queries as they are executed & related debugging info
	 *
	 *		- complex query mode to retrieve large amounts of data:
	 *			- mysql_unbuffered_query() to avoid retrieving masses of data
	 *			- mysql_fetch_(field|row) to retrieve it row-by-row or one field at a time
	 *			- mysql_field_len() to avoid fetching large data
	 *			- mysql_data_seek() to avoid fetching some rows or to see a row again
	 */

	assert(extension_loaded("mysql"));

	class DB_MySQL {
		var $Server;
		var $Name;
		var $User;
		var $Password;

		# MySQL connection handle:
		var $Handle;

		# Internal flag:
		var $_isPersistent	 = true;
		var $_displayQueries = false;
		var $_profileQueries = false;

		var $dbCharset = 'utf8';

		function DB_MySQL() {
			/**
			 * The constructor can either be called with an existing database handle
			 * or a set of four parameters to use with mysql_[p]connect():
			 *
			 * $db = new DB_MySQL($my_existing_mysql_link_handle);
			 *
			 * or
			 *
			 * $db = new DB_MySQL("localhost", "my_db", "db_user", "db_password");
			 *
			 */
			switch (func_num_args()) {
				case 1:
					$h = func_get_arg(0);

					// Make sure what we got really is a mysql link
					assert(is_resource($h));
					$t = get_resource_type($h);

					if ($t == "mysql link") {
						$this->_isPersistent = false;
					} elseif ($t == "mysql link persistent") {
						$this->_isPersistent = true;
					} else {
						trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() Passed handle isn't a mysql connection - it's a $t resource!", E_USER_ERROR);
					}

					$this->Handle = $t;
					return;

				case 4:
					list ($this->Server, $this->Name, $this->User, $this->Password) = func_get_args();
					break;

				default:
					trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() called with " . func_num_args() . " arguments - it should be called with either 1 (a mysql connection handle) or 4 (the server, db_name, user, and password to connect with)", E_USER_ERROR);
			}
		}

		function displayQueries($b = true) {
			$this->_displayQueries = $b;
		}

		function profileQueries($b = true) {
			$this->_profileQueries = $b;

			if ($b) {
				$this->_displayQueries = $b;
			}

			$this->_queryCount           = 0;
			$this->_cummulativeQueryTime = 0;

			if ($b and !function_exists("micro_time")) {
				require_once("ImpUtils/profiling.php");
			}
		}

		function _startTimer() {
			if (!$this->_profileQueries) return false;
			$this->_queryStartTime = micro_time();
		}

		function _stopTimer($location) {
			if (!$this->_profileQueries) {
				if ($this->_displayQueries) {
					print "\n<pre>$location</pre>\n";
				}
				return false;
			} else {
				$n = micro_time() - $this->_queryStartTime;
				$this->_queryCount++;
				$this->_cummulativeQueryTime += $n;

				print "\n<pre>$location elapsed time = " . number_format($n, 6) . " seconds (total {$this->_queryCount} queries in " . number_format($this->_cummulativeQueryTime, 6) . " seconds)</pre>\n";
			}
		}

		function changeConnection($Server, $Name, $User, $Pass) {
			/**
			 * Changes the connection settings but attempts to change as few things as possible
			 * to avoid unncessary connection churn
			 *
			 */
			assert(func_num_args() == 4);

			if (empty($this->Handle)) {
				trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() called before a link has been established", E_USER_NOTICE);
			}

			if (!strcmp($Server, $this->Server) or empty($this->Handle)) {
				// We have to open a new connection:
				$this->disconnect();
				$this->Server   = $Server;
				$this->Name     = $Name;
				$this->User     = $User;
				$this->Password = $Pass;
				$this->connect();
				return;
			}

			if (!strcmp($User, $this->User) or !strcmp($Pass, $this->Password)) {
				$this->_startTimer();
				mysql_change_user($User, $Pass, $Name, $this->Handle) or trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() mysql_change_user() failed: " . mysql_error(), E_USER_ERROR);
				$this->_stopTimer(__CLASS__ . "->" . __FUNCTION__ . "() - mysql_change_user()");
				$this->Name     = $Name;
				$this->User     = $User;
				$this->Password = $Pass;
				return;
			}

			if (!strcmp($Name, $this->Name)) {
				$this->_startTimer();
				mysql_select_db($Name, $this->Handle) or trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() mysql_select_db() failed: " . mysql_error(), E_USER_ERROR);
				$this->_stopTimer(__CLASS__ . "->" . __FUNCTION__ . "() - mysql_select_db()");
				$this->Name = $Name;
			}
		}

		function connect() {
			assert(func_num_args() == 0);

			if (!empty($this->Handle)) {
				trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() called when a link has already been established", E_USER_NOTICE);
			}

			// Determine whether or not to open a persistent connection with the
			// problems this can entail. The mysql_pconnect() documentation has details,
			// some real, others imaginary or user error. We'll stay out of the debate.
			$connect_func = ($this->_isPersistent) ? "mysql_pconnect" : "mysql_connect";

			$this->_startTimer();

			$this->Handle = $connect_func($this->Server, $this->User, $this->Password) or trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() $connect_func() failed: " . mysql_error(), E_USER_ERROR);

			mysql_selectdb($this->Name, $this->Handle) or trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() mysql_selectdb() failed: " . mysql_error($this->Handle), E_USER_ERROR);

      $this->execute("SET NAMES '" . $this->dbCharset . "'");

			$this->_stopTimer(__CLASS__ . "->" . __FUNCTION__ . "() using $connect_func({$this->Server}, ...)");
		}

		function disconnect() {
			assert(func_num_args() == 0);

			if (empty($this->Handle)) {
				trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() called but no link has been established", E_USER_NOTICE);
			} else {
				$this->_startTimer();
				mysql_close($this->Handle) or trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() mysql_close() failed: " . mysql_error($this->Handle), E_USER_ERROR);
				$this->_stopTimer(__CLASS__ . "->" . __FUNCTION__ . "() - mysql_close()");
				unset($this->Handle);
			}
		}

		function query($sql, $fetchAssoc = true) {
			/**
			 * Returns an associative array containing the results returned by the passed SELECT statement
			 * NOTE: this function should really only be called in cases where it makes sense to get records back;
			 *			 execute() should be used for statements which will return no data. Note we don't enforce this
			 *		 on the theory that there might be a point where the caller will pass multiple commands in a single call
			 */
			if (empty($sql)) {
				trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() called without a SQL query!", E_USER_WARNING);
				return false;
			}

			if (empty($this->Handle)) {
				$this->connect();
			}

			$this->_StartTimer();

			$q = mysql_query($sql, $this->Handle) or trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() mysql_query() failed: " . mysql_error($this->Handle), E_USER_ERROR);

			$this->_stopTimer(__CLASS__ . "->" . __FUNCTION__ . "('" . ($this->_displayQueries ? htmlspecialchars($sql) : '...') . "')");

			$r = array();

			if ($fetchAssoc) {
				for ($i = 0; $i < mysql_num_rows($q); $i++) {
					$r[] = mysql_fetch_assoc($q) or trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() mysql_fetch_assoc() failed: " . mysql_error($this->Handle), E_USER_ERROR);
				}
			} else {
				for ($i = 0; $i < mysql_num_rows($q); $i++) {
					$r[] = mysql_fetch_row($q) or trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() mysql_fetch_row() failed: " . mysql_error($this->Handle), E_USER_ERROR);
				}
			}

			mysql_free_result($q) or trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() mysql_free_result() failed: " . mysql_error($this->Handle), E_USER_ERROR);

			return $r;
		}

		function queryValue($sql, $row = 0, $column = 0) {
			/**
			 * Returns a single value from the specified column of the first row generated by the passed SELECT statement
			 */
			if (empty($sql)) {
				trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() called without a SQL query!", E_USER_WARNING);
				return false;
			}
			assert(func_num_args() == 1);

			if (empty($this->Handle)) {
				$this->connect();
			}

			if ($this->_displayQueries) {
				$this->printSQL($sql);
			}

			$this->_StartTimer();

			$q = mysql_query($sql, $this->Handle) or trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() mysql_query() failed: " . mysql_error($this->Handle), E_USER_ERROR);

			$this->_stopTimer(__CLASS__ . "->" . __FUNCTION__ . "('" . ($this->_displayQueries ? htmlspecialchars($sql) : '...') . "')");


			$r = false;

			if (mysql_num_rows($q)) {
				$r = mysql_result($q, $row, $column);
			}

			mysql_free_result($q) or trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() mysql_free_result() failed: " . mysql_error($this->Handle), E_USER_ERROR);

			return $r;
		}

		function queryValues($sql) {
			/**
			 * Returns an array containing the values of the first column returned by the passed SELECT statement
			 */
			if (empty($sql)) {
				trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() called without a SQL query!", E_USER_WARNING);
				return false;
			}
			assert(func_num_args() == 1);

			if (empty($this->Handle)) {
				$this->connect();
			}

			if ($this->_displayQueries) {
				$this->printSQL($sql);
			}

			$this->_StartTimer();

			$q = mysql_query($sql, $this->Handle) or trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() mysql_query() failed: " . mysql_error($this->Handle), E_USER_ERROR);

			$this->_stopTimer(__CLASS__ . "->" . __FUNCTION__ . "('" . ($this->_displayQueries ? htmlspecialchars($sql) : '...') . "')");


			$r = array();

			for ($i = 0; $i < mysql_num_rows($q); $i++) {
				// Use a strict type check to avoid problems when the value retrieved is 0, which evaluates to false
				($r[] = mysql_result($q, $i)) !== FALSE or trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() mysql_result() failed: " . mysql_error($this->Handle), E_USER_ERROR);
			}

			mysql_free_result($q) or trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() mysql_free_result() failed: " . mysql_error($this->Handle), E_USER_ERROR);

			return $r;
		}


		function execute($sql) {
			/**
			 * Executes a SQL statement which does not return any records
			 */
			if (empty($sql)) {
				trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() called without a SQL query!", E_USER_WARNING);
				return false;
			}
			assert(func_num_args() == 1);

			if (empty($this->Handle)) {
				$this->connect();
			}

			if ($this->_displayQueries) {
				$this->printSQL($sql);
			}

			$this->_StartTimer();

			$q = mysql_query($sql, $this->Handle) or trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() mysql_query('$sql') failed: " . mysql_error($this->Handle), E_USER_ERROR);

			$this->_stopTimer(__CLASS__ . "->" . __FUNCTION__ . "('" . ($this->_displayQueries ? htmlspecialchars($sql) : '...') . "')");

		}

		function getAffectedRowCount() {
			/**
			 * Returns the number of rows affected by the last statement
			 */

			assert(func_num_args() == 0);

			if (empty($this->Handle)) {
				trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() called without a current database connection", E_USER_WARNING);
				return false;
			}

			$i = mysql_affected_rows($this->Handle);

			return $i;
		}

		function getLastInsertId() {
			/**
			 * Returns the numeric ID of the last insert statement (used with AUTO_INCREMENT colums)
			 */
			assert(func_num_args() == 0);

			if (empty($this->Handle)) {
				trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() called without a current database connection", E_USER_WARNING);
				return false;
			}

			$i = mysql_insert_id($this->Handle) or trigger_error(__CLASS__ . "::" . __FUNCTION__ . "() mysql_insert_id() failed: " . mysql_error($this->Handle), E_USER_ERROR);

			return $i;
		}

		function escape($v) {
			/**
			 * Returns $v with any characters which have special meaning to MySQL escaped
			 */

			 if (is_array($v)) {
					foreach ($v as $k => $i) {
						$v[$k] = mysql_real_escape_string($i, $this->Handle);
					}
			 } else {
				 return mysql_real_escape_string($v, $this->Handle);
			 }
		}

		function escapeString($str) {
			/**
			 * Returns $str with any characters which have special meaning to MySQL escaped
			 */

			 return mysql_real_escape_string(strval($str), $this->Handle);
		}

		function printSQL($sql) {
			/**
			 * Prints a formatted version of the passed SQL string
			 */

			assert(is_string($sql));

			print "\n<pre>" . htmlspecialchars($sql) . "</pre>\n";
		}
	}
?>