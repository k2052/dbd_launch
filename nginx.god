God.watch do |w|
  w.pid_file = "/var/run/nginx.pid"
  w.name = "nginx"
  w.interval = 30.seconds # default      
  w.start = "/etc/init.d/nginx start"
  w.stop = "sudo /etc/init.d/nginx stop" 
  w.restart = "/etc/init.d/nginx stop && /etc/init.d/nginx start"
  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
    
  w.behavior(:clean_pid_file)
  
  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false     
    end  
  end  
    
  w.restart_if do |restart|
    restart.condition(:http_response_code) do |c|
      c.host = 'localhost'
      c.port = 80
      c.path = '/'
      c.timeout = 3.seconds
      c.times = [4, 5]
      c.code_is_not = 200  
    end  
  end 

  # lifecycle
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours 
    end  
  end  
  
end