root = File.absolute_path(File.dirname(__FILE__))
 
file_cache_path root
cookbook_path root + '/cookbooks'
log_level :info
log_location STDOUT
